import { connect } from "../connectToDatabase.mjs";
import { mqttService } from "./mqttService.mjs";
import { signalRService } from "./signalRService.mjs";
import { socketioService } from "./socketIOService.mjs";

export const notifier = async (userId) => {

    const memberIds = await getMembers(userId);

    memberIds.forEach(memberId => {
        const platform = determinePlatform(memberId);
        switch (platform) {
            case 'watch':
                mqttService.notify(memberId, 'Notification message for watch users');
                break;
            case 'mobile':
                signalRService.notify(memberId, 'Notification message for mobile app users');
                break;
            case 'web':
                socketIOService.notify(memberId, 'Notification message for web users');
                break;
            default:
                console.error(`Unsupported platform for user ${memberId}`);
        }
    });
}

const getMembers = async (userId) => {
    const dbConnection = await connect(); 
    let memberIds = []
    const getGroupsQueryString = `SELECT t_groups.groupId FROM t_groups JOIN t_users ON t_groups.fkUser = t_users.userId WHERE t_users.userId = ?`;
    const getMemebersQueryString = `SELECT t_users.userId FROM t_users JOIN t_group_members ON t_group_members.fkUser = t_users.userId WHERE t_group_members.fkGroup = ?`;
    try {
        const [groups] = await dbConnection.execute(getGroupsQueryString, [userId]);
        // user doesn't have any groups
        if (groups.length <= 0) {
            return 
        }
        else
        {
            for (let index = 0; index < groups.length; index++) {
                const groupId = groups[index].groupId;
                const [members] = await dbConnection.execute(getMemebersQueryString, [groupId]);
                memberIds = members;
            }
            return memberIds;
        }
    } catch (error) {
        console.error("Error fetching users:", error);
        throw error; // Re-throw the error to handle it outside
    }
};

