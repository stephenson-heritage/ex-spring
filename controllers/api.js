const express = require('express');
const router = express.Router();
const blogModel = require('../models/blog');


router.post('/add', async function (req, res, next) {
    if (req.auth.loggedIn) {
        const inserted = await blogModel.addEntry(req.auth.userID, req.body);
        res.json({ result: "success" });
    } else {
        next();
    }
});


async function blogPage(req, res, next) {
    if (req.params.start === undefined) {
        req.params.start = 0;
    }

    const blogData = await blogModel.getEntries(req.params.start, 2);

    res.json({
        blogEntries: blogData,
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


