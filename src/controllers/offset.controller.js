const httpStatus = require("http-status");
const catchAsync = require("../utils/catchAsync");
const offsetService = require("../services/offset.service");
const customMessage = require("../utils/customMessage");
const {
    userHome,
    userMobility,
    userGear,
    userOther,
    userPublicShare,
  } = require("../models");

const getContents = catchAsync(async (req, res) => {
  const all_offset = await offsetService.getContents();
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_OFFSETS,
    all_offset,
  });
});
const getContentsApp = catchAsync(async (req, res) => {
    const all_offset = await offsetService.getContents();
    const firstYear = new Date().getFullYear();
    let firstYearAllCalculation = {};
    const userId = req.user._id;
    const firstYearDataHome = await userHome.findOne({
        user: userId,
        isDelete: false,
        createdAt: {
          $gte: new Date(`${firstYear}-01-01`),
          $lt: new Date(`${firstYear + 1}-01-01`),
        }
      });
      // console.log("firstYearDataHome",firstYearDataHome);
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
      // console.log("firstYearDataMobility",firstYearDataMobility);
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
      // console.log("firstYearDataGear",firstYearDataGear);
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
      // console.log("firstYearDataOther",firstYearDataOther);
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
      // console.log("firstYearDataPublicShare",firstYearDataPublicShare);
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
      const user_carbon_ton = firstYearAllCalculation.totalTonsOfCo2;
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.All_OFFSETS,
      user_carbon_ton,
      all_offset,
    });
  });
const getContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const offset = await offsetService.getContent(req.params.id);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_OFFSETS,
    offset,
  });
});
const getContentByName = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await offsetService.getContentByName(req.params.name);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.All_OFFSETS,
      tips,
    });
  });
const updateContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const tips = await offsetService.updateContent(req.params.id, req.body);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATE_OFFSET,
    tips,
  });
});
const addNewOffset = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const offset = await offsetService.addNewOffset(req.body);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.ADD_SUCCESS,
      offset,
    });
  });

const removeTips = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await offsetService.deleteOffset(req.params.id);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.DELETED_SUCCESSFULLY,
      tips,
    });
});



module.exports = {
  getContents,
  getContentsById,
  updateContentsById,
  getContentByName,
  getContentsApp,
  addNewOffset,
  removeTips
};
