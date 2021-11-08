<template>
    <view>
        <view class="cart">
            <view class="content">
                <label v-for="(item, index) in list" :key="index">
                    <view class="list">
                        <view class="left">
                            <checkbox v-bind:checked="item.isSelect" @click="item.isSelect=!item.isSelect"></checkbox>
                            <image :src="item.image" class="image"></image>
                        </view>
                        <view class="center">
                            <view class="name">
                                {{item.name}}
                            </view>
                            <view class="count">
                                数量：
                                <button class="btn" @click="item.num>0?item.num--:''">
                                    -
                                </button>
                                x{{item.num}}
                                <button class="btn" @click="item.num++">
                                    +
                                </button>
                            </view>
                            <view class="price">
                                价格：{{item.price}}元
                            </view>
                        </view>
                        <view class="delBtn">
                            <button @click="delPro(item.id)">
                                <u-icon name="trash-fill" size="38"></u-icon>
                            </button>
                        </view>
                    </view>
                </label>
            </view>
            <!-- 底部导航栏 -->
            <view class="tabbar">
                <view class="selAll">
                    <checkbox-group>
                        <checkbox @click="selectProduct(isSelectAll)" v-bind:checked="isSelectAll" />全选
                    </checkbox-group>
                </view>
                <view class="totalPrice">
                    总价：{{getTotal.totalPrice}}元
                </view>
            </view>
            <view class="pay" @click="payment()">
                付款
            </view>
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
                isShow: false
            }
        },
        methods: {
            selectProduct(_isSelect) {
                //遍历List，全部取反
                for (var i = 0, len = this.list.length; i < len; i++) {
                    this.list[i].isSelect = !_isSelect;
                }
            },
            delPro(id) {
                axios.get('http://localhost:3000/shop/DelshopCart', {
                    params: {
                        id: id
                    }
                }).then(function (res) {
                    uni.showToast({
                        title: '删除成功',
                    });
                })
                this.getList();
            },
            payment() {

            },
            getList() {
                var _this = this
                axios.get('http://localhost:3000/shop/shopCartDeatil', {
                }).then(function (res) {
                    _this.list = res.data
                    /*赋值，是否选中*/
                    _this.list.map(function (item) {
                        _this.$set(item, 'isSelect', true);
                    })
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
        computed: {
            isSelectAll() {
                //如果List中每一条数据的isSelect都为true，返回true，否则返回false;
                return this.list.every(
                    function (val) {
                        return val.isSelect
                    });
            },
            getTotal() {
                var prolist = this.list.filter(function (val) {
                    return val.isSelect
                }),
                    totalPri = 0;
                for (var i = 0, len = prolist.length; i < len; i++) {
                    totalPri += prolist[i].price * prolist[i].num;
                }
                return { totalPrice: totalPri }
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

    .btn {
        height: 18px;
        width: 18px;
    }

    uni-button {
        display: inline-block !important;
        line-height: 18px !important;
        padding: 0 !important;
    }

    .title {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }

    .content {
        width: 700rpx;
        margin: 0 auto 180rpx;
    }

    .list {
        width: 702rpx;
        height: 210rpx;
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
        position: fixed;
        bottom: 45px;
    }

    .selAll {
        margin-left: 10px;
    }

    .totalPrice {
        margin-left: 140px;
    }

    .pay {
        background: #6adae9;
        height: 108rpx;
        display: flex;
        justify-content: center;
        align-items: center;
        /*垂直居中*/
        width: 20%;
        position: fixed;
        bottom: 45px;
        right: 0;
    }
</style>