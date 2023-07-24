const Joi = require("joi");


const updateTipsId = {
  body: Joi.object().keys({
    content: Joi.string().required(),
    title: Joi.string().required()
  })
};
const newCmsTips = {
    body: Joi.object().keys({
      name: Joi.string().required(),
      content: Joi.string().required(),
      title: Joi.string().required(),
    })
  };
  const deleteTipsContent = {
    body: Joi.object().keys({
      content_id: Joi.string().required()
    })
  };
module.exports = {
    updateTipsId,
    newCmsTips,
    deleteTipsContent
};
