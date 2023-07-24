var mongoose = require("mongoose");
var Schema = mongoose.Schema;

  const OffsetSchema = new Schema(
    {
      name: {type: String, required: true},
      title: {type: String, required: true},
      content: {type: String, required: true},
      amount: String, 
      url: String, 
    },
    {
      timestamps: { createdAt: "created_at", updatedAt: "updated_at" },
      toJSON: { virtuals: true },
    }
  );
module.exports = {
  model: mongoose.model("offset", OffsetSchema),
};
