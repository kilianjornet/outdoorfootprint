const httpStatus = require("http-status");
const pick = require("../utils/pick");
const ApiError = require("../utils/ApiError");
const catchAsync = require("../utils/catchAsync");
const cmsService = require("../services/cms.service");
const customMessage = require("../utils/customMessage");
const localhostUrl = "https://nodeserver.mydevfactory.com:6006";

const getContents = catchAsync(async (req, res) => {
  const allCms = await cmsService.getContents();
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_CMS,
    allCms,
  });
});
const getContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const cms = await cmsService.getContent(req.params.id);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.All_CMS,
    cms,
  });
});
const getContentByName = catchAsync(async (req, res) => {
    // console.log("req.params.id",req.params.id)
    const cms = await cmsService.getContentByName(req.params.name);
    res.status(httpStatus.OK).send({
      status: true,
      message: customMessage.english.All_CMS,
      cms,
    });
  });
const updateContentsById = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const cms = await cmsService.updateContent(req.params.id, req.body);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATE_CMS,
    cms,
  });
});
const addNewCms = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const cms = await cmsService.addNewCms(req.body);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.ADD_SUCCESS,
    cms,
  });
});
const deleteCms = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  const cms = await cmsService.deleteCms(req.params.id);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.DELETED_SUCCESSFULLY,
    cms,
  });
});
const uploadImageByCmsId = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  // console.log("req.files",req.files)
  const imagePaths = req.files.map(file => localhostUrl + "/uploads/cms-images/" + file.filename);
  const cms = await cmsService.addCMSImage(req.params.id, imagePaths);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATE_CMS,
    cms,
  });
});
const removeImageByCmsId = catchAsync(async (req, res) => {
  // console.log("req.params.id",req.params.id)
  // console.log("req.body.image_path",req.body.image_path)
  const cms = await cmsService.removeCMSImage(req.params.id, req.body.image_path);
  res.status(httpStatus.OK).send({
    status: true,
    message: customMessage.english.UPDATE_CMS
  });
});


module.exports = {
  getContents,
  getContentsById,
  updateContentsById,
  getContentByName,
  uploadImageByCmsId,
  removeImageByCmsId,
  addNewCms,
  deleteCms
};
