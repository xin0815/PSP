/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1
Source Server Version : 50067
Source Host           : localhost:3306
Source Database       : ssg_base

Target Server Type    : MYSQL
Target Server Version : 50067
File Encoding         : 65001

Date: 2016-09-03 22:06:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `basic_academyinfo`
-- ----------------------------
DROP TABLE IF EXISTS `basic_academyinfo`;
CREATE TABLE `basic_academyinfo` (
  `AAcademyCode` int(11) NOT NULL COMMENT '编码',
  `AName` varchar(64) default NULL COMMENT '名称',
  PRIMARY KEY  (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学院表';

-- ----------------------------
-- Records of basic_academyinfo
-- ----------------------------
INSERT INTO `basic_academyinfo` VALUES ('101', '教育科学学院');
INSERT INTO `basic_academyinfo` VALUES ('102', '蒙古学学院');
INSERT INTO `basic_academyinfo` VALUES ('103', '文学院');
INSERT INTO `basic_academyinfo` VALUES ('104', '外国语学院');
INSERT INTO `basic_academyinfo` VALUES ('105', '国际交流学院');
INSERT INTO `basic_academyinfo` VALUES ('106', '历史文化学院');
INSERT INTO `basic_academyinfo` VALUES ('107', '旅游学院');
INSERT INTO `basic_academyinfo` VALUES ('108', '法政学院');
INSERT INTO `basic_academyinfo` VALUES ('109', '经济学院');
INSERT INTO `basic_academyinfo` VALUES ('110', '音乐学院');
INSERT INTO `basic_academyinfo` VALUES ('111', '体育学院');
INSERT INTO `basic_academyinfo` VALUES ('112', '美术学院');
INSERT INTO `basic_academyinfo` VALUES ('113', '国际现代设计艺术学院');
INSERT INTO `basic_academyinfo` VALUES ('114', '雕塑艺术研究院');
INSERT INTO `basic_academyinfo` VALUES ('115', '数学科学学院');
INSERT INTO `basic_academyinfo` VALUES ('116', '物理与电子信息学院');
INSERT INTO `basic_academyinfo` VALUES ('117', '化学与环境科学学院');
INSERT INTO `basic_academyinfo` VALUES ('118', '生命科学与技术学院');
INSERT INTO `basic_academyinfo` VALUES ('119', '地理科学学院');
INSERT INTO `basic_academyinfo` VALUES ('120', '传媒学院');
INSERT INTO `basic_academyinfo` VALUES ('121', '计算机与信息工程学院');
INSERT INTO `basic_academyinfo` VALUES ('122', '田家炳教育书院');
INSERT INTO `basic_academyinfo` VALUES ('123', '社会学民俗学学院');
INSERT INTO `basic_academyinfo` VALUES ('124', '科学技术史研究院');
INSERT INTO `basic_academyinfo` VALUES ('125', '马克思主义学院');
INSERT INTO `basic_academyinfo` VALUES ('126', '基础教育学院');
INSERT INTO `basic_academyinfo` VALUES ('127', '公共管理学院');
INSERT INTO `basic_academyinfo` VALUES ('128', '继续教育学院');
INSERT INTO `basic_academyinfo` VALUES ('129', '青年政治学院');
INSERT INTO `basic_academyinfo` VALUES ('130', '人民武装学院');
INSERT INTO `basic_academyinfo` VALUES ('131', '鸿德学院');
INSERT INTO `basic_academyinfo` VALUES ('132', '公共外语教育学院');
INSERT INTO `basic_academyinfo` VALUES ('135', '网络技术学院');
INSERT INTO `basic_academyinfo` VALUES ('136', '民族艺术学院');
INSERT INTO `basic_academyinfo` VALUES ('137', '二连国际学院');
INSERT INTO `basic_academyinfo` VALUES ('138', '餐饮管理学院');
INSERT INTO `basic_academyinfo` VALUES ('156', '学生处');

-- ----------------------------
-- Table structure for `basic_class`
-- ----------------------------
DROP TABLE IF EXISTS `basic_class`;
CREATE TABLE `basic_class` (
  `CID` int(11) NOT NULL auto_increment,
  `CClassCode` varchar(20) NOT NULL COMMENT '班级编码',
  `AcademyCode` int(11) default NULL COMMENT '学院编码',
  `CClassName` varchar(32) default NULL COMMENT '班级名称',
  `CGrade` varchar(4) default NULL COMMENT '年级',
  `CMajor` varchar(32) default NULL COMMENT '专业',
  `CLanguage` varchar(10) default NULL COMMENT '语种',
  `CLevel` varchar(10) default NULL COMMENT '培养层次',
  `CisTeacher` tinyint(1) default NULL COMMENT '是否师范生',
  `CurrTeacherId` int(11) default NULL COMMENT '当前学期的班主任',
  `isDeleted` tinyint(1) default '0' COMMENT '删除标志',
  PRIMARY KEY  (`CID`),
  KEY `FKE2448627384218C` (`AcademyCode`),
  KEY `FKE2448627DF3F3806` (`CurrTeacherId`),
  CONSTRAINT `FKE2448627384218C` FOREIGN KEY (`AcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`),
  CONSTRAINT `FKE2448627DF3F3806` FOREIGN KEY (`CurrTeacherId`) REFERENCES `basic_teacher` (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班级表';

-- ----------------------------
-- Records of basic_class
-- ----------------------------

-- ----------------------------
-- Table structure for `basic_classinfo`
-- ----------------------------
DROP TABLE IF EXISTS `basic_classinfo`;
CREATE TABLE `basic_classinfo` (
  `BCID` int(11) NOT NULL auto_increment,
  `CClassId` int(11) default NULL COMMENT '班级Id',
  `BSCode` varchar(20) default NULL COMMENT '学年学期',
  `BTeacherId` int(11) default NULL COMMENT '教师Id',
  `BCStuMonitor` varchar(32) default NULL COMMENT '班长',
  `BCStuLeaner` varchar(32) default NULL COMMENT '学习委员',
  `BCStuSecretary` varchar(32) default NULL COMMENT '团支书',
  `BCStuOrganizer` varchar(32) default NULL COMMENT '组织委员',
  `BCStuSport` varchar(32) default NULL COMMENT '体育委员',
  `BCStuPropagandist` varchar(32) default NULL COMMENT '宣传委员',
  `BCStuLive` varchar(32) default NULL COMMENT '生活委员',
  `BCDate` varchar(19) default NULL COMMENT '录入日期',
  PRIMARY KEY  (`BCID`),
  KEY `FK82E87F55ED63C021` (`CClassId`),
  KEY `FK82E87F558BF473D6` (`BTeacherId`),
  KEY `FK82E87F55866369AB` (`BSCode`),
  CONSTRAINT `FK82E87F55866369AB` FOREIGN KEY (`BSCode`) REFERENCES `basic_semesterinfo` (`BSCode`),
  CONSTRAINT `FK82E87F558BF473D6` FOREIGN KEY (`BTeacherId`) REFERENCES `basic_teacher` (`TID`),
  CONSTRAINT `FK82E87F55ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班级信息表';

-- ----------------------------
-- Records of basic_classinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `basic_schoolyear`
-- ----------------------------
DROP TABLE IF EXISTS `basic_schoolyear`;
CREATE TABLE `basic_schoolyear` (
  `syid` int(11) NOT NULL auto_increment,
  `SYname` varchar(32) default NULL COMMENT '学年名称',
  PRIMARY KEY  (`syid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_schoolyear
-- ----------------------------
INSERT INTO `basic_schoolyear` VALUES ('1', '2015~2016学年');
INSERT INTO `basic_schoolyear` VALUES ('2', '2016~2017学年');
INSERT INTO `basic_schoolyear` VALUES ('3', '2017~2018学年');
INSERT INTO `basic_schoolyear` VALUES ('4', '2018~2019学年');
INSERT INTO `basic_schoolyear` VALUES ('5', '2019~2020学年');
INSERT INTO `basic_schoolyear` VALUES ('6', '2020~2021学年');
INSERT INTO `basic_schoolyear` VALUES ('7', '2021~2022学年');
INSERT INTO `basic_schoolyear` VALUES ('8', '2022~2023学年');
INSERT INTO `basic_schoolyear` VALUES ('9', '2023~2024学年');
INSERT INTO `basic_schoolyear` VALUES ('10', '2024~2025学年');
INSERT INTO `basic_schoolyear` VALUES ('11', '2025~2026学年');
INSERT INTO `basic_schoolyear` VALUES ('12', '2026~2027学年');
INSERT INTO `basic_schoolyear` VALUES ('13', '2027~2028学年');
INSERT INTO `basic_schoolyear` VALUES ('14', '2028~2029学年');
INSERT INTO `basic_schoolyear` VALUES ('15', '2029~2030学年');
INSERT INTO `basic_schoolyear` VALUES ('16', '2030~2031学年');
INSERT INTO `basic_schoolyear` VALUES ('17', '2031~2032学年');
INSERT INTO `basic_schoolyear` VALUES ('18', '2032~2033学年');
INSERT INTO `basic_schoolyear` VALUES ('19', '2033~2034学年');
INSERT INTO `basic_schoolyear` VALUES ('20', '2034~2035学年');

-- ----------------------------
-- Table structure for `basic_semesterinfo`
-- ----------------------------
DROP TABLE IF EXISTS `basic_semesterinfo`;
CREATE TABLE `basic_semesterinfo` (
  `BSCode` varchar(20) NOT NULL COMMENT '编码',
  `SYid` int(11) default NULL COMMENT '学年id',
  `BSemerter` int(2) default NULL COMMENT '学期',
  `BName` varchar(32) default NULL COMMENT '名称',
  `beginTime` varchar(19) default NULL COMMENT '学期开始时间',
  `endTime` varchar(19) default NULL COMMENT '学期结束时间',
  PRIMARY KEY  (`BSCode`),
  KEY `FKE5B76A57ABDB9399` (`SYid`),
  CONSTRAINT `FKE5B76A57ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学年学期';

-- ----------------------------
-- Records of basic_semesterinfo
-- ----------------------------
INSERT INTO `basic_semesterinfo` VALUES ('2015201601', '1', '1', '2015~2016第一学期', '2015-08-15 00:00:00', '2016-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2015201602', '1', '2', '2015~2016第二学期', '2016-02-15 00:00:00', '2016-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2016201701', '2', '1', '2016~2017第一学期', '2016-08-15 00:00:00', '2017-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2016201702', '2', '2', '2016~2017第二学期', '2017-02-15 00:00:00', '2017-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2017201801', '3', '1', '2017~2018第一学期', '2017-08-15 00:00:00', '2018-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2017201802', '3', '2', '2017~2018第二学期', '2018-02-15 00:00:00', '2018-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2018201901', '4', '1', '2018~2019第一学期', '2018-08-15 00:00:00', '2019-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2018201902', '4', '2', '2018~2019第二学期', '2019-02-15 00:00:00', '2019-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2019202001', '5', '1', '2019~2020第一学期', '2019-08-15 00:00:00', '2020-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2019202002', '5', '2', '2019~2020第二学期', '2020-02-15 00:00:00', '2020-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2020202101', '6', '1', '2020~2021第一学期', '2020-08-15 00:00:00', '2021-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2020202102', '6', '2', '2020~2021第二学期', '2021-02-15 00:00:00', '2021-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2021202201', '7', '1', '2021~2022第一学期', '2021-08-15 00:00:00', '2022-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2021202202', '7', '2', '2021~2022第二学期', '2022-02-15 00:00:00', '2022-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2022202301', '8', '1', '2022~2023第一学期', '2022-08-15 00:00:00', '2023-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2022202302', '8', '2', '2022~2023第二学期', '2023-02-15 00:00:00', '2023-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2023202401', '9', '1', '2023~2024第一学期', '2023-08-15 00:00:00', '2024-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2023202402', '9', '2', '2023~2024第二学期', '2024-02-15 00:00:00', '2024-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2024202501', '10', '1', '2024~2025第一学期', '2024-08-15 00:00:00', '2025-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2024202502', '10', '2', '2024~2025第二学期', '2025-02-15 00:00:00', '2025-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2025202601', '11', '1', '2025~2026第一学期', '2025-08-15 00:00:00', '2026-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2025202602', '11', '2', '2025~2026第二学期', '2026-02-15 00:00:00', '2026-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2026202701', '12', '1', '2026~2027第一学期', '2026-08-15 00:00:00', '2027-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2026202702', '12', '2', '2026~2027第二学期', '2027-02-15 00:00:00', '2027-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2027202801', '13', '1', '2027~2028第一学期', '2027-08-15 00:00:00', '2028-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2027202802', '13', '2', '2027~2028第二学期', '2028-02-15 00:00:00', '2028-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2028202901', '14', '1', '2028~2029第一学期', '2028-08-15 00:00:00', '2029-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2028202902', '14', '2', '2028~2029第二学期', '2029-02-15 00:00:00', '2029-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2029203001', '15', '1', '2029~2030第一学期', '2029-08-15 00:00:00', '2030-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2029203002', '15', '2', '2029~2030第二学期', '2030-02-15 00:00:00', '2030-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2030203101', '16', '1', '2030~2031第一学期', '2030-08-15 00:00:00', '2031-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2030203102', '16', '2', '2030~2031第二学期', '2031-02-15 00:00:00', '2031-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2031203201', '17', '1', '2031~2032第一学期', '2031-08-15 00:00:00', '2032-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2031203202', '17', '2', '2031~2032第二学期', '2032-02-15 00:00:00', '2032-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2032203301', '18', '1', '2032~2033第一学期', '2032-08-15 00:00:00', '2033-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2032203302', '18', '2', '2032~2033第二学期', '2033-02-15 00:00:00', '2033-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2033203401', '19', '1', '2033~2034第一学期', '2033-08-15 00:00:00', '2034-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2033203402', '19', '2', '2033~2034第二学期', '2034-02-15 00:00:00', '2034-08-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2034203501', '20', '1', '2034~2035第一学期', '2034-08-15 00:00:00', '2035-02-15 00:00:00');
INSERT INTO `basic_semesterinfo` VALUES ('2034203502', '20', '2', '2034~2035第二学期', '2035-02-15 00:00:00', '2035-08-15 00:00:00');

-- ----------------------------
-- Table structure for `basic_studentinfo`
-- ----------------------------
DROP TABLE IF EXISTS `basic_studentinfo`;
CREATE TABLE `basic_studentinfo` (
  `SStudentCode` varchar(20) NOT NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `SOldName` varchar(32) default NULL COMMENT '曾用名',
  `SName` varchar(32) default NULL COMMENT '姓名',
  `SBirthDate` varchar(19) default NULL COMMENT '生日',
  `SSex` varchar(4) default NULL COMMENT '性别',
  `SPolitical` varchar(10) default NULL COMMENT '政治面貌',
  `SDormNum` varchar(20) default NULL COMMENT '宿舍号码',
  `SPhoneNum` varchar(20) default NULL COMMENT '电话号码',
  `SPostcode` varchar(10) default NULL COMMENT '邮编',
  `SOrigin` varchar(20) default NULL COMMENT '籍贯',
  `SisOrphan` tinyint(1) default NULL COMMENT '是否孤儿',
  `SisDisable` tinyint(1) default NULL COMMENT '是否残疾',
  `SDisableLevel` varchar(32) default NULL COMMENT '残疾等级',
  `SRelation1` varchar(32) default NULL COMMENT '联系人1',
  `SRelation2` varchar(20) default NULL COMMENT '联系人2',
  `SRelationship1` varchar(10) default NULL COMMENT '关系1',
  `SRelationship2` varchar(10) default NULL COMMENT '关系2',
  `SRelationPhone1` varchar(20) default NULL COMMENT '联系人电话1',
  `SRelationPhone2` varchar(20) default NULL COMMENT '联系人电话2',
  `SHomeAdd` varchar(64) default NULL COMMENT '家庭住址',
  `SOriginHome` varchar(32) default NULL COMMENT '生源地',
  `SOldSchool` varchar(64) default NULL COMMENT '以前的学校',
  `SIdCard` varchar(20) default NULL COMMENT '身份证号码',
  `SFamilyRel1` varchar(10) default NULL COMMENT '家庭关系1',
  `SFamilyRel2` varchar(10) default NULL COMMENT '家庭关系2',
  `SFamilyRel3` varchar(10) default NULL COMMENT '家庭关系3',
  `SFamilyName1` varchar(32) default NULL COMMENT '家庭成员1',
  `SFamilyName2` varchar(32) default NULL COMMENT '家庭成员2',
  `SFamilyName3` varchar(32) default NULL COMMENT '家庭成员3',
  `SFamilyAge1` int(11) default NULL COMMENT '家庭成员年龄1',
  `SFamilyAge2` int(11) default NULL COMMENT '家庭成员年龄2',
  `SFamilyAge3` int(11) default NULL COMMENT '家庭成员年龄3',
  `SFamilyPolitical1` varchar(10) default NULL COMMENT '家庭成员政治面貌1',
  `SFamilyPolitical2` varchar(10) default NULL COMMENT '家庭成员政治面貌2',
  `SFamilyPolitical3` varchar(10) default NULL COMMENT '家庭成员政治面貌3',
  `SFamilyWork1` varchar(32) default NULL COMMENT '家庭成员工作1',
  `SFamilyWork2` varchar(32) default NULL COMMENT '家庭成员工作2',
  `SFamilyWork3` varchar(32) default NULL COMMENT '家庭成员工作3',
  `SFamilyWorkDuty1` varchar(20) default NULL COMMENT '家庭成员职务1',
  `SFamilyWorkDuty2` varchar(20) default NULL COMMENT '家庭成员职务2',
  `SFamilyWorkDuty3` varchar(20) default NULL COMMENT '家庭成员职务3',
  `SResumeDate1` varchar(10) default NULL COMMENT '简历日期1',
  `SOldSchool1` varchar(32) default NULL COMMENT '所在学校1',
  `SResCertifier1` varchar(32) default NULL COMMENT '证明人1',
  `SResumeDate2` varchar(10) default NULL COMMENT '简历日期2',
  `SOldSchool2` varchar(32) default NULL COMMENT '所在学校2',
  `SResCertifier2` varchar(32) default NULL COMMENT '证明人2',
  `SResumeDate3` varchar(10) default NULL COMMENT '简历日期3',
  `SOldSchool3` varchar(32) default NULL COMMENT '所在学校3',
  `SResCertifier3` varchar(32) default NULL COMMENT '证明人3',
  `SResumeDate4` varchar(10) default NULL COMMENT '简历日期4',
  `SOldSchool4` varchar(32) default NULL COMMENT '所在学校4',
  `SResCertifier4` varchar(32) default NULL COMMENT '证明人4',
  `pictureUrl` varchar(64) default NULL COMMENT '学生照片url',
  `SNationId` int(11) default NULL COMMENT '民族',
  `joinDate` varchar(19) default NULL COMMENT '加入时间',
  PRIMARY KEY  (`SStudentCode`),
  KEY `FKFECAAED8ED63C021` (`CClassId`),
  KEY `FKFECAAED8BF27DF98` (`SNationId`),
  CONSTRAINT `FKFECAAED8BF27DF98` FOREIGN KEY (`SNationId`) REFERENCES `c_nation` (`NID`),
  CONSTRAINT `FKFECAAED8ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生信息表';

-- ----------------------------
-- Records of basic_studentinfo
-- ----------------------------

-- ----------------------------
-- Table structure for `basic_teacher`
-- ----------------------------
DROP TABLE IF EXISTS `basic_teacher`;
CREATE TABLE `basic_teacher` (
  `TID` int(11) NOT NULL auto_increment,
  `BTeacherId` int(11) default NULL COMMENT '老师Id',
  `TName` varchar(32) default NULL COMMENT '名称',
  `TDuty` varchar(20) default NULL COMMENT '职务',
  `TProTitle` varchar(20) default NULL COMMENT '职称',
  `TEduBackground` varchar(10) default NULL COMMENT '学历',
  `AAcademyId` int(11) default NULL COMMENT '学院Id',
  `TBirthDay` varchar(10) default NULL COMMENT '生日',
  `TPhone` varchar(20) default NULL COMMENT '电话号码',
  `IsActive` tinyint(1) default NULL COMMENT '是否有效',
  `SysUserId` int(11) default NULL COMMENT '系统用户Id',
  `temail` varchar(32) default NULL COMMENT '电子邮箱',
  `isSchoolTeacher` bit(1) default NULL COMMENT '学校学工',
  `isAcademyTeacher` bit(1) default NULL COMMENT '学院学工',
  `isClassTeacher` bit(1) default NULL COMMENT '班主任',
  PRIMARY KEY  (`TID`),
  KEY `FKDA8C38D1645EA879` (`AAcademyId`),
  CONSTRAINT `FKDA8C38D1645EA879` FOREIGN KEY (`AAcademyId`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of basic_teacher
-- ----------------------------
INSERT INTO `basic_teacher` VALUES ('19', '20050001', '巴图', null, null, null, '156', null, null, '1', '2', null, '', '', '');
INSERT INTO `basic_teacher` VALUES ('21', '20050002', '白舍楞', null, null, null, '156', null, null, '1', '4', null, '', '', '');

-- ----------------------------
-- Table structure for `c_nation`
-- ----------------------------
DROP TABLE IF EXISTS `c_nation`;
CREATE TABLE `c_nation` (
  `NID` int(11) NOT NULL auto_increment,
  `NAME` varchar(40) NOT NULL COMMENT '民族名称',
  PRIMARY KEY  (`NID`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of c_nation
-- ----------------------------
INSERT INTO `c_nation` VALUES ('1', '汉族');
INSERT INTO `c_nation` VALUES ('2', '蒙古族');
INSERT INTO `c_nation` VALUES ('3', '回族');
INSERT INTO `c_nation` VALUES ('4', '藏族');
INSERT INTO `c_nation` VALUES ('5', '维吾尔族');
INSERT INTO `c_nation` VALUES ('6', '苗族');
INSERT INTO `c_nation` VALUES ('7', '彝族');
INSERT INTO `c_nation` VALUES ('8', '壮族');
INSERT INTO `c_nation` VALUES ('9', '布依族');
INSERT INTO `c_nation` VALUES ('10', '朝鲜族');
INSERT INTO `c_nation` VALUES ('11', '满族');
INSERT INTO `c_nation` VALUES ('12', '侗族');
INSERT INTO `c_nation` VALUES ('13', '瑶族');
INSERT INTO `c_nation` VALUES ('14', '白族');
INSERT INTO `c_nation` VALUES ('15', '土家族');
INSERT INTO `c_nation` VALUES ('16', '哈尼族');
INSERT INTO `c_nation` VALUES ('17', '哈萨克族');
INSERT INTO `c_nation` VALUES ('18', '傣族');
INSERT INTO `c_nation` VALUES ('19', '黎族');
INSERT INTO `c_nation` VALUES ('20', '傈僳族');
INSERT INTO `c_nation` VALUES ('21', '佤族');
INSERT INTO `c_nation` VALUES ('22', '畲族');
INSERT INTO `c_nation` VALUES ('23', '高山族');
INSERT INTO `c_nation` VALUES ('24', '拉祜族');
INSERT INTO `c_nation` VALUES ('25', '水族');
INSERT INTO `c_nation` VALUES ('26', '东乡族');
INSERT INTO `c_nation` VALUES ('27', '纳西族');
INSERT INTO `c_nation` VALUES ('28', '景颇族');
INSERT INTO `c_nation` VALUES ('29', '柯尔克孜族');
INSERT INTO `c_nation` VALUES ('30', '土族');
INSERT INTO `c_nation` VALUES ('31', '达斡尔族');
INSERT INTO `c_nation` VALUES ('32', '仫佬族');
INSERT INTO `c_nation` VALUES ('33', '羌族');
INSERT INTO `c_nation` VALUES ('34', '布朗族');
INSERT INTO `c_nation` VALUES ('35', '撒拉族');
INSERT INTO `c_nation` VALUES ('36', '毛南族');
INSERT INTO `c_nation` VALUES ('37', '仡佬族');
INSERT INTO `c_nation` VALUES ('38', '锡伯族');
INSERT INTO `c_nation` VALUES ('39', '阿昌族');
INSERT INTO `c_nation` VALUES ('40', '普米族');
INSERT INTO `c_nation` VALUES ('41', '塔吉克族');
INSERT INTO `c_nation` VALUES ('42', '怒族');
INSERT INTO `c_nation` VALUES ('43', '乌孜别克族');
INSERT INTO `c_nation` VALUES ('44', '俄罗斯族');
INSERT INTO `c_nation` VALUES ('45', '鄂温克族');
INSERT INTO `c_nation` VALUES ('46', '德昂族');
INSERT INTO `c_nation` VALUES ('47', '保安族');
INSERT INTO `c_nation` VALUES ('48', '裕固族');
INSERT INTO `c_nation` VALUES ('49', '京族');
INSERT INTO `c_nation` VALUES ('50', '塔塔尔族');
INSERT INTO `c_nation` VALUES ('51', '独龙族');
INSERT INTO `c_nation` VALUES ('52', '鄂伦春族');
INSERT INTO `c_nation` VALUES ('53', '赫哲族');
INSERT INTO `c_nation` VALUES ('54', '门巴族');
INSERT INTO `c_nation` VALUES ('55', '珞巴族');
INSERT INTO `c_nation` VALUES ('56', '基诺族');
INSERT INTO `c_nation` VALUES ('57', '其他');
INSERT INTO `c_nation` VALUES ('58', '外国血统');

-- ----------------------------
-- Table structure for `discipline_student`
-- ----------------------------
DROP TABLE IF EXISTS `discipline_student`;
CREATE TABLE `discipline_student` (
  `DID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `DCode` varchar(32) default NULL COMMENT '处理文号',
  `DDisDate` varchar(20) default NULL COMMENT '违纪日期',
  `DReason` varchar(256) default NULL COMMENT '原因',
  `DLevel` varchar(20) default NULL COMMENT '等级',
  `DOccurDate` varchar(10) default NULL COMMENT '处分日期',
  `DisCancel` tinyint(1) default NULL COMMENT '是否取消',
  `DCancelDate` varchar(10) default NULL COMMENT '取消日期',
  `DCancelReason` varchar(256) default NULL COMMENT '取消原因',
  `BTeacherId` int(11) default NULL COMMENT '处理人',
  `DCheckDate` varchar(19) default NULL COMMENT '处理日期',
  PRIMARY KEY  (`DID`),
  KEY `FKD42F546C7C9B2D7` (`SStudentCode`),
  CONSTRAINT `FKD42F546C7C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='违纪信息表';

-- ----------------------------
-- Records of discipline_student
-- ----------------------------

-- ----------------------------
-- Table structure for `grant_application`
-- ----------------------------
DROP TABLE IF EXISTS `grant_application`;
CREATE TABLE `grant_application` (
  `GAID` int(11) NOT NULL auto_increment,
  `GID` int(11) NOT NULL COMMENT '国家助学金信息表Id',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `GATCheck` tinyint(1) default NULL COMMENT '班主任审核状态',
  `GATCheckDate` varchar(19) default NULL COMMENT '班主任审核日期',
  `GAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `GAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `GAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `GAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `GAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `GAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `GAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `GADate` varchar(19) default NULL COMMENT '数据备份历史日期',
  `GAHomeResidence` varchar(20) default NULL COMMENT '家庭户口种类',
  `GAHomePopulationTotal` int(11) default NULL COMMENT '家庭人口总数',
  `GAHomeIncomePMTotal` int(11) default NULL COMMENT '家庭月总收入',
  `GAHomeIncomePMPP` int(11) default NULL COMMENT '人均月收入',
  `GAHomeIncomeSource` varchar(64) default NULL COMMENT '家庭收入来源',
  `GAReason` varchar(512) default NULL COMMENT '助学金申请理由',
  `GAGrade` varchar(2) default NULL COMMENT '助学金等级',
  `GAMoney` int(11) default NULL COMMENT '助学金金额',
  `YEAR` varchar(4) default NULL COMMENT '学年',
  `isSubmit` bit(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  `GACard` varchar(32) default NULL COMMENT '银行卡号',
  PRIMARY KEY  (`GAID`),
  KEY `FK4BAC5AADE75FD765` (`GID`),
  KEY `FK4BAC5AADED63C021` (`CClassId`),
  KEY `FK4BAC5AAD7C9B2D7` (`SStudentCode`),
  CONSTRAINT `FK4BAC5AAD7C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK4BAC5AADE75FD765` FOREIGN KEY (`GID`) REFERENCES `grant_info` (`gid`),
  CONSTRAINT `FK4BAC5AADED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='助学金申请';

-- ----------------------------
-- Records of grant_application
-- ----------------------------

-- ----------------------------
-- Table structure for `grant_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `grant_distribution`;
CREATE TABLE `grant_distribution` (
  `GDID` int(11) NOT NULL auto_increment,
  `GID` int(11) default NULL COMMENT '国家助学金信息表id',
  `AAcademyCode` int(11) default NULL COMMENT '学院编码',
  `GDLeve1` int(11) default NULL COMMENT '校内一等助学金',
  `GDLeve2` int(11) default NULL COMMENT '校内二等助学金',
  `GDLeve3` int(11) default NULL COMMENT '校内三等助学金',
  `AcaStudentNum` int(11) default NULL COMMENT '学院学生人数',
  PRIMARY KEY  (`GDID`),
  KEY `FK93CAA4C7E75FD765` (`GID`),
  KEY `FK93CAA4C7EDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FK93CAA4C7E75FD765` FOREIGN KEY (`GID`) REFERENCES `grant_info` (`gid`),
  CONSTRAINT `FK93CAA4C7EDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='助学金指标分配表';

-- ----------------------------
-- Records of grant_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `grant_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `grant_historyrecord`;
CREATE TABLE `grant_historyrecord` (
  `GHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(32) default NULL,
  `YEAR` varchar(4) default NULL,
  `CClassCode` varchar(20) default NULL,
  PRIMARY KEY  (`GHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grant_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `grant_info`
-- ----------------------------
DROP TABLE IF EXISTS `grant_info`;
CREATE TABLE `grant_info` (
  `gid` int(11) NOT NULL auto_increment COMMENT '励志奖学金信息表id',
  `name` varchar(128) NOT NULL COMMENT '励志奖学金名称',
  `SYid` int(11) NOT NULL COMMENT '学年',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`gid`),
  KEY `FK32A3ADF1ABDB9399` (`SYid`),
  CONSTRAINT `FK32A3ADF1ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of grant_info
-- ----------------------------

-- ----------------------------
-- Table structure for `huoshibutie_application`
-- ----------------------------
DROP TABLE IF EXISTS `huoshibutie_application`;
CREATE TABLE `huoshibutie_application` (
  `HAID` int(11) NOT NULL auto_increment,
  `HID` int(11) NOT NULL COMMENT '伙食补贴信息表id',
  `HDTimes` int(11) default NULL COMMENT '发放次',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `HAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `HAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `HAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `HAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `HAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `HAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `HAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `HADate` varchar(19) default NULL COMMENT '数据备份历史日期',
  `YEAR` varchar(4) default NULL COMMENT '学年',
  `isSubmit` bit(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  `HACard` varchar(32) default NULL COMMENT '银行卡号',
  PRIMARY KEY  (`HAID`),
  KEY `FKF5AEF13C95CE01F5` (`HID`),
  KEY `FKF5AEF13CED63C021` (`CClassId`),
  KEY `FKF5AEF13C7C9B2D7` (`SStudentCode`),
  CONSTRAINT `FKF5AEF13C7C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FKF5AEF13C95CE01F5` FOREIGN KEY (`HID`) REFERENCES `huoshibutie_info` (`hid`),
  CONSTRAINT `FKF5AEF13CED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='以班级提交伙食补贴申请';

-- ----------------------------
-- Records of huoshibutie_application
-- ----------------------------

-- ----------------------------
-- Table structure for `huoshibutie_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `huoshibutie_distribution`;
CREATE TABLE `huoshibutie_distribution` (
  `HDID` int(11) NOT NULL auto_increment,
  `HID` int(11) NOT NULL COMMENT '伙食补贴信息表id',
  `AAcademyCode` int(11) default NULL COMMENT '学院编码',
  `HDTimes` int(11) default NULL COMMENT '年度补贴发放次',
  `HDStandard` int(11) default NULL COMMENT '伙食补贴标准',
  `HDNumber` int(11) default NULL COMMENT '发放人数',
  `YEAR` varchar(4) default NULL COMMENT '学年学期',
  `HDPublisher` varchar(32) default NULL COMMENT '发布人',
  `HDPublishDate` varchar(19) default NULL COMMENT '发布日期',
  `HDPublishStatus` bit(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`HDID`),
  KEY `FK2A1AE01895CE01F5` (`HID`),
  KEY `FK2A1AE018EDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FK2A1AE01895CE01F5` FOREIGN KEY (`HID`) REFERENCES `huoshibutie_info` (`hid`),
  CONSTRAINT `FK2A1AE018EDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='临时伙食补贴指标分配表';

-- ----------------------------
-- Records of huoshibutie_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `huoshibutie_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `huoshibutie_historyrecord`;
CREATE TABLE `huoshibutie_historyrecord` (
  `HHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(20) default NULL,
  `YEAR` varchar(4) default NULL,
  `HDTimes` int(11) default NULL COMMENT '补贴年度发放次',
  `CClassCode` varchar(20) default NULL,
  PRIMARY KEY  (`HHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of huoshibutie_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `huoshibutie_info`
-- ----------------------------
DROP TABLE IF EXISTS `huoshibutie_info`;
CREATE TABLE `huoshibutie_info` (
  `hid` int(11) NOT NULL auto_increment COMMENT '伙食补贴信息表id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `SYid` int(4) NOT NULL COMMENT '学年id',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`hid`),
  KEY `FKB828CA42ABDB9399` (`SYid`),
  CONSTRAINT `FKB828CA42ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of huoshibutie_info
-- ----------------------------

-- ----------------------------
-- Table structure for `jianmian_application`
-- ----------------------------
DROP TABLE IF EXISTS `jianmian_application`;
CREATE TABLE `jianmian_application` (
  `JAID` int(11) NOT NULL auto_increment,
  `JID` int(11) NOT NULL COMMENT '减免学费信息表ID',
  `SStudentCode` varchar(32) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `JATCheck` tinyint(1) default NULL COMMENT '班主任审核状态',
  `JATCheckDate` varchar(19) default NULL COMMENT '班主任审核日期',
  `JAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `JAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `JAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `JAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `JAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `JAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `JAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `JADate` varchar(19) default NULL COMMENT '数据备份历史日期',
  `JAGrade` varchar(32) default NULL COMMENT '减免学费等级',
  `JAMoney` int(11) default NULL COMMENT '减免学费金额',
  `YEAR` varchar(4) default NULL COMMENT '学年',
  `isSubmit` bit(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  `JACard` varchar(32) default NULL COMMENT '银行卡号',
  PRIMARY KEY  (`JAID`),
  KEY `FK97298E861F50016F` (`JID`),
  KEY `FK97298E86ED63C021` (`CClassId`),
  KEY `FK97298E867C9B2D7` (`SStudentCode`),
  CONSTRAINT `FK97298E861F50016F` FOREIGN KEY (`JID`) REFERENCES `jianmian_info` (`jid`),
  CONSTRAINT `FK97298E867C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK97298E86ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='减免学费申请';

-- ----------------------------
-- Records of jianmian_application
-- ----------------------------

-- ----------------------------
-- Table structure for `jianmian_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `jianmian_distribution`;
CREATE TABLE `jianmian_distribution` (
  `JDID` int(11) NOT NULL auto_increment,
  `JID` int(11) NOT NULL COMMENT '学年学期',
  `AAcademyCode` int(11) default NULL COMMENT '学院编码',
  `JDLeve1` int(11) default NULL COMMENT '校内一等减免学费',
  `JDLeve2` int(11) default NULL COMMENT '校内二等减免学费',
  `JDLeve3` int(11) default NULL COMMENT '校内三等减免学费',
  `AcaStudentNum` int(11) default NULL COMMENT '学院学生人数',
  PRIMARY KEY  (`JDID`),
  KEY `FKB7F3EC0E1F50016F` (`JID`),
  KEY `FKB7F3EC0EEDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FKB7F3EC0E1F50016F` FOREIGN KEY (`JID`) REFERENCES `jianmian_info` (`jid`),
  CONSTRAINT `FKB7F3EC0EEDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='减免学费指标分配表';

-- ----------------------------
-- Records of jianmian_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `jianmian_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `jianmian_historyrecord`;
CREATE TABLE `jianmian_historyrecord` (
  `JHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(32) default NULL,
  `YEAR` varchar(4) default NULL,
  `CClassCode` varchar(20) default NULL,
  PRIMARY KEY  (`JHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jianmian_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `jianmian_info`
-- ----------------------------
DROP TABLE IF EXISTS `jianmian_info`;
CREATE TABLE `jianmian_info` (
  `jid` int(11) NOT NULL auto_increment COMMENT '减免学费信息表id',
  `name` varchar(128) NOT NULL COMMENT '名称',
  `SYid` int(4) NOT NULL COMMENT '学年',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`jid`),
  KEY `FKD5302C38ABDB9399` (`SYid`),
  CONSTRAINT `FKD5302C38ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of jianmian_info
-- ----------------------------

-- ----------------------------
-- Table structure for `lizhi_application`
-- ----------------------------
DROP TABLE IF EXISTS `lizhi_application`;
CREATE TABLE `lizhi_application` (
  `LAID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(32) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `LATCheck` tinyint(1) default NULL COMMENT '班主任审核状态',
  `LATCheckDate` varchar(19) default NULL COMMENT '班主任审核日期',
  `LAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `LAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `LAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `LAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `LAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `LAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `LAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `LADate` varchar(19) default NULL COMMENT '数据备份历史课日期',
  `LAOldReward` varchar(512) default NULL COMMENT '曾获何种奖励',
  `LAHomeResidence` varchar(20) default NULL COMMENT '家庭户口种类',
  `LAHomePopulationTotal` int(11) default NULL COMMENT '家庭人口总数',
  `LAHomeIncomePMTotal` int(11) default NULL COMMENT '家庭月总收入',
  `LAHomeIncomePMPP` int(11) default NULL COMMENT '人均月收入',
  `LAHomeIncomeSource` varchar(32) default NULL COMMENT '家庭收入来源',
  `LAReason` varchar(512) default NULL COMMENT '励志申请理由',
  `LAMoney` int(11) default NULL COMMENT '金额',
  `LID` int(11) default NULL COMMENT '励志奖学金信息表',
  `YEAR` varchar(4) default NULL COMMENT '学年',
  `isSubmit` bit(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  `LACard` varchar(32) default NULL COMMENT '银行卡号',
  PRIMARY KEY  (`LAID`),
  KEY `FK2C7642EFED63C021` (`CClassId`),
  KEY `FK2C7642EF7C9B2D7` (`SStudentCode`),
  KEY `FK2C7642EF456F346C` (`LID`),
  CONSTRAINT `FK2C7642EF456F346C` FOREIGN KEY (`LID`) REFERENCES `lizhi_info` (`LID`),
  CONSTRAINT `FK2C7642EF7C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK2C7642EFED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='励志奖学金申请';

-- ----------------------------
-- Records of lizhi_application
-- ----------------------------

-- ----------------------------
-- Table structure for `lizhi_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `lizhi_distribution`;
CREATE TABLE `lizhi_distribution` (
  `LDID` int(11) NOT NULL auto_increment,
  `AAcademyCode` int(11) default NULL COMMENT '学院编号',
  `LDNumber` int(11) default NULL COMMENT '分配指标额',
  `LID` int(11) default NULL COMMENT '励志奖学金信息表',
  `AcaStudentNum` int(11) default NULL COMMENT '学院学生人数',
  PRIMARY KEY  (`LDID`),
  KEY `FKCC3DC4C5456F346C` (`LID`),
  KEY `FKCC3DC4C5EDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FKCC3DC4C5456F346C` FOREIGN KEY (`LID`) REFERENCES `lizhi_info` (`LID`),
  CONSTRAINT `FKCC3DC4C5EDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='励志奖学金';

-- ----------------------------
-- Records of lizhi_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `lizhi_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `lizhi_historyrecord`;
CREATE TABLE `lizhi_historyrecord` (
  `LHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(32) default NULL,
  `YEAR` varchar(4) default NULL,
  `CClassCode` varchar(20) default NULL,
  PRIMARY KEY  (`LHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lizhi_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `lizhi_info`
-- ----------------------------
DROP TABLE IF EXISTS `lizhi_info`;
CREATE TABLE `lizhi_info` (
  `LID` int(11) NOT NULL auto_increment COMMENT '励志奖学金信息表',
  `name` varchar(128) NOT NULL COMMENT '励志奖学金名称',
  `SYid` int(4) NOT NULL COMMENT '学年',
  `publiser` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`LID`),
  KEY `FK967DABEFABDB9399` (`SYid`),
  CONSTRAINT `FK967DABEFABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of lizhi_info
-- ----------------------------

-- ----------------------------
-- Table structure for `mingde_application`
-- ----------------------------
DROP TABLE IF EXISTS `mingde_application`;
CREATE TABLE `mingde_application` (
  `MAID` int(11) NOT NULL auto_increment,
  `MID` int(11) default NULL COMMENT '明德奖学金信息表id',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `MAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `MAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `MAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `MAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `MAUChecker` varchar(32) default NULL COMMENT '学院审核人',
  `MAUCheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `MAStatusCount` int(11) default NULL,
  `MADate` varchar(19) default NULL,
  PRIMARY KEY  (`MAID`),
  KEY `FK67A32227ED63C021` (`CClassId`),
  KEY `FK67A32227420D0F13` (`MID`),
  KEY `FK67A322277C9B2D7` (`SStudentCode`),
  CONSTRAINT `FK67A32227420D0F13` FOREIGN KEY (`MID`) REFERENCES `mingde_info` (`mid`),
  CONSTRAINT `FK67A322277C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK67A32227ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='明德奖学金申请';

-- ----------------------------
-- Records of mingde_application
-- ----------------------------

-- ----------------------------
-- Table structure for `mingde_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `mingde_distribution`;
CREATE TABLE `mingde_distribution` (
  `MDID` int(11) NOT NULL auto_increment,
  `MID` varchar(20) default NULL COMMENT '学年学期',
  `AAcademyCode` int(11) default NULL COMMENT '学院编号',
  `MDNumber` int(11) default NULL COMMENT '分配指标额',
  `MDNStudentNum` int(11) default NULL COMMENT '师范生人数',
  PRIMARY KEY  (`MDID`),
  KEY `FKF6ACCC8DEDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FKF6ACCC8DEDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='明德奖学金';

-- ----------------------------
-- Records of mingde_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `mingde_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `mingde_historyrecord`;
CREATE TABLE `mingde_historyrecord` (
  `MHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(20) default NULL,
  `BSCode` varchar(20) default NULL,
  `CClassCode` varchar(20) default NULL,
  `STFCode` varchar(20) default NULL,
  PRIMARY KEY  (`MHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mingde_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `mingde_info`
-- ----------------------------
DROP TABLE IF EXISTS `mingde_info`;
CREATE TABLE `mingde_info` (
  `mid` int(11) NOT NULL auto_increment,
  `name` varchar(128) NOT NULL COMMENT '明德奖学金名称',
  `SYid` int(11) NOT NULL COMMENT '学年',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` bit(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`mid`),
  KEY `FK7434FBB7ABDB9399` (`SYid`),
  CONSTRAINT `FK7434FBB7ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mingde_info
-- ----------------------------

-- ----------------------------
-- Table structure for `poor_application`
-- ----------------------------
DROP TABLE IF EXISTS `poor_application`;
CREATE TABLE `poor_application` (
  `PAID` int(11) NOT NULL auto_increment,
  `PID` int(11) default NULL COMMENT '贫困认定信息表',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `PGrade` varchar(2) default NULL COMMENT '贫困认定等级',
  `PATCheck` int(1) default NULL COMMENT '班主任审核状态',
  `PATCheckDate` varchar(19) default NULL COMMENT '班主任审核日期',
  `PAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `PAACheck` int(1) default NULL COMMENT '学院审核状态',
  `PAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `PAUCheck` int(1) default NULL COMMENT '学校审核状态',
  `PAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `PAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `PAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `PADate` varchar(19) default NULL COMMENT '数据备份历史课日期',
  `PAHAverageIncome` int(11) default NULL COMMENT '家庭人均年收入',
  `PAReason` varchar(512) default NULL COMMENT '申请理由',
  `PAHomeInvestigation` varchar(512) default NULL COMMENT '家庭情况调查表',
  `PAEvidence` varchar(64) default NULL COMMENT '经济困难佐证材料',
  `PACard` varchar(20) default NULL COMMENT '农业银行卡号',
  `isSubmit` tinyint(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  PRIMARY KEY  (`PAID`),
  KEY `FK307D8B3ED63C021` (`CClassId`),
  KEY `FK307D8B3D524CAA2` (`PID`),
  KEY `FK307D8B37C9B2D7` (`SStudentCode`),
  CONSTRAINT `FK307D8B37C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK307D8B3D524CAA2` FOREIGN KEY (`PID`) REFERENCES `poor_info` (`PID`),
  CONSTRAINT `FK307D8B3ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poor_application
-- ----------------------------

-- ----------------------------
-- Table structure for `poor_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `poor_distribution`;
CREATE TABLE `poor_distribution` (
  `PDID` int(11) NOT NULL auto_increment,
  `PID` int(11) default NULL COMMENT '贫困认定信息表',
  `AAcademyCode` int(11) default NULL COMMENT '学院编号',
  `PDSpecialDifficultyN` int(11) default NULL COMMENT '特殊困难人数',
  `PDDifficultyN` int(11) default NULL COMMENT '困难人数',
  `PDGeneralDiffcultyN` int(11) default NULL COMMENT '一般困难人数',
  `AcaStudentNum` int(11) default NULL COMMENT '学院学生人数',
  PRIMARY KEY  (`PDID`),
  KEY `FKC7DEE781D524CAA2` (`PID`),
  KEY `FKC7DEE781EDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FKC7DEE781D524CAA2` FOREIGN KEY (`PID`) REFERENCES `poor_info` (`PID`),
  CONSTRAINT `FKC7DEE781EDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poor_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `poor_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `poor_historyrecord`;
CREATE TABLE `poor_historyrecord` (
  `PHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(32) default NULL,
  `YEAR` varchar(4) default NULL,
  `CClassCode` varchar(20) default NULL,
  PRIMARY KEY  (`PHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poor_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `poor_info`
-- ----------------------------
DROP TABLE IF EXISTS `poor_info`;
CREATE TABLE `poor_info` (
  `PID` int(11) NOT NULL auto_increment COMMENT '贫困认定表主键id',
  `pname` varchar(128) NOT NULL COMMENT '贫困认定名称',
  `SYid` int(11) NOT NULL COMMENT '学年',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`PID`),
  KEY `FKA05B4AABABDB9399` (`SYid`),
  CONSTRAINT `FKA05B4AABABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of poor_info
-- ----------------------------

-- ----------------------------
-- Table structure for `quality_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `quality_historyrecord`;
CREATE TABLE `quality_historyrecord` (
  `QHID` int(11) NOT NULL auto_increment,
  `SYid` int(11) default NULL COMMENT '学年id',
  `SStudentCode` varchar(20) default NULL,
  `CClassId` int(11) default NULL,
  `QTHDuty` varchar(20) default NULL,
  `QTHisDiscip` tinyint(1) default NULL,
  `QTHisRStudy` tinyint(1) default NULL,
  `QTHChecker` varchar(20) default NULL,
  `QTHCheckDate` varchar(19) default NULL,
  `QMHRanktype` varchar(20) default NULL,
  `QMHOther` varchar(256) default NULL,
  `QMHChecker` varchar(20) default NULL,
  `QMHCheckDate` varchar(19) default NULL,
  `QDHRank` int(11) default NULL,
  `QDHBasicScore` int(11) default NULL,
  `QDHAddingScore` int(11) default NULL,
  `QDHReducingScore` int(11) default NULL,
  `QDHAddingDetail` varchar(256) default NULL,
  `QDHReducingDetail` varchar(256) default NULL,
  `QDHChecker` varchar(32) default NULL,
  `QDHCheckDate` varchar(19) default NULL,
  `QSHAverageSocre` int(11) default NULL,
  `QSHRank` int(11) default NULL,
  `QSHChecker` varchar(32) default NULL,
  `QSHCheckDate` varchar(19) default NULL,
  `QBHBodyRank` int(11) default NULL,
  `QBHChecker` varchar(32) default NULL,
  `QBHCheckDate` varchar(19) default NULL,
  PRIMARY KEY  (`QHID`),
  KEY `FKD382FAA5ED63C021` (`CClassId`),
  KEY `FKD382FAA5ABDB9399` (`SYid`),
  KEY `FKD382FAA57C9B2D7` (`SStudentCode`),
  CONSTRAINT `FKD382FAA57C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FKD382FAA5ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`),
  CONSTRAINT `FKD382FAA5ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='素质评测历史表';

-- ----------------------------
-- Records of quality_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `quality_team`
-- ----------------------------
DROP TABLE IF EXISTS `quality_team`;
CREATE TABLE `quality_team` (
  `QTID` int(11) NOT NULL auto_increment COMMENT '主键id',
  `SYid` int(11) default NULL COMMENT '学年id',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `QTDuty` varchar(20) default NULL COMMENT '单人职务',
  `QTisDiscip` tinyint(1) default NULL COMMENT '是否受处分',
  `QTisRStudy` tinyint(1) default NULL COMMENT '有无补考或重修',
  `QTChecker` varchar(32) default NULL COMMENT '审核人',
  `QTCheckDate` varchar(19) default NULL COMMENT '审核日期',
  `CHECK_STATUS` int(11) default NULL COMMENT '审核状态 0：暂存 1：提交 2：审核通过 3：退回',
  PRIMARY KEY  (`QTID`),
  KEY `FKF63C019D7C9B2D7` (`SStudentCode`),
  KEY `FKF63C019DED63C021` (`CClassId`),
  KEY `FKF63C019DABDB9399` (`SYid`),
  CONSTRAINT `FKF63C019D7C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FKF63C019DABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`),
  CONSTRAINT `FKF63C019DED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='素质考评小组';

-- ----------------------------
-- Records of quality_team
-- ----------------------------

-- ----------------------------
-- Table structure for `quality_totaly`
-- ----------------------------
DROP TABLE IF EXISTS `quality_totaly`;
CREATE TABLE `quality_totaly` (
  `QTID` int(11) NOT NULL auto_increment,
  `SYid` int(11) default NULL COMMENT '学年id',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级Id',
  `QTCheck` tinyint(1) default NULL COMMENT '班主任审核状态',
  `QACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `QUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `QSAvgScore` float default NULL COMMENT '学业成绩-平均成绩',
  `QSRank` int(11) default NULL COMMENT '学业成绩排名',
  `QSRankType` varchar(10) default NULL COMMENT '思想品德等级（优秀、良好、较好、一般）',
  `QBRankType` varchar(10) default NULL COMMENT '身体素质等级（优秀、良好、及格、不及格）',
  `QDTotalScore` float default NULL COMMENT '日常表现总成绩',
  `QDRank` int(11) default NULL COMMENT '日常表现排名',
  `QDBasicScore` float default NULL COMMENT '日常表现基础成绩',
  `QDAddingScore` float default NULL COMMENT '日常表现加分',
  `QDReducingScore` float default NULL COMMENT '日常表现减分',
  `QDAddingDetail` varchar(512) default NULL COMMENT '日常表现加分明细',
  `QDReducingDetail` varchar(512) default NULL COMMENT '日常表现减分明细',
  `QLastCheckDate` varchar(19) default NULL COMMENT '最终审核时间',
  PRIMARY KEY  (`QTID`),
  KEY `FK57D77CF57C9B2D7` (`SStudentCode`),
  KEY `FK57D77CF5ED63C021` (`CClassId`),
  KEY `FK57D77CF5ABDB9399` (`SYid`),
  CONSTRAINT `FK57D77CF57C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK57D77CF5ABDB9399` FOREIGN KEY (`SYid`) REFERENCES `basic_schoolyear` (`syid`),
  CONSTRAINT `FK57D77CF5ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='素质评价汇总';

-- ----------------------------
-- Records of quality_totaly
-- ----------------------------

-- ----------------------------
-- Table structure for `scholarship_application`
-- ----------------------------
DROP TABLE IF EXISTS `scholarship_application`;
CREATE TABLE `scholarship_application` (
  `SAID` int(11) NOT NULL auto_increment,
  `BSCode` varchar(20) default NULL COMMENT '学年学期',
  `SStudentCode` varchar(20) default NULL COMMENT '学号',
  `CClassId` int(11) default NULL COMMENT '班级id',
  `SLevel` varchar(2) default NULL COMMENT '奖学金类型',
  `SATCheck` tinyint(1) default NULL COMMENT '班主任审核状态',
  `SATCheckDate` varchar(19) default NULL COMMENT '班主任审核日期',
  `SAAChecker` varchar(32) default NULL COMMENT '学院审核人',
  `SAACheck` tinyint(1) default NULL COMMENT '学院审核状态',
  `SAACheckDate` varchar(19) default NULL COMMENT '学院审核日期',
  `SAUCheck` tinyint(1) default NULL COMMENT '学校审核状态',
  `SAUChecker` varchar(32) default NULL COMMENT '学校审核人',
  `SAUCheckDate` varchar(19) default NULL COMMENT '学校审核日期',
  `SAStatusCount` int(11) default NULL COMMENT '已审核累计数',
  `SADate` varchar(19) default NULL COMMENT '数据备份历史课日期',
  `SSUCheck` bit(1) default NULL COMMENT '学校审核状态',
  `SID` int(11) default NULL COMMENT '校内奖学金信息表',
  `SAOldReward` text COMMENT '曾获何种奖励',
  `LAMoney` int(11) default NULL COMMENT '金额',
  `isSubmit` bit(1) default NULL COMMENT '是否提交（0：暂存 ， 1：提交）',
  `SACard` varchar(32) default NULL COMMENT '银行卡号',
  PRIMARY KEY  (`SAID`),
  KEY `FK1CA03EB3ED63C021` (`CClassId`),
  KEY `FK1CA03EB397E3DFB7` (`SID`),
  KEY `FK1CA03EB37C9B2D7` (`SStudentCode`),
  CONSTRAINT `FK1CA03EB37C9B2D7` FOREIGN KEY (`SStudentCode`) REFERENCES `basic_studentinfo` (`SStudentCode`),
  CONSTRAINT `FK1CA03EB397E3DFB7` FOREIGN KEY (`SID`) REFERENCES `scholarship_info` (`sid`),
  CONSTRAINT `FK1CA03EB3ED63C021` FOREIGN KEY (`CClassId`) REFERENCES `basic_class` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='校内奖学金申请';

-- ----------------------------
-- Records of scholarship_application
-- ----------------------------

-- ----------------------------
-- Table structure for `scholarship_distribution`
-- ----------------------------
DROP TABLE IF EXISTS `scholarship_distribution`;
CREATE TABLE `scholarship_distribution` (
  `SDID` int(11) NOT NULL auto_increment,
  `SID` varchar(20) default NULL COMMENT '学年学期',
  `AAcademyCode` int(11) default NULL COMMENT '学院编码',
  `SDLeve1` int(11) default NULL COMMENT '校内一等',
  `SDLeve2` int(11) default NULL COMMENT '校内二等',
  `SDLeve3` int(11) default NULL COMMENT '校内三等',
  `SDSingle` int(11) default NULL COMMENT '单项奖励',
  `AcaStudentNum` int(11) default NULL COMMENT '学院学生人数',
  PRIMARY KEY  (`SDID`),
  KEY `FKE1534181EDD3CA8B` (`AAcademyCode`),
  CONSTRAINT `FKE1534181EDD3CA8B` FOREIGN KEY (`AAcademyCode`) REFERENCES `basic_academyinfo` (`AAcademyCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='校内奖学金指标分配表';

-- ----------------------------
-- Records of scholarship_distribution
-- ----------------------------

-- ----------------------------
-- Table structure for `scholarship_historyrecord`
-- ----------------------------
DROP TABLE IF EXISTS `scholarship_historyrecord`;
CREATE TABLE `scholarship_historyrecord` (
  `SHID` int(11) NOT NULL auto_increment,
  `SStudentCode` varchar(20) default NULL COMMENT '序号',
  `BSCode` varchar(20) default NULL COMMENT '学年学期',
  `CClassId` varchar(20) default NULL COMMENT '班级Id',
  `STFCode` varchar(20) default NULL COMMENT '奖学金类型',
  PRIMARY KEY  (`SHID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scholarship_historyrecord
-- ----------------------------

-- ----------------------------
-- Table structure for `scholarship_info`
-- ----------------------------
DROP TABLE IF EXISTS `scholarship_info`;
CREATE TABLE `scholarship_info` (
  `sid` int(11) NOT NULL auto_increment COMMENT '校内奖学金信息表id',
  `sname` varchar(128) NOT NULL COMMENT '校内奖学金认定名称',
  `syid` int(11) NOT NULL COMMENT '学年id',
  `publisher` varchar(32) default NULL COMMENT '发布人',
  `publishDate` varchar(19) default NULL COMMENT '发布日期',
  `publishStatus` tinyint(1) default NULL COMMENT '发布状态',
  PRIMARY KEY  (`sid`),
  KEY `FKF8C9A4ABABDB9399` (`syid`),
  CONSTRAINT `FKF8C9A4ABABDB9399` FOREIGN KEY (`syid`) REFERENCES `basic_schoolyear` (`syid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of scholarship_info
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_module`
-- ----------------------------
DROP TABLE IF EXISTS `sys_module`;
CREATE TABLE `sys_module` (
  `MODULE_ID` int(11) NOT NULL auto_increment,
  `NAME` varchar(32) NOT NULL,
  `URL` varchar(256) NOT NULL,
  `DESCRIPTION` varchar(128) default NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`MODULE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_module
-- ----------------------------
INSERT INTO `sys_module` VALUES ('1', '内蒙古师范大学奖助学金系统', 'ssg', '内蒙古师范大学奖助学金系统', '0');

-- ----------------------------
-- Table structure for `sys_page`
-- ----------------------------
DROP TABLE IF EXISTS `sys_page`;
CREATE TABLE `sys_page` (
  `PAGE_ID` int(11) NOT NULL auto_increment,
  `PRE_PAGE_ID` int(11) default NULL,
  `PAGE_NAME` varchar(32) NOT NULL,
  `MODULE_ID` int(11) NOT NULL,
  `URL` varchar(512) default NULL,
  `LEVEL_CODE` varchar(16) default NULL,
  `ORDER_NO` int(11) default NULL,
  `DESCRIPTION` varchar(256) default NULL,
  `IMG_SRC` varchar(128) default NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  `ACTIVE_BEGIN_TIME` varchar(255) default NULL COMMENT '菜单有效时间段（开始时间）',
  `ACTIVE_END_TIME` varchar(255) default NULL COMMENT '菜单有效时间段（结束时间）',
  PRIMARY KEY  (`PAGE_ID`),
  KEY `FK74A594C11CEDEC85` USING BTREE (`MODULE_ID`),
  KEY `FK74A594C148B072C9` USING BTREE (`PRE_PAGE_ID`),
  KEY `FK74A594C19E15C89E` USING BTREE (`MODULE_ID`),
  KEY `FK74A594C15E228122` USING BTREE (`PRE_PAGE_ID`),
  CONSTRAINT `FK74A594C11CEDEC85` FOREIGN KEY (`MODULE_ID`) REFERENCES `sys_module` (`MODULE_ID`),
  CONSTRAINT `FK74A594C148B072C9` FOREIGN KEY (`PRE_PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK74A594C15E228122` FOREIGN KEY (`PRE_PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK74A594C19E15C89E` FOREIGN KEY (`MODULE_ID`) REFERENCES `sys_module` (`MODULE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_page
-- ----------------------------
INSERT INTO `sys_page` VALUES ('1', null, '系统管理', '1', null, '01', null, null, '1.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('2', '1', '角色管理', '1', 'sysRole/list', '0101', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('3', '1', '用户管理', '1', 'sysUser/list', '0102', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('4', '1', '菜单管理', '1', 'sysPage/edit', '0103', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('5', '1', '权限设置', '1', 'power/main', '0104', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('6', '1', '部门管理', '1', null, '0105', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('7', '1', '密码修改', '1', 'sysUser/editPass', '0106', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('8', '1', '功能时间设定', '1', null, '0107', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('9', null, '学生管理', '1', null, '02', null, null, '2.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('10', '9', '班级新建及新生设定', '1', 'classStudent/list', '0201', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('11', '9', '班级信息维护', '1', 'classInfo/list', '0202', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('12', '9', '学生基本信息', '1', 'student/list', '0203', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('13', null, '学工人员管理', '1', null, '03', null, null, '3.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('14', '13', '学工领导及干部管理', '1', 'leader/list', '0301', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('15', '13', '班主任管理', '1', 'classTeacher/list', '0302', null, null, null, '1', null, null);
INSERT INTO `sys_page` VALUES ('16', null, '违纪学生管理', '1', null, '04', null, null, '4.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('17', '16', '违纪学生信息导入', '1', 'disciplineStudent/add', '0401', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('18', '16', '违纪学生信息查询', '1', 'disciplineStudent/list', '0402', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('19', '16', '违纪撤销申请', '1', 'disciplineStudent/recall', '0403', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('20', '16', '违纪撤销审核', '1', 'disciplineStudent/reviewed', '0404', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('21', null, '素质评价', '1', null, '05', null, null, '5.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('22', '21', '素质考评小组', '1', 'qualityteam/list', '0501', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('27', '21', '申请年度素质评价查询', '1', 'qualityQuery/list', '0506', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('29', '21', '学院审核', '1', 'qacheck/list', '0508', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('30', '21', '学校审核', '1', 'qucheck/list', '0509', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('31', '21', '历年素质评价归档资料', '1', 'qualityTotaly/list', '0510', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('32', null, '校内奖学金', '1', null, '06', null, null, '6.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('33', '32', '奖励指标分配', '1', 'scholarshipDistribution/toAutoDis', '0601', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('34', '32', '奖励指标查看', '1', 'scholarshipDistribution/list', '0602', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('35', '32', '学生奖励申请', '1', 'scholarshipApplication/toApply', '0603', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('36', '32', '班主任（辅导员）审核', '1', 'satCheck/list', '0604', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('37', '32', '学院审核', '1', 'saaCheck/list', '0605', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('38', '32', '申请学年度奖学金汇总', '1', 'saaQuery/list', '0606', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('39', '32', '学校审核', '1', 'sauCheck/list', '0607', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('40', '32', '历年校内奖励归档资料', '1', null, '0608', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('41', null, '明德奖学金', '1', null, '07', null, null, '7.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('42', '41', '奖励指标分配', '1', 'mingdeDistribution/toAutoDis', '0701', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('43', '41', '奖励指标查看', '1', 'mingdeDistribution/list', '0702', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('44', '41', '学生奖励申请', '1', 'mingdeApplication/toApply', '0703', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('45', '41', '学院审核', '1', 'maaCheck/list', '0704', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('46', '41', '学校审核', '1', 'mauCheck/list', '0705', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('47', '41', '历年奖励归档资料', '1', null, '0706', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('48', null, '贫困认定', '1', null, '08', null, null, '8.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('49', '48', '贫困认定指标分配', '1', 'poorDistribution/toAutoDis', '0801', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('50', '48', '贫困认定指标查看', '1', 'poorDistribution/list', '0802', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('51', '48', '贫困认定申请', '1', 'poorApplication/toApply', '0803', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('52', '48', '班级认定', '1', 'patCheck/list', '0804', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('53', '48', '学院审核', '1', 'paaCheck/list', '0805', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('54', '48', '申请学年度贫困认定汇总', '1', 'paaQuery/list', '0806', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('55', '48', '学校审核', '1', 'pauCheck/list', '0807', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('56', '49', '历年贫困认定归档资料', '1', null, '0808', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('57', null, '励志奖学金', '1', null, '09', null, null, '9.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('58', '57', '励志奖学金指标分配', '1', 'lizhiDistribution/toAutoDis', '0901', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('59', '57', '励志奖学金指标查看', '1', 'lizhiDistribution/list', '0902', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('60', '57', '励志奖学金申请', '1', 'lizhiApplication/toApply', '0903', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('61', '57', '班主任（辅导员）审核', '1', 'latCheck/list', '0904', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('62', '57', '学院审核', '1', 'laaCheck/list', '0905', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('63', '57', '申请年度励志奖学金汇总', '1', 'laaQuery/list', '0906', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('64', '57', '学校审核', '1', 'lauCheck/list', '0907', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('65', '57', '历年励志奖学金归档资料', '1', null, '0908', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('66', null, '国家助学金', '1', null, '10', null, null, '10.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('67', '66', '国家助学金指标分配', '1', 'grantDistribution/toAutoDis', '1001', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('68', '66', '国家助学金指标查看', '1', 'grantDistribution/list', '1002', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('69', '66', '国家助学金申请', '1', 'grantApplication/toApply', '1003', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('70', '66', '班主任（辅导员）审核', '1', 'gatCheck/list', '1004', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('71', '66', '学院审核', '1', 'gaaCheck/list', '1005', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('72', '66', '申请年度国家助学金汇总', '1', 'gaaQuery/list', '1006', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('73', '66', '学校审核', '1', 'gauCheck/list', '1007', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('74', '66', '历年励志奖学金归档资料', '1', null, '1008', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('75', null, '减免学费', '1', null, '11', null, null, '11.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('76', '75', '减免学费指标分配', '1', 'jianmianDistribution/toAutoDis', '1101', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('77', '75', '减免学费指标查看', '1', 'jianmianDistribution/list', '1102', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('78', '75', '减免学费申请', '1', 'jianmianApplication/toApply', '1103', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('79', '75', '班主任（辅导员）审核', '1', 'jatCheck/list', '1104', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('80', '75', '学院审核', '1', 'jaaCheck/list', '1105', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('81', '75', '申请年度减免学费汇总', '1', 'jaaQuery/list', '1106', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('82', '75', '学校审核', '1', 'jauCheck/list', '1107', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('83', '75', '历年减免学费归档资料', '1', null, '1108', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('84', null, '临时伙食补贴', '1', null, '12', null, null, '12.jpg', '0', null, null);
INSERT INTO `sys_page` VALUES ('85', '84', '临时伙食补贴指标分配', '1', 'huoshiDistribution/toAutoDis', '1201', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('86', '84', '临时伙食补贴指标查看', '1', 'huoshiDistribution/list', '1202', null, '', '', '0', null, null);
INSERT INTO `sys_page` VALUES ('87', '84', '班级学生临时伙食补贴', '1', 'huoshiApplication/toApply', '1203', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('88', '84', '学院审核', '1', 'haaCheck/list', '1204', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('89', '84', '本次临时伙食补贴汇总', '1', 'haaQuery/list', '1205', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('90', '84', '学校审核', '1', 'hauCheck/list', '1206', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('91', '84', '历史临时伙食补贴归档资料', '1', null, '1207', null, null, null, '0', null, null);
INSERT INTO `sys_page` VALUES ('92', '84', '', '1', '', '1209', '9', '', '', '1', null, null);
INSERT INTO `sys_page` VALUES ('93', '21', '班主任提交', '1', 'qtsubmit/list', '0503', null, null, null, '0', null, null);

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `ROLE_ID` int(11) NOT NULL auto_increment,
  `ROLE_CODE` varchar(2) NOT NULL COMMENT '角色代码  10：学校学工 11：学院学工 12：班主任  13：学生  99：系统管理员',
  `ROLE_NAME` varchar(32) NOT NULL,
  `DESCRIPTION` varchar(256) default NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '12', '超级管理员', '超级管理员', '0');
INSERT INTO `sys_role` VALUES ('2', '13', '学校学工', '学校学工', '0');
INSERT INTO `sys_role` VALUES ('3', '14', '学院学工', '学院学工', '0');
INSERT INTO `sys_role` VALUES ('4', '15', '班主任', '班主任', '0');
INSERT INTO `sys_role` VALUES ('5', '11', '学生', '学生', '0');

-- ----------------------------
-- Table structure for `sys_role_page`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_page`;
CREATE TABLE `sys_role_page` (
  `ROLE_PAGE_ID` int(11) NOT NULL auto_increment,
  `ROLE_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) NOT NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`ROLE_PAGE_ID`),
  KEY `FK65D5D1C6D2564F05` USING BTREE (`ROLE_ID`),
  KEY `FK65D5D1C6505E6C65` USING BTREE (`PAGE_ID`),
  KEY `FK65D5D1C6E7C85D5E` USING BTREE (`ROLE_ID`),
  KEY `FK65D5D1C665D07ABE` USING BTREE (`PAGE_ID`),
  CONSTRAINT `FK65D5D1C6505E6C65` FOREIGN KEY (`PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK65D5D1C665D07ABE` FOREIGN KEY (`PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK65D5D1C6D2564F05` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`),
  CONSTRAINT `FK65D5D1C6E7C85D5E` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=477 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_role_page
-- ----------------------------
INSERT INTO `sys_role_page` VALUES ('1', '1', '1', '0');
INSERT INTO `sys_role_page` VALUES ('2', '1', '2', '0');
INSERT INTO `sys_role_page` VALUES ('3', '1', '3', '0');
INSERT INTO `sys_role_page` VALUES ('4', '1', '4', '0');
INSERT INTO `sys_role_page` VALUES ('5', '1', '5', '0');
INSERT INTO `sys_role_page` VALUES ('6', '1', '7', '0');
INSERT INTO `sys_role_page` VALUES ('7', '2', '1', '0');
INSERT INTO `sys_role_page` VALUES ('8', '2', '6', '0');
INSERT INTO `sys_role_page` VALUES ('9', '2', '7', '0');
INSERT INTO `sys_role_page` VALUES ('10', '2', '8', '0');
INSERT INTO `sys_role_page` VALUES ('11', '2', '9', '0');
INSERT INTO `sys_role_page` VALUES ('12', '2', '12', '0');
INSERT INTO `sys_role_page` VALUES ('13', '2', '13', '0');
INSERT INTO `sys_role_page` VALUES ('14', '2', '14', '0');
INSERT INTO `sys_role_page` VALUES ('15', '2', '15', '0');
INSERT INTO `sys_role_page` VALUES ('16', '2', '16', '0');
INSERT INTO `sys_role_page` VALUES ('17', '2', '17', '0');
INSERT INTO `sys_role_page` VALUES ('18', '2', '18', '0');
INSERT INTO `sys_role_page` VALUES ('19', '2', '20', '0');
INSERT INTO `sys_role_page` VALUES ('20', '2', '21', '0');
INSERT INTO `sys_role_page` VALUES ('22', '2', '30', '0');
INSERT INTO `sys_role_page` VALUES ('23', '2', '31', '0');
INSERT INTO `sys_role_page` VALUES ('24', '2', '32', '0');
INSERT INTO `sys_role_page` VALUES ('25', '2', '33', '0');
INSERT INTO `sys_role_page` VALUES ('26', '2', '34', '0');
INSERT INTO `sys_role_page` VALUES ('27', '2', '39', '0');
INSERT INTO `sys_role_page` VALUES ('28', '2', '40', '0');
INSERT INTO `sys_role_page` VALUES ('29', '2', '41', '0');
INSERT INTO `sys_role_page` VALUES ('30', '2', '42', '0');
INSERT INTO `sys_role_page` VALUES ('31', '2', '43', '0');
INSERT INTO `sys_role_page` VALUES ('32', '2', '46', '0');
INSERT INTO `sys_role_page` VALUES ('33', '2', '47', '0');
INSERT INTO `sys_role_page` VALUES ('34', '2', '48', '0');
INSERT INTO `sys_role_page` VALUES ('35', '2', '49', '0');
INSERT INTO `sys_role_page` VALUES ('36', '2', '50', '0');
INSERT INTO `sys_role_page` VALUES ('37', '2', '55', '0');
INSERT INTO `sys_role_page` VALUES ('38', '2', '56', '0');
INSERT INTO `sys_role_page` VALUES ('39', '2', '57', '0');
INSERT INTO `sys_role_page` VALUES ('40', '2', '58', '0');
INSERT INTO `sys_role_page` VALUES ('41', '2', '59', '0');
INSERT INTO `sys_role_page` VALUES ('42', '2', '64', '0');
INSERT INTO `sys_role_page` VALUES ('43', '2', '65', '0');
INSERT INTO `sys_role_page` VALUES ('44', '2', '66', '0');
INSERT INTO `sys_role_page` VALUES ('45', '2', '67', '0');
INSERT INTO `sys_role_page` VALUES ('46', '2', '68', '0');
INSERT INTO `sys_role_page` VALUES ('47', '2', '73', '0');
INSERT INTO `sys_role_page` VALUES ('48', '2', '74', '0');
INSERT INTO `sys_role_page` VALUES ('49', '2', '75', '0');
INSERT INTO `sys_role_page` VALUES ('50', '2', '76', '0');
INSERT INTO `sys_role_page` VALUES ('51', '2', '77', '0');
INSERT INTO `sys_role_page` VALUES ('52', '2', '82', '0');
INSERT INTO `sys_role_page` VALUES ('53', '2', '83', '0');
INSERT INTO `sys_role_page` VALUES ('54', '2', '84', '0');
INSERT INTO `sys_role_page` VALUES ('55', '2', '85', '0');
INSERT INTO `sys_role_page` VALUES ('56', '2', '86', '0');
INSERT INTO `sys_role_page` VALUES ('57', '2', '90', '0');
INSERT INTO `sys_role_page` VALUES ('58', '2', '91', '0');
INSERT INTO `sys_role_page` VALUES ('59', '3', '1', '0');
INSERT INTO `sys_role_page` VALUES ('60', '3', '7', '0');
INSERT INTO `sys_role_page` VALUES ('61', '3', '9', '0');
INSERT INTO `sys_role_page` VALUES ('62', '3', '10', '0');
INSERT INTO `sys_role_page` VALUES ('63', '3', '11', '0');
INSERT INTO `sys_role_page` VALUES ('64', '3', '12', '0');
INSERT INTO `sys_role_page` VALUES ('65', '3', '13', '0');
INSERT INTO `sys_role_page` VALUES ('66', '3', '14', '0');
INSERT INTO `sys_role_page` VALUES ('67', '3', '15', '0');
INSERT INTO `sys_role_page` VALUES ('68', '3', '16', '0');
INSERT INTO `sys_role_page` VALUES ('69', '3', '18', '0');
INSERT INTO `sys_role_page` VALUES ('70', '3', '19', '0');
INSERT INTO `sys_role_page` VALUES ('71', '3', '21', '0');
INSERT INTO `sys_role_page` VALUES ('72', '3', '27', '0');
INSERT INTO `sys_role_page` VALUES ('73', '3', '29', '0');
INSERT INTO `sys_role_page` VALUES ('74', '3', '31', '0');
INSERT INTO `sys_role_page` VALUES ('75', '3', '32', '0');
INSERT INTO `sys_role_page` VALUES ('76', '3', '34', '0');
INSERT INTO `sys_role_page` VALUES ('77', '3', '37', '0');
INSERT INTO `sys_role_page` VALUES ('78', '3', '38', '0');
INSERT INTO `sys_role_page` VALUES ('79', '3', '40', '0');
INSERT INTO `sys_role_page` VALUES ('80', '3', '41', '0');
INSERT INTO `sys_role_page` VALUES ('81', '3', '43', '0');
INSERT INTO `sys_role_page` VALUES ('82', '3', '45', '0');
INSERT INTO `sys_role_page` VALUES ('83', '3', '48', '0');
INSERT INTO `sys_role_page` VALUES ('84', '3', '50', '0');
INSERT INTO `sys_role_page` VALUES ('85', '3', '53', '0');
INSERT INTO `sys_role_page` VALUES ('86', '3', '54', '0');
INSERT INTO `sys_role_page` VALUES ('87', '3', '56', '0');
INSERT INTO `sys_role_page` VALUES ('88', '3', '57', '0');
INSERT INTO `sys_role_page` VALUES ('89', '3', '59', '0');
INSERT INTO `sys_role_page` VALUES ('90', '3', '62', '0');
INSERT INTO `sys_role_page` VALUES ('91', '3', '63', '0');
INSERT INTO `sys_role_page` VALUES ('92', '3', '65', '0');
INSERT INTO `sys_role_page` VALUES ('93', '3', '66', '0');
INSERT INTO `sys_role_page` VALUES ('94', '3', '68', '0');
INSERT INTO `sys_role_page` VALUES ('95', '3', '71', '0');
INSERT INTO `sys_role_page` VALUES ('96', '3', '72', '0');
INSERT INTO `sys_role_page` VALUES ('97', '3', '74', '0');
INSERT INTO `sys_role_page` VALUES ('98', '3', '75', '0');
INSERT INTO `sys_role_page` VALUES ('99', '3', '77', '0');
INSERT INTO `sys_role_page` VALUES ('100', '3', '80', '0');
INSERT INTO `sys_role_page` VALUES ('101', '3', '81', '0');
INSERT INTO `sys_role_page` VALUES ('102', '3', '83', '0');
INSERT INTO `sys_role_page` VALUES ('103', '3', '84', '0');
INSERT INTO `sys_role_page` VALUES ('104', '3', '86', '0');
INSERT INTO `sys_role_page` VALUES ('105', '3', '88', '0');
INSERT INTO `sys_role_page` VALUES ('106', '3', '89', '0');
INSERT INTO `sys_role_page` VALUES ('107', '3', '91', '0');
INSERT INTO `sys_role_page` VALUES ('108', '4', '1', '0');
INSERT INTO `sys_role_page` VALUES ('109', '4', '7', '0');
INSERT INTO `sys_role_page` VALUES ('110', '4', '9', '0');
INSERT INTO `sys_role_page` VALUES ('111', '4', '12', '0');
INSERT INTO `sys_role_page` VALUES ('112', '4', '21', '0');
INSERT INTO `sys_role_page` VALUES ('113', '4', '22', '0');
INSERT INTO `sys_role_page` VALUES ('120', '4', '32', '0');
INSERT INTO `sys_role_page` VALUES ('121', '4', '36', '0');
INSERT INTO `sys_role_page` VALUES ('122', '4', '48', '0');
INSERT INTO `sys_role_page` VALUES ('123', '4', '52', '0');
INSERT INTO `sys_role_page` VALUES ('124', '4', '57', '0');
INSERT INTO `sys_role_page` VALUES ('125', '4', '61', '0');
INSERT INTO `sys_role_page` VALUES ('126', '4', '66', '0');
INSERT INTO `sys_role_page` VALUES ('127', '4', '70', '0');
INSERT INTO `sys_role_page` VALUES ('128', '4', '75', '0');
INSERT INTO `sys_role_page` VALUES ('129', '4', '79', '0');
INSERT INTO `sys_role_page` VALUES ('130', '4', '84', '0');
INSERT INTO `sys_role_page` VALUES ('131', '4', '87', '0');
INSERT INTO `sys_role_page` VALUES ('132', '5', '1', '0');
INSERT INTO `sys_role_page` VALUES ('133', '5', '7', '0');
INSERT INTO `sys_role_page` VALUES ('134', '5', '9', '0');
INSERT INTO `sys_role_page` VALUES ('135', '5', '12', '0');
INSERT INTO `sys_role_page` VALUES ('136', '5', '32', '0');
INSERT INTO `sys_role_page` VALUES ('137', '5', '35', '0');
INSERT INTO `sys_role_page` VALUES ('138', '5', '41', '0');
INSERT INTO `sys_role_page` VALUES ('139', '5', '44', '0');
INSERT INTO `sys_role_page` VALUES ('140', '5', '48', '0');
INSERT INTO `sys_role_page` VALUES ('141', '5', '51', '0');
INSERT INTO `sys_role_page` VALUES ('142', '5', '57', '0');
INSERT INTO `sys_role_page` VALUES ('143', '5', '60', '0');
INSERT INTO `sys_role_page` VALUES ('144', '5', '66', '0');
INSERT INTO `sys_role_page` VALUES ('145', '5', '69', '0');
INSERT INTO `sys_role_page` VALUES ('146', '5', '75', '0');
INSERT INTO `sys_role_page` VALUES ('147', '5', '78', '0');
INSERT INTO `sys_role_page` VALUES ('467', '2', '5', '0');
INSERT INTO `sys_role_page` VALUES ('468', '2', '2', '0');
INSERT INTO `sys_role_page` VALUES ('469', '4', '93', '0');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `USER_ID` int(11) NOT NULL auto_increment,
  `USER_NAME` varchar(64) default NULL,
  `ACCOUNT` varchar(32) NOT NULL,
  `PASSWORD` varchar(20) NOT NULL,
  `DESCRIPTION` varchar(256) default NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  `USER_TYPE` varchar(2) default NULL COMMENT '00:系统用户；01：老师；02：学生',
  PRIMARY KEY  (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '系统管理员', 'admin', '123456', null, '0', '02');
INSERT INTO `sys_user` VALUES ('2', '巴图', '20050001', '111111', null, '0', '02');
INSERT INTO `sys_user` VALUES ('4', '白舍楞', '20050002', '111111', null, '0', '02');

-- ----------------------------
-- Table structure for `sys_user_page`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_page`;
CREATE TABLE `sys_user_page` (
  `USER_PAGE_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL,
  `PAGE_ID` int(11) NOT NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`USER_PAGE_ID`),
  KEY `FK660B3391778112E5` USING BTREE (`USER_ID`),
  KEY `FK660B3391505E6C65` USING BTREE (`PAGE_ID`),
  KEY `FK660B33918CF3213E` USING BTREE (`USER_ID`),
  KEY `FK660B339165D07ABE` USING BTREE (`PAGE_ID`),
  CONSTRAINT `FK660B3391505E6C65` FOREIGN KEY (`PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK660B339165D07ABE` FOREIGN KEY (`PAGE_ID`) REFERENCES `sys_page` (`PAGE_ID`),
  CONSTRAINT `FK660B3391778112E5` FOREIGN KEY (`USER_ID`) REFERENCES `sys_user` (`USER_ID`),
  CONSTRAINT `FK660B33918CF3213E` FOREIGN KEY (`USER_ID`) REFERENCES `sys_user` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user_page
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `USER_ROLE_ID` int(11) NOT NULL auto_increment,
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `IS_DELETED` tinyint(4) NOT NULL,
  PRIMARY KEY  (`USER_ROLE_ID`),
  KEY `FK660C5178D2564F05` USING BTREE (`ROLE_ID`),
  KEY `FK660C5178778112E5` USING BTREE (`USER_ID`),
  KEY `FK660C5178EDEE9A2D` USING BTREE (`ROLE_ID`),
  KEY `FK660C517893195E0D` USING BTREE (`USER_ID`),
  KEY `FK660C5178E7C85D5E` USING BTREE (`ROLE_ID`),
  KEY `FK660C51788CF3213E` USING BTREE (`USER_ID`),
  CONSTRAINT `FK660C5178778112E5` FOREIGN KEY (`USER_ID`) REFERENCES `sys_user` (`USER_ID`),
  CONSTRAINT `FK660C51788CF3213E` FOREIGN KEY (`USER_ID`) REFERENCES `sys_user` (`USER_ID`),
  CONSTRAINT `FK660C517893195E0D` FOREIGN KEY (`USER_ID`) REFERENCES `sys_user` (`USER_ID`),
  CONSTRAINT `FK660C5178D2564F05` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`),
  CONSTRAINT `FK660C5178E7C85D5E` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`),
  CONSTRAINT `FK660C5178EDEE9A2D` FOREIGN KEY (`ROLE_ID`) REFERENCES `sys_role` (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES ('1', '1', '1', '0');
INSERT INTO `sys_user_role` VALUES ('31', '2', '2', '0');
INSERT INTO `sys_user_role` VALUES ('32', '4', '2', '0');
