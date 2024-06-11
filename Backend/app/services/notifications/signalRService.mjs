import { HubConnectionBuilder } from "@microsoft/signalr";

const connections = new Map();

const signalRService = {
    init() {
        this.connection = new HubConnectionBuilder()
            .withUrl("YOUR_SIGNALR_HUB_URL")
            .build();

        this.connection.start()
            .then(() => console.log("SignalR Connected"))
            .catch(err => console.error("SignalR Connection Error: ", err));
        
        this.connection.on("UserConnected", (userId, connectionId) => {
            connections.set(userId, connectionId);
        });

        this.connection.on("UserDisconnected", (userId) => {
            connections.delete(userId);
        });
    },
    notify(memberId, sender) {
        const notification = `${sender.username} is feeling ${sender.mood}`;
        const connectionId = connections.get(memberId);
        if (!connectionId) {
            console.error("User not connected.");
            return;
        }

        this.connection.invoke("SendNotificationToMaui", connectionId, notification)
            .then(() => console.log("Notification sent successfully"))
            .catch(error => console.error("Error sending notification: ", error));
    },
    getConnection(userId) {
        return connections.get(userId);
    }
};

export default signalRService;
