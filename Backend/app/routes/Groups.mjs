import express from "express";
import { postFriendsGroup } from "../controllers/GroupsController.mjs";

const router = express.Router();
router.post('/', postFriendsGroup);

export default router;