const httpStatus = require('http-status');
const pick = require('../utils/pick');
const ApiError = require('../utils/ApiError');
const catchAsync = require('../utils/catchAsync');
const { userService } = require('../services');
const customMessage = require('../utils/customMessage');


const createUser = catchAsync(async (req, res) => {
  const user = await userService.createUser(req.body);
  res.status(httpStatus.CREATED).send(user);
});

const getUsers = catchAsync(async (req, res) => {
  const filter = pick(req.query, ['firstName','lastName', 'role']);
  const options = pick(req.query, ['sortBy', 'limit', 'page']);
  const result = await userService.queryUsers(filter, options);
  res.send(result);
});

const getUser = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, 'User not found');
  }
  res.send(user);
});
const getProfile = catchAsync(async (req, res) => {
  const user = await userService.getUserByIdApp(req.user._id);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found');
    return res.status(httpStatus.UNAUTHORIZED).send({
      status: false,
      message: customMessage.english.ERROR_GET_PROFILE,
      user
    });
  }
  // res.send(user);
  return res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.SUCCESS,
    user
  });
});

const updateUser = catchAsync(async (req, res) => {
  const user = await userService.updateUserById(req.params.userId, req.body);
  res.send(user);
});

const deleteUser = catchAsync(async (req, res) => {
  await userService.deleteUserById(req.params.userId);
  res.status(httpStatus.NO_CONTENT).send();
});
// createCarbonCategory
const createCarbonCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
  }
  await userService.createUserCarbonCalculation(req.body);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
  // res.send(userCarbonCalculate);
});

const createHomeCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const userHomeCarbonCalculate = await userService.createUserHomeCarbonCalculation(req.body);
  // res.status(httpStatus.CREATED).send(userHomeCarbonCalculate);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const createMobilityCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const userMobilityCarbonCalculate = await userService.createUserMobilityCarbonCalculation(req.body);
  // res.status(httpStatus.CREATED).send(userMobilityCarbonCalculate);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const createGearCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const userGearCarbonCalculate = await userService.createUserGearCarbonCalculation(req.body);
  // res.status(httpStatus.CREATED).send(userGearCarbonCalculate);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const createOtherCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const userOtherCarbonCalculate = await userService.createUserOtherCarbonCalculation(req.body);
  // res.status(httpStatus.CREATED).send(userOtherCarbonCalculate);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const createPublicShareCategory = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const userPublicShareCarbonCalculate = await userService.createUserPublicShareCarbonCalculation(req.body);
  // res.status(httpStatus.CREATED).send(userPublicShareCarbonCalculate);
  res.status(httpStatus.CREATED).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const getAllCalculationByUserId = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.user.id);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const allCalculationByUserId = await userService.getAllCalculationYearByUserId(req.user.id);
  // res.status(httpStatus.OK).send(allCalculationByUserId);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.DEFAULT_SUCCESS,
    allCalculationByUserId
  });
});
const getAllCalculationByUserIdAdmin = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const allCalculationByUserId = await userService.getAllCalculationYearByUserId(req.params.userId);
  // res.status(httpStatus.OK).send(allCalculationByUserId);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.DEFAULT_SUCCESS,
    allCalculationByUserId
  });
});

const getAllCalculationFourYearByUserId = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.user.id);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const fourYearData = await userService.getAllCalculationFourYearByUserId(req.user.id);
  // res.status(httpStatus.OK).send(allCalculationByUserId);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.DEFAULT_SUCCESS,
    fourYearData
  });
});
const getAllCalculationFourYearByUserIdAdmin = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.params.id);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  const fourYearData = await userService.getAllCalculationFourYearByUserId(req.params.id);
  // res.status(httpStatus.OK).send(allCalculationByUserId);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.DEFAULT_SUCCESS,
    fourYearData
  });
});

const getAllUsersCalculation = catchAsync(async (req, res) => {
  const allUserCalculation = await userService.getAllUsersCalculation();
  // res.status(httpStatus.OK).send(allUserCalculation);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS,
    allUserCalculation
  });
  
  // return res.json({ ab: "hi"});
});

const createTips = catchAsync(async (req, res) => {
  const user = await userService.getUserById(req.body.userId);
  if (!user) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'User not found, Please give a valid user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_USER
    });
  }
  if (user.role !== 'admin' && user.isDelete == false) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Please give a valid admin user id');
    res.status(httpStatus.CONFLICT).send({
      status: false,
      message: customMessage.english.NOT_A_ADMIN
    });
  }
  const createTipsByAdminId = await userService.createTipsByAdminId(req.body);
  // res.status(httpStatus.CREATED).send(createTipsByAdminId);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS
  });
});

const getAllTipData = catchAsync(async (req, res) => {
  const allTipsData = await userService.getAllTipsData();
  // res.status(httpStatus.OK).send(allTipsData);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS,
    allTipsData
  });
});

const getTipsData = catchAsync(async (req, res) => {
  const tipsData = await userService.getTipsDataById(req.params);
  // res.status(httpStatus.OK).send(tipsData);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.SUBMIT_SUCCESS,
    tipsData
  });
});

const updateTips = catchAsync(async (req, res) => {
  const updateByTipsId = await userService.updateDataByTipsId(req.body);
  res.status(httpStatus.OK).send(updateByTipsId);
});

const deleteTips = catchAsync(async (req, res) => {
  const deleteByTipsId = await userService.deleteDataByTipsId(req.body);
  res.status(httpStatus.NO_CONTENT).send(deleteByTipsId);
});

module.exports = {
  createUser,
  getUsers,
  getUser,
  getProfile,
  updateUser,
  deleteUser,
  createCarbonCategory,
  createHomeCategory,
  createMobilityCategory,
  createGearCategory,
  createOtherCategory,
  createPublicShareCategory,
  getAllCalculationByUserId,
  getAllUsersCalculation,
  createTips,
  getAllTipData,
  getTipsData,
  updateTips,
  deleteTips,
  getAllCalculationFourYearByUserId,
  getAllCalculationFourYearByUserIdAdmin,
  getAllCalculationByUserIdAdmin
};
