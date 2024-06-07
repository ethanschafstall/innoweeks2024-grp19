import mqtt from 'mqtt';
import dotenv from 'dotenv';

dotenv.config();

const topic = process.env.MQTT_BASE_TOPIC_STRING;
const url = process.env.MQTT_URL;

export const mqttService = {
    notify: (memberId, sender) => {
        const client = mqtt.connect(url);
        client.on('connect', () => {
            console.log('Connected to MQTT broker');

            const message = `${sender.username} is feeling ${sender.mood}`;
            const fullTopic = `${topic}${memberId}`;
            
            client.publish(fullTopic, message, (err) => {
                if (err) {
                    console.error('Failed to publish message', err);
                } else {
                    console.log(`Message published successfully to ${fullTopic}: ${message}`);
                }
                
                client.end();
            });
        });

        client.on('error', (err) => {
            console.error('Connection error:', err);
        });

        client.on('close', () => {
            console.log('Connection to MQTT broker closed');
        });
    }
};
