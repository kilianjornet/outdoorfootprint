// const express = require('express');
// const app = express();

// // Import the router
// const myRouter = require('./routes/myRouter');

// // Use the router for a specific path
// app.use('/my-route', myRouter);

// // Start the server
// const port = process.env.PORT || 3000;
// app.listen(port, () => {
//   console.log(`Server is running on port ${port}`);
// });

/* const express = require('express');
const path = require('path');

const app = express();
const myRouter = require('./routes/myRouter');
app.use('/api', myRouter);

// Serve the Angular application
app.use(express.static(path.join(__dirname, 'client/dist/carbon-footprint-calculator')));

// Handle requests for Angular routes
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'client/dist/carbon-footprint-calculator/index.html'));
});

// Start the server
const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
}); */

const mongoose = require('mongoose');
const app = require('./app');
const config = require('./config/config');
const logger = require('./config/logger');
const cmsSeeder = require('./models/seeders/cms.seeder');
const tipsSeeder = require('./models/seeders/tips.seeder');
const offsetSeeder = require('./models/seeders/offset.seeder');

let server;
mongoose.connect(config.mongoose.url, config.mongoose.options).then(() => {
  logger.info('Connected to MongoDB');
  cmsSeeder()
      .then(() => {
        logger.info('cms seeded successfully');
      })
      .catch((err) => {
        logger.error('Error seeding schema:', err);
      });
  // Seed Tips data
  tipsSeeder()
    .then(() => {
      logger.info('Tips seeded successfully');
    })
    .catch((err) => {
      logger.error('Error seeding Tips:', err);
    });
  offsetSeeder()
    .then(() => {
      logger.info('Offset seeded successfully');
    })
    .catch((err) => {
      logger.error('Error seeding Tips:', err);
    });
  server = app.listen(config.port, () => {
    logger.info(`Listening to port ${config.port}: http://localhost:${config.port}`);
  });
});

const exitHandler = () => {
  if (server) {
    server.close(() => {
      logger.info('Server closed');
      process.exit(1);
    });
  } else {
    process.exit(1);
  }
};

const unexpectedErrorHandler = (error) => {
  logger.error(error);
  exitHandler();
};

process.on('uncaughtException', unexpectedErrorHandler);
process.on('unhandledRejection', unexpectedErrorHandler);

process.on('SIGTERM', () => {
  logger.info('SIGTERM received');
  if (server) {
    server.close();
  }
});
