const express = require('express');
const router = express.Router();
const db = require('../config/db');

/* GET home page. */
router.get('/', async function (req, res, next) {

  const pageData = await getPage("home");
  // console.log(pageData);
  res.render('index', { title: pageData.title, page: pageData });
});


const getPage = async function (pageKey) {
  let connection = await db.getConnection();
  const rows = await connection.query("SELECT pageID,pageKey,title,content,dateModified FROM `page` WHERE pageKey = ?",
    [
      pageKey
    ]);
  let data = rows[0];
  connection.end();

  return data;
}

module.exports = router;
