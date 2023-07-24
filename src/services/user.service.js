const httpStatus = require("http-status");
const {
  User,
  Gear,
  userCarbon,
  userHome,
  userMobility,
  userGear,
  userOther,
  userPublicShare,
  Tip,
} = require("../models");
const ApiError = require("../utils/ApiError");
const { findById } = require("mongoose/lib/model");
// const localhostUrl = "http://localhost:3000";
const localhostUrl = "https://nodeserver.mydevfactory.com:6006";
/**
 * Create a user
 * @param {Object} userBody
 * @returns {Promise<User>}
 */
const createUser = async (userBody) => {
  const userEmailCheck = await User.findOne({
    email: userBody.email,
    isDelete: false,
  });
  const userPhoneCheck = await User.findOne({
    phoneNumber: userBody.phoneNumber,
    isDelete: false,
  });
  if (userPhoneCheck) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Phone number already exists");
  }
  if (userEmailCheck) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already exists");
  }
  if (await User.isEmailTaken(userBody.email)) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }
  if (await User.isPhoneNumberTaken(userBody.phoneNumber)) {
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      "Phone number already exists! Please give another phone number"
    );
  }
  if (userBody.password !== userBody.confirmPassword) {
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      "password and confirm password do not match, it should be same"
    );
  }
  if (
    !userBody.isAgreeTermsAndServices ||
    userBody.isAgreeTermsAndServices != true
  ) {
    throw new ApiError(
      httpStatus.BAD_REQUEST,
      "Please agree the Terms of services and Privacy Policy"
    );
  }
  return User.create(userBody);
};

/**
 * Query for users
 * @param {Object} filter - Mongo filter
 * @param {Object} options - Query options
 * @param {string} [options.sortBy] - Sort option in the format: sortField:(desc|asc)
 * @param {number} [options.limit] - Maximum number of results per page (default = 10)
 * @param {number} [options.page] - Current page (default = 1)
 * @returns {Promise<QueryResult>}
 */
const queryUsers = async (filter, options) => {
  const users = await User.paginate(filter, options);
  return users;
};

/**
 * Get user by id
 * @param {ObjectId} id
 * @returns {Promise<User>}
 */
const getUserById = async (id) => {
  return User.findById(id);
};
const getUserByIdApp = async (id) => {
  return User.findById(id).select('id firstName lastName address email phoneNumber profile_image');
};

/**
 * Get user by email
 * @param {string} email
 * @returns {Promise<User>}
 */
const getUserByEmail = async (email) => {
  return User.findOne({ email ,isDelete:false});
};

/**
 * Update user by id
 * @param {ObjectId} userId
 * @param {Object} updateBody
 * @returns {Promise<User>}
 */
