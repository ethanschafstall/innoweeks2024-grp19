import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";

export const getAllUsers = async (req, res) => {
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
        const userRole = decodedToken.role;
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

export const getUsers = async (req, res) => {
    const token = req.cookies.authToken;

    // Checking if token exists
    if (!token) {
        // If token is missing, return 401 Unauthorized status
        const message = `You did not provide an authentication token. Please add one to the request header.`;
        return res.status(401).json({ message });
    }

    let query = "";

    // Checks if the request body contains a username
    if (req.body.username) {
        query = req.body.username;
    } 
    else if (req.params.username) // Checks if the request params contain a username
    {
        query = req.params.username;
    } else {
        const message = "No username provided.";
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
        const userRole = decodedToken.role;

        if (userRole !== "admin") {
            const message = `The user is not authorized to access this resource.`;
            return res.status(401).json({ message });
        }

        const queryString = `SELECT * FROM t_users WHERE useUsername LIKE ?;`;

        try {
            const [rows] = await req.dbConnection.execute(queryString, [query]);

            return res.status(200).json({ users: rows });
        } catch (error) {
            const message = "Internal Server Error";
            return res.status(500).json({ message });
        }
    });
};