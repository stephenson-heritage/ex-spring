const express = require('express');
const router = express.Router();
const db = require('../config/db');
const menuModel = require('../models/menu');
const blogModel = require('../models/blog');



/* blog listing  */
router.all('/', async function (req, res, next) {
    const menuData = await menuModel.getMenu("main");
    const blogData = await blogModel.getEntries();
    res.render("blog",
        {
            title: "Blog",
            mainMenu: menuData,
            blogEntries: blogData,
            auth: req.auth,
        });
});
module.exports = router;
