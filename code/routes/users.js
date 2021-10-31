var express = require('express');
var router = express.Router();

//引入连接数据库模块
const conn=require('./conn')

//连接数据
conn.connect(()=>{
  console.log("数据库连接成功")
})
var jsonWrite = function (res, ret) {
  if (typeof ret === 'undefined') {
      res.json({
          code: '1', msg: '操作失败'
      });
  }
  else {
      res.json(
          ret
      );
  }
};

router.post('/addUser', (req, res) => {
  var sql = 'insert into users(userName,passWord) values (?,?)';
  var params = req.body;
  conn.query(sql, [params.userName, params.passWord], function (err, result) {
    if (err) {
      console.log(err);
    }
    if (result) {
      jsonWrite(res, result);
    }
  })
});

// 判断是否注册
router.get('/isReg', (req, res) => {
  let { userName } = req.query;
  const sqlStr = `select * from users where  userName='${userName}'`
  conn.query(sqlStr, (err, result) => {
    if (err) {
      throw err;
    } if (result) {
      jsonWrite(res, result);
    }
  })
});



/**用户登录 */
router.post('/login', (req, res) => {
  let { userName, passWord } = req.body;
  const sqlStr = `select * from users where  userName='${userName}' and passWord='${passWord}'`
  conn.query(sqlStr, (err, result) => {
    if (err) {
      throw err;
    } if (result) {
      jsonWrite(res, result);
    }
  })
});
module.exports = router;
