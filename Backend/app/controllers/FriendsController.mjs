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

    if (!body || !body.groName || !body.useUsername) {
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
            const groName = body.groName;
            const useUsername = body.useUsername;

            // Obtener o crear el ID del grupo
            const fkGroup = await getOrCreateGroupId(req.dbConnection, groName, token);

            // Obtener el ID del usuario
            const fkUser = await getUserId(req.dbConnection, useUsername);

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

// Función para obtener o crear el ID del grupo
const getOrCreateGroupId = async (dbConnection, groName, authToken) => {
    const groupIdQuery = `SELECT groupId FROM t_groups WHERE groName = ?`;
    let [groupIdRows] = await dbConnection.execute(groupIdQuery, [groName]);
    
    if (!groupIdRows || groupIdRows.length === 0) {
        // Si el grupo no existe, crear uno nuevo usando postFriendsGroup
        const newGroupRequest = {
            body: { groName },
            cookies: { authToken }, // Añadir la cookie authToken
            dbConnection,
        };
        const newGroup = await postFriendsGroup(newGroupRequest);
        if (!newGroup || !newGroup.groupId) {
            throw new Error(`Failed to create the group ${groName}.`);
        }
        groupIdRows = [{ groupId: newGroup.groupId }];
    }
    
    return groupIdRows[0].groupId;
};

// Función para obtener el ID del usuario
const getUserId = async (dbConnection, useUsername) => {
    const userIdQuery = `SELECT userId FROM t_users WHERE useUsername = ?`;
    const [userIdRows] = await dbConnection.execute(userIdQuery, [useUsername]);
    
    if (!userIdRows || userIdRows.length === 0) {
        throw new Error(`The user with the username ${useUsername} does not exist.`);
    }
    
    return userIdRows[0].userId;
};