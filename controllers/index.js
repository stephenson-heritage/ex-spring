const express = require('express');
const router = express.Router();
const db = require('../config/db');
const pageModel = require('../models/page');

/* GET home page. */
router.get('/', async function (req, res, next) {

  const pageData = await pageModel.getPage("home");
  // console.log(pageData);
  res.render('index', { title: pageData.title, page: pageData });
});



module.exports = router;
