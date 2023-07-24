var offset = require('../models/offset.model');
const he = require('he');
exports.getContents = _ => offset.model.find({}).exec()
exports.getContent = (id) => offset.model.findOne({'_id':id}).exec()
exports.getContentByName = (name) => offset.model.findOne({ 'name':name }).select().exec()
// exports.updateContent = (content_id, text) => offset.model.findByIdAndUpdate(content_id, { content: text }, { new: true }).exec();
exports.updateContent = (content_id, element) => {
    const updateObj = {};
    updateObj.title = element.title;
    updateObj.content = he.decode(element.content);;
    updateObj.amount = element.amount;
    updateObj.url = element.url;
    return offset.model.findOneAndUpdate({'_id':content_id},updateObj).exec();
};
exports.addNewOffset = async (element) => {
    const insertObj = {
        name:element.name,
        title:element.title,
        content:he.decode(element.content),
        amount:element.amount,
        url:element.url,
    }
    return await offset.model.create(insertObj);
};
exports.deleteOffset = (id) => {
    return offset.model.deleteOne({_id:id}).exec();
};
