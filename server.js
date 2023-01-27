// Get Express to work
var express = require('express');
var app = express();

// Get the body-parser to work
var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Get the mongoose to work
const sequelize = require('./config/db');

// Get the routes to work
var routes = require('./routes/routes');
routes(app);

// Start the server
app.listen(3000, function () {
    console.log("Server running on port 3000");
});



