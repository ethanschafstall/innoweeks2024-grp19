import jwt from 'jsonwebtoken';
import { privateKey } from "../privateKey.mjs";
import { formatDateToSQL } from "../tools/dateFormater.mjs";
import { notifier } from '../services/notifications/notificationManager.mjs';

export const postFriendsGroup = async (req, res) => {
    const token = req.cookies.authToken;
    const body = req.body;

    if (!token) {
        const message = `Vous n'avez pas fourni de jeton d'authentification.`;
        return res.status(401).json({ message });
    }
    if (!body || !body.groName) {
        const message = `Vous n'avez pas fourni un corps de requête ou un nom de groupe valide.`;
        return res.status(400).json({ message });
    }

    jwt.verify(token, privateKey, async (error, decodedToken) => {
        if (error) {
            console.log(error);
            let message;
            if (error.name === 'TokenExpiredError') {
                message = `Votre session a expiré. Veuillez vous reconnecter.`;
            } else if (error.name === 'JsonWebTokenError') {
                message = `La requête est invalide. Veuillez vérifier vos identifiants de connexion.`;
            } else {
                message = `L'utilisateur n'est pas autorisé à accéder à cette ressource.`;
            }
            return res.status(401).json({ message });
        }

        const groupName = body.groName;
        const fkUser = decodedToken.id;

        try {
            const checkGroupQuery = `SELECT groupId FROM t_groups WHERE groName = ?`;
            const [existingGroup] = await req.dbConnection.execute(checkGroupQuery, [groupName]);

            if (existingGroup.length > 0) {
                const message = `Un groupe avec le nom "${groupName}" existe déjà.`;
                return res.status(400).json({ message });
            }

            const insertGroupQuery = `INSERT INTO t_groups (groName, fkUser) VALUES (?, ?)`;
            const [rows] = await req.dbConnection.execute(insertGroupQuery, [groupName, fkUser]);

            return res.status(200).json({ group: rows });
        } catch (error) {
            console.error("Error creating group:", error);
            return res.status(500).json({ error: "Erreur interne du serveur" });
        }
    });
};