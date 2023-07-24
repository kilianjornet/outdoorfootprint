const httpStatus = require("http-status");
const catchAsync = require("../utils/catchAsync");
const customMessage = require("../utils/customMessage");
const {
  authService,
  userService,
  tokenService,
  emailService,
} = require("../services");
const {
  User,
  Gear,
  userCarbon,
  userHome,
  userMobility,
  userGear,
  userOther,
  userPublicShare,
} = require("../models");
const ApiError = require("../utils/ApiError");

const register = catchAsync(async (req, res) => {
  const user = await userService.createUser(req.body);
  if (user.role == "user") {
    const createdUserId = user._id;
    const user_home_data = new userHome({
      user: createdUserId,
    });
    await user_home_data.save().then((homeData) => {
      console.log("object created homeData:111", homeData);
    });
    const user_mobility_data = new userMobility({
      user: createdUserId,
    });
    await user_mobility_data.save().then((mobilityData) => {
      console.log("object created mobilityData:111", mobilityData);
    });
    const user_gear_data = new userGear({
      user: createdUserId,
    });
    await user_gear_data.save().then((gearData) => {
      console.log("object created gearData:111", gearData);
    });
    const user_other_data = new userOther({
      user: createdUserId,
    });
    await user_other_data.save().then((otherData) => {
      console.log("object created otherData:111", otherData);
    });
    const user_public_data = new userPublicShare({
      user: createdUserId,
    });
    await user_public_data.save().then((publicData) => {
      console.log("object created publicData:111", publicData);
    });
  }
  const tokens = await tokenService.generateAuthTokens(user);
  if (user.role == "user") {
    res.status(httpStatus.CREATED).send({
      status: true,
      message: customMessage.english.REGISTRATION_SUCCESS,
      tokens,
    });
  } else {
    res.status(httpStatus.CREATED).send({
      status: true,
      message: customMessage.english.REGISTRATION_SUCCESS,
      user,
      tokens,
    });
  }
});

const login = catchAsync(async (req, res) => {
  const { email, password } = req.body;
  const user = await authService.loginUserWithEmailAndPassword(email, password);
  const tokens = await tokenService.generateAuthTokens(user);
  if (user.role == "user") {
    if (user.isEmailVerified) {
      res.send({
        status: true,
        message: customMessage.english.LOGIN_SUCCESS,
        tokens,
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.NEED_EMAIL_VERIFY,
        tokens,
      });
    }
  } else {
    const tokens = await tokenService.generateAuthTokens(user);
    res.send({
      status: true,
      message: customMessage.english.LOGIN_SUCCESS,
      user,
      tokens,
    });
  }
});

const logout = catchAsync(async (req, res) => {
  await authService.logout(req.body.refreshToken);
  res.status(httpStatus.NO_CONTENT).send();
});

const refreshTokens = catchAsync(async (req, res) => {
  const tokens = await authService.refreshAuth(req.body.refreshToken);
  res.send({ ...tokens });
});

const forgotPassword = catchAsync(async (req, res) => {
  if (req.body.role == "admin") {
    const adminExist = await User.findOne({
      email: req.body.email,
      role: "admin",
      isDelete: false,
    });
    if (!adminExist) {
      return res.status(httpStatus.UNAUTHORIZED).send({
        status: false,
        message: customMessage.english.NOT_A_ADMIN,
      });
    }
    // console.log("adminExist", adminExist);
    const sentEmail = await emailService.sendForgotOtpEmail(
      adminExist.email,
      adminExist.firstName + " " + adminExist.lastName,
      adminExist._id
    );
    if (sentEmail) {
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.FORGOT_EMAIL_SENT,
      });
    } else {
      res.status(httpStatus.UNAUTHORIZED).send({
        status: false,
        message: customMessage.english.DEFAULT_ERROR,
      });
    }
  } else {
    const userExist = await User.findOne({
      email: req.body.email,
      role: "user",
      isDelete: false,
    });
    if (!userExist) {
      return res.status(httpStatus.UNAUTHORIZED).send({
        status: false,
        message: customMessage.english.NOT_A_USER,
      });
    }
    // console.log("userExit", userExist);
    const sentEmail = await emailService.sendForgotOtpEmail(
      userExist.email,
      userExist.firstName + " " + userExist.lastName,
      userExist._id
    );
    if (sentEmail) {
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.FORGOT_EMAIL_SENT,
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.DEFAULT_ERROR,
      });
    }
  }
  // const resetPasswordToken = await tokenService.generateResetPasswordToken(
  //   req.body.email
  // );
  // await emailService.sendResetPasswordEmail(req.body.email, resetPasswordToken);
  // res.status(httpStatus.NO_CONTENT).send();
});

