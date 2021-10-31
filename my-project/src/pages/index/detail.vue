<template>
    <view>
        <u-swiper :list="shopList" name="product_picture" mode='number' :autoplay='false' indicator-pos='bottomRight'
            height='650'>
        </u-swiper>

        <view class="u-p-20" v-for="(item, index) in shopList" :key="index">
            <view class="u-m-b-20">
                <u-tag text="品牌好物" mode="dark" bg-color='#0eb6ff' />
                <text class="u-font-24 u-m-l-20 u-type-info-dark">原装正厂 售后无忧</text>
            </view>
            <view class="u-font-36 u-m-b-20">
                {{item.name}}
            </view>
            <view class="u-m-b-20">
                <text class="u-font-24 u-type-info-dark">质量有保障</text>
            </view>
            <view class="u-m-b-20">
                <text class="prices u-font-36">{{item.price}}</text>元
                <text class="u-type-info-dark line-through u-m-l-25 u-font-24"></text>
                <!--折后价-->
            </view>
        </view>


        <button class="setCart" type="primary" @click="show=true">加入购物车</button>
        <u-popup v-model="show" mode='bottom' closeable>
            <view class="">
                <view class="u-p-30" v-for="(item, index) in shopList" :key="index">
                    <view class="u-text-center u-font-30">
                        {{item.title}}
                    </view>
                    <view class="u-flex u-m-b-20">
                        <u-image class='u-m-r-30' width="150rpx" height="150rpx" :src=imgUrl> </u-image>
                        <view class="u-flex-col">
                            <view class="u-m-b-20">
                                <text class="prices">{{item.price}}</text>元/台 <text
                                    class="u-m-l-20 through u-type-info-dark u-font-24"></text>
                            </view>
                            <view class="">
                                已选：{{num}}台
                            </view>
                        </view>
                    </view>
                    <view class="u-p-t-20 u-p-b-20 u-border-top">
                        商家24H发货，第三方物流配送，免运费
                    </view>
                    <view class="u-p-t-20 u-p-b-20 u-border-top u-flex u-row-between">
                        <text>购买数量(台)</text>
                        <u-number-box v-model="num" :min="1" @change="valChange"></u-number-box>
                    </view>
                </view>
                <button class="" type="primary" @click="shopCart()">加入购物车</button>
            </view>
        </u-popup>
    </view>
</template>

<script>
    import axios from "axios";
    export default {
        data() {
            return {
                shopList: [],
                num: 1,
                show: false,
                imgUrl: "",
                price: "",
                id: "",
                name: ""
            }
        },

        onLoad(option) {
            this.id = option.id
            this.getList()
        },
        methods: {
            getList() {
                const url = 'http://localhost:3001/'
                var _this = this
                axios.get('http://localhost:3000/shop/shopDetail', {
                    params: {
                        id: this.id
                    }
                }).then(function (res) {
                    let arr = res.data
                    if (Array.isArray(arr)) {
                        arr.forEach(item => {
                            item.product_picture = `${url}${item.product_picture}`
                        })
                        _this.shopList = arr
                    }
                    _this.imgUrl = res.data[0].product_picture//图片路径
                    _this.name = res.data[0].name
                    _this.price = res.data[0].price
                }).catch(function (err) {
                    console.log(err)
                })
            },
            shopCart() {
                var _this = this
                axios.get('http://localhost:3000/shop/shopCart', {
                    params: {
                        name: this.name,
                        num: this.num,
                        price: this.price,
                        product_id: this.id,
                        image: this.imgUrl
                    }
                }).then(function (res) {
                    _this.show=false
                    uni.showToast({
                        title: '加入成功',
                    });

                }).catch(function (err) {
                    console.log(err)
                })
            },
            valChange(e) {
                this.num = e.value
            }
        }
    }
</script>

<style scoped>
    .prices {
        color: red;
    }


    .setCart {
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
    }



    .line-through {
        text-decoration: line-through
    }

    .prices {
        color: #ce5962;
    }
</style>