const db = require('../config/db');

module.exports = {
    getMenu: async function (menuName) {
        let connection = await db.getConnection();
        const rows = await connection.query("SELECT html,link,target FROM menuitem JOIN menu ON menu.menuID = menuitem.menuID WHERE `name` = ? ORDER BY sort",
            [
                menuName
            ]);
        let data = rows;
        connection.end();
        return data;
    }
}
