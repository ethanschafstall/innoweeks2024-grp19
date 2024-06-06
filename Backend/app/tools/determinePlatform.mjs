import { connect } from "../services/connectToDatabase.mjs";

export const determinePlatform = async (userId) => {
    let dbConnection;
    try {
        dbConnection = await connect();
        const platformQueryString = `SELECT usePlatform FROM t_users WHERE userId = ?`;
        const [result] = await dbConnection.execute(platformQueryString, [userId]);
        if (result.length > 0) {
            return result[0].usePlatform;
        } else {
            throw new Error(`No platform found for user ${userId}`);
        }
    } catch (error) {
        console.error("Error determining platform:", error);
        throw error;
    }
};
