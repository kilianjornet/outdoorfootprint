const express = require('express');
const auth = require('../middlewares/auth');
const validate = require('../middlewares/validate');
const cmsController = require('../controllers/cms.controller');
const cmsValidation = require('../validations/cms.validation');
const uploadCmsImage = require('../middlewares/uploadCmsImage');

const router = express.Router();
router
  .route('/')
  .get(auth('getCms'), cmsController.getContents);

router
  .route('/:id')
  .get(auth('getCms'), cmsController.getContentsById);

router
  .route('/update/:id')
  .post(auth('getCms'),validate(cmsValidation.updateCmsId),cmsController.updateContentsById);

router
  .route('/add/new-cms')
  .post(auth('getCms'),validate(cmsValidation.newCmsAdd),cmsController.addNewCms);
router
  .route('/remove/cms-data/:id')
  .post(auth('getCms'),cmsController.deleteCms);

router
  .route('/app/:name')
  .get(cmsController.getContentByName);

router.post('/upload-cms-image/:id',auth(), uploadCmsImage.array('images', Infinity), cmsController.uploadImageByCmsId);
router.post('/remove-cms-image/:id',auth(),validate(cmsValidation.removeCmsImage), cmsController.removeImageByCmsId);



module.exports = router;