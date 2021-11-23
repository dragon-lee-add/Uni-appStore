/*
 Navicat Premium Data Transfer

 Source Server         : itcast
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : localhost:3306
 Source Schema         : uniappshop

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 23/11/2021 09:34:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carousel
-- ----------------------------
DROP TABLE IF EXISTS `carousel`;
CREATE TABLE `carousel`  (
  `carousel_id` int(11) NOT NULL AUTO_INCREMENT,
  `imgPath` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `describes` char(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`carousel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carousel
-- ----------------------------
INSERT INTO `carousel` VALUES (1, 'static/imgs/cms_1.jpg', '小米手机');
INSERT INTO `carousel` VALUES (2, 'static/imgs/cms_2.jpg', '小米手机');
INSERT INTO `carousel` VALUES (4, 'static/imgs/cms_4.jpg', '小米手机');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '手机');
INSERT INTO `category` VALUES (2, '电视机');
INSERT INTO `category` VALUES (3, '空调');
INSERT INTO `category` VALUES (4, '洗衣机');
INSERT INTO `category` VALUES (5, '保护套');
INSERT INTO `category` VALUES (6, '保护膜');
INSERT INTO `category` VALUES (7, '充电器');
INSERT INTO `category` VALUES (8, '充电宝');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `product_num` int(11) NOT NULL,
  `product_price` double NOT NULL,
  `order_time` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_order_user_id`(`user_id`) USING BTREE,
  INDEX `FK_order_id`(`product_id`) USING BTREE,
  CONSTRAINT `FK_order_id` FOREIGN KEY (`product_id`) REFERENCES `shop` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_title` char(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_intro` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_picture` char(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` double NOT NULL,
  `product_selling_price` double NOT NULL,
  `product_num` int(11) NOT NULL,
  `product_sales` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_product_category`(`category_id`) USING BTREE,
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES (1, 'Redmi K30', 1, '120Hz流速屏，全速热爱', '120Hz高帧率流速屏/ 索尼6400万前后六摄 / 6.67\'小孔径全面屏 / 最高可选8GB+256GB大存储 / 高通骁龙730G处理器 / 3D四曲面玻璃机身 / 4500mAh+27W快充 / 多功能NFC', 'static/imgs/phone/Redmi-k30.png', 2000, 1599, 10, 0);
INSERT INTO `shop` VALUES (2, 'Redmi K30 5G', 1, '双模5G,120Hz流速屏', '双模5G / 三路并发 / 高通骁龙765G / 7nm 5G低功耗处理器 / 120Hz高帧率流速屏 / 6.67\'小孔径全面屏 / 索尼6400万前后六摄 / 最高可选8GB+256GB大存储 / 4500mAh+30W快充 / 3D四曲面玻璃机身 / 多功能NFC', 'static/imgs/phone/Redmi-k30-5G.png', 2599, 2599, 10, 0);
INSERT INTO `shop` VALUES (3, '小米CC9 Pro', 1, '1亿像素,五摄四闪', '1亿像素主摄 / 全场景五摄像头 / 四闪光灯 / 3200万自拍 / 10 倍混合光学变焦，50倍数字变焦 / 5260mAh ⼤电量 / 标配 30W疾速快充 / ⼩米⾸款超薄屏下指纹 / 德国莱茵低蓝光认证 / 多功能NFC / 红外万能遥控 / 1216超线性扬声器', 'static/imgs/phone/Mi-CC9.png', 2799, 2599, 20, 0);
INSERT INTO `shop` VALUES (4, 'Redmi 8', 1, '5000mAh超长续航', '5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB', 'static/imgs/phone/Redmi-8.png', 799, 699, 20, 0);
INSERT INTO `shop` VALUES (5, 'Redmi 8A', 1, '5000mAh超长续航', '5000mAh超长续航 / 高通骁龙439八核处理器 / 4GB+64GB / 1200万AI后置相机', 'static/imgs/phone/Redmi-8A.png', 599, 699, 20, 0);
INSERT INTO `shop` VALUES (6, 'Redmi Note8 Pro', 1, '6400万全场景四摄', '6400万四摄小金刚拍照新旗舰超强解析力，超震撼', 'static/imgs/phone/Redmi-Note8-pro.png', 1399, 1199, 20, 0);
INSERT INTO `shop` VALUES (7, 'Redmi Note8', 1, '千元4800万四摄', '千元4800万四摄 | 高通骁龙665 | 小金刚品质保证', 'static/imgs/phone/Redmi-Note8.png', 999, 999, 20, 0);
INSERT INTO `shop` VALUES (8, 'Redmi 7A', 1, '小巧大电量 持久流畅', '小巧大电量，持久又流畅骁龙8核高性能处理器 | 4000mAh超长续航 | AI人脸解锁 | 整机防泼溅', 'static/imgs/phone/Redmi-7A.png', 599, 539, 20, 0);
INSERT INTO `shop` VALUES (9, '小米电视4A 32英寸', 2, '人工智能系统，高清液晶屏', '小米电视4A 32英寸 | 64位四核处理器 | 1GB+4GB大内存 | 人工智能系统', 'static/imgs/appliance/MiTv-4A-32.png', 799, 799, 10, 0);
INSERT INTO `shop` VALUES (10, '小米全面屏电视E55A', 2, '全面屏设计，人工智能语音', '全面屏设计 | 内置小爱同学 | 4K + HDR | 杜比DTS | PatchWall | 海量内容 | 2GB + 8GB大存储 | 64位四核处理器', 'static/imgs/appliance/MiTv-E55A.png', 2099, 1899, 10, 0);
INSERT INTO `shop` VALUES (11, '小米全面屏电视E65A', 2, '全面屏设计，人工智能语音', '人工智能语音系统 | 海量影视内容 | 4K 超高清屏 | 杜比音效 | 64位四核处理器 | 2GB + 8GB大存储', 'static/imgs/appliance/MiTv-E65A.png', 3999, 2799, 10, 0);
INSERT INTO `shop` VALUES (12, '小米电视4X 43英寸', 2, 'FHD全高清屏，人工智能语音', '人工智能语音系统 | FHD全高清屏 | 64位四核处理器 | 海量片源 | 1GB+8GB大内存 | 钢琴烤漆', 'static/imgs/appliance/MiTv-4X-43.png', 1499, 1299, 10, 0);
INSERT INTO `shop` VALUES (13, '小米电视4C 55英寸', 2, '4K HDR，人工智能系统', '人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆', 'static/imgs/appliance/MiTv-4C-55.png', 1999, 1799, 10, 0);
INSERT INTO `shop` VALUES (14, '小米电视4A 65英寸', 2, '4K HDR，人工智能系统', '人工智能 | 大内存 | 杜比音效 | 超窄边 | 4K HDR | 海量片源 | 纤薄机身| 钢琴烤漆', 'static/imgs/appliance/MiTv-4A-65.png', 2999, 2799, 10, 0);
INSERT INTO `shop` VALUES (15, '小米壁画电视 65英寸', 2, '壁画外观，全面屏，远场语音', '纯平背板 | 通体13.9mm | 远场语音 | 4K+HDR | 杜比+DTS | 画框模式 | 内置小爱同学 | PatchWall | SoundBar+低音炮 | 四核处理器+大存储', 'static/imgs/appliance/MiTv-ArtTv-65.png', 6999, 6999, 10, 0);
INSERT INTO `shop` VALUES (16, '米家互联网空调C1（一级能效）', 3, '变频节能省电，自清洁', '一级能效 | 1.5匹 | 全直流变频 | 高效制冷/热 | 静音设计 | 自清洁 | 全屋互联', 'static/imgs/appliance/AirCondition-V1C1.png', 2699, 2599, 20, 10);
INSERT INTO `shop` VALUES (17, '米家空调', 3, '出众静音，快速制冷热', '大1匹 | 三级能效 | 静音 | 快速制冷热 | 广角送风 | 除湿功能 | 高密度过滤网 | 典雅外观', 'static/imgs/appliance/AirCondition-F3W1.png', 1799, 1699, 20, 8);
INSERT INTO `shop` VALUES (18, '米家互联网洗烘一体机 Pro 10kg', 4, '智能洗烘，省心省力', '国标双A+级洗烘能力 / 22种洗烘模式 / 智能投放洗涤剂 / 支持小爱同学语音遥控 / 支持OTA在线智能升级 / 智能空气洗 / 除菌率达99.9%+', 'static/imgs/appliance/Washer-Pro-10.png', 2999, 2999, 20, 7);
INSERT INTO `shop` VALUES (19, 'Redmi K20/ K20 Pro 怪力魔王保护壳', 5, '怪力魔王专属定制', '优选PC材料，强韧张力，经久耐用 / 精选开孔，全面贴合机身 / 手感轻薄细腻，舒适无负担 / 三款颜色可选，彰显个性，与众不同', 'static/imgs/accessory/protectingShell-RedMi-K20&pro.png', 39, 39, 20, 10);
INSERT INTO `shop` VALUES (20, '小米9 ARE U OK保护壳', 5, '一个与众不同的保护壳', '彰显独特个性 / 轻薄无负担 / 优选PC材料 / 贴合机身 / 潮流五色', 'static/imgs/accessory/protectingShell-Mi-9.png', 49, 39, 20, 10);
INSERT INTO `shop` VALUES (21, '小米CC9&小米CC9美图定制版 标准高透贴膜', 6, '高清透亮，耐磨性强', '耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感', 'static/imgs/accessory/protectingMen-Mi-CC9.png', 19, 19, 20, 9);
INSERT INTO `shop` VALUES (22, '小米CC9e 标准高透贴膜', 6, '高清透亮，耐磨性强', '耐磨性强，防护更出众 / 疏油疏水，有效抗水抗脏污 / 高清透亮，保留了原生屏幕的亮丽颜色和清晰度 / 操作灵敏，智能吸附 / 进口高端PET材质，裸机般手感', 'static/imgs/accessory/protectingMen-Mi-CC9e.png', 19, 19, 20, 9);
INSERT INTO `shop` VALUES (23, '小米USB充电器30W快充版（1A1C）', 7, '多一种接口，多一种选择', '双口输出 / 30W 输出 / 可折叠插脚 / 小巧便携', 'static/imgs/accessory/charger-30w.png', 59, 59, 20, 8);
INSERT INTO `shop` VALUES (24, '小米USB充电器快充版（18W）', 7, '安卓、苹果设备均可使用', '支持QC3.0设备充电 / 支持iOS设备充电/ 美观耐用', 'static/imgs/accessory/charger-18w.png', 29, 29, 20, 8);
INSERT INTO `shop` VALUES (25, '小米USB充电器60W快充版（6口）', 7, '6口输出，USB-C输出接口', '6口输出 / USB-C输出接口 / 支持QC3.0快充协议 / 总输出功率60W', 'static/imgs/accessory/charger-60w.png', 129, 129, 20, 0);
INSERT INTO `shop` VALUES (26, '小米USB充电器36W快充版（2口）', 7, '6多重安全保护，小巧便携', '双USB输出接口 / 支持QC3.0快充协议 / 多重安全保护 / 小巧便携', 'static/imgs/accessory/charger-36w.png', 59, 59, 20, 0);
INSERT INTO `shop` VALUES (27, '小米车载充电器快充版', 7, '让爱车成为移动充电站', 'QC3.0 双口输出 / 智能温度控制 / 5重安全保护 / 兼容iOS&Android设备', 'static/imgs/accessory/charger-car.png', 69, 69, 20, 0);
INSERT INTO `shop` VALUES (28, '小米车载充电器快充版(37W)', 7, '双口快充，车载充电更安全', '单口27W 快充 / 双口输出 / 多重安全保护', 'static/imgs/accessory/charger-car-37w.png', 49, 49, 20, 0);
INSERT INTO `shop` VALUES (29, '小米二合一移动电源（充电器）', 7, '一个设备多种用途', '5000mAh充沛电量 / 多协议快充 / USB 口输出', 'static/imgs/accessory/charger-tio.png', 99, 99, 20, 0);
INSERT INTO `shop` VALUES (30, '小米无线充电宝青春版10000mAh', 8, '能量满满，无线有线都能充', '10000mAh大容量 / 支持边充边放 / 有线无线都能充 / 双向快充', 'static/imgs/accessory/charger-10000mAh.png', 129, 129, 20, 8);
INSERT INTO `shop` VALUES (31, '小米CC9 Pro/尊享版 撞色飘带保护壳', 5, '全面贴合，无感更舒适', '优选环保PC材质，强韧张力，全面贴合，无感更舒适', 'static/imgs/accessory/protectingShell-Mi-CC9Pro.png', 69, 69, 20, 0);
INSERT INTO `shop` VALUES (32, 'Redmi K20系列 幻境之心保护壳', 5, '柔软坚韧,全面贴合', '优质环保材质，柔软坚韧 / 全面贴合，有效抵抗灰尘 / 鲜亮三种颜色可选，为爱机随时换装', 'static/imgs/accessory/protectingShell-RedMi-K20.png', 39, 39, 20, 0);
INSERT INTO `shop` VALUES (33, '小米9 SE 街头风保护壳黑色', 5, '个性时尚,细节出众', '个性时尚 / 细节出众 / 纤薄轻巧 / 多彩时尚', 'static/imgs/accessory/protectingShell-Mi-9SE.png', 49, 49, 20, 0);
INSERT INTO `shop` VALUES (34, '小米9 街头风保护壳 红色', 5, '个性时尚,细节出众', '时尚多彩 / 细节出众 / 纤薄轻巧 / 是腕带也是支架', 'static/imgs/accessory/protectingShell-Mi-9-red.png', 49, 49, 20, 0);
INSERT INTO `shop` VALUES (35, '小米MIX 3 极简保护壳蓝色', 5, '时尚简约设计，手感细腻顺滑', '时尚简约设计，手感细腻顺滑 / 优质环保PC原材料，强韧张力，经久耐用 / 超薄 0.8MM厚度', 'static/imgs/accessory/protectingShell-Mix-3.png', 49, 12.9, 20, 0);

-- ----------------------------
-- Table structure for shoppingcart
-- ----------------------------
DROP TABLE IF EXISTS `shoppingcart`;
CREATE TABLE `shoppingcart`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` int(11) NULL DEFAULT NULL,
  `product_id` int(11) NULL DEFAULT NULL,
  `num` int(11) NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `userName` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_user_id`(`price`) USING BTREE,
  INDEX `FK_shoppingCart_id`(`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shoppingcart
-- ----------------------------
INSERT INTO `shoppingcart` VALUES (29, 'Redmi K30 5G', 2599, 2, 1, 'http://localhost:3001/static/imgs/phone/Redmi-k30-5G.png', 'admin');
INSERT INTO `shoppingcart` VALUES (30, '小米电视4A 32英寸', 799, 9, 1, 'http://localhost:3001/static/imgs/appliance/MiTv-4A-32.png', 'guest');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `passWord` char(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPhoneNumber` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `userName`(`userName`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', '15273124437');
INSERT INTO `users` VALUES (9, 'guest', '123456', NULL);

SET FOREIGN_KEY_CHECKS = 1;
