const express = require('express');
const auth = require('../middlewares/auth');
const validate = require('../middlewares/validate');
const tipsController = require('../controllers/tips.controller');
const tipsValidation = require('../validations/tips.validation');

const router = express.Router();
router
  .route('/')
  .get(auth('getTipsAdmin'), tipsController.getContents);

router
  .route('/:id')
  .get(auth('getTipsAdmin'), tipsController.getContentsById);

router
  .route('/update/:id')
  .post(auth('getTipsAdmin'),validate(tipsValidation.updateTipsId),tipsController.updateContentsById);

router
  .route('/update/tips-title/:id')
  .post(auth('getTipsAdmin'),tipsController.updatTipsTitleById);
router
  .route('/add/new-tips/:id')
  .post(auth('getTipsAdmin'),validate(tipsValidation.newCmsTips),tipsController.addNewTips);
router
  .route('/remove/tips-content/:id')
  .post(auth('getTipsAdmin'),validate(tipsValidation.deleteTipsContent),tipsController.deleteTips);

router
  .route('/app/list')
  .get(auth('getTipsUser'),tipsController.getContents);


// router.post('/update/:id',auth('getCms'),validate(cmsValidation.updateCmsId),tipsController.updateContentsById);
// router
//   .route('/update/:id')
//   .post(auth('getCms'), validate(cmsValidation.updateCmsId),tipsController.updateContentsById);


module.exports = router;