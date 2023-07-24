const httpStatus = require("http-status");
const tokenService = require("./token.service");
const userService = require("./user.service");
const Token = require("../models/token.model");
const ApiError = require("../utils/ApiError");
const { tokenTypes } = require("../config/tokens");

/**
 * Login with username and password
 * @param {string} email
 * @param {string} password
 * @returns {Promise<User>}
 */
const loginUserWithEmailAndPassword = async (email, password) => {
  const user = await userService.getUserByEmail(email);
  if (!user || !(await user.isPasswordMatch(password))) {
    throw new ApiError(httpStatus.UNAUTHORIZED, "Incorrect email or password");
  }
  return user;
};

/**
 * Logout
 * @param {string} refreshToken
 * @returns {Promise}
 */
const logout = async (refreshToken) => {
  const refreshTokenDoc = await Token.findOne({
    token: refreshToken,
    type: tokenTypes.REFRESH,
    blacklisted: false,
  });
  if (!refreshTokenDoc) {
    throw new ApiError(httpStatus.NOT_FOUND, "Not found");
  }
  await refreshTokenDoc.remove();
};

/**
 * Refresh auth tokens
 * @param {string} refreshToken
 * @returns {Promise<Object>}
 */
const refreshAuth = async (refreshToken) => {
  try {
    const refreshTokenDoc = await tokenService.verifyToken(
      refreshToken,
      tokenTypes.REFRESH
    );
    const user = await userService.getUserById(refreshTokenDoc.user);
    if (!user) {
      throw new Error();
    }
    await refreshTokenDoc.remove();
    return tokenService.generateAuthTokens(user);
  } catch (error) {
    console.log("error", error);
    throw new ApiError(httpStatus.UNAUTHORIZED, "Please authenticate");
  }
};

/**
 * Reset password
 * @param {string} resetPasswordToken
 * @param {string} newPassword
 * @returns {Promise}
 */
const resetPassword = async (resetPasswordToken, newPassword) => {
  try {
    const resetPasswordTokenDoc = await tokenService.verifyToken(resetPasswordToken, tokenTypes.RESET_PASSWORD);
    const user = await userService.getUserById(resetPasswordTokenDoc.user);
    if (!user) {
      return false;
    }
    await userService.updateUserById(user.id, { password: newPassword });
    await Token.deleteMany({ user: user.id, type: tokenTypes.RESET_PASSWORD });
    return true;
  } catch (error) {
    return false;
    // throw new ApiError(httpStatus.UNAUTHORIZED, 'Password reset failed');
  }
  // try {
  //   const user = await userService.getUserByEmail(email);
  //   if (!user || !(await user.isPasswordMatch(oldPassword))) {
  //     return false;
  //     // throw new ApiError(
  //     //   httpStatus.UNAUTHORIZED,
  //     //   "Incorrect email or password"
  //     // );
  //   }
  //   const setPass = await userService.updateUserById(user.id, { password: newPassword });
  //   if (setPass) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  //   // const resetPasswordTokenDoc = await tokenService.verifyToken(
  //   //   resetPasswordToken,
  //   //   tokenTypes.RESET_PASSWORD
  //   // );
  //   // const user = await userService.getUserById(resetPasswordTokenDoc.user);
  //   // if (!user) {
  //   //   throw new Error();
  //   // }
  //   // await userService.updateUserById(user.id, { password: newPassword });
  //   // await Token.deleteMany({ user: user.id, type: tokenTypes.RESET_PASSWORD });
  // } catch (error) {
  //   return false;
  //   // throw new ApiError(httpStatus.UNAUTHORIZED, "Password reset failed");
  // }
};

/**
 * Verify email
 * @param {string} verifyEmailToken
 * @returns {Promise}
 */
const verifyEmail = async (ReqUser, otp) => {
  try {
    // const verifyEmailTokenDoc = await tokenService.verifyToken(verifyEmailToken, tokenTypes.VERIFY_EMAIL);
    // const user = await userService.getUserById(verifyEmailTokenDoc.user);
    const Verify = await userService.userOtpVerify(ReqUser._id, otp);
    if (!Verify) {
      return false;
    }
    // await Token.deleteMany({ user: user.id, type: tokenTypes.VERIFY_EMAIL });
    await userService.updateUserById(ReqUser._id, {
      isEmailVerified: true,
      otp: "",
    });
    return true;
  } catch (error) {
    console.log("error", error);
    return false;
  }
};
const verifyForgotPassword = async (ReqUser, otp) => {
  try {
    // const verifyEmailTokenDoc = await tokenService.verifyToken(verifyEmailToken, tokenTypes.VERIFY_EMAIL);
    // const user = await userService.getUserById(verifyEmailTokenDoc.user);
    const Verify = await userService.userOtpVerify(ReqUser._id, otp);
    if (!Verify) {
      return false;
    }
    // await Token.deleteMany({ user: user.id, type: tokenTypes.VERIFY_EMAIL });
    await userService.updateUserById(ReqUser._id, {
      isEmailVerified: true,
      otp: "",
    });
    return true;
  } catch (error) {
    console.log("error", error);
    return false;
  }
};

module.exports = {
  loginUserWithEmailAndPassword,
  logout,
  refreshAuth,
  resetPassword,
  verifyEmail,
  verifyForgotPassword,
};