const updateUserById = async (userId, updateBody) => {
  const user = await getUserById(userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  if (updateBody.email && (await User.isEmailTaken(updateBody.email, userId))) {
    throw new ApiError(httpStatus.BAD_REQUEST, "Email already taken");
  }
  Object.assign(user, updateBody);
  await user.save();
  return user;
};

/**
 * Delete user by id
 * @param {ObjectId} userId
 * @returns {Promise<User>}
 */
const deleteUserById = async (userId) => {
  const user = await getUserById(userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  user.isDelete = true;
  await user.save();
  return user;
};

const restoreUserById = async (userId) => {
  const user = await getUserById(userId);
  if (!user) {
    throw new ApiError(httpStatus.NOT_FOUND, "User not found");
  }
  user.isDelete = false;
  await user.save();
  return user;
};

const updateUser = async (updateBody, uploadFiles) => {
  const userId = updateBody.userId;
  var obj = {};
  const user = await getUserById(userId);
  if (!user) {
    throw new ApiError(
      httpStatus.NOT_FOUND,
      "User not found, Please give a valid user id"
    );
  }
  if (updateBody.email) {
    if (await User.isEmailTaken(updateBody.email)) {
      throw new ApiError(
        httpStatus.BAD_REQUEST,
        `This "${updateBody.email}" already exists, Please use another email address`
      );
    }
    obj.email = updateBody.email;
  }
  if (updateBody.phoneNumber) {
    if (await User.isPhoneNumberTaken(updateBody.phoneNumber)) {
      throw new ApiError(
        httpStatus.BAD_REQUEST,
        `This "${updateBody.phoneNumber}" already exists, Please use another phone number`
      );
    }
    obj.phoneNumber = updateBody.phoneNumber;
  }
  if (updateBody.firstName) {
    obj.firstName = updateBody.firstName;
  }
  if (updateBody.lastName) {
    obj.lastName = updateBody.lastName;
  }
  if (updateBody.address) {
    obj.address = updateBody.address;
  }
  if (uploadFiles?.profile_image) {
    const profile_image = uploadFiles.profile_image
      ? uploadFiles.profile_image.length > 0
        ? localhostUrl +
          "/uploads/user-profile-image/" +
          uploadFiles.profile_image[0].filename
        : ""
      : "";
    // const profile_image = uploadFiles.profile_image
    // ? uploadFiles.profile_image.length > 0
    //   ? localhostUrl +
    //   "/user-profile-image/" +
    //   uploadFiles.profile_image[0].filename
    //   : localhostUrl + "/user-profile-image/default_img.png"
    // : "";
    obj.profile_image = profile_image;
  }
  const updateData = await User.findByIdAndUpdate(userId, obj, {
    new: true,
  });
  const getUser = await getUserByIdApp(userId);

  return getUser;
};
const updateOtpUser = async (id, otp) => {
  try {
    await User.findByIdAndUpdate(
      {_id:id},
      { otp: otp }
    );
    return true;
  } catch (error) {
    return false;
  }
};
const userOtpVerify = async (id, otp) => {
  try {
    const otpExist = await User.findOne(
      {_id:id, otp: otp },
    );
    if (otpExist) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
};

const createUserGear = async (gearBody) => {
  try {
    const userId = gearBody.userId;
    const user = await getUserById(userId);
    if (!user) {
      throw new ApiError(
        httpStatus.NOT_FOUND,
        "User not found, Please give a valid user id"
      );
    }
    const totalKgGear =
      gearBody.quantityOfRunShoes * 13.6 +
      gearBody.quantityOfSkies * 45.2 +
      gearBody.quantityOfClimbRope * 0.25 +
      gearBody.quantityOfClimbGear * 12 +
      gearBody.quantityOfBike * 300 +
      gearBody.quantityOfPoliesterTees * 15 +
      gearBody.quantityOfCottonTees * 10 +
      gearBody.quantityOfJacket * 18 +
      gearBody.quantityOfUnderwearSocks * 1.9 +
      gearBody.quantityOfPants * 9 +
      gearBody.quantityOfGlobes * 2 +
      gearBody.quantityOfSportswear * 6.1 +
      gearBody.quantityOfSkiclothes * 15 +
      gearBody.quantityOfSwimwear * 1.8 +
      gearBody.quantityOfSmartwatch * 40 +
      gearBody.quantityOfTent * 13 +
      gearBody.quantityOfCustomProducts * 0;
    const newGearObj = new Gear({
      user: gearBody.userId,
      totalKgCo2OfGear: totalKgGear,
    });
    await newGearObj
      .save()
      .then(async (result) => {
        
        const gearId = result._id;
        const gearData = await Gear.findById(gearId);
        
        const responseData = {
          user: gearData._id,
          totalKgCo2OfGear: gearData.totalKgCo2OfGear,
        };
        return responseData;
      })
      .catch((err) => {
        console.log("object error: ", err);
      });
  } catch (e) {
    console.log("error:------??>?>?> ", e.message);
  }
};

const createUserCarbonCalculation = async (reqBody) => {
  try {
    const carbonData = new userCarbon({
      user: reqBody.userId,
      category: reqBody.categoryType,
      totalKgCo2OfHome: reqBody.totalKgCo2OfHome
        ? reqBody.totalKgCo2OfHome
        : 0.0,
      totalKgCo2OfMobility: reqBody.totalKgCo2OfMobility
        ? reqBody.totalKgCo2OfMobility
        : 0.0,
      totalKgCo2OfGear: reqBody.totalKgCo2OfGear
        ? reqBody.totalKgCo2OfGear
        : 0.0,
      totalKgCo2OfOthers: reqBody.totalKgCo2OfOthers
        ? reqBody.totalKgCo2OfOthers
        : 0.0,
      totalKgCo2OfPublicServiceShare: reqBody.totalKgCo2OfPublicServiceShare
        ? reqBody.totalKgCo2OfPublicServiceShare
        : 0.0,
    });
    return false;
  } catch (e) {
    console.log("error:------??>?>?> ", e.message);
  }
};

const createUserHomeCarbonCalculation = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdFindingHomeSchema = await userHome.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  if (userIdFindingHomeSchema) {
    const userHomeData = await userHome.updateOne(
      { user: user_id },
      { totalKgCo2OfHome: reqBody.totalKgCo2OfHome },
      { new: true }
    );
    const getData = await userHome.findOne({ user: user_id, isDelete: false });
    return getData;
  }
  const user_home_data = new userHome({
    user: reqBody.userId,
    totalKgCo2OfHome: reqBody.totalKgCo2OfHome,
  });
  const userHomeData = await user_home_data.save();
  return userHomeData;
};

const createUserMobilityCarbonCalculation = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdFindingMobtySchema = await userMobility.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  if (userIdFindingMobtySchema) {
    const userMobilityData = await userMobility.updateOne(
      { user: user_id },
      { totalKgCo2OfMobility: reqBody.totalKgCo2OfMobility },
      { new: true }
    );
    const getData = await userMobility.findOne({
      user: user_id,
      isDelete: false,
    });
    return getData;
  }
  const user_mobty_data = new userMobility({
    user: reqBody.userId,
    totalKgCo2OfMobility: reqBody.totalKgCo2OfMobility,
  });
  const userMobilityData = await user_mobty_data.save();
  return userMobilityData;
};

const createUserGearCarbonCalculation = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdFindingGearSchema = await userGear.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  if (userIdFindingGearSchema) {
    const userGearData = await userGear.updateOne(
      { user: user_id },
      { totalKgCo2OfGear: reqBody.totalKgCo2OfGear },
      { new: true }
    );
    const getData = await userGear.findOne({ user: user_id, isDelete: false });
    
    return getData;
  }
  const user_gear_data = new userGear({
    user: reqBody.userId,
    totalKgCo2OfGear: reqBody.totalKgCo2OfGear,
  });
  const userGearData = await user_gear_data.save();
  return userGearData;
};

