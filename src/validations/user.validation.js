const Joi = require('joi');
const { password, confirmPassword, objectId, firstName, lastName, phoneNumber, categoryFormat, FloatNumberFormat } = require('./custom.validation');

const createUser = {
  body: Joi.object().keys({
    firstName: Joi.string().required().custom(firstName),
    lastName: Joi.string().required().custom(lastName),
    email: Joi.string().required().email(),
    password: Joi.string().required().custom(password),
    confirmPassword: Joi.string().required().custom(confirmPassword),
    address: Joi.string().required(),
    phoneNumber: Joi.string().required().custom(phoneNumber),
    role: Joi.string(),
    isAgreeTermsAndServices: Joi.boolean().required(),
    // role: Joi.string().required().valid('user', 'admin'),
  }),
};

const getUsers = {
  query: Joi.object().keys({
    firstName: Joi.string(),
    lastName: Joi.string(),
    role: Joi.string(),
    sortBy: Joi.string(),
    limit: Joi.number().integer(),
    page: Joi.number().integer(),
  }),
};

const getUser = {
  params: Joi.object().keys({
    userId: Joi.string().custom(objectId),
  }),
};

const updateUser = {
  params: Joi.object().keys({
    userId: Joi.required().custom(objectId),
  }),
  body: Joi.object()
    .keys({
      email: Joi.string().email(),
      password: Joi.string().custom(password),
      name: Joi.string(),
    })
    .min(1),
};

const deleteUser = {
  params: Joi.object().keys({
    userId: Joi.string().custom(objectId),
  }),
};

const createCarbonCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    categoryType: Joi.string().required().custom(categoryFormat),
    totalKgCo2OfHome: Joi.string(),
    totalKgCo2OfMobility: Joi.string(),
    totalKgCo2OfGear: Joi.string(),
    totalKgCo2OfOthers: Joi.string(),
    totalKgCo2OfPublicServiceShare: Joi.string()
  }),
};

const createHomeCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    totalKgCo2OfHome: Joi.string().required().custom(FloatNumberFormat)
  }),
};

const createMobilityCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    totalKgCo2OfMobility: Joi.string().required().custom(FloatNumberFormat)
  }),
};

const createGearCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    totalKgCo2OfGear: Joi.string().required().custom(FloatNumberFormat)
  }),
};

const createOtherCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    totalKgCo2OfOthers: Joi.string().required().custom(FloatNumberFormat)
  }),
};

const createPublicShareCategory = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    totalKgCo2OfPublicServiceShare: Joi.string().required().custom(FloatNumberFormat)
  }),
};

const getAllCalculationByUserId = {
  params: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
  }),
};

const createTips = {
  body: Joi.object().keys({
    userId: Joi.string().required().custom(objectId),
    tipsQuestion: Joi.string().required(),
    tipsDescription: Joi.string()
  }),
};

const updateTips = {
  body: Joi.object().keys({
    tipsId: Joi.string().required().custom(objectId),
    tipsQuestion: Joi.string(),
    tipsDescription: Joi.string()
  }),
};

const deleteTips = {
  body: Joi.object().keys({
    tipsId: Joi.string().required().custom(objectId)
  }),
};

module.exports = {
  createUser,
  getUsers,
  getUser,
  updateUser,
  deleteUser,
  createCarbonCategory,
  createHomeCategory,
  createMobilityCategory,
  createGearCategory,
  createOtherCategory,
  createPublicShareCategory,
  getAllCalculationByUserId,
  createTips,
  updateTips,
  deleteTips
};
