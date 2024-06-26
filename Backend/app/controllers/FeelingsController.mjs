import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";

export const postFeeling = async (req, res) => {
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
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        const queryString = `INSERT INTO t_feelings (feeMood, feeCreatedAt, fkUser) VALUES (?,?,?)`;
        const mood = body.mood;
        const timeDate = formatDateToSQL(new Date());
        const fkUser = decodedToken.id;
        try {
            const [rows] = await req.dbConnection.execute(queryString, [mood, timeDate, fkUser]);
            console.log(`${decodedToken.username} is feelings "${mood}"`)
            return res.status(200).json({ users: rows });
        } catch (error) {
            console.error("Error fetching users:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};


export const getFeelingsByUserId = async (req, res) => {
    const token = req.cookies.authToken;
    const { id } = req.params; 

    if (!token) {
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        const queryString = `SELECT * FROM t_feelings WHERE fkUser = ?`;
        try {
            const [rows] = await req.dbConnection.execute(queryString, [id]);
            return res.status(200).json({ feelings: rows });
        } catch (error) {
            console.error("Error fetching feelings:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

export const getLastFeelingByUserId = async (req, res) => {
    const token = req.cookies.authToken;
    const { id } = req.params; 

    if (!token) {
        const message = `You did not provide an authentication token.`;
        return res.status(401).json({ message });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.error("JWT Verification Error:", error);
            const message = error.name === 'TokenExpiredError'
                ? "Your session has expired. Please log in again."
                : "The request is invalid. Please check your login details.";
            return res.status(401).json({ message });
        }

        const queryString = `SELECT * FROM t_feelings WHERE fkUser = ? ORDER BY feelingsId DESC LIMIT 1`;
        try {
            const [rows] = await req.dbConnection.execute(queryString, [id]);
            if (rows.length > 0) {
                return res.status(200).json({ feeling: rows[0] });
            } else {
                return res.status(404).json({ message: "No feelings found for this user." });
            }
        } catch (error) {
            console.error("Error fetching feelings:", error);
            return res.status(500).json({ error: "Internal Server Error" });
        }
    });
};

