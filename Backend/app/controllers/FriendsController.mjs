import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";
import { notifier } from '../services/notifications/notificationManager.mjs';

export const postFriends = async (req, res) => {
    const token = req.cookies.authToken;
    const body = req.body;

    if (!token) {
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }

    if (!body || !body.groName || !body.userUsername) {
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

        const groName = body.groName;
        const userUsername = body.userUsername;
        const groupIdQuery = `SELECT groupId FROM t_groups WHERE groName = ?`;
        const userIdQuery = `SELECT userId FROM t_users WHERE useUsername = ?`;

        try {
            // Obtener el ID del grupo
            const [groupIdRows] = await req.dbConnection.execute(groupIdQuery, [groName]);
            if (!groupIdRows || groupIdRows.length === 0) {
                const message = `The group with the name ${groName} does not exist.`;
                return res.status(404).json({ message });
            }
            const fkGroup = groupIdRows[0].groupId;

            // Obtener el ID del usuario a partir del nombre de usuario
            const [userIdRows] = await req.dbConnection.execute(userIdQuery, [userUsername]);
            if (!userIdRows || userIdRows.length === 0) {
                const message = `The user with the username ${userUsername} does not exist.`;
                return res.status(404).json({ message });
            }
            const fkUser = userIdRows[0].userId;

            // Insertar el amigo en t_groups_members
            const insertQuery = `INSERT INTO t_group_members (fkGroup, fkUser) VALUES (?, ?)`;
            await req.dbConnection.execute(insertQuery, [fkGroup, fkUser]);

            // Respuesta exitosa
            return res.status(200).json({ message: `Friend added successfully to the group ${groName}.` });
        } catch (error) {
            console.error("Error adding friend to group:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};