const resetPassword = catchAsync(async (req, res) => {
  const resetPass = await authService.resetPassword(
    req.body.token,
    req.body.password
  );
  if (resetPass) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.RESET_PASSWORD,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.RESET_PASSWORD_FAILED,
    });
  }
  // res.status(httpStatus.NO_CONTENT).send();
});

const sendVerificationEmail = catchAsync(async (req, res) => {
  // delete req.user.email;
  // req.user.email = "debabrata.kandar@brainiuminfotech.com";
  // console.log("request:---", req.user);
  // const verifyEmailToken = await tokenService.generateVerifyEmailToken(
  //   req.user
  // );
  const sentEmail = await emailService.sendVerificationEmail(
    req.user.email,
    req.user.firstName + " " + req.user.lastName,
    req.user._id
  );
  if (sentEmail) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.REGISTRATION_SUCCESS,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR,
    });
  }
});

const verifyEmail = catchAsync(async (req, res) => {
  const verify = await authService.verifyEmail(req.user, req.body.otp);
  if (verify) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.SUCCESS_OTP,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.INVALID_OTP,
    });
  }
  // res.status(httpStatus.NO_CONTENT).send();
});
const verifyForgotPassword = catchAsync(async (req, res) => {
  if (req.body.role == "admin") {
    const adminExist = await User.findOne({
      email: req.body.email,
      role: "admin",
      isDelete: false,
    });
    if (!adminExist) {
      return res.status(httpStatus.UNAUTHORIZED).send({
        status: false,
        message: customMessage.english.NOT_A_ADMIN,
      });
    }
    const verify = await authService.verifyForgotPassword(
      adminExist,
      req.body.otp
    );
    if (verify) {
      const resetPasswordToken = await tokenService.generateResetPasswordToken(
        adminExist.email
      );
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.SUCCESS_OTP,
        token: resetPasswordToken,
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.INVALID_OTP,
      });
    }
  } else {
    const userExist = await User.findOne({
      email: req.body.email,
      role: "user",
      isDelete: false,
    });
    if (!userExist) {
      return res.status(httpStatus.UNAUTHORIZED).send({
        status: false,
        message: customMessage.english.NOT_A_USER,
      });
    }
    const verify = await authService.verifyForgotPassword(
      userExist,
      req.body.otp
    );
    if (verify) {
      const resetPasswordToken = await tokenService.generateResetPasswordToken(
        userExist.email
      );
      res.status(httpStatus.OK).send({
        status: true,
        message: customMessage.english.SUCCESS_OTP,
        token: resetPasswordToken,
      });
    } else {
      res.status(httpStatus.CONFLICT).send({
        status: false,
        message: customMessage.english.INVALID_OTP,
      });
    }
  }

  // res.status(httpStatus.NO_CONTENT).send();
});

const updateProfile = catchAsync(async (req, res) => {
  const user = await userService.updateUser(req.body, req.files);
  // res.send(user);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATED_SUCCESSFULLY,
    user
  });
});
const updateDeviceToken = catchAsync(async (req, res) => {
  const updateToken = await userService.updateUserDeviceToken(req.user.id,req.body.device_token);
  // res.send(user);
  if (updateToken) {
    return res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.UPDATED_SUCCESSFULLY
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR
    });
  }
  
});
const removeDeviceToken = catchAsync(async (req, res) => {
  const updateToken = await userService.removeUserDeviceToken(req.user.id,req.body.device_token);
  // res.send(user);
  if (updateToken) {
    return res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.UPDATED_SUCCESSFULLY
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR
    });
  }
  
});

const createGear = catchAsync(async (req, res) => {
  const userGear = await userService.createUserGear(req.body);
  res.send(userGear);
});
const blockUser = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id);
  const userBlock = await userService.deleteUserById(req.params.id);
  if (userBlock) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.USER_BLOCK_SUCCESSFULLY,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR,
    });
  }
});

const unblockUser = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id);
  const userBlock = await userService.restoreUserById(req.params.id);
  if (userBlock) {
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.USER_UNBLOCK_SUCCESSFULLY,
    });
  } else {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.DEFAULT_ERROR,
    });
  }
});

module.exports = {
  register,
  login,
  logout,
  refreshTokens,
  forgotPassword,
  resetPassword,
  sendVerificationEmail,
  verifyEmail,
  updateProfile,
  createGear,
  verifyForgotPassword,
  blockUser,
  unblockUser,
  updateDeviceToken,
  removeDeviceToken
};
