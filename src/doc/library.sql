/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : 39.107.253.236:3306
 Source Schema         : library

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 10/04/2019 14:19:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book_book
-- ----------------------------
DROP TABLE IF EXISTS `book_book`;
CREATE TABLE `book_book`  (
  `book_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `book_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书名称',
  `book_type_id` bigint(11) NULL DEFAULT NULL COMMENT '分类id',
  `book_author` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `book_pub` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出版社',
  `book_pub_time` datetime(0) NULL DEFAULT NULL COMMENT '出版时间',
  `book_record` datetime(0) NULL DEFAULT NULL COMMENT '登记日期',
  `book_num` int(11) NULL DEFAULT NULL COMMENT '数量',
  `book_left_num` int(11) NULL DEFAULT NULL COMMENT '在馆数量',
  `book_state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书状态',
  `book_language` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书语言',
  `book_introduction` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图书d简介',
  `book_price` decimal(10, 0) NULL DEFAULT NULL COMMENT '图书价格',
  `ISBN` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ISBN',
  `book_img` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片',
  `create_date_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book_borrow
-- ----------------------------
DROP TABLE IF EXISTS `book_borrow`;
CREATE TABLE `book_borrow`  (
  `borrow_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(11) NULL DEFAULT NULL COMMENT '用户id',
  `book_id` bigint(11) NULL DEFAULT NULL COMMENT '图书id',
  `borrow_time` datetime(0) NULL DEFAULT NULL COMMENT '借书时间',
  `return_time` datetime(0) NULL DEFAULT NULL COMMENT '还书时间',
  `act_return_time` datetime(0) NULL DEFAULT NULL COMMENT '实际还书时间',
  `is_return` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '是否归还',
  `create_date_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `operator_id` bigint(11) NULL DEFAULT NULL COMMENT '操作者',
  PRIMARY KEY (`borrow_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book_info
-- ----------------------------
DROP TABLE IF EXISTS `book_info`;
CREATE TABLE `book_info`  (
  `book_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `publish` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ISBN` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `language` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `pubdate` date NULL DEFAULT NULL,
  `class_id` int(11) NULL DEFAULT NULL,
  `pressmark` int(11) NULL DEFAULT NULL,
  `state` smallint(6) NULL DEFAULT NULL,
  PRIMARY KEY (`book_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50000012 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book_type
-- ----------------------------
DROP TABLE IF EXISTS `book_type`;
CREATE TABLE `book_type`  (
  `book_type_id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `book_type_parent_id` bigint(11) NULL DEFAULT NULL COMMENT '父级id',
  `book_type_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `create_date_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `level_code` bigint(2) NULL DEFAULT NULL COMMENT '分类等级',
  PRIMARY KEY (`book_type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for book_user
-- ----------------------------
DROP TABLE IF EXISTS `book_user`;
CREATE TABLE `book_user`  (
  `userId` bigint(11) NOT NULL AUTO_INCREMENT COMMENT 'Id',
  `user_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户账号',
  `user_name` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `gender` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `telephone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地址',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `recommendDateTime` datetime(0) NULL DEFAULT NULL COMMENT '被推荐时间',
  `recommendUserId` bigint(11) NULL DEFAULT NULL COMMENT '推荐人Id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `user_password` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `login_time` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `qq_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'qq号',
  `webchat_account` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信号',
  `memo` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `user_type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户类型',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `point` bigint(38) NULL DEFAULT NULL COMMENT '积分',
  `is_valid` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否有效',
  `mother_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '母亲姓名',
  `father_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父亲姓名',
  `school` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学校',
  `class_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班级',
  `mother_telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '母亲电话',
  `father_telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '父亲电话',
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
