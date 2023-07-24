const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userMobilitySchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        totalKgCo2OfMobility: {
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
userMobilitySchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userMobility = mongoose.model('user-Mobility-calculate-category', userMobilitySchema);

module.exports = userMobility;