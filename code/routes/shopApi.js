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
//轮播图
router.get('/shopSwiper', function (req, res) {
    const sqlStr = 'select * from carousel'
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
//瀑布流
router.get('/shopWaterpullPhone', function (req, res) {
    const sqlStr = 'select * from shop where category_id=1'
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
router.get('/shopWaterpullElectric', function (req, res) {
    const sqlStr = 'select * from shop where category_id=2'
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
router.get('/shopWaterpullCharger', function (req, res) {
    const sqlStr = 'select * from shop where category_id=7'
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
// 商品详情
router.get('/shopDetail', function (req, res) {
    let id = req.query.id
    const sqlStr = `select * from shop where  id='${id}'`
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});

//左侧分类
router.get('/category', function (req, res) {
    const sqlStr = 'select * from category'
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
//右侧分类
router.get('/shopCategory', function (req, res) {
    let category_id = req.query.category_id
    const sqlStr = `select * from shop where category_id='${category_id}'`
    conn.query(sqlStr, (err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
//添加购物车
router.get('/shopCart', function (req, res) {  
    const sqlStr = 'insert into shoppingcart(name,price,product_id,num,image,userName) values (?,?,?,?,?,?)';
    var params = req.query
    conn.query(sqlStr, [params.name,params.price,params.product_id,params.num,params.image,params.userName],(err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
//购物车
router.get('/shopCartDeatil', function (req, res) {  
    let userName = req.query.userName
    const sqlStr = `select * from shoppingcart where userName='${userName}'`;
    conn.query(sqlStr,(err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
//购物车删除
router.get('/DelshopCart', function (req, res) {  
    let  id = req.query.id;
    const sqlStr = `delete  from shoppingcart where  id=${id}`;
    conn.query(sqlStr,(err, result) => {
        if (err) {
            throw err;
        } if (result) {
            jsonWrite(res, result);
        }
    })
});
module.exports = router;

