const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userHomeSchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        totalKgCo2OfHome: {
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
userHomeSchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userHome = mongoose.model('user-Home-calculate-category', userHomeSchema);

module.exports = userHome;