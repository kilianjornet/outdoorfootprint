const mongoose = require('mongoose');
const { toJSON } = require('./plugins');
const { tokenTypes } = require('../config/tokens');

const mobilitySchema = mongoose.Schema(
    {
        user: {
            type: mongoose.SchemaTypes.ObjectId,
            ref: 'User',
            required: true,
        },
        // quantityOfRunShoes: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfRunShoes: {
        //     type: Number,
        //     default: 13.6
        // },
        // quantityOfSkies: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfSkies: {
        //     type: Number,
        //     default: 45.2
        // },
        // quantityOfClimbRope: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfClimbRope: {
        //     type: Number,
        //     default: 0.25
        // },
        // quantityOfClimbGear: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfClimbGear: {
        //     type: Number,
        //     default: 12
        // },
        // quantityOfBike: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfBike: {
        //     type: Number,
        //     default: 300
        // },
        // quantityOfPoliesterTees: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfPoliesterTees: {
        //     type: Number,
        //     default: 15
        // },
        // quantityOfCottonTees: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfCottonTees: {
        //     type: Number,
        //     default: 10
        // },
        // quantityOfJacket: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfJacket: {
        //     type: Number,
        //     default: 18
        // },
        // quantityOfUnderwearSocks: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfUnderwearSocks: {
        //     type: Number,
        //     default: 1.9
        // },
        // quantityOfPants: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfPants: {
        //     type: Number,
        //     default: 9
        // },
        // quantityOfGlobes: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfGlobes: {
        //     type: Number,
        //     default: 2
        // },
        // quantityOfSportswear: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfSportswear: {
        //     type: Number,
        //     default: 6.1
        // },
        // quantityOfSkiclothes: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfSkiclothes: {
        //     type: Number,
        //     default: 15
        // },
        // quantityOfSwimwear: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfSwimwear: {
        //     type: Number,
        //     default: 1.8
        // },
        // quantityOfSmartwatch: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfSmartwatch: {
        //     type: Number,
        //     default: 40
        // },
        // quantityOfTent: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfTent: {
        //     type: Number,
        //     default: 13
        // },
        // quantityOfCustomProducts: {
        //     type: Number,
        //     default: ""
        // },
        // kgCo2OfCustomProducts: {
        //     type: Number,
        //     default: 0
        // },
        totalKgCo2OfGear: {
            type: Number,
            default: ""
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
mobilitySchema.plugin(toJSON);

/**
 * @typedef Token
 */
const Mobility = mongoose.model('user-mobility', mobilitySchema);

module.exports = Mobility;