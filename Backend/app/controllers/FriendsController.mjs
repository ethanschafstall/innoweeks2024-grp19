import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";
import { notifier } from '../services/notifications/notificationManager.mjs';
import { postFriendsGroup } from './FriendsGroupController.mjs';

export const postFriends = async (req, res) => {
    const token = req.cookies.authToken;
    const body = req.body;

    if (!token) {
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }

    if (!body  || !body.groId || !body.useUsername) {
        const message = `You did not provide a valid request body, group name, or user username.`;
        return res.status(400).json({ message });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.log(error);
            let message;
            if (error.name === 'TokenExpiredError') {
                message = `Your session has expired. Please log in again.`;
            } else if (error.name === 'JsonWebTokenError') {
                message = `The request is invalid. Please check your login details.`;
            } else {
                message = `The user is not authorized to access this resource.`;
            }
            return res.status(401).json({ message });
        }

        try {
            const fkGroup = body.groId;
            const useUsername = body.useUsername;

            const userInGroupQuery = `SELECT * FROM t_group_members WHERE fkGroup = ? AND fkUser IN (SELECT userId FROM t_users WHERE useUsername = ?)`;
            const [userInGroupRows] = await req.dbConnection.execute(userInGroupQuery, [fkGroup, useUsername]);

            if (userInGroupRows.length > 0) {
                const message = `The user ${useUsername} is already assigned to the group ${fkGroup}.`;
                return res.status(400).json({ message });
            }
            
            const fkUser = await getUserId(req.dbConnection, useUsername);

            if (fkUser.length == 0 || !fkUser.userId ) {
                const message = `The user ${useUsername} it doesn't existe.`;
                return res.status(400).json({ message });
            }
            const insertQuery = `INSERT INTO t_group_members (fkGroup, fkUser) VALUES (?, ?)`;

            await req.dbConnection.execute(insertQuery, [fkGroup, fkUser.userId]);

            return res.status(200).json({ message: `Friend added successfully to the group ${fkGroup}.` });
        } catch (error) {
            console.error("Error adding friend to group:", error);
            return res.status(500).json({ error: `Internal Server Error` });
        }
    });
};

const getUserId = async (dbConnection, useUsername) => {
    try {
        const userIdQuery = `SELECT userId FROM t_users WHERE useUsername = ?`;
        const [userIdRows] = await dbConnection.execute(userIdQuery, [useUsername]);

        if (!userIdRows || userIdRows.length == 0) {
            return { success: false, message: `The user with the username ${useUsername} does not exist.` };
        }

        return { success: true, userId: userIdRows[0].userId };
    } catch (error) {
        console.error("Error in getUserId:", error);
        return { success: false, message: "Internal Server Error" };
    }
};