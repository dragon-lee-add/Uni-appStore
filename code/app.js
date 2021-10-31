var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var app = express();


// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'code/public')));

// catch 404 and forward to error handler
// app.use(function(req, res, next) {
//   next(createError(404));
// });

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

const usersApi = require('./routes/users');
const shopApi = require('./routes/shopApi');

// 允许跨域
app.all('*', function(req, res, next) {
  console.log(req.headers.origin)
  console.log(req.environ)
  // res.header("Access-Control-Allow-Origin", req.headers.origin);
  //设置允许跨域的域名，*代表允许任意域名跨域
  res.header("Access-Control-Allow-Origin", "*");
  //允许的header类型
  res.header("Access-Control-Allow-Headers", "content-type");
  //跨域允许的请求方式 
  res.header("Access-Control-Allow-Methods", "DELETE,PUT,POST,GET,OPTIONS");
  if(req.method === "OPTIONS") res.send(200);/*让options请求快速返回*/
  else  next();
});



app.use('/users', usersApi);
app.use('/shop', shopApi);

app.listen(3000,()=>{
  console.log("服务器已启动..")
})
module.exports = app;
