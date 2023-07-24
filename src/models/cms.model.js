var mongoose     = require('mongoose');
var Schema       = mongoose.Schema;

var CmsPageSchema   = new Schema({
    name: {type: String, required: true},
    title: String,
    content: {
        type: String,
        required: true
    },
    images:[String]
},{
    timestamps: { createdAt: 'created_at',updatedAt:'updated_at' },
    toJSON: { virtuals: true }
});
module.exports = {
    model: mongoose.model('cms-page', CmsPageSchema)
};