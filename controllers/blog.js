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
async function blogPage(req, res, next) {
    if (req.params.start === undefined) {
        req.params.start = 0;
    }
    const menuData = await menuModel.getMenu("main");
    const blogData = await blogModel.getEntries(req.params.start, 3);
    let entries = [];
    for (let i = 0; i <= Math.floor(blogData.rowCount / 3); i++) {
        entries[i] = { start: i, page: i + 1 };
    }
    blogData.entries = entries;
    //console.log(blogData.entries);
    res.render("blog/list",
        {
            title: "Blog",
            mainMenu: menuData,
            blogEntries: blogData,
            auth: req.auth,
        });
}
router.all('/:start', async function (req, res, next) {
    blogPage(req, res, next);
});
/* blog listing  */
router.all('/', async function (req, res, next) {
    blogPage(req, res, next);
});
module.exports = router;