const createUserOtherCarbonCalculation = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdFindingOtherSchema = await userOther.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  if (userIdFindingOtherSchema) {
    const userOtherData = await userOther.updateOne(
      { user: user_id },
      { totalKgCo2OfOthers: reqBody.totalKgCo2OfOthers },
      { new: true }
    );
    const getData = await userOther.findOne({ user: user_id, isDelete: false });
    return getData;
  }
  const user_other_data = new userOther({
    user: reqBody.userId,
    totalKgCo2OfOthers: reqBody.totalKgCo2OfOthers,
  });

  const userOtherData = await user_other_data.save();
  return userOtherData;
};

const createUserPublicShareCarbonCalculation = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdFindingPublicShareSchema = await userPublicShare.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  if (userIdFindingPublicShareSchema) {
    
    const userPublicShareData = await userPublicShare.updateOne(
      { user: user_id },
      {
        totalKgCo2OfPublicServiceShare: reqBody.totalKgCo2OfPublicServiceShare,
      },
      { new: true }
    );
    
    const getData = await userPublicShare.findOne({
      user: user_id,
      isDelete: false,
    });
    
    return getData;
  }
  
  const user_PublicShare_data = new userPublicShare({
    user: reqBody.userId,
    totalKgCo2OfPublicServiceShare: reqBody.totalKgCo2OfPublicServiceShare,
  });
  const userPublicShareData = await user_PublicShare_data.save();
  return userPublicShareData;
};

