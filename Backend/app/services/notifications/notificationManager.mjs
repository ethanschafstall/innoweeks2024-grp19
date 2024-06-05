import { connect } from "../connectToDatabase.mjs";
import { mqttService } from "./mqttService.mjs";
import { signalRService } from "./signalRService.mjs";
import { socketioService } from "./socketIOService.mjs";
import { determinePlatform } from "../../tools/determinePlatform.mjs";

export const notifier = async (userId) => {
    const memberIds = await getMembers(userId);
    if (!memberIds) {
        return;
    }
    for (const memberId of memberIds) {
        try {
            const platform = await determinePlatform(memberId);
            switch (platform) {
                case 'watch':
                    mqttService.notify(memberId, 'Notification message for watch users');
                    console.log("watch notif link works")
                    break;
                case 'mobile':
                    signalRService.notify(memberId, 'Notification message for mobile app users');
                    console.log("mobile notif link works")
                    break;
                case 'web':
                    socketioService.notify(memberId, 'Notification message for web users');
                    console.log("web notif link works")
                    break;
                default:
                    console.error(`Unsupported platform for user ${memberId}`);
            }
        } catch (error) {
            console.error(`Error notifying user ${memberId}:`, error);
        }
    }
};

const getMembers = async (userId) => {
    const dbConnection = await connect(); 
    let memberIds = [];
    const getGroupsQueryString = `SELECT t_groups.groupId FROM t_groups JOIN t_users ON t_groups.fkUser = t_users.userId WHERE t_users.userId = ?`;
    const getMembersQueryString = `SELECT t_users.userId FROM t_users JOIN t_group_members ON t_group_members.fkUser = t_users.userId WHERE t_group_members.fkGroup = ?`;
    try {
        const [groups] = await dbConnection.execute(getGroupsQueryString, [userId]);
        if (groups.length <= 0) {
            return false;
        }
        for (const group of groups) {
            const groupId = group.groupId;
            const [members] = await dbConnection.execute(getMembersQueryString, [groupId]);
            memberIds.push(...members.map(member => member.userId));
        }
        return memberIds;
    } catch (error) {
        console.error("Error fetching users:", error);
        throw error;
    }
};
