const express = require('express');
const router = express.Router();
const db = require('../config/db');
const pageModel = require('../models/page');
const menuModel = require('../models/menu');
/* GET home page. */
router.all('/', async function (req, res, next) {
  routePage(req, res, next);
});

router.all('/:pageKey', async function (req, res, next) {
  routePage(req, res, next);
});


async function routePage(req, res, next) {
  if (req.params.pageKey === undefined) {
    req.params.pageKey = "home";
  }
  const pageData = await pageModel.getPage(req.params.pageKey);
  if (pageData === undefined) {
    next();
  } else {
    const menuData = await menuModel.getMenu("main");
    const sideData = await menuModel.getMenu("side");
    //console.log(pageData);
    res.render('index', { title: pageData.title, page: pageData, mainMenu: menuData, sideMenu: sideData, auth: req.auth });
  }
}

module.exports = router;