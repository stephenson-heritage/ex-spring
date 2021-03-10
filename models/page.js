const db = require('../config/db');

module.exports = {
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
