const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'src/uploads/user-profile-image/');
  },
  filename: function (req, file, cb) {
    // cb(null, file.fieldname + '-' + Date.now());
    // const fileName = file.originalname.replace(/\s/g, "_");
    //   cb(null, "testImages-" + Date.now() + "-" + fileName);
    if (file.fieldname === "profile_image") {
        const fileName = file.originalname.replace(/\s/g, "_");
      cb(null, "profile_image-" + Date.now() + "-" + fileName);
    }
  }
});

const uploadPic = multer({ storage: storage });

module.exports = uploadPic;