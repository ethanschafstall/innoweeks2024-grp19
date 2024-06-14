import express from "express";
import { postFriends, getFriendsFeelings} from "../controllers/FriendsController.mjs";

const router = express.Router();
router.post('/', postFriends);
router.get('/feelings', getFriendsFeelings)

export default router;