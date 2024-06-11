import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";
import { notifier } from '../services/notifications/notificationManager.mjs';


export const postFriendsGroup = async (req, res) => {
    const token = req.cookies.authToken;
    const body = req.body;

    if (!token) {
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }
    if (!body || !body.groName) {
        const message = `You did not provide a valid request body or group name.`;
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

        const queryString = `INSERT INTO t_groups (groName, fkUser) VALUES (?,?)`;
        const groupName = body.groName;
        const fkUser = decodedToken.id;

        try {
            const [rows] = await req.dbConnection.execute(queryString, [groupName, fkUser]);
            return res.status(200).json({ group: rows });
        } catch (error) {
            console.error("Error creating group:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};