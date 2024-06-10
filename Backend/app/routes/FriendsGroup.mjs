import express from "express";
import { postFriendsGroup } from "../controllers/FriendsGroupController.mjs";

const router = express.Router();
router.post('/', postFriendsGroup);

export default router;