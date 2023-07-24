var cms_page = require('../models/cms.model');
const he = require('he');
exports.getContents = _ => cms_page.model.find({}).select('name content title updated_at').exec()
exports.getContent = (id) => cms_page.model.findById(id).select('name content title images').exec()
exports.getContentByName = (name) => cms_page.model.findOne({ name }).select('name content title images').exec()
exports.addCMSImage = (content_id, image) => cms_page.model.findByIdAndUpdate(content_id, { '$addToSet': { images: image } }).exec()
// exports.updateContent = (content_id, text) => cms_page.model.findByIdAndUpdate(content_id, { content: text }, { new: true }).exec();
exports.updateContent = (content_id, element) => {
    const contentTitle = element.title;
    const contentDecodedText = he.decode(element.content);
    return cms_page.model.findByIdAndUpdate(content_id, { content: contentDecodedText ,title:contentTitle}, { new: true }).exec();
};
exports.addNewCms = async (element) => {
    const insertObj = {
        name:element.name,
        title:element.title,
        content:he.decode(element.content),
    }
    return await cms_page.model.create(insertObj);
};
exports.removeCMSImage = (content_id, image) => cms_page.model.findByIdAndUpdate(content_id, { '$pull': { images: image } }).exec();
exports.deleteCms = (id) => {
    return cms_page.model.deleteOne({_id:id}).exec();
};