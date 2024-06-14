import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";

export const postFriends = async (req, res) => {
    const token = req.cookies.authToken;
    const { groId, useUsername } = req.body;

    if (!token) {
        return res.status(401).json({ message: "You did not provide an authentication token." });
    }

    if (!groId || !useUsername) {
        return res.status(400).json({ message: "You did not provide a valid request body, group name, or user username." });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        try {
            const userInGroupQuery = `
                SELECT * FROM t_group_members
                WHERE fkGroup = ? AND fkUser = (SELECT userId FROM t_users WHERE useUsername = ?)
            `;
            const [userInGroupRows] = await req.dbConnection.execute(userInGroupQuery, [groId, useUsername]);

            if (userInGroupRows.length > 0) {
                return res.status(400).json({ message: `The user ${useUsername} is already assigned to the group ${groId}.` });
            }

            const userQuery = `SELECT userId FROM t_users WHERE useUsername = ?`;
            const [userRows] = await req.dbConnection.execute(userQuery, [useUsername]);

            if (userRows.length === 0) {
                return res.status(400).json({ message: `The user ${useUsername} does not exist.` });
            }

            const fkUser = userRows[0].userId;
            const insertQuery = `INSERT INTO t_group_members (fkGroup, fkUser) VALUES (?, ?)`;
            await req.dbConnection.execute(insertQuery, [groId, fkUser]);

            return res.status(200).json({ message: `Friend added successfully to the group ${groId}.` });
        } catch (error) {
            console.error("Error adding friend to group:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};
