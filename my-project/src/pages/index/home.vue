<template>
  <view class="wrap">
    <!--轮播图-->
    <u-swiper :list="list" name="imgPath" mode="dot" duration="3000" :circular="false" :effect3d="true"></u-swiper>
    <view class="title">推荐好物</view>
    <u-line color="black" />
    <u-tabs name="cate_name" count="cate_count" :list="tablist" :is-scroll="false" :current="current" @change="change">
    </u-tabs>

    <waterpull ref="child"></waterpull>
    <!--返回顶部-->
    <u-back-top :scrollTop="scrollTop" :mode="mode" :icon-style="iconStyle"></u-back-top>
  </view>
</template>

<script>
  import axios from "axios";
  import waterpull from '../../pages/index/waterPull/waterpull';
  export default {
    components: {
      waterpull,
    },
    data() {
      return {
        list: [],
        tablist: [{
          cate_name: '手机'
        }, {
          cate_name: '电器'
        }, {
          cate_name: '充电器',
        }],
        current: 0,
        //返回顶部
        scrollTop: 0,
        mode: 'square',
        iconStyle: {
          fontSize: '32rpx',
          color: '#2979ff'
        },
        startInterval: null,
        onlineInterval: null
      };
    },
    onPageScroll(e) {
      this.scrollTop = e.scrollTop;
    },

    onShow() {
      //轮播图
      var _this = this;
      var url = 'http://localhost:3001/'
      axios.get("/api/shop/shopSwiper").then(function (res) {
        let arr = res.data
        if (Array.isArray(arr)) {
          arr.forEach(item => {
            item.imgPath = `${url}${item.imgPath}`
          })
          _this.list = arr
        }
      });
    },
    destroyed() {
      clearInterval(this.startInterval)
      clearInterval(this.onlineInterval)
    },
    methods: {
      // 调用子组件方法
      createData() {
        this.$refs.child.getshopWaterpullOne();
      },
      start() {
        // 关闭初始定时器
        clearInterval(this.startInterval)
        // 调用子组件方法
        this.createData()
      },
      change(index) {
        this.current = index;
        if (index == 0) {
          this.$refs.child.getshopWaterpullOne();
        }
        if (index == 1) {
          this.$refs.child.getshopWaterpullTwo();
        }
        if (index == 2) {
          this.$refs.child.getshopWaterpullThree();
        }
      }
    },
    mounted() {
      // 定时访问子组件方法
      this.onlineInterval = setInterval(this.createData, 15000)
      // 开启初始定时器
      this.startInterval = setInterval(this.start, 100)
    }
  };
</script>

<style>
  /* page不能写带scope的style标签中，否则无效 */
  page {
    background-color: rgb(240, 240, 240);
  }
</style>

<style lang="scss" scoped>
  .title {
    font-size: medium;
    font-weight: bolder;
  }
</style>