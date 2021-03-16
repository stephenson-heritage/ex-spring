const db = require('../config/db');


module.exports = {
    addEntry: async function (userID, entry) {
        let connection = await db.getConnection();
        //SELECT `blogId`, `title`, `userId`, `content`, `dateAdded` FROM `express_spring`.`blog` ORDER BY `dateAdded` LIMIT 5

        const rows = await connection.query("INSERT INTO `express_spring`.`blog` (`title`, `userId`, `content`) VALUES (?, ?, ?)",
            [
                entry.title, userID, entry.content
            ]);


        let data = rows;
        connection.end();

        if (rows.length > 0) {
            return data;
        } else {
            return false;
        }
    },
    getEntries: async function (row, perPage) {
        let connection = await db.getConnection();
        //SELECT `blogId`, `title`, `userId`, `content`, `dateAdded` FROM `express_spring`.`blog` ORDER BY `dateAdded` LIMIT 5

        if (row === undefined) {
            row = 0;
        };
        if (perPage === undefined) {
            perPage = 3;
        };
        let startRow = row * perPage;
        const rows = await connection.query("SELECT `blogId`, `title`,username, user.userId, `content`, `dateAdded` FROM `express_spring`.`blog` JOIN `user` ON `user`.userID = blog.userId Order BY `dateAdded` DESC LIMIT ?,?",
            [
                startRow, startRow + perPage
            ]);
        const rowCount = await connection.query("SELECT COUNT(blogId) AS rowTotal FROM `blog`");
        // console.log(rowCount[0].rowTotal)
        let data = { rows: rows, rowCount: rowCount[0].rowTotal };
        connection.end();

        if (rows.length > 0) {
            return data;
        } else {
            return false;
        }
    }
}
