const db = require('../config/db');

module.exports = {
    getEntries: async function () {
        let connection = await db.getConnection();
        //SELECT `blogId`, `title`, `userId`, `content`, `dateAdded` FROM `express_spring`.`blog` ORDER BY `dateAdded` LIMIT 5

        const rows = await connection.query("SELECT `blogId`, `title`,username, user.userId, `content`, `dateAdded` FROM `express_spring`.`blog` JOIN `user` ON `user`.userID = blog.userId Order BY `dateAdded` DESC LIMIT 5");


        let data = rows;
        connection.end();

        if (rows.length > 0) {
            return data;
        } else {
            return false;
        }
    }
}
