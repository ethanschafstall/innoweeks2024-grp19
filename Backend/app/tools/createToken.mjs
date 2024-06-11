import jwt from "jsonwebtoken";
import { privateKey } from "../privateKey.mjs"; // Importing private key for JWT
import dotenv from 'dotenv';

dotenv.config();

const topic = process.env.MQTT_BASE_TOPIC_STRING;

export function generateToken(user) {
    const payload = {
        username: user.useUsername,
        id: user.userId,
        role: user.useRole,
        topic: `${topic}${user.userId}`
    };
    const options = {
        expiresIn: '24h',
    };
    const token = jwt.sign(payload, privateKey, options);
    return token;
}