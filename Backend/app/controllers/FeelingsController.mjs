import express from "express";
import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";
const router = express.Router();

// TODO
export const getFeeling = async (req, res) => {
    const token = req.cookies.authToken;

    // Checking if token exists
    if (!token) {
        // If token is missing, return 401 Unauthorized status
        const message = `You did not provide an authentication token. Please add one to the request header.`;
        return res.status(401).json({ message });
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
        const userRole = decodedToken.userRole;
        console.log(decodedToken)
        if (userRole !== "admin" && userRole !== "superadmin") {
            const message = `The user is not authorized to access this resource.`;
            return res.status(401).json({ message });
        }

        const queryString = `SELECT * FROM t_users;`;

        try {
            const [rows] = await req.dbConnection.execute(queryString);

            return res.status(200).json({ users: rows });
        } catch (error) {
            console.error("Error fetching users:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

// TODO
export const getFeelings = async (req, res) => {
    const token = req.cookies.authToken;

    // Checking if token exists
    if (!token) {
        // If token is missing, return 401 Unauthorized status
        const message = `You did not provide an authentication token. Please add one to the request header.`;
        return res.status(401).json({ message });
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
        const userRole = decodedToken.userRole;
        console.log(decodedToken.userRole)
        if (userRole !== "admin" && userRole !== "superadmin") {
            const message = `The user is not authorized to access this resource.`;
            return res.status(401).json({ message });
        }

        const queryString = `SELECT * FROM t_users;`;

        try {
            const [rows] = await req.dbConnection.execute(queryString);

            return res.status(200).json({ users: rows });
        } catch (error) {
            console.error("Error fetching users:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

export const setFeeling = async (req, res) => {
    const token = req.cookies.authToken;
    const body = req.body;
    // Checking if token exists
    if (!token) {
        // If token is missing, return 401 Unauthorized status
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }
    if (!body) {
        // If token is missing, return 401 Unauthorized status
        const message = `You did not provide request body.`;
        return res.status(401).json({ message });
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
        const queryString = `INSERT INTO t_feelings (feeMood, feeCreatedAt, userId) VALUES (?,?,?)`;
        const mood = body.mood;
        const timeDate = formatDateToSQL(new Date());
        const userId = decodedToken.id;
        try {
            const [rows] = await req.dbConnection.execute(queryString, [mood, timeDate, userId]);

            return res.status(200).json({ users: rows });
        } catch (error) {
            console.error("Error fetching users:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

router.get('/', setFeeling);
export default router;
