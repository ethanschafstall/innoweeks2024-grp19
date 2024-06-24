import express from "express";
import { getUser} from "../controllers/UserController.mjs";

const router = express.Router();
router.get('/', getUser);

export default router;