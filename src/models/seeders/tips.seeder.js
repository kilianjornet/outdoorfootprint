var TipsSchema = require('../tips.model');

module.exports = async () => {
    let count = await TipsSchema.model.estimatedDocumentCount().exec();
    if (!count) {
        await TipsSchema.model.create([
            {
              tips_title: 'What can you do to preserve these very vulnerable natural spaces?',
              content: [
                {
                  content_name: 'gear',
                  content_title: 'Gear',
                  content: "<p>Gear content</p>",
                },
                {
                  content_name: 'mountains',
                  content_title: 'When you go to the mountains',
                  content: "<p>When you go to the mountains content</p>",
                },
                {
                  content_name: 'eating',
                  content_title: 'When eating',
                  content: "<p>When eating content</p>",
                },
                {
                  content_name: 'shopping',
                  content_title: 'When shopping',
                  content: "<p>When shopping content</p>",
                },
                {
                  content_name: 'home',
                  content_title: 'At Home',
                  content: "<p>At Home content</p>",
                },
                {
                  content_name: 'transportation',
                  content_title: 'Transportation',
                  content: "<p>Transportation content</p>",
                },
                {
                  content_name: 'air-travel',
                  content_title: 'Air Travel',
                  content: "<p>Air Travel content</p>",
                },
                {
                  content_name: 'at-work',
                  content_title: 'At Work',
                  content: "<p>At Work content</p>",
                },
              ],
            },
          ])
    }
    return true;
}