import express from "express";
import { getUser} from "../controllers/UserController.mjs";
import { connectToDatabase } from "../tools/sqlConnection.mjs";

const router = express.Router();
router.get('/:username', getUser);


export default router;