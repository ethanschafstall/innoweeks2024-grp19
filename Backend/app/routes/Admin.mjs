import express from "express";
import { getAllUsers, getUsers } from "../controllers/AdminController.mjs";

const router = express.Router();

router.get('/', getAllUsers);
router.get('/:username', getUsers);

export default router;