const getAllCalculationByUserId = async (reqBody) => {
  const user_id = reqBody.userId;
  const userIdCheckForHome = await userHome.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  const userIdCheckForMobility = await userMobility.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  const userIdCheckForGear = await userGear.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  const userIdCheckForOther = await userOther.findOne({
    user: reqBody.userId,
    isDelete: false,
  });
  const userIdCheckForPublicShare = await userPublicShare.findOne({
    user: reqBody.userId,
    isDelete: false,
  });

  const sum = 0.0;
  let allCalculation = {};
  //****----For Home ----
  if (!userIdCheckForHome || userIdCheckForHome == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalHomeCo2 = sum;
  }
  if (userIdCheckForHome) {
    const totalKgCo2OfHome = userIdCheckForHome
      ? parseFloat(userIdCheckForHome.totalKgCo2OfHome)
      : 0.0;
    const totalKgOfHome = sum + totalKgCo2OfHome;
    allCalculation.totalHomeCo2 = totalKgOfHome;
  }

  //****----For Mobility ----
  if (!userIdCheckForMobility || userIdCheckForMobility == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalMobilityCo2 = sum;
  }
  if (userIdCheckForMobility) {
    const totalKgCo2OfMobility = userIdCheckForMobility
      ? parseFloat(userIdCheckForMobility.totalKgCo2OfMobility)
      : 0.0;
    const totalKgOfMobility = sum + totalKgCo2OfMobility;
    allCalculation.totalMobilityCo2 = totalKgOfMobility;
  }

  //****----For Gear ----
  if (!userIdCheckForGear || userIdCheckForGear == null) {
    allCalculation.totalGearCo2 = sum;
  }
  if (userIdCheckForGear) {
    
    const totalKgCo2OfGear = userIdCheckForGear
      ? parseFloat(userIdCheckForGear.totalKgCo2OfGear)
      : 0.0;
    const totalKgOfGear = sum + totalKgCo2OfGear;
    allCalculation.totalGearCo2 = totalKgOfGear;
  }

  //****----For Food & Others ----
  if (!userIdCheckForOther || userIdCheckForOther == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalOtherCo2 = sum;
  }
  if (userIdCheckForOther) {
    const totalKgCo2OfOther = userIdCheckForOther
      ? parseFloat(userIdCheckForOther.totalKgCo2OfOthers)
      : 0.0;
    const totalKgOfOther = sum + totalKgCo2OfOther;
    allCalculation.totalOtherCo2 = totalKgOfOther;
  }

  //****----For Public Shares ----
  if (!userIdCheckForPublicShare || userIdCheckForPublicShare == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalPublicShareCo2 = sum;
  }
  if (userIdCheckForPublicShare) {
    
    const totalKgCo2OfPublicShare = userIdCheckForPublicShare
      ? parseFloat(userIdCheckForPublicShare.totalKgCo2OfPublicServiceShare)
      : 0.0;
    const totalKgOfPublicShare = sum + totalKgCo2OfPublicShare;
    allCalculation.totalPublicShareCo2 = totalKgOfPublicShare;
    
  }

  //****----For All Total kg of co2 ----
  allCalculation.totalKgOfCo2 = parseFloat(
    (
      allCalculation.totalHomeCo2 +
      allCalculation.totalMobilityCo2 +
      allCalculation.totalGearCo2 +
      allCalculation.totalOtherCo2 +
      allCalculation.totalPublicShareCo2
    ).toFixed(5)
  );

  //****----For All Total Ton of co2 ----
  allCalculation.totalTonsOfCo2 = parseFloat(
    (
      (allCalculation.totalHomeCo2 +
        allCalculation.totalMobilityCo2 +
        allCalculation.totalGearCo2 +
        allCalculation.totalOtherCo2 +
        allCalculation.totalPublicShareCo2) /
      1000
    ).toFixed(5)
  );
  

  return allCalculation;
};
const getAllCalculationYearByUserId = async (userId) => {
  const currentYear = new Date().getFullYear();
  const userIdCheckForHome = await userHome.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${currentYear}-01-01`),
      $lt: new Date(`${currentYear + 1}-01-01`),
    }
  });
  const userIdCheckForMobility = await userMobility.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${currentYear}-01-01`),
      $lt: new Date(`${currentYear + 1}-01-01`),
    }
  });
  const userIdCheckForGear = await userGear.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${currentYear}-01-01`),
      $lt: new Date(`${currentYear + 1}-01-01`),
    }
  });
  const userIdCheckForOther = await userOther.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${currentYear}-01-01`),
      $lt: new Date(`${currentYear + 1}-01-01`),
    }
  });
  const userIdCheckForPublicShare = await userPublicShare.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${currentYear}-01-01`),
      $lt: new Date(`${currentYear + 1}-01-01`),
    }
  });

  const sum = 0.0;
  let allCalculation = {};
  //****----For Home ----
  if (!userIdCheckForHome || userIdCheckForHome == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalHomeCo2 = sum.toFixed(2);
  }
  if (userIdCheckForHome) {
    
    const totalKgCo2OfHome = userIdCheckForHome
      ? parseFloat(userIdCheckForHome.totalKgCo2OfHome)
      : 0.0;
    const totalKgOfHome = sum + totalKgCo2OfHome;
    allCalculation.totalHomeCo2 = totalKgOfHome.toFixed(2);
    
  }

  //****----For Mobility ----
  if (!userIdCheckForMobility || userIdCheckForMobility == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalMobilityCo2 = sum.toFixed(2);
  }
  if (userIdCheckForMobility) {
    
    const totalKgCo2OfMobility = userIdCheckForMobility
      ? parseFloat(userIdCheckForMobility.totalKgCo2OfMobility)
      : 0.0;
    const totalKgOfMobility = sum + totalKgCo2OfMobility;
    allCalculation.totalMobilityCo2 = totalKgOfMobility.toFixed(2);
    
  }

  //****----For Gear ----
  if (!userIdCheckForGear || userIdCheckForGear == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalGearCo2 = sum.toFixed(2);
  }
  if (userIdCheckForGear) {
    
    const totalKgCo2OfGear = userIdCheckForGear
      ? parseFloat(userIdCheckForGear.totalKgCo2OfGear)
      : 0.0;
    const totalKgOfGear = sum + totalKgCo2OfGear;
    allCalculation.totalGearCo2 = totalKgOfGear.toFixed(2);
    
  }

  //****----For Food & Others ----
  if (!userIdCheckForOther || userIdCheckForOther == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalOtherCo2 = sum.toFixed(2);
  }
  if (userIdCheckForOther) {
    
    const totalKgCo2OfOther = userIdCheckForOther
      ? parseFloat(userIdCheckForOther.totalKgCo2OfOthers)
      : 0.0;
    const totalKgOfOther = sum + totalKgCo2OfOther;
    
    allCalculation.totalOtherCo2 = totalKgOfOther.toFixed(2);
    
  }

  //****----For Public Shares ----
  if (!userIdCheckForPublicShare || userIdCheckForPublicShare == null) {
    // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
    allCalculation.totalPublicShareCo2 = sum.toFixed(2);
  }
  if (userIdCheckForPublicShare) {
    
    const totalKgCo2OfPublicShare = userIdCheckForPublicShare
      ? parseFloat(userIdCheckForPublicShare.totalKgCo2OfPublicServiceShare)
      : 0.0;
    const totalKgOfPublicShare = sum + totalKgCo2OfPublicShare;
    allCalculation.totalPublicShareCo2 = totalKgOfPublicShare.toFixed(2);
  }

  //****----For All Total kg of co2 ----
  const allCarbon = parseFloat(allCalculation.totalHomeCo2) +  parseFloat(allCalculation.totalMobilityCo2 )
                  +  parseFloat(allCalculation.totalGearCo2) +
                  parseFloat(allCalculation.totalOtherCo2) +  parseFloat(allCalculation.totalPublicShareCo2);

  allCalculation.totalKgOfCo2 = allCarbon.toFixed(2);

  //****----For All Total Ton of co2 ----
  allCalculation.totalTonsOfCo2 = (allCarbon/1000).toFixed(2);
  

  return allCalculation;
};

const getAllCalculationFourYearByUserId = async (userId) => {
  let allYearCarbonDataArr = []
  let firstCarbonDataObj = {
    year:"",
    calculation:{}
  }
  let secondCarbonDataObj = {
    year:"",
    calculation:{}
  }
  let thirdCarbonDataObj = {
    year:"",
    calculation:{}
  }
  let fourthCarbonDataObj = {
    year:"",
    calculation:{}
  }
  let firstYearAllCalculation = {};
  let secondYearAllCalculation = {};
  let thirdYearAllCalculation = {};
  let fourthYearAllCalculation = {};
  const firstYear = new Date().getFullYear();
  const secondYear = firstYear-1;
  const thirdYear = secondYear -1;
  const fourthYear = thirdYear-1;
  
  /* First year data of a user for all category */
  const firstYearDataHome = await userHome.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${firstYear}-01-01`),
      $lt: new Date(`${firstYear + 1}-01-01`),
    }
  });
  
  if (firstYearDataHome) {
    firstYearAllCalculation.totalKgCo2OfHome = parseFloat(firstYearDataHome.totalKgCo2OfHome).toFixed(2);
  } else {
    firstYearAllCalculation.totalKgCo2OfHome = parseFloat('0.0').toFixed(2);
  }
  const firstYearDataMobility = await userMobility.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${firstYear}-01-01`),
      $lt: new Date(`${firstYear + 1}-01-01`),
    }
  });
  
  if (firstYearDataMobility) {
    firstYearAllCalculation.totalKgCo2OfMobility = parseFloat(firstYearDataMobility.totalKgCo2OfMobility).toFixed(2);
  } else {
    firstYearAllCalculation.totalKgCo2OfMobility = parseFloat('0.0').toFixed(2);
  }
  const firstYearDataGear = await userGear.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${firstYear}-01-01`),
      $lt: new Date(`${firstYear + 1}-01-01`),
    }
  });
  
  if (firstYearDataGear) {
    firstYearAllCalculation.totalKgCo2OfGear = parseFloat(firstYearDataGear.totalKgCo2OfGear).toFixed(2);
  } else {
    firstYearAllCalculation.totalKgCo2OfGear = parseFloat('0.0').toFixed(2);
  }
  const firstYearDataOther = await userOther.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${firstYear}-01-01`),
      $lt: new Date(`${firstYear + 1}-01-01`),
    }
  });
  
  if (firstYearDataOther) {
    firstYearAllCalculation.totalKgCo2OfOthers = parseFloat(firstYearDataOther.totalKgCo2OfOthers).toFixed(2);
  } else {
    firstYearAllCalculation.totalKgCo2OfOthers = parseFloat('0.0').toFixed(2);
  }
  const firstYearDataPublicShare = await userPublicShare.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${firstYear}-01-01`),
      $lt: new Date(`${firstYear + 1}-01-01`),
    }
  });
  
  if (firstYearDataPublicShare) {
    firstYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat(firstYearDataPublicShare.totalKgCo2OfPublicServiceShare).toFixed(2);
  } else {
    firstYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat('0.0').toFixed(2);
  }
  const firstYearAllCarbon = parseFloat(firstYearAllCalculation.totalKgCo2OfHome)+
  parseFloat(firstYearAllCalculation.totalKgCo2OfMobility)+
  parseFloat(firstYearAllCalculation.totalKgCo2OfGear)+
  parseFloat(firstYearAllCalculation.totalKgCo2OfOthers)+
  parseFloat(firstYearAllCalculation.totalKgCo2OfPublicServiceShare);
  firstYearAllCalculation.totalKgOfCo2 = firstYearAllCarbon.toFixed(2);
  firstYearAllCalculation.totalTonsOfCo2 = (firstYearAllCarbon/1000).toFixed(2);
  
  firstCarbonDataObj.year = firstYear.toString();
  firstCarbonDataObj.calculation = firstYearAllCalculation;

  allYearCarbonDataArr.push(firstCarbonDataObj);
  /* Second year data */
  const secondYearDataHome = await userHome.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${secondYear}-01-01`),
      $lt: new Date(`${secondYear + 1}-01-01`),
    }
  });
  
  if (secondYearDataHome) {
    secondYearAllCalculation.totalKgCo2OfHome = parseFloat(secondYearDataHome.totalKgCo2OfHome).toFixed(2);
  } else {
    secondYearAllCalculation.totalKgCo2OfHome = parseFloat('0.0').toFixed(2);
  }
  const secondYearDataMobility = await userMobility.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${secondYear}-01-01`),
      $lt: new Date(`${secondYear + 1}-01-01`),
    }
  });
  
  if (secondYearDataMobility) {
    secondYearAllCalculation.totalKgCo2OfMobility = parseFloat(secondYearDataMobility.totalKgCo2OfMobility).toFixed(2);
  } else {
    secondYearAllCalculation.totalKgCo2OfMobility = parseFloat('0.0').toFixed(2);
  }
  const secondYearDataGear = await userGear.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${secondYear}-01-01`),
      $lt: new Date(`${secondYear + 1}-01-01`),
    }
  });
  
  if (secondYearDataGear) {
    secondYearAllCalculation.totalKgCo2OfGear = parseFloat(secondYearDataGear.totalKgCo2OfGear).toFixed(2);
  } else {
    secondYearAllCalculation.totalKgCo2OfGear = parseFloat('0.0').toFixed(2);
  }
  const secondYearDataOther = await userOther.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${secondYear}-01-01`),
      $lt: new Date(`${secondYear + 1}-01-01`),
    }
  });
  
  if (secondYearDataOther) {
    secondYearAllCalculation.totalKgCo2OfOthers = parseFloat(secondYearDataOther.totalKgCo2OfOthers).toFixed(2);
  } else {
    secondYearAllCalculation.totalKgCo2OfOthers = parseFloat('0.0').toFixed(2);
  }
  const secondYearDataPublicShare = await userPublicShare.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${secondYear}-01-01`),
      $lt: new Date(`${secondYear + 1}-01-01`),
    }
  });
  
  if (secondYearDataPublicShare) {
    secondYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat(secondYearDataPublicShare.totalKgCo2OfPublicServiceShare).toFixed(2);
  } else {
    secondYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat('0.0').toFixed(2);
  }
  const secondYearAllCarbon = parseFloat(secondYearAllCalculation.totalKgCo2OfHome)+
  parseFloat(secondYearAllCalculation.totalKgCo2OfMobility)+
  parseFloat(secondYearAllCalculation.totalKgCo2OfGear)+
  parseFloat(secondYearAllCalculation.totalKgCo2OfOthers)+
  parseFloat(secondYearAllCalculation.totalKgCo2OfPublicServiceShare);
  secondYearAllCalculation.totalKgOfCo2 = secondYearAllCarbon.toFixed(2);
  secondYearAllCalculation.totalTonsOfCo2 = (secondYearAllCarbon/1000).toFixed(2);
  
  secondCarbonDataObj.year = secondYear.toString();
  secondCarbonDataObj.calculation = secondYearAllCalculation;

  allYearCarbonDataArr.push(secondCarbonDataObj);
  /* Third Year data */
  const thirdYearDataHome = await userHome.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${thirdYear}-01-01`),
      $lt: new Date(`${thirdYear + 1}-01-01`),
    }
  });
  
  if (thirdYearDataHome) {
    thirdYearAllCalculation.totalKgCo2OfHome = parseFloat(thirdYearDataHome.totalKgCo2OfHome).toFixed(2);
  } else {
    thirdYearAllCalculation.totalKgCo2OfHome = parseFloat('0.0').toFixed(2);
  }
  const thirdYearDataMobility = await userMobility.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${thirdYear}-01-01`),
      $lt: new Date(`${thirdYear + 1}-01-01`),
    }
  });
  
  if (thirdYearDataMobility) {
    thirdYearAllCalculation.totalKgCo2OfMobility = parseFloat(thirdYearDataMobility.totalKgCo2OfMobility).toFixed(2);
  } else {
    thirdYearAllCalculation.totalKgCo2OfMobility = parseFloat('0.0').toFixed(2);
  }
  const thirdYearDataGear = await userGear.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${thirdYear}-01-01`),
      $lt: new Date(`${thirdYear + 1}-01-01`),
    }
  });
  
  if (thirdYearDataGear) {
    thirdYearAllCalculation.totalKgCo2OfGear = parseFloat(thirdYearDataGear.totalKgCo2OfGear).toFixed(2);
  } else {
    thirdYearAllCalculation.totalKgCo2OfGear = parseFloat('0.0').toFixed(2);
  }
  const thirdYearDataOther = await userOther.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${thirdYear}-01-01`),
      $lt: new Date(`${thirdYear + 1}-01-01`),
    }
  });
  
  if (thirdYearDataOther) {
    thirdYearAllCalculation.totalKgCo2OfOthers = parseFloat(thirdYearDataOther.totalKgCo2OfOthers).toFixed(2);
  } else {
    thirdYearAllCalculation.totalKgCo2OfOthers = parseFloat('0.0').toFixed(2);
  }
  const thirdYearDataPublicShare = await userPublicShare.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${thirdYear}-01-01`),
      $lt: new Date(`${thirdYear + 1}-01-01`),
    }
  });
  
  if (thirdYearDataPublicShare) {
    thirdYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat(thirdYearDataPublicShare.totalKgCo2OfPublicServiceShare).toFixed(2);
  } else {
    thirdYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat('0.0').toFixed(2);
  }
  const thirdYearAllCarbon = parseFloat(thirdYearAllCalculation.totalKgCo2OfHome)+
  parseFloat(thirdYearAllCalculation.totalKgCo2OfMobility)+
  parseFloat(thirdYearAllCalculation.totalKgCo2OfGear)+
  parseFloat(thirdYearAllCalculation.totalKgCo2OfOthers)+
  parseFloat(thirdYearAllCalculation.totalKgCo2OfPublicServiceShare);
  thirdYearAllCalculation.totalKgOfCo2 = thirdYearAllCarbon.toFixed(2);
  thirdYearAllCalculation.totalTonsOfCo2 = (thirdYearAllCarbon/1000).toFixed(2);
  
  thirdCarbonDataObj.year = thirdYear.toString();
  thirdCarbonDataObj.calculation = thirdYearAllCalculation;

  allYearCarbonDataArr.push(thirdCarbonDataObj);
  /* Fourth data */
  const fourthYearDataHome = await userHome.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${fourthYear}-01-01`),
      $lt: new Date(`${fourthYear + 1}-01-01`),
    }
  });
  
  if (fourthYearDataHome) {
    fourthYearAllCalculation.totalKgCo2OfHome = parseFloat(fourthYearDataHome.totalKgCo2OfHome).toFixed(2);
  } else {
    fourthYearAllCalculation.totalKgCo2OfHome = parseFloat('0.0').toFixed(2);
  }
  const fourthYearDataMobility = await userMobility.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${fourthYear}-01-01`),
      $lt: new Date(`${fourthYear + 1}-01-01`),
    }
  });
  
  if (fourthYearDataMobility) {
    fourthYearAllCalculation.totalKgCo2OfMobility = parseFloat(fourthYearDataMobility.totalKgCo2OfMobility).toFixed(2);
  } else {
    fourthYearAllCalculation.totalKgCo2OfMobility = parseFloat('0.0').toFixed(2);
  }
  const fourthYearDataGear = await userGear.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${fourthYear}-01-01`),
      $lt: new Date(`${fourthYear + 1}-01-01`),
    }
  });
  
  if (fourthYearDataGear) {
    fourthYearAllCalculation.totalKgCo2OfGear = parseFloat(fourthYearDataGear.totalKgCo2OfGear).toFixed(2);
  } else {
    fourthYearAllCalculation.totalKgCo2OfGear = parseFloat('0.0').toFixed(2);
  }
  const fourthYearDataOther = await userOther.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${fourthYear}-01-01`),
      $lt: new Date(`${fourthYear + 1}-01-01`),
    }
  });
  
  if (fourthYearDataOther) {
    fourthYearAllCalculation.totalKgCo2OfOthers = parseFloat(fourthYearDataOther.totalKgCo2OfOthers).toFixed(2);
  } else {
    fourthYearAllCalculation.totalKgCo2OfOthers = parseFloat('0.0').toFixed(2);
  }
  const fourthYearDataPublicShare = await userPublicShare.findOne({
    user: userId,
    isDelete: false,
    createdAt: {
      $gte: new Date(`${fourthYear}-01-01`),
      $lt: new Date(`${fourthYear + 1}-01-01`),
    }
  });
  
  if (fourthYearDataPublicShare) {
    fourthYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat(fourthYearDataPublicShare.totalKgCo2OfPublicServiceShare).toFixed(2);
  } else {
    fourthYearAllCalculation.totalKgCo2OfPublicServiceShare = parseFloat('0.0').toFixed(2);
  }
  const fourthYearAllCarbon = parseFloat(fourthYearAllCalculation.totalKgCo2OfHome)+
  parseFloat(fourthYearAllCalculation.totalKgCo2OfMobility)+
  parseFloat(fourthYearAllCalculation.totalKgCo2OfGear)+
  parseFloat(fourthYearAllCalculation.totalKgCo2OfOthers)+
  parseFloat(fourthYearAllCalculation.totalKgCo2OfPublicServiceShare);
  fourthYearAllCalculation.totalKgOfCo2 = fourthYearAllCarbon.toFixed(2);
  fourthYearAllCalculation.totalTonsOfCo2 = (fourthYearAllCarbon/1000).toFixed(2);
  
  fourthCarbonDataObj.year = fourthYear.toString();
  fourthCarbonDataObj.calculation = fourthYearAllCalculation;

  allYearCarbonDataArr.push(fourthCarbonDataObj);

  return allYearCarbonDataArr;
};

const getAllUsersCalculation = async () => {
  const allUserData = await User.find({ isDelete: false,role:'user' }).sort({ _id: -1 });
  let getList = [];
  for (let allUser of allUserData) {
    const userIdCheckForHome = await userHome.findOne({
      user: allUser._id,
      isDelete: false,
    });
    const userIdCheckForMobility = await userMobility.findOne({
      user: allUser._id,
      isDelete: false,
    });
    const userIdCheckForGear = await userGear.findOne({
      user: allUser._id,
      isDelete: false,
    });
    const userIdCheckForOther = await userOther.findOne({
      user: allUser._id,
      isDelete: false,
    });
    const userIdCheckForPublicShare = await userPublicShare.findOne({
      user: allUser._id,
      isDelete: false,
    });

    const sum = 0.0;
    let allCalculation = {};
    allCalculation.userId = allUser._id;
    allCalculation.fullname = allUser.firstName+" "+allUser.lastName;
    //****----For Home ----
    if (!userIdCheckForHome || userIdCheckForHome == null) {
      // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
      allCalculation.totalHomeCo2 = sum;
    }
    if (userIdCheckForHome) {
      
      const totalKgCo2OfHome = userIdCheckForHome
        ? parseFloat(userIdCheckForHome.totalKgCo2OfHome)
        : 0.0;
      const totalKgOfHome = sum + totalKgCo2OfHome;
      allCalculation.totalHomeCo2 = totalKgOfHome;
      
    }

    //****----For Mobility ----
    if (!userIdCheckForMobility || userIdCheckForMobility == null) {
      // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
      allCalculation.totalMobilityCo2 = sum;
    }
    if (userIdCheckForMobility) {
      
      const totalKgCo2OfMobility = userIdCheckForMobility
        ? parseFloat(userIdCheckForMobility.totalKgCo2OfMobility)
        : 0.0;
      const totalKgOfMobility = sum + totalKgCo2OfMobility;
      allCalculation.totalMobilityCo2 = totalKgOfMobility;
      
    }

    //****----For Gear ----
    if (!userIdCheckForGear || userIdCheckForGear == null) {
      // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
      allCalculation.totalGearCo2 = sum;
    }
    if (userIdCheckForGear) {
      
      const totalKgCo2OfGear = userIdCheckForGear
        ? parseFloat(userIdCheckForGear.totalKgCo2OfGear)
        : 0.0;
      const totalKgOfGear = sum + totalKgCo2OfGear;
      allCalculation.totalGearCo2 = totalKgOfGear;
      
    }

    //****----For Food & Others ----
    if (!userIdCheckForOther || userIdCheckForOther == null) {
      // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
      allCalculation.totalOtherCo2 = sum;
    }
    if (userIdCheckForOther) {
      
      const totalKgCo2OfOther = userIdCheckForOther
      ? parseFloat(userIdCheckForOther.totalKgCo2OfOthers)
      : 0.0;
      const totalKgOfOther = sum + totalKgCo2OfOther;
      
      allCalculation.totalOtherCo2 = totalKgOfOther;
      
    }

    //****----For Public Shares ----
    if (!userIdCheckForPublicShare || userIdCheckForPublicShare == null) {
      // throw new ApiError(httpStatus.NOT_FOUND, 'Sorry, no data found for user');
      allCalculation.totalPublicShareCo2 = sum;
    }
    if (userIdCheckForPublicShare) {
      
      const totalKgCo2OfPublicShare = userIdCheckForPublicShare
        ? parseFloat(userIdCheckForPublicShare.totalKgCo2OfPublicServiceShare)
        : 0.0;
      const totalKgOfPublicShare = sum + totalKgCo2OfPublicShare;
      
      allCalculation.totalPublicShareCo2 = totalKgOfPublicShare;
      
    }

    //****----For All Total kg of co2 ----
    allCalculation.totalKgOfCo2 = parseFloat(
      allCalculation.totalHomeCo2 +
        allCalculation.totalMobilityCo2 +
        allCalculation.totalGearCo2 +
        allCalculation.totalOtherCo2 +
        allCalculation.totalPublicShareCo2
    );

    //****----For All Total Ton of co2 ----
    allCalculation.totalTonsOfCo2 = parseFloat(
      (allCalculation.totalHomeCo2 +
        allCalculation.totalMobilityCo2 +
        allCalculation.totalGearCo2 +
        allCalculation.totalOtherCo2 +
        allCalculation.totalPublicShareCo2) /
        1000
    );
    
    getList.push(allCalculation);
  }

  return getList;
};

const createTipsByAdminId = async (reqBody) => {
  
  const tipsQuestionCheck = await Tip.findOne({
    tipsQuestion: reqBody.tipsQuestion,
  });
  if (tipsQuestionCheck) {
    throw new ApiError(
      httpStatus.ALREADY_REPORTED,
      `'${reqBody.tipsQuestion}' is already exists.`
    );
  }
  const tip_data = new Tip({
    user: reqBody.userId,
    tipsQuestion: reqBody.tipsQuestion,
    tipsDescription: reqBody.tipsDescription ? reqBody.tipsDescription : "",
  });
  const tipAdviceData = await tip_data.save();
  
  return tipAdviceData;
};

const getAllTipsData = async () => {
  let getList = [];
  const tipsAllData = await Tip.find({ isDelete: false }).sort({ _id: -1 });
  for (const allTips of tipsAllData) {
    const obj = {
      tips_id: allTips._id,
      tipsQuestion: allTips.tipsQuestion,
      tipsDescription: allTips.tipsDescription,
    };
    getList.push(obj);
  }
  return getList;
};

const getTipsDataById = async (reqBody) => {
  
  const tipsIdCheckData = await Tip.findById({
    _id: reqBody.tips_id,
    isDelete: false,
  });
  if (!tipsIdCheckData) {
    throw new ApiError(httpStatus.NOT_FOUND, "Please give a valid tips id");
  }
  return tipsIdCheckData;
};

const updateDataByTipsId = async (updateBody) => {
  const TipId = updateBody.tipsId;
  var obj = {};
  const tipIdCheck = await Tip.findOne({
    _id: updateBody.tipsId,
    isDelete: false,
  });
  if (!tipIdCheck) {
    throw new ApiError(httpStatus.NOT_FOUND, "Please give a valid tips id");
  }
  if (updateBody.tipsQuestion) {
    obj.tipsQuestion = updateBody.tipsQuestion;
  }
  if (updateBody.tipsDescription) {
    obj.tipsDescription = updateBody.tipsDescription;
  }
  const updateData = await Tip.findByIdAndUpdate(TipId, obj, {
    new: true,
  });
  const getData = await Tip.findById(TipId);

  return getData;
};

const deleteDataByTipsId = async (updateBody) => {
  const TipId = updateBody.tipsId;
  const tipIdCheck = await Tip.findOne({ _id: updateBody.tipsId });
  if (!tipIdCheck) {
    throw new ApiError(httpStatus.NOT_FOUND, "Please give a valid tips id");
  }
  if (tipIdCheck.isDelete === true) {
    throw new ApiError(httpStatus.NOT_FOUND, "Already deleted");
  }
  const updateData = await Tip.findByIdAndUpdate(
    TipId,
    { isDelete: true },
    {
      new: true,
    }
  );
  const getData = await Tip.findById(TipId);

  return getData;
};
const updateUserDeviceToken = async (id,token) => {
  return await User.findByIdAndUpdate({_id:id},{device_tokens:token});
}
const removeUserDeviceToken = async (id,token) => {
  return await User.findByIdAndUpdate({_id:id},{ '$pull': { device_tokens: token }});
}

module.exports = {
  createUser,
  queryUsers,
  getUserById,
  getUserByEmail,
  updateUserById,
  deleteUserById,
  updateUser,
  createUserGear,
  createUserCarbonCalculation,
  createUserHomeCarbonCalculation,
  createUserMobilityCarbonCalculation,
  createUserGearCarbonCalculation,
  createUserOtherCarbonCalculation,
  createUserPublicShareCarbonCalculation,
  getAllCalculationByUserId,
  getAllUsersCalculation,
  createTipsByAdminId,
  getAllTipsData,
  getTipsDataById,
  updateDataByTipsId,
  deleteDataByTipsId,
  updateOtpUser,
  userOtpVerify,
  getUserByIdApp,
  restoreUserById,
  getAllCalculationYearByUserId,
  getAllCalculationFourYearByUserId,
  updateUserDeviceToken,
  removeUserDeviceToken
};
