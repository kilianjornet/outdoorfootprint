var fcmNotificationSchema = require("../models/fcm.model");
var userSchema = require("../models/user.model");
var fcmAuth = require("../config/fcm");

exports.sendNotificationToAllUser = async (title, content) => {
  const allUser = await userSchema.find({
    $and: [
      {
        device_tokens: { $exists: true, $ne: [] },
      },
      {
        isDelete: false,
      },
      {
        role: "user",
      },
    ],
  });
  try {
    if (allUser.length > 0) {
      for (const user of allUser) {
        user.device_tokens.forEach(async (dtoken) => {
          // console.log("dtoken", dtoken);
          await fcmAuth.sendViaFCM(
            dtoken,
            {
              notification: {
                title: title,
                body: content,
              },
            },
            null
          );
        });
      }
      await fcmNotificationSchema.model.create({
        role: "all_user",
        role_count: allUser.length.toString(),
        title: title,
        content: content,
      });
      return true;
    } else {
      return false;
    }
  } catch (e) {
    console.log("FCM error", e);
    return false;
  }
};
exports.getAllNotificationAdmin = async () => {
    return await fcmNotificationSchema.model.find({});
};
exports.getAllNotificationApp = async () => {
    return await fcmNotificationSchema.model.find({}).select('_id title content created_at updated_at');
};
