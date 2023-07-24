const express = require('express');
const auth = require('../middlewares/auth');
const validate = require('../middlewares/validate');
const fcmController = require('../controllers/fcm.controller');
const fcmValidator = require('../validations/fcm.validation');

const router = express.Router();

router
  .route('/send-notification-all-users')
  .post(auth('sendNotification'),validate(fcmValidator.sendNotificationToAllUser),fcmController.sendNotificationToAllUser);

router
  .route('/get-all-notification')
  .get(auth('sendNotification'),fcmController.getAllNotificationAdmin);

router
  .route('/app/get-all-notification')
  .get(auth(),fcmController.getAllNotificationApp);



// router.post('/update/:id',auth('getCms'),validate(cmsValidation.updateCmsId),tipsController.updateContentsById);
// router
//   .route('/update/:id')
//   .post(auth('getCms'), validate(cmsValidation.updateCmsId),tipsController.updateContentsById);


module.exports = router;