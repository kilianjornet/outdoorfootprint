const express = require('express');
const path = require('path');
const helmet = require('helmet');
// const xss = require('xss-clean');
const mongoSanitize = require('express-mongo-sanitize');
const compression = require('compression');
const cors = require('cors');
const passport = require('passport');
const httpStatus = require('http-status');
const config = require('./config/config');
const morgan = require('./config/morgan');
const { jwtStrategy } = require('./config/passport');
const { authLimiter } = require('./middlewares/rateLimiter');
const routes = require('./routes');
const { errorConverter, errorHandler } = require('./middlewares/error');
const ApiError = require('./utils/ApiError');

const app = express();

/*// Serve the Angular application
app.use(express.static(path.join(__dirname, '../client/dist/carbon-footprint-calculator')));

// Handle requests for Angular routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, '../client/dist/carbon-footprint-calculator/index.html'));
});*/
if (config.env !== 'test') {
  app.use(morgan.successHandler);
  app.use(morgan.errorHandler);
}

// set security HTTP headers
app.use(helmet());

// parse json request body
app.use(express.json());


// parse urlencoded request body
app.use(express.urlencoded({ extended: true }));

app.use("/uploads", express.static(path.join(__dirname, "uploads")));

// app.use('/uploads', express.static(path.join(__dirname, '/uploads', 'user-profile-image')));
// app.use(express.static(path.join(__dirname, 'uploads')));
// sanitize request data
// app.use(xss());
app.use(mongoSanitize());

// gzip compression
app.use(compression());
const corsOptions = {
  origin: 'https://nodeserver.mydevfactory.com:6006', // Replace with your client's domain
};
app.use(cors());
// Set the Access-Control-Allow-Origin header
// Set the Access-Control-Allow-Origin header
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*'); // Replace with your desired origin(s)
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization, Content-Disposition'); // Add 'Content-Disposition' to the allowed headers
  next();
});
app.options('*', cors());
// Define a route to serve the image
app.get('/uploads/user-profile-image/:imageName', (req, res) => {
  const imageName = req.params.imageName;
  const imagePath = path.join(__dirname, 'uploads', 'user-profile-image', imageName);

  // Send the image file as the response
  res.sendFile(imagePath);
});

// jwt authentication
app.use(passport.initialize());
passport.use('jwt', jwtStrategy);

// limit repeated failed requests to auth endpoints
if (config.env === 'production') {
  app.use('/auth', authLimiter);
}

// v1 api routes
app.use('/api', routes);

// send back a 404 error for any unknown api request
app.use((req, res, next) => {
  next(new ApiError(httpStatus.NOT_FOUND, 'Not found'));
});

// convert error to ApiError, if needed
app.use(errorConverter);

// handle error
app.use(errorHandler);

module.exports = app;
