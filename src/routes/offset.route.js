const express = require('express');
const auth = require('../middlewares/auth');
const validate = require('../middlewares/validate');
const offsetController = require('../controllers/offset.controller');
const offsetValidation = require('../validations/offset.validation');

const router = express.Router();
router
  .route('/')
  .get(auth('OffsetAdmin'), offsetController.getContents);

router
  .route('/:id')
  .get(auth('OffsetAdmin'), offsetController.getContentsById);

router
  .route('/update/:id')
  .post(auth('OffsetAdmin'),validate(offsetValidation.updateOffsetId),offsetController.updateContentsById);
router
  .route('/add/new-offset')
  .post(auth('OffsetAdmin'),validate(offsetValidation.newCmsOffset),offsetController.addNewOffset);
router
  .route('/remove/offset-data/:id')
  .post(auth('OffsetAdmin'),offsetController.removeTips);

router
  .route('/app/list')
  .get(auth('OffsetApp'),offsetController.getContentsApp);


// router.post('/update/:id',auth('getCms'),validate(cmsValidation.updateCmsId),tipsController.updateContentsById);
// router
//   .route('/update/:id')
//   .post(auth('getCms'), validate(cmsValidation.updateCmsId),tipsController.updateContentsById);


module.exports = router;