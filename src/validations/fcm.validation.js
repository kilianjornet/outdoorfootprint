const Joi = require("joi");

const sendNotificationToAllUser = {
  body: Joi.object().keys({
    title: Joi.string().required(),
    content: Joi.string().required(),
  }),
};

module.exports = {
    sendNotificationToAllUser
};
