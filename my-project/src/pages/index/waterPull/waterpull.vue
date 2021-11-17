<template>
  <view class="wrap">
    <!--瀑布流1-->
    <u-waterfall v-model="flowListOne" ref="uWaterfallOne" v-show="showOne">
      <template v-slot:left="{ leftList }">
        <view class="demo-warter" v-for="(item, index) in leftList" :key="index">
          <!-- 警告：微信小程序中需要hx2.8.11版本才支持在template中结合其他组件，比如下方的lazy-load组件 -->
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{item.name}}
          </view>
          <view class="demo-price">
            {{item.price}}元
          </view>
        </view>
      </template>
      <template v-slot:right="{ rightList }">
        <view class="demo-warter" v-for="(item, index) in rightList" :key="index">
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{ item.name}}
          </view>
          <view class="demo-price"> {{ item.price }}元 </view>
        </view>
      </template>
    </u-waterfall>
    <!--瀑布流2-->
    <u-waterfall v-model="flowListTwo" ref="uWaterfallTwo" v-show="showTwo">
      <template v-slot:left="{ leftList }">
        <view class="demo-warter" v-for="(item, index) in leftList" :key="index">
          <!-- 警告：微信小程序中需要hx2.8.11版本才支持在template中结合其他组件，比如下方的lazy-load组件 -->
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{item.name}}
          </view>
          <view class="demo-price">
            {{item.price}}元
          </view>
        </view>
      </template>
      <template v-slot:right="{ rightList }">
        <view class="demo-warter" v-for="(item, index) in rightList" :key="index">
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{ item.name}}
          </view>
          <view class="demo-price"> {{ item.price }}元 </view>
        </view>
      </template>
    </u-waterfall>
    <!--瀑布流3-->
    <u-waterfall v-model="flowListThree" ref="uWaterfallThree" v-show="showThree">
      <template v-slot:left="{ leftList }">
        <view class="demo-warter" v-for="(item, index) in leftList" :key="index">
          <!-- 警告：微信小程序中需要hx2.8.11版本才支持在template中结合其他组件，比如下方的lazy-load组件 -->
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{item.name}}
          </view>
          <view class="demo-price">
            {{item.price}}元
          </view>
        </view>
      </template>
      <template v-slot:right="{ rightList }">
        <view class="demo-warter" v-for="(item, index) in rightList" :key="index">
          <a @click="shopDetail(item.id)">
            <u-lazy-load threshold="-450" border-radius="10" :image="item.product_picture" :index="index"></u-lazy-load>
          </a>
          <view class="demo-title">
            {{ item.name}}
          </view>
          <view class="demo-price"> {{ item.price }}元 </view>
        </view>
      </template>
    </u-waterfall>

    <!--加载更多-->
    <u-loadmore :status="status" />
  </view>
</template>

<script>
  import axios from "axios";
  export default {
    data() {
      return {
        showOne: true,
        showTwo: false,
        showThree: false,
        flowListOne: [],
        flowListTwo: [],
        flowListThree: [],
        //加载
        status: 'nomore',
      };
    },
    onPageScroll(e) {
      this.scrollTop = e.scrollTop;
    },
    methods: {
      getshopWaterpullOne() {
        var _this = this;
        var url = 'http://localhost:3001/'
        axios.get("http://localhost:3000/shop/shopWaterpullPhone", {
        }).then(function (res) {
          let arr = res.data
          if (Array.isArray(arr)) {
            arr.forEach(item => {
              item.product_picture = `${url}${item.product_picture}`
            })
            _this.flowListOne = arr
            _this.showOne = true
            _this.showTwo = false
            _this.showThree = false
          }
        });
      },
      getshopWaterpullTwo() {
        var _this = this;
        var url = 'http://localhost:3001/'
        axios.get("http://localhost:3000/shop/shopWaterpullElectric", {
        }).then(function (res) {
          let arr = res.data
          if (Array.isArray(arr)) {
            arr.forEach(item => {
              item.product_picture = `${url}${item.product_picture}`
            })
            _this.flowListTwo = arr
            _this.showOne = false
            _this.showTwo = true
            _this.showThree = false
          }
        });
      },
      getshopWaterpullThree() {
        var _this = this;
        var url = 'http://localhost:3001/'
        axios.get("http://localhost:3000/shop/shopWaterpullCharger", {
        }).then(function (res) {
          let arr = res.data
          if (Array.isArray(arr)) {
            arr.forEach(item => {
              item.product_picture = `${url}${item.product_picture}`
            })
            _this.flowListThree = arr
            _this.showOne = false
            _this.showTwo = false
            _this.showThree = true
          }
        });
      },
      shopDetail(id) {
        uni.navigateTo({
          url: "detail?id=" + id,
        });
      }
    }
  };
</script>

<style lang="scss" scoped>
  .wrap {
    height: 200vh;
  }

  .title {
    font-size: medium;
    font-weight: bolder;
  }

  .wrap {
    padding: 40rpx;
  }

  .demo-warter {
    border-radius: 8px;
    margin: 5px;
    background-color: #ffffff;
    padding: 8px;
    position: relative;
  }

  .u-close {
    position: absolute;
    top: 32rpx;
    right: 32rpx;
  }

  .demo-image {
    width: 100%;
    border-radius: 4px;
  }
</style>