const httpStatus = require("http-status");
const catchAsync = require("../utils/catchAsync");
const fcmService = require("../services/fcm.service");
const customMessage = require("../utils/customMessage");

const sendNotificationToAllUser = catchAsync(async (req, res) => {
  const send_all = await fcmService.sendNotificationToAllUser(
    req.body.title,
    req.body.content
  );
  if (send_all) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.NOTIFICATION_SEND_SUCCESS,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR,
    });
  }
});
const getAllNotificationAdmin = catchAsync(async (req, res) => {
    const all_notification = await fcmService.getAllNotificationAdmin(
    );
    if (all_notification.length>0) {
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.DEFAULT_SUCCESS,
        all_notification
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.NO_DATA_FOUND,
      });
    }
  });

  const getAllNotificationApp = catchAsync(async (req, res) => {
    const all_notification = await fcmService.getAllNotificationApp(
    );
    if (all_notification.length>0) {
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.DEFAULT_SUCCESS,
        all_notification
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.NO_DATA_FOUND,
      });
    }
  });

module.exports = {
  sendNotificationToAllUser,
  getAllNotificationAdmin,
  getAllNotificationApp
};
