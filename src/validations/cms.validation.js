const Joi = require("joi");

const getCmsId = {
  query: Joi.object().keys({
    id: Joi.string().required(),
  }),
};
const updateCmsId = {
  body: Joi.object().keys({
    content: Joi.string().required(),
    title: Joi.string().required(),
  })
};
const newCmsAdd = {
  body: Joi.object().keys({
    name: Joi.string().required(),
    content: Joi.string().required(),
    title: Joi.string().required(),
  })
};
const removeCmsImage = {
  body: Joi.object().keys({
    image_path: Joi.string().required(),
  })
};

module.exports = {
  getCmsId,
  updateCmsId,
  removeCmsImage,
  newCmsAdd
};
