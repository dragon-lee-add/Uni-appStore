<template>
    <view class="login">
        <!--默认界面-->
        <view>
            <u-navbar :is-back="false" title="　" :border-bottom="false">
                <view class="u-flex u-row-right" style="width: 100%;">
                    <view class="camera u-flex u-row-center">
                        <u-icon name="camera-fill" color="#000000" size="48"></u-icon>
                    </view>
                </view>
            </u-navbar>
            <view class="u-flex user-box u-p-l-30 u-p-r-20 u-p-b-30">
                <view class="u-m-r-10">
                    <u-avatar :src="pic" size="140" @click=login()></u-avatar>
                </view>
                <view class="u-flex-1">
                    <view class="u-font-18 u-p-b-20" v-show="loginName==null">您还未登录&nbsp;请先登录</view>
                    <view class="u-font-14 u-tips-color" v-show="loginName!=null">尊贵的用户<br />{{loginName}}</view>
                </view>
                <view class="u-m-l-10 u-p-10">
                    <u-icon name="scan" color="#969799" size="28"></u-icon>
                </view>
                <view class="u-m-l-10 u-p-10">
                    <u-icon name="arrow-right" color="#969799" size="28"></u-icon>
                </view>
            </view>
            <view class="u-m-t-20">
                <u-cell-group>
                    <u-cell-item icon="rmb-circle" title="支付"></u-cell-item>
                </u-cell-group>
            </view>
            <view class="u-m-t-20">
                <u-cell-group>
                    <u-cell-item icon="star" title="足迹"></u-cell-item>
                    <u-cell-item icon="coupon" title="卡券"></u-cell-item>
                </u-cell-group>
            </view>
            <view class="u-m-t-20">
                <u-cell-group>
                    <u-cell-item icon="setting" title="退出登录" @click="loginOut()"></u-cell-item>
                </u-cell-group>
            </view>
        </view>
        <!--弹出层-->
        <!--登录-->
        <u-popup v-model="showLogin" mode="center" width="600rpx" height="240px" border-radius=45>
            <view class="form">
                <u-form :model="loginForm" ref="uLoginForm">
                    <view class="title">登录</view>
                    <u-form-item label="账号" prop="userName" :border-bottom=false>
                        <u-input v-model="loginForm.userName" :type="userType" :border="border" />
                    </u-form-item>
                    <u-form-item label="密码" prop="passWord" :border-bottom=false>
                        <u-input v-model="loginForm.passWord" :type="Pwdtype" :border="border" />
                    </u-form-item>
                    <view class="btn">
                        <u-button type="primary" shape="square" @click=loginBtn()>登录</u-button>
                        <u-button type="primary" shape="square" @click=registerUser()>注册</u-button>
                    </view>
                </u-form>
            </view>
        </u-popup>
        <!--注册-->
        <u-popup v-model="showResigter" mode="center" width="600rpx" height="240px" border-radius=45>
            <view class="form">
                <u-form :model="registerForm" ref="uResitgerForm">
                    <view class="title">注册</view>
                    <u-form-item label="账号" prop="userName" :border-bottom=false>
                        <u-input v-model="loginForm.userName" :type="userType" :border="border" />
                    </u-form-item>
                    <u-form-item label="密码" prop="passWord" :border-bottom=false>
                        <u-input v-model="loginForm.passWord" :type="Pwdtype" :border="border" />
                    </u-form-item>
                    <view class="btn">
                        <u-button type="success" shape="square" @click=registerBtn()>确定</u-button>
                        <u-button type="success" shape="square" @click=CanleBtn()>返回</u-button>
                    </view>
                </u-form>
            </view>

        </u-popup>
    </view>
</template>

<script>
    import axios from "axios";

    export default {
        data() {
            return {
                pic: 'https://uviewui.com/common/logo.png',
                loginForm: {
                    userName: "",
                    passWord: "",
                },
                registerForm: {
                    userName: "",
                    passWord: "",
                },
                userType: 'text',
                Pwdtype: 'password',
                passwordIcon: true,
                border: true,
                showLogin: false,
                showResigter: false,
                loginName: "",//用户名
            }
        },
        onLoad() {
            //重新获取用户名
            this.loginName = sessionStorage.getItem("userName")

        },
        onShow() {

        },
        methods: {
            registerUser() {
                this.showResigter = true
                this.showLogin = false
            },
            CanleBtn() {
                uni.navigateBack({
                    delta: 1
                })
            },
            addUser() {
                var _this = this
                axios.post('http://localhost:3000/users/addUser', {
                    userName: this.loginForm.userName,
                    passWord: this.loginForm.passWord
                }).then(function (res) {
                });

            },
            registerBtn() {
                var _this = this;
                axios.get('http://localhost:3000/users/isReg', {
                    params: {
                        userName: this.loginForm.userName,
                    }
                }).then(function (res) {
                    if (res.data.length) {
                        uni.showToast({
                            title: '账号已存在',
                            icon: 'none'
                        });
                    } else {
                        _this.addUser();
                        uni.showToast({
                            title: '注册成功',
                        });
                        _this.showResigter = false
                    }
                });

            },
            loginBtn() {
                var _this = this;
                axios.post('http://localhost:3000/users/login', {
                    userName: this.loginForm.userName,
                    passWord: this.loginForm.passWord
                }).then(function (res) {
                    console.log(res)
                    if (res.data.length) {
                        uni.showToast({
                            title: '登录成功',
                        });
                        _this.showLogin = false
                        //存储
                        sessionStorage.setItem("userName", res.data[0].userName);
                        location.reload();
                    } else {
                        uni.showToast({
                            title: '账号或者密码输入有误',
                            icon: 'none'
                        });
                    }
                }).catch(function (err) {
                    console.log(err)
                })
            },
            //打开登录界面
            login() {
                this.showLogin = true
            },
            loginOut() {
                if (this.loginName == null) {
                    uni.showToast({
                        title: '您还未登录',
                        icon: 'none'
                    });
                } else {
                    sessionStorage.removeItem("userName");
                    location.reload();//页面刷新
                }
            }
        },

    }
</script>

<style scoped>
    page {
        background-color: #ededed;
    }

    /deep/.uni-input-input {
        width: 100px;
    }

    /deep/ .u-size-default {
        width: 70px;
        height: 30px;
        display: inline-block;
        line-height: 30px;
        margin-right: 10px;
    }

    .camera {
        width: 54px;
        height: 44px;

        &:active {
            background-color: #ededed;
        }
    }

    .user-box {
        background-color: #fff;
    }

    .form {
        position: absolute;
        top: 50%;
        left: 50%;
        -webkit-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
        padding-bottom: 10px;
    }

    .title {
        margin-bottom: 10px;
        text-align: center;
        font-size: 25px;
    }

    .input {
        padding-bottom: 10px;
    }

    .btn {
        text-align: center;
    }

    .u-size-mini {
        margin-right: 8px;
    }

    .logo {
        margin: 10px;
    }
</style>