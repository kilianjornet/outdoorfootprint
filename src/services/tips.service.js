var tips = require('../models/tips.model');
const he = require('he');
exports.getContents = _ => tips.model.find({}).exec()
exports.getContent = (id) => tips.model.findOne({'content._id':id},{
    _id: 1,
    tips_title: 1,
    content: { $elemMatch: { _id: id } },
  }).exec()
exports.getContentByName = (name) => tips.model.findOne({ 'content.content_name':name }).select().exec()
// exports.updateContent = (content_id, text) => tips.model.findByIdAndUpdate(content_id, { content: text }, { new: true }).exec();
exports.updateContent = (content_id, eliment) => {
    const contentTitle = eliment.title;
    const contentDecodedText = he.decode(eliment.content);
    return tips.model.findOneAndUpdate({'content._id':content_id}, { $set: { 'content.$.content': contentDecodedText,'content.$.content_title':contentTitle } }, { new: true,projection: { // Projection to return specific fields using $elemMatch
        _id: 1,
        tips_title: 1,
        content: { $elemMatch: { _id: content_id } },
      } }).exec();
};
exports.updateTipsTitle = (content_id, text) => {
    return tips.model.findOneAndUpdate({_id:content_id}, { $set: { tips_title: text } }, { new: true}).exec();
};
exports.addNewTips = async (tips_id,element) => {
    const insertObj = {
        content_name:element.name,
        content_title:element.title,
        content:he.decode(element.content)
    }
    return tips.model.findOneAndUpdate({_id:tips_id}, { $push: { content: insertObj } }, { new: true}).exec();
};
exports.deleteTips = async (tips_id,content_id) => {
    return tips.model.findOneAndUpdate({_id:tips_id}, { $pull: { content: { _id: content_id } } }).exec();
};