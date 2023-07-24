var mongoose = require("mongoose");
var Schema = mongoose.Schema;

const tipsContentSchema = new Schema({
    content_name: { type: String, required: true },
    content_title: String,
    content: { type: String, required: true },
  });
  
  const TipsSchema = new Schema(
    {
      tips_title: String,
      content: [tipsContentSchema], // An array of content items
    },
    {
      timestamps: { createdAt: "created_at", updatedAt: "updated_at" },
      toJSON: { virtuals: true },
    }
  );
module.exports = {
  model: mongoose.model("tips", TipsSchema),
};
