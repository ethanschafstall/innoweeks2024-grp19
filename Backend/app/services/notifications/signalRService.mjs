import { HubConnectionBuilder } from "@microsoft/signalr";

const signalRService = {
    connection: null,
    init() {
        this.connection = new HubConnectionBuilder()
            .withUrl("YOUR_SIGNALR_HUB_URL")
            .build();

        this.connection.start()
            .then(() => console.log("SignalR Connected"))
            .catch(err => console.error("SignalR Connection Error: ", err));
    },
    notify(memberId, sender) {
        const notification = `${sender.username} is feeling ${sender.mood}`;
        if (!this.connection) {
            console.error("SignalR connection not initialized.");
            return;
        }

        this.connection.invoke("SendNotificationToMaui", notification)
            .then(() => console.log("Notification sent successfully"))
            .catch(error => console.error("Error sending notification: ", error));
    }
};

export default signalRService;
