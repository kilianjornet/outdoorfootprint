const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userOtherSchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        totalKgCo2OfOthers: {
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
userOtherSchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userOther = mongoose.model('user-Food&Others-calculate-category', userOtherSchema);

module.exports = userOther;