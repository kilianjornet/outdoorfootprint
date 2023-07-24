const Joi = require("joi");
const {
  objectId,
  password,
  confirmPassword,
  firstName,
  lastName,
  phoneNumber,
  GearQtyNumber,
} = require("./custom.validation");

const register = {
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
  }),
};

const login = {
  body: Joi.object().keys({
    email: Joi.string().required(),
    password: Joi.string().required(),
  }),
};

const logout = {
  body: Joi.object().keys({
    refreshToken: Joi.string().required(),
  }),
};

const refreshTokens = {
  body: Joi.object().keys({
    refreshToken: Joi.string().required(),
  }),
};

const forgotPassword = {
  body: Joi.object().keys({
    email: Joi.string().email().required(),
    role: Joi.string(),
  }),
};

const resetPassword = {
  body: Joi.object().keys({
    token: Joi.string().required(),
    password: Joi.string().required().custom(password),
  }),
};

const verifyEmail = {
  body: Joi.object().keys({
    otp: Joi.string().required(),
  }),
};
const addDeviceToken = {
  body: Joi.object().keys({
    device_token: Joi.string().required(),
  }),
};
const verifyForgotPassword = {
  body: Joi.object().keys({
    role: Joi.string(),
    email: Joi.string().required(),
    otp: Joi.string().required(),
  }),
};

const updateProfile = {
  authorization: Joi.object().keys({
    token: Joi.string().required(),
  }),
  FormData: Joi.object().keys({
    userId: Joi.string().custom(objectId),
  }),
};

const createGear = {
  authorization: Joi.object().keys({
    token: Joi.string().required(),
  }),
  body: Joi.object().keys({
    userId: Joi.string().custom(objectId),
    quantityOfRunShoes: Joi.string().required().custom(GearQtyNumber),
    quantityOfSkies: Joi.string().required().custom(GearQtyNumber),
    quantityOfClimbRope: Joi.string().required().custom(GearQtyNumber),
    quantityOfClimbGear: Joi.string().required().custom(GearQtyNumber),
    quantityOfBike: Joi.string().required().custom(GearQtyNumber),
    quantityOfPoliesterTees: Joi.string().required().custom(GearQtyNumber),
    quantityOfCottonTees: Joi.string().required().custom(GearQtyNumber),
    quantityOfJacket: Joi.string().required().custom(GearQtyNumber),
    quantityOfUnderwearSocks: Joi.string().required().custom(GearQtyNumber),
    quantityOfPants: Joi.string().required().custom(GearQtyNumber),
    quantityOfGlobes: Joi.string().required().custom(GearQtyNumber),
    quantityOfSportswear: Joi.string().required().custom(GearQtyNumber),
    quantityOfSkiclothes: Joi.string().required().custom(GearQtyNumber),
    quantityOfSwimwear: Joi.string().required().custom(GearQtyNumber),
    quantityOfSmartwatch: Joi.string().required().custom(GearQtyNumber),
    quantityOfTent: Joi.string().required().custom(GearQtyNumber),
    quantityOfCustomProducts: Joi.string().required().custom(GearQtyNumber),
  }),
};

module.exports = {
  register,
  login,
  logout,
  refreshTokens,
  forgotPassword,
  resetPassword,
  verifyEmail,
  updateProfile,
  createGear,
  verifyForgotPassword,
  addDeviceToken
};
