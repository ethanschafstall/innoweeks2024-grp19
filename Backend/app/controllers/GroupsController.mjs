import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";

export const postFriendsGroup = async (req, res) => {
    const token = req.cookies.authToken;
    const { groName } = req.body;

    if (!token) {
        return res.status(401).json({ message: "You did not provide an authentication token." });
    }

    if (!groName) {
        return res.status(400).json({ message: "You did not provide a valid request body or group name." });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        const fkUser = decodedToken.id;

        try {
            const checkGroupQuery = `SELECT groupId FROM t_groups WHERE groName = ?`;
            const [existingGroup] = await req.dbConnection.execute(checkGroupQuery, [groName]);

            if (existingGroup.length > 0) {
                return res.status(400).json({ message: `A group with the name "${groName}" already exists.` });
            }

            const insertGroupQuery = `INSERT INTO t_groups (groName, fkUser) VALUES (?, ?)`;
            await req.dbConnection.execute(insertGroupQuery, [groName, fkUser]);

            return res.status(200).json({ message: `Group ${groName} created successfully.` });
        } catch (error) {
            console.error("Error creating group:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

export const getGroups = async (req, res) => {
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

        try {
            const getGroupsQuery = `SELECT * FROM t_groups WHERE fkUser = ?`;
            const [groups] = await req.dbConnection.execute(getGroupsQuery, [decodedToken.id]);
            console.log(groups)
            if (groups.length < 0) {
                return res.status(400).json({ message: `The user hasn't created any groups` });
            }

            console.table(groups)
            return res.status(200).json({ groups: groups });
        } catch (error) {
            console.error("Error creating group:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};