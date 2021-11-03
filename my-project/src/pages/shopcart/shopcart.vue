<template>
    <view>
        <view class="cart">
            <view class="content">
                <label v-for="(item, index) in list" :key="index">
                    <view class="list">
                        <view class="left">
                            <checkbox @change="checkboxChange" :checked="checked"></checkbox>
                            <image :src="item.image" class="image"></image>
                        </view>
                        <view class="center">
                            <view class="name">
                                {{item.name}}
                            </view>
                            <view class="count">
                                数量：x{{item.num}}
                            </view>
                            <view class="price">
                                价格：{{item.price}}元
                            </view>
                        </view>
                    </view>
                </label>
            </view>
            <!-- 底部导航栏 -->
            <!-- <view class="tabbar">
                <view class="selAll">
                    <checkbox-group @change="checkboxChangeAll">
                        <checkbox :checked="isAllChecked" />全选
                    </checkbox-group>
                </view>
            </view>
            <view class="pay" @click="payment()">
                付款
            </view> -->
        </view>
        <view v-show="isShow" class="title">
            <h2>购物车空空如也</h2>
        </view>
    </view>
</template>

<script>
    import axios from "axios";
    export default {

        data() {
            return {
                list: [], //列表数据
                checked: false,
                isAllChecked: false,//是否全选
                isShow: false
            }
        },

        methods: {
            checkboxChangeAll(e) {
                this.isAllChecked = !this.isAllChecked
                this.checked = true
            },
            payment() {
                alert("支付")
            },
            checkboxChange: function (e) {
                var checked = e.target.value
                var changed = {}
                for (var i = 0; i < this.checkboxItems.length; i++) {
                    if (checked.indexOf(this.checkboxItems[i].name) !== -1) {
                        changed['checkboxItems[' + i + '].checked'] = true
                    } else {
                        changed['checkboxItems[' + i + '].checked'] = false
                    }
                }
            },
            getList() {
                var _this = this
                axios.get('http://localhost:3000/shop/shopCartDeatil', {
                }).then(function (res) {
                    _this.list = res.data
                    console.log(res.data)
                    if (res.data.length == 0) {
                        _this.isShow = true
                    } else {
                        _this.isShow = false
                    }
                }).catch(function (err) {
                    console.log(err)
                })
            }
        },
        onShow() {
            this.getList()

        }
    }
</script>

<style lang="scss" scoped>
    page {
        background: #f1e8e7;
    }

    .title {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%,-50%);
    }

    .content {
        width: 670rpx;
        margin: 0 auto 180rpx;
    }

    .list {
        width: 672rpx;
        height: 208rpx;
        background: #f9f9f9;
        box-shadow: 0 8rpx 16rpx 0 rgba(83, 66, 49, 0.08);
        border-radius: 24rpx;
        margin-top: 32rpx;
        display: flex;
        justify-content: space-around;
        align-items: center;

    }

    .left {
        display: flex;
        justify-content: space-around;
        align-items: center;
    }

    .image {
        width: 136rpx;
        height: 136rpx;
        margin-left: 10rpx;
        border-radius: 8%;
    }

    .tabbar {
        background: #f9f9f9;
        height: 108rpx;
        display: flex;
        align-items: center;
        width: 80%;
        position: absolute;
        bottom: 45px;
    }

    .selAll {
        margin-left: 10px;
    }

    .pay {
        background: #6adae9;
        height: 108rpx;
        display: flex;
        justify-content: center;
        align-items: center;
        /*垂直居中*/
        width: 20%;
        position: absolute;
        bottom: 45px;
        right: 0;
    }
</style>