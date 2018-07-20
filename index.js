var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var pool = mysql.createPool({
    connectionLimit: 10,
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: '_test'
});


/* GET home page. */
router.get('/', function (req, res, next) {

    pool.query('call _category_list(?)', [0], function (error, r) {
        if (error) throw error;
        res.render('index', {r: r[0]});
    });

});

router.post('/', function (req, res, next) {

    // console.log(req.body);
    pool.query('call _category_save_all(?,?,?)', [req.body.p, req.body.tm, req.body.ts], function (error, r) {
        if (error) throw error;
    });

});

module.exports = router;
