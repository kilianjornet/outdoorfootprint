const express = require('express');
const authRoute = require('./auth.route');
const userRoute = require('./user.route');
const docsRoute = require('./docs.route');
const adminCmsRoute = require('./admin.cms.route');
const tipsRoute = require('./tips.route');
const fcmRoute = require('./fcm.route');
const offsetRoute = require('./offset.route');
const config = require('../config/config');

const router = express.Router();

const defaultRoutes = [
  {
    path: '/auth',
    route: authRoute,
  },
  {
    path: '/users',
    route: userRoute,
  },
  {
    path: '/cms',
    route: adminCmsRoute,
  },
  {
    path: '/tips',
    route: tipsRoute,
  },
  {
    path:'/fcm',
    route: fcmRoute,
  },
  {
    path:'/offset',
    route: offsetRoute,
  }
];

const devRoutes = [
  // routes available only in development mode
  {
    path: '/docs',
    route: docsRoute,
  },
];

defaultRoutes.forEach((route) => {
  router.use(route.path, route.route);
});

/* istanbul ignore next */
if (config.env === 'development') {
  devRoutes.forEach((route) => {
    router.use(route.path, route.route);
  });
}

module.exports = router;
