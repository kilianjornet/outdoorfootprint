const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userPublicShareSchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        totalKgCo2OfPublicServiceShare: {
            type: String,
            default: "0.0"
        },
        isDelete: {
            type: Boolean,
            default: false,
        },
    },
    {
        timestamps: true,
    }
);

// add plugin that converts mongoose to json
userPublicShareSchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userPublicShare = mongoose.model('user-publicshare-calculate-category', userPublicShareSchema);

module.exports = userPublicShare;