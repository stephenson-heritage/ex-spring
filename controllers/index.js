const express = require('express');
const router = express.Router();
const db = require('../config/db');
const pageModel = require('../models/page');
const menuModel = require('../models/menu');
/* GET home page. */
router.get('/', async function (req, res, next) {
  routePage(req, res, next);
});

router.get('/:pageKey', async function (req, res, next) {
  routePage(req, res, next);
});


async function routePage(req, res, next) {
  if (req.params.pageKey === undefined) {
    req.params.pageKey = "home";
  }
  const pageData = await pageModel.getPage(req.params.pageKey);

  if (pageData === undefined) {
    next();
  }
  const menuData = await menuModel.getMenu("main");
  //console.log(menuData);
  res.render('index', { title: pageData.title, page: pageData, mainMenu: menuData });
}

module.exports = router;