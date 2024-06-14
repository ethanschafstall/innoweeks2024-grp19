import express from "express";
import { postFriends} from "../controllers/FriendsController.mjs";

const router = express.Router();
router.post('/', postFriends);

export default router;