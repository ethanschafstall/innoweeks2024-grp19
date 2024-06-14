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

export const getFriendsFeelings = async (req, res) => {
    const token = req.cookies.authToken;

    if (!token) {
        return res.status(401).json({ message: "You did not provide an authentication token." });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        const userId = decodedToken.id;
        const username = decodedToken.username
        try {
            // First query to get the group owners where the authenticated user is a member
            const groupOwnersQuery = `
                SELECT g.fkUser
                FROM t_group_members as gm
                JOIN t_groups as g ON gm.fkGroup = g.groupId
                WHERE gm.fkUser = ?
            `;
            const [groupOwnersRows] = await req.dbConnection.execute(groupOwnersQuery, [userId]);

            const groupOwnerIds = groupOwnersRows.map(row => row.fkUser);


            // Initialize an array to hold the feelings
            const feelings = [];

            // Iterate over each group owner and get their last feeling
            for (const ownerId of groupOwnerIds) {
                const feelingsQuery = `
                    SELECT f.feeMood, u.useUsername
                    FROM t_feelings as f
                    JOIN t_users as u ON f.fkUser = u.userId
                    WHERE f.fkUser = ?
                    ORDER BY f.feelingsId DESC
                    LIMIT 1
                `;
                const [feelingsRows] = await req.dbConnection.execute(feelingsQuery, [ownerId]);

                if (feelingsRows.length > 0) {
                    feelings.push(feelingsRows[0]);
                }
            }

            if (feelings.length > 0) {
                console.log(`${username} got feelings of their friends`)
                console.table(feelings)
                return res.status(200).json({ feelings });
            } else {
                return res.status(404).json({ message: "No feelings found for the specified users." });
            }

        } catch (error) {
            console.error("Error fetching feelings:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};