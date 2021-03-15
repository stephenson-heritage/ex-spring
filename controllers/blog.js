const express = require('express');
const router = express.Router();
const db = require('../config/db');
const menuModel = require('../models/menu');




/* blog listing  */
router.all('/', async function (req, res, next) {
    res.send("blogenty");
});
module.exports = router;