var OffsetPage = require('../offset.model');

module.exports = async () => {
    let count = await OffsetPage.model.estimatedDocumentCount().exec();
    if (!count) {
        await OffsetPage.model.create([
            {
                name: 'removal',
                content: "<p>Removal content</p>",
                title: 'REMOVAL',
                amount:'1250',
                url:'https://climeworks.com/checkout/cart?customizer=true'
            }, {
                name: 'reforest',
                content: "<p>Reforest content</p>",
                title: 'REFOREST',
                amount:'530',
                url:'https://store.thefutureforestcompany.com/'
            },
            {
                name: 'carbon-offset',
                content: "<p>A carbon offset is a reduction in greenhouse gasses emissions, or an increase in carbon storage, that is used to compensate for emissions that occur elsewhere.</p>",
                title: 'What is a carbon offset?',
                amount:'',
                url:''
            }
        ])
    }
    return true;
}