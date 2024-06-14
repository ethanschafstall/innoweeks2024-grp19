import express from "express";
import { postFriendsGroup, getGroups } from "../controllers/GroupsController.mjs";

const router = express.Router();
router.post('/', postFriendsGroup);
router.get('/', getGroups)

export default router;