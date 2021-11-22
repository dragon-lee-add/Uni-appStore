//拦截器 拦截只要是未登录状态，想要跳转到名单内的路径时，直接跳到登录页。
// 页面名单
const whiteList = [
	'/pages/my/my'
]

function hasPermission (url) {
	let islogin = sessionStorage.getItem("isLogin");
	islogin = Boolean(Number(islogin));//返回布尔值
    // 在白名单中或有token，直接跳转
    if(whiteList.indexOf(url) !== -1 || islogin) {
        return true
    }
    return false
}
 
uni.addInterceptor('navigateTo', {
    // 页面跳转前进行拦截, invoke根据返回值进行判断是否继续执行跳转
    invoke (e) {
        if(!hasPermission(e.url)){
            uni.reLaunch({
                url: '/pages/my/my'
            })
            return false
        }
        return true
    },
    success (e) {
        // console.log(e)
    }
})
 
uni.addInterceptor('switchTab', {
    // tabbar页面跳转前进行拦截
    invoke (e) {
        if(!hasPermission(e.url)){
            uni.reLaunch({
                url: '/pages/my/my'
            })
            return false
        }
        return true
    },
    success (e) {
       
    }
})
