const config = require('./config');
var admin = require("firebase-admin");
var fcmReady = false;
if (config.fcm_auth.type === "service_account") {
    admin.initializeApp({
        credential: admin.credential.cert(config.fcm_auth),
        //databaseURL: "<your database URL here>"
    });
    fcmReady = true;
}

const sendViaFCM = async (registrationToken,payload, topic) => {
    if (fcmReady) {
        if (registrationToken) {
            return admin.messaging().sendToDevice(registrationToken, payload, {
                priority: "high",
                timeToLive: 60 * 60 * 24
            })
        } else if (topic) {
            return admin.messaging().sendToTopic(topic, payload, {
                priority: "high",
                timeToLive: 60 * 60 * 24
            });
        } else {
            return Promise.reject('registration token or topic needed');
        }
    } else {
        return Promise.reject('FCM not configured')
    }
};
const registerDeviceToTopic = async (registrationToken, topic) => {
    if (fcmReady) {
        return admin.messaging().subscribeToTopic(registrationToken, topic)
    } else {
        return Promise.reject('FCM not configured')
    }
}
const unRegisterDeviceToTopic = async (registrationToken, topic) => {
    if (fcmReady) {
        return admin.messaging().unsubscribeFromTopic(registrationToken, topic)
    } else {
        return Promise.reject('FCM not configured')
    }
}

module.exports = {
    sendViaFCM,
    registerDeviceToTopic,
    unRegisterDeviceToTopic
};
