const httpStatus = require("http-status");
const catchAsync = require("../utils/catchAsync");
const tipsService = require("../services/tips.service");
const customMessage = require("../utils/customMessage");

const getContents = catchAsync(async (req, res) => {
  const allTips = await tipsService.getContents();
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_TIPS,
    allTips,
  });
});
const getContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const tips = await tipsService.getContent(req.params.id);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_TIPS,
    tips,
  });
});
const getContentByName = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await tipsService.getContentByName(req.params.name);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.All_TIPS,
      tips,
    });
  });
const updateContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const tips = await tipsService.updateContent(req.params.id, req.body);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATE_TIPS,
    tips,
  });
});
const addNewTips = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await tipsService.addNewTips(req.params.id,req.body);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.ADD_SUCCESS,
      tips,
    });
  });
  const deleteTips = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await tipsService.deleteTips(req.params.id,req.body.content_id);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.DELETED_SUCCESSFULLY,
      tips,
    });
  });
const updatTipsTitleById = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const tips = await tipsService.updateTipsTitle(req.params.id, req.body.tips_title);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.UPDATE_TIPS,
      tips,
    });
});



module.exports = {
  getContents,
  getContentsById,
  updateContentsById,
  getContentByName,
  updatTipsTitleById,
  addNewTips,
  deleteTips
};
