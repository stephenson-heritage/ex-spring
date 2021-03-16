const express = require('express');
const router = express.Router();
const db = require('../config/db');
const menuModel = require('../models/menu');
const blogModel = require('../models/blog');


router.get('/add', async function (req, res, next) {
    if (req.auth.loggedIn) {
        const menuData = await menuModel.getMenu("main");
        res.render("blog/add",
            {
                title: "Add blog entry",
                mainMenu: menuData,
                auth: req.auth,
            });
    } else {
        next();
    }
});
router.post('/add', async function (req, res, next) {
    if (req.auth.loggedIn) {
        const menuData = await menuModel.getMenu("main");
        const inserted = await blogModel.addEntry(req.auth.userID, req.body);
        res.redirect("../blog");

        // res.render("blog/add",
        //     {
        //         title: "Add blog entry",
        //         mainMenu: menuData,
        //         auth: req.auth,
        //     });
    } else {
        next();
    }
});

/* blog listing  */
router.all('/', async function (req, res, next) {
    const menuData = await menuModel.getMenu("main");
    const blogData = await blogModel.getEntries();
    res.render("blog/list",
        {
            title: "Blog",
            mainMenu: menuData,
            blogEntries: blogData,
            auth: req.auth,
        });
});
module.exports = router;


