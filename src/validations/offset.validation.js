const Joi = require("joi");

const getOffsetId = {
  query: Joi.object().keys({
    id: Joi.string().required(),
  }),
};
const updateOffsetId = {
  body: Joi.object().keys({
    content: Joi.string(),
    title: Joi.string(),
    amount: Joi.string().allow('').optional(),
    url: Joi.string().allow('').optional(),
  }),
};
const newCmsOffset = {
    body: Joi.object().keys({
      name: Joi.string().required(),
      content: Joi.string().required(),
      title: Joi.string().required(),
      amount: Joi.string().allow('').optional(),
      url: Joi.string().allow('').optional(),
    })
  };

module.exports = {
  getOffsetId,
  updateOffsetId,
  newCmsOffset
};
