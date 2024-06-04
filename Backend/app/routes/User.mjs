import express from "express";
import { getUser} from "../controllers/UserController.mjs";

const router = express.Router();
router.get('/:username', getUser);

export default router;