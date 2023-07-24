var mongoose = require("mongoose");
var Schema = mongoose.Schema;
var fcmNotificationSchema   = new Schema({
    role: { type: String },
    role_count:{type: String},
    title: { type: String, required: true },
    content: { type: String, required: true }
},{
    timestamps: { createdAt: 'created_at',updatedAt:'updated_at' },
    toJSON: { virtuals: true }
});
module.exports = {
    model: mongoose.model('fcm-notification', fcmNotificationSchema)
};