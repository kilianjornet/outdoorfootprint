const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userGearSchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        totalKgCo2OfGear: {
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
userGearSchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userGear = mongoose.model('user-Gear-calculate-category', userGearSchema);

module.exports = userGear;