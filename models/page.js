const db = require('../config/db');

module.exports = {
    addPage: async function (pageData, userID) {
        let connection = await db.getConnection();

        const res = await connection.query("INSERT INTO `phpsite`.`page` (`pageKey`, `title`, `content`, `lastUserID`) VALUES (?, ?, ?, ?);",
            [
                pageData.pageKey, pageData.title, pageData.content, userID,
            ]);


        if (res.affectedRows == 1) {
            return true;
        } else {
            return false;
        }

    },

    editPage: async function (pageKey, pageData, userID) {
        let connection = await db.getConnection();

        const res = await connection.query("UPDATE `page` SET `title`=?, `content`=?,lastUserID=? WHERE pageKey=?;",
            [
                pageData.title, pageData.content, userID, pageKey
            ]);


        if (res.affectedRows == 1) {
            return true;
        } else {
            return false;
        }

    },
    getPage: async function (pageKey) {
        let connection = await db.getConnection();
        const rows = await connection.query("SELECT pageID,pageKey,title,content,dateModified FROM `page` WHERE pageKey = ?",
            [
                pageKey
            ]);

        if (rows[0] === undefined) {
            //todo load home page or return []
            return undefined;
        } else {
            let data = rows[0];
            connection.end();

            return data;
        }
    }
}
