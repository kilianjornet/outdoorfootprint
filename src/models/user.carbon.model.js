const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const userCarbonSchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        category: {
            type: String,
            enum: ['home', 'mobility', 'gear', 'others', 'publicserviceshare'],
        },
        totalKgCo2OfHome: {
            type: String,
            default: "0.0"
        },
        totalKgCo2OfMobility: {
            type: String,
            default: "0.0"
        },
        totalKgCo2OfGear: {
            type: String,
            default: "0.0"
        },
        totalKgCo2OfOthers: {
            type: String,
            default: "0.0"
        },
        totalKgCo2OfPublicServiceShare: {
            type: String,
            default: "0.0"
        },
        // allTotalKgOfCo2: {
        //     type: String,
        //     default: "0.0"
        // },
        // allTotalTonsOfCo2: {
        //     type: String,
        //     default: "0.0"
        // },
        isDelete: {
            type: Boolean,
            default: false,
        },
    },
    {
        timestamps: true,
    }
);

// Pre-save middleware to recalculate allTotalKgOfCo2 and convert it to tons
userCarbonSchema.pre('save', function (next) {
    const totalKgCo2OfHome = parseFloat(this.totalKgCo2OfHome) || 0.0;
    const totalKgCo2OfMobility = parseFloat(this.totalKgCo2OfMobility) || 0.0;
    const totalKgCo2OfGear = parseFloat(this.totalKgCo2OfGear) || 0.0;
    const totalKgCo2OfOthers = parseFloat(this.totalKgCo2OfOthers) || 0.0;
    const totalKgCo2OfPublicServiceShare = parseFloat(this.totalKgCo2OfPublicServiceShare) || 0.0;

    this.allTotalKgOfCo2 = (totalKgCo2OfHome + totalKgCo2OfMobility + totalKgCo2OfGear + totalKgCo2OfOthers + totalKgCo2OfPublicServiceShare).toFixed(5);

    this.allTotalTonsOfCo2 = (parseFloat(this.allTotalKgOfCo2) / 1000).toFixed(5); // Convert kg to tons and fix the decimal default to 5 rounded places

    next();
});

// add plugin that converts mongoose to json
userCarbonSchema.plugin(toJSON);

/**
 * @typedef Token
 */
const userCarbon = mongoose.model('user-carbon-calculator', userCarbonSchema);

module.exports = userCarbon;