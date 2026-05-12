/*
 Navicat Premium Data Transfer

 Source Server         : tjh
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : itas

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 12/05/2026 08:59:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `session_id` bigint(0) NOT NULL COMMENT '关联chat_session.id',
  `role` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'user/assistant/system',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '消息内容',
  `rag_context` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT 'RAG检索到的上下文片段(JSON)',
  `ref_chunk_ids` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '引用的chunk_id列表(JSON数组)',
  `tokens_used` int(0) DEFAULT NULL COMMENT '本次消耗token数',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_session_id`(`session_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对话消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_message
-- ----------------------------
INSERT INTO `chat_message` VALUES (13, 13, 'user', '你好', NULL, NULL, NULL, '2026-05-03 10:13:13');
INSERT INTO `chat_message` VALUES (14, 13, 'assistant', '你好！我是ITAS智能教学辅助系统的学科知识助手，很高兴为你服务。  \n我可以帮助你分析成绩、解答学科问题、制定学习计划，如果你有具体疑问或需要指导，随时告诉我吧！', NULL, NULL, NULL, '2026-05-03 10:13:19');
INSERT INTO `chat_message` VALUES (15, 13, 'user', '1*8/365+722等于多少', NULL, NULL, NULL, '2026-05-03 10:13:52');
INSERT INTO `chat_message` VALUES (16, 13, 'assistant', '根据数学运算的优先级，先进行乘除运算，再进行加减运算。\n\n计算过程如下：\n1. 计算 1 × 8 = 8\n2. 计算 8 ÷ 365 = 8/365（这是一个分数，约等于 0.0219178）\n3. 最后加上 722：722 + 8/365\n\n所以，结果可以表示为带分数 \\(722 \\frac{8}{365}\\)，或者若需要小数形式，约为 722.0219（四舍五入到小数点后四位）。\n\n如果你需要精确的分数或不同精度的小数，可以告诉我，我可以进一步换算。', NULL, NULL, NULL, '2026-05-03 10:14:01');
INSERT INTO `chat_message` VALUES (18, 15, 'user', '你好', NULL, NULL, NULL, '2026-05-08 20:24:13');
INSERT INTO `chat_message` VALUES (19, 15, 'assistant', '你好！我是ITAS智能教学辅助系统的学科知识助手，很高兴为你服务。你可以向我询问关于成绩分析、学科知识解答、学习方法或学习计划等方面的问题。请随时告诉我你需要什么帮助，我会尽力为你提供清晰、有条理的解答。\n\n由于当前知识库中没有与你问题相关的内容，以上回复基于我自身知识生成。', NULL, NULL, NULL, '2026-05-08 20:24:22');
INSERT INTO `chat_message` VALUES (20, 16, 'user', '盐的化学式', NULL, NULL, NULL, '2026-05-08 22:07:23');
INSERT INTO `chat_message` VALUES (21, 16, 'assistant', '盐是一类化合物，在化学中指由金属离子（或铵根离子）和酸根离子组成的化合物。它通常由酸和碱中和反应生成。盐的化学式没有一个固定的形式，而是根据具体金属离子和酸根离子的种类及比例来书写。\n\n### 盐的化学式书写规则\n1. **写金属离子（或铵根）在前，酸根离子在后**。  \n   - 例如：氯化钠 NaCl（Na⁺ 和 Cl⁻）、硫酸铜 CuSO₄（Cu²⁺ 和 SO₄²⁻）、碳酸铵 (NH₄)₂CO₃（NH₄⁺ 和 CO₃²⁻）。\n2. **根据化合价使正负电荷总数相等**。  \n   - 将离子的化合价标出，用“十字交叉法”配平下标。  \n   - 例：铝离子 Al³⁺，硫酸根 SO₄²⁻，最小公倍数为6 → 需要2个Al³⁺和3个SO₄²⁻ → 化学式 Al₂(SO₄)₃。\n3. **注意离子团的括号**：若酸根或铵根有多个原子且需要多个时，用括号括起来并在右下角标数字。  \n   - 如氢氧化钙 Ca(OH)₂、硝酸铵 NH₄NO₃（铵根和硝酸根都是一个，不必加括号）。\n\n### 常见盐的化学式举例\n- **氯化物**：NaCl（食盐）、KCl、CaCl₂\n- **硫酸盐**：Na₂SO₄、MgSO₄、FeSO₄（硫酸亚铁）、Fe₂(SO₄)₃（硫酸铁）\n- **硝酸盐**：KNO₃、AgNO₃、Cu(NO₃)₂\n- **碳酸盐**：Na₂CO₃（纯碱）、CaCO₃（石灰石）\n- **酸式盐**（含可电离氢的盐）：NaHCO₃（小苏打）、KH₂PO₄\n- **碱式盐**（含OH⁻）：Cu₂(OH)₂CO₃（铜绿）\n\n### 分类与命名\n- **正盐**：酸和碱完全中和，如NaCl。\n- **酸式盐**：酸中氢部分被中和，如NaHCO₃。\n- **碱式盐**：碱中氢氧根部分被中和，如Mg(OH)Cl。\n- **复盐**：含两种金属离子，如KAl(SO₄)₂·12H₂O（明矾）。\n- **络盐**：含有配离子，如[Ag(NH₃)₂]Cl。\n\n如果你需要了解某一种具体盐的化学式或更多关于盐的性质，可以进一步提问。', NULL, NULL, NULL, '2026-05-08 22:07:47');
INSERT INTO `chat_message` VALUES (22, 17, 'user', '你好', NULL, NULL, NULL, '2026-05-09 17:32:39');
INSERT INTO `chat_message` VALUES (23, 17, 'assistant', '你好！很高兴为你服务。我是ITAS智能教学辅助系统的学科知识助手，可以帮你：\n\n- 分析考试成绩和学业表现\n- 解答各学科的知识问题\n- 制定个性化的学习计划\n- 提供学习方法和技巧建议\n\n请告诉我你遇到的具体问题，比如哪门学科有疑问、想了解什么知识点，或者需要我帮你分析哪次考试的成绩。我会尽力为你提供专业、清晰的解答！', NULL, NULL, NULL, '2026-05-09 17:32:49');

-- ----------------------------
-- Table structure for chat_session
-- ----------------------------
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `session_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '会话唯一标识(UUID)',
  `user_id` bigint(0) NOT NULL COMMENT '发起用户',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '会话标题（取首条消息前20字）',
  `agent_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'CHAT' COMMENT 'CHAT/ANALYZE/RESOURCE',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `deleted` tinyint(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_session_key`(`session_key`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对话会话表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_session
-- ----------------------------
INSERT INTO `chat_session` VALUES (13, 'a664752f05364d07b7f6bb4685ebd299', 3, '你好', 'CHAT', '2026-05-03 10:13:13', '2026-05-09 17:32:27', 1);
INSERT INTO `chat_session` VALUES (15, '97f00eca628243fa9bdb12ad60b3f0d5', 3, '你好', 'CHAT', '2026-05-08 20:24:13', '2026-05-09 17:32:29', 1);
INSERT INTO `chat_session` VALUES (16, '05382ae6a1054cdfbdfc507efe700aea', 3, '盐的化学式', 'CHAT', '2026-05-08 22:07:23', '2026-05-09 17:32:30', 1);
INSERT INTO `chat_session` VALUES (17, '7ebe9976d1f44c85b6a9011befb3588e', 3, '你好', 'CHAT', '2026-05-09 17:32:39', '2026-05-09 17:32:39', 0);

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `course_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程编号',
  `course_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程名称',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学科分类，对应RAG知识库标签',
  `credit` decimal(3, 1) DEFAULT NULL COMMENT '学分',
  `teacher_id` bigint(0) DEFAULT NULL COMMENT '授课教师ID',
  `semester` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '学期，如2024-2025-1',
  `class_id` bigint(0) DEFAULT NULL COMMENT '授课班级',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code_semester_class`(`course_code`, `semester`, `class_id`) USING BTREE,
  INDEX `idx_teacher`(`teacher_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES (1, 'CS101', '数据结构', '数据结构', 3.0, 2, '2023-2024-1', 1, '2026-04-25 09:10:14');
INSERT INTO `course` VALUES (2, 'CS102', '操作系统', '操作系统', 3.0, 2, '2023-2024-1', 1, '2026-04-25 09:10:14');
INSERT INTO `course` VALUES (3, 'CS103', '计算机网络', '计算机网络', 3.0, 2, '2023-2024-2', 1, '2026-04-25 09:10:14');
INSERT INTO `course` VALUES (4, 'CS104', '数据库原理', '数据库', 3.0, 2, '2023-2024-2', 1, '2026-04-25 09:10:14');
INSERT INTO `course` VALUES (5, 'CS105', '算法设计与分析', '算法', 3.0, 2, '2024-2025-1', 1, '2026-04-25 09:10:14');
INSERT INTO `course` VALUES (6, '244591903', '面向对象程序设计Java', 'Java程序设计', 3.0, 2, '2025-2026-1', NULL, '2026-05-09 16:44:35');

-- ----------------------------
-- Table structure for knowledge_chunk
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_chunk`;
CREATE TABLE `knowledge_chunk`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `doc_id` bigint(0) NOT NULL COMMENT '关联knowledge_document.id',
  `chunk_index` int(0) NOT NULL COMMENT '分块序号',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分块原文',
  `token_count` int(0) DEFAULT NULL COMMENT '估算token数',
  `milvus_id` bigint(0) DEFAULT NULL COMMENT '对应Milvus中的向量ID',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_doc_id`(`doc_id`) USING BTREE,
  INDEX `idx_milvus_id`(`milvus_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库文档分块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for knowledge_document
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_document`;
CREATE TABLE `knowledge_document`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文档标题',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学科标签，与course.subject对应',
  `file_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原始文件名',
  `file_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '存储路径',
  `file_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'pdf/docx/txt/md',
  `file_size` bigint(0) DEFAULT NULL COMMENT '文件大小(字节)',
  `chunk_count` int(0) NOT NULL DEFAULT 0 COMMENT '切分后的chunk数量',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0=待处理 1=向量化中 2=完成 3=失败',
  `uploader_id` bigint(0) NOT NULL COMMENT '上传人ID',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `deleted` tinyint(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_subject`(`subject`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库文档表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for learning_plan
-- ----------------------------
DROP TABLE IF EXISTS `learning_plan`;
CREATE TABLE `learning_plan`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `student_id` bigint(0) NOT NULL COMMENT '关联student_info.id',
  `plan_title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '计划内容(Markdown)',
  `weak_subjects` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '薄弱学科列表(JSON)',
  `semester` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '针对学期',
  `generated_by` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'AI' COMMENT 'AI/TEACHER',
  `status` tinyint(0) NOT NULL DEFAULT 1 COMMENT '0=草稿 1=生效',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_student_id`(`student_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习计划表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for learning_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `learning_plan_item`;
CREATE TABLE `learning_plan_item`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `plan_id` bigint(0) NOT NULL COMMENT '关联learning_plan.id',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学科',
  `task_desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务描述',
  `resource_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '推荐资源链接',
  `priority` tinyint(0) NOT NULL DEFAULT 1 COMMENT '优先级 1-5',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0=未完成 1=完成',
  `due_date` date DEFAULT NULL COMMENT '建议完成日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_plan_id`(`plan_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习计划任务项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for learning_resource
-- ----------------------------
DROP TABLE IF EXISTS `learning_resource`;
CREATE TABLE `learning_resource`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源标题',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学科',
  `res_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'VIDEO/ARTICLE/EXERCISE/BOOK',
  `url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '资源链接',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '资源描述',
  `difficulty` tinyint(0) NOT NULL DEFAULT 2 COMMENT '难度 1=简单 2=中等 3=困难',
  `uploader_id` bigint(0) DEFAULT NULL COMMENT '上传人',
  `view_count` int(0) NOT NULL DEFAULT 0,
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted` tinyint(0) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_subject`(`subject`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习资源表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of learning_resource
-- ----------------------------
INSERT INTO `learning_resource` VALUES (1, '数据结构与算法图解', '数据结构', 'ARTICLE', 'https://example.com/ds', '图文并茂讲解常见数据结构', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (2, '操作系统概念精讲', '操作系统', 'VIDEO', 'https://example.com/os', '操作系统核心概念视频教程', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (3, '数据库SQL练习题集', '数据库', 'EXERCISE', 'https://example.com/sql', '100道SQL经典练习题', 1, 2, 0, '2026-04-25 09:10:14', 0);

-- ----------------------------
-- Table structure for score
-- ----------------------------
DROP TABLE IF EXISTS `score`;
CREATE TABLE `score`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `student_id` bigint(0) NOT NULL COMMENT '关联student_info.id',
  `course_id` bigint(0) NOT NULL COMMENT '关联course.id',
  `usual_score` decimal(5, 2) DEFAULT NULL COMMENT '平时成绩',
  `mid_score` decimal(5, 2) DEFAULT NULL COMMENT '期中成绩',
  `final_score` decimal(5, 2) DEFAULT NULL COMMENT '期末成绩',
  `total_score` decimal(5, 2) DEFAULT NULL COMMENT '综合成绩（加权后）',
  `grade_level` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '等级: A/B/C/D/F',
  `is_pass` tinyint(0) NOT NULL DEFAULT 1 COMMENT '是否及格: 0=不及格 1=及格',
  `semester` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学期',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '备注',
  `created_by` bigint(0) DEFAULT NULL COMMENT '录入人ID',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_student_course_semester`(`student_id`, `course_id`, `semester`) USING BTREE,
  INDEX `idx_student`(`student_id`) USING BTREE,
  INDEX `idx_course`(`course_id`) USING BTREE,
  INDEX `idx_semester`(`semester`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 123 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '成绩表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score
-- ----------------------------
INSERT INTO `score` VALUES (1, 1, 1, 85.00, 78.00, 82.00, 82.50, 'B', 1, '2023-2024-1', NULL, 2, '2026-04-25 09:10:14', '2026-04-25 09:10:14');
INSERT INTO `score` VALUES (2, 1, 2, 72.00, 65.00, 70.00, 70.10, 'C', 1, '2023-2024-1', NULL, 2, '2026-04-25 09:10:14', '2026-04-25 09:10:14');
INSERT INTO `score` VALUES (3, 1, 3, 90.00, 88.00, 92.00, 91.00, 'A', 1, '2023-2024-2', NULL, 2, '2026-04-25 09:10:14', '2026-04-25 09:10:14');
INSERT INTO `score` VALUES (4, 1, 4, 55.00, 50.00, 48.00, 50.90, 'F', 0, '2023-2024-2', NULL, 2, '2026-04-25 09:10:14', '2026-04-25 09:10:14');
INSERT INTO `score` VALUES (5, 1, 5, 88.00, 85.00, 87.00, 87.10, 'B', 1, '2024-2025-1', NULL, 2, '2026-04-25 09:10:14', '2026-04-25 09:10:14');
INSERT INTO `score` VALUES (6, 2, 6, 74.70, 78.50, 61.00, 68.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (7, 3, 6, 52.00, 81.50, 58.50, 61.20, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (8, 4, 6, 55.40, 74.50, 85.00, 74.00, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (9, 5, 6, 52.00, 39.00, 44.00, 45.40, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (10, 6, 6, 47.00, 55.50, 65.50, 58.00, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (11, 7, 6, 69.00, 95.50, 93.50, 86.60, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (12, 8, 6, 64.00, 69.50, 50.50, 58.40, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (13, 9, 6, 74.00, 83.00, 89.00, 83.30, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (14, 10, 6, 68.00, 51.50, 86.50, 74.00, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (15, 11, 6, 70.00, 79.00, 80.00, 76.80, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (16, 12, 6, 65.50, 57.50, 68.00, 65.20, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (17, 13, 6, 55.00, 87.00, 98.00, 82.90, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (18, 14, 6, 68.00, 80.00, 61.00, 66.90, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (19, 15, 6, 86.00, 98.00, 86.50, 88.70, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (20, 16, 6, 55.00, 69.50, 76.00, 68.40, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (21, 17, 6, 46.70, 46.50, 84.50, 65.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (22, 18, 6, 39.70, 83.50, 75.50, 66.40, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (23, 19, 6, 60.00, 81.00, 64.00, 66.20, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (24, 20, 6, 57.00, 67.50, 54.00, 57.60, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (25, 21, 6, 57.00, 69.50, 62.50, 62.30, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (26, 22, 6, 63.00, 48.50, 76.00, 66.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (27, 23, 6, 69.00, 75.00, 70.50, 71.00, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (28, 24, 6, 66.00, 71.00, 65.00, 66.50, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (29, 25, 6, 86.00, 69.00, 40.50, 59.90, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (30, 26, 6, 74.00, 68.00, 65.50, 68.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (31, 27, 6, 42.50, 62.00, 79.00, 64.70, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (32, 28, 6, 66.00, 84.00, 60.50, 66.90, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (33, 29, 6, 71.00, 59.50, 53.00, 59.70, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (34, 30, 6, 91.00, 93.00, 93.00, 92.40, 'A', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (35, 31, 6, 80.00, 71.50, 59.50, 68.10, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (36, 32, 6, 57.00, 86.00, 64.00, 66.30, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (37, 33, 6, 41.00, 47.50, 71.50, 57.60, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (38, 34, 6, 80.00, 84.50, 74.50, 78.20, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (39, 35, 6, 76.00, 71.50, 87.00, 80.60, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (40, 36, 6, 72.00, 65.00, 52.00, 60.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (41, 37, 6, 70.00, 64.00, 79.00, 73.30, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (42, 38, 6, 54.00, 61.50, 45.50, 51.30, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (43, 39, 6, 83.00, 78.50, 71.00, 76.10, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (44, 40, 6, 66.00, 66.50, 66.50, 66.40, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (45, 41, 6, 77.30, 77.00, 68.00, 72.60, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (46, 42, 6, 34.00, 64.00, 45.50, 45.80, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (47, 43, 6, 55.40, 50.00, 68.00, 60.60, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (48, 44, 6, 58.00, 75.00, 93.50, 79.20, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (49, 45, 6, 55.00, 56.00, 69.50, 62.50, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (50, 46, 6, 68.00, 64.50, 78.50, 72.60, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (51, 47, 6, 45.00, 60.00, 58.50, 54.80, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (52, 48, 6, 48.00, 53.00, 57.00, 53.50, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (53, 49, 6, 37.00, 51.50, 61.00, 51.90, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (54, 50, 6, 61.00, 18.50, NULL, 22.00, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (55, 51, 6, 54.00, 83.00, 59.00, 62.30, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (56, 52, 6, 40.00, 60.00, 67.50, 57.80, 'F', 0, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (57, 53, 6, 58.00, 89.50, 76.50, 73.60, 'C', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (58, 54, 6, 80.00, 73.50, 88.00, 82.70, 'B', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (59, 55, 6, NULL, NULL, NULL, NULL, NULL, 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (60, 56, 6, 55.00, 63.00, 73.50, 65.90, 'D', 1, '2025-2026-1', NULL, 1, '2026-05-09 16:44:35', '2026-05-09 21:39:41');

-- ----------------------------
-- Table structure for score_import_batch
-- ----------------------------
DROP TABLE IF EXISTS `score_import_batch`;
CREATE TABLE `score_import_batch`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '批次号(UUID)',
  `file_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '原始文件名',
  `course_id` bigint(0) NOT NULL,
  `semester` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `total_rows` int(0) NOT NULL DEFAULT 0 COMMENT '总行数',
  `success_rows` int(0) NOT NULL DEFAULT 0 COMMENT '成功行数',
  `fail_rows` int(0) NOT NULL DEFAULT 0 COMMENT '失败行数',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0=处理中 1=完成 2=失败',
  `operator_id` bigint(0) NOT NULL COMMENT '操作人',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_batch_no`(`batch_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '成绩导入批次表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of score_import_batch
-- ----------------------------
INSERT INTO `score_import_batch` VALUES (1, '07a8bbbb4ee249e68e6a98bfb131ad8a', 'itas_import_scores.xlsx', 6, '2025-2026-1', 55, 55, 0, 1, 2, '2026-05-09 16:46:47');

-- ----------------------------
-- Table structure for student_info
-- ----------------------------
DROP TABLE IF EXISTS `student_info`;
CREATE TABLE `student_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(0) NOT NULL COMMENT '关联sys_user.id',
  `student_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '学号',
  `class_id` bigint(0) NOT NULL COMMENT '所在班级',
  `enrollment_year` smallint(0) DEFAULT NULL COMMENT '入学年份',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE,
  UNIQUE INDEX `uk_student_no`(`student_no`) USING BTREE,
  INDEX `idx_class`(`class_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学生信息扩展表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of student_info
-- ----------------------------
INSERT INTO `student_info` VALUES (1, 3, '202207034221', 1, 2022);
INSERT INTO `student_info` VALUES (2, 4, '202407034101', 4, 2024);
INSERT INTO `student_info` VALUES (3, 5, '202407034102', 4, 2024);
INSERT INTO `student_info` VALUES (4, 6, '202407034103', 4, 2024);
INSERT INTO `student_info` VALUES (5, 7, '202407034104', 4, 2024);
INSERT INTO `student_info` VALUES (6, 8, '202407034105', 4, 2024);
INSERT INTO `student_info` VALUES (7, 9, '202407034106', 4, 2024);
INSERT INTO `student_info` VALUES (8, 10, '202407034107', 4, 2024);
INSERT INTO `student_info` VALUES (9, 11, '202407034108', 4, 2024);
INSERT INTO `student_info` VALUES (10, 12, '202407034109', 4, 2024);
INSERT INTO `student_info` VALUES (11, 13, '202407034110', 4, 2024);
INSERT INTO `student_info` VALUES (12, 14, '202407034111', 4, 2024);
INSERT INTO `student_info` VALUES (13, 15, '202407034113', 4, 2024);
INSERT INTO `student_info` VALUES (14, 16, '202407034114', 4, 2024);
INSERT INTO `student_info` VALUES (15, 17, '202407034116', 4, 2024);
INSERT INTO `student_info` VALUES (16, 18, '202407034117', 4, 2024);
INSERT INTO `student_info` VALUES (17, 19, '202407034118', 4, 2024);
INSERT INTO `student_info` VALUES (18, 20, '202407034119', 4, 2024);
INSERT INTO `student_info` VALUES (19, 21, '202407034120', 4, 2024);
INSERT INTO `student_info` VALUES (20, 22, '202407034121', 4, 2024);
INSERT INTO `student_info` VALUES (21, 23, '202407034122', 4, 2024);
INSERT INTO `student_info` VALUES (22, 24, '202407034123', 4, 2024);
INSERT INTO `student_info` VALUES (23, 25, '202407034125', 4, 2024);
INSERT INTO `student_info` VALUES (24, 26, '202407034126', 4, 2024);
INSERT INTO `student_info` VALUES (25, 27, '202407034127', 4, 2024);
INSERT INTO `student_info` VALUES (26, 28, '202407034129', 4, 2024);
INSERT INTO `student_info` VALUES (27, 29, '202407034130', 4, 2024);
INSERT INTO `student_info` VALUES (28, 30, '202407034201', 5, 2024);
INSERT INTO `student_info` VALUES (29, 31, '202407034202', 5, 2024);
INSERT INTO `student_info` VALUES (30, 32, '202407034203', 5, 2024);
INSERT INTO `student_info` VALUES (31, 33, '202407034204', 5, 2024);
INSERT INTO `student_info` VALUES (32, 34, '202407034205', 5, 2024);
INSERT INTO `student_info` VALUES (33, 35, '202407034206', 5, 2024);
INSERT INTO `student_info` VALUES (34, 36, '202407034207', 5, 2024);
INSERT INTO `student_info` VALUES (35, 37, '202407034208', 5, 2024);
INSERT INTO `student_info` VALUES (36, 38, '202407034209', 5, 2024);
INSERT INTO `student_info` VALUES (37, 39, '202407034210', 5, 2024);
INSERT INTO `student_info` VALUES (38, 40, '202407034211', 5, 2024);
INSERT INTO `student_info` VALUES (39, 41, '202407034213', 5, 2024);
INSERT INTO `student_info` VALUES (40, 42, '202407034214', 5, 2024);
INSERT INTO `student_info` VALUES (41, 43, '202407034215', 5, 2024);
INSERT INTO `student_info` VALUES (42, 44, '202407034216', 5, 2024);
INSERT INTO `student_info` VALUES (43, 45, '202407034217', 5, 2024);
INSERT INTO `student_info` VALUES (44, 46, '202407034218', 5, 2024);
INSERT INTO `student_info` VALUES (45, 47, '202407034219', 5, 2024);
INSERT INTO `student_info` VALUES (46, 48, '202407034220', 5, 2024);
INSERT INTO `student_info` VALUES (47, 49, '202407034221', 5, 2024);
INSERT INTO `student_info` VALUES (48, 50, '202407034222', 5, 2024);
INSERT INTO `student_info` VALUES (49, 51, '202407034223', 5, 2024);
INSERT INTO `student_info` VALUES (50, 52, '202407034224', 5, 2024);
INSERT INTO `student_info` VALUES (51, 53, '202407034225', 5, 2024);
INSERT INTO `student_info` VALUES (52, 54, '202407034226', 5, 2024);
INSERT INTO `student_info` VALUES (53, 55, '202407034227', 5, 2024);
INSERT INTO `student_info` VALUES (54, 56, '202407034228', 5, 2024);
INSERT INTO `student_info` VALUES (55, 57, '202407034229', 5, 2024);
INSERT INTO `student_info` VALUES (56, 58, '202407034230', 5, 2024);

-- ----------------------------
-- Table structure for sys_class
-- ----------------------------
DROP TABLE IF EXISTS `sys_class`;
CREATE TABLE `sys_class`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `class_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '班级名称，如B222',
  `department_id` bigint(0) NOT NULL COMMENT '所属院系',
  `grade` smallint(0) NOT NULL COMMENT '年级，如2022',
  `teacher_id` bigint(0) DEFAULT NULL COMMENT '班主任ID',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_department`(`department_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '班级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_class
-- ----------------------------
INSERT INTO `sys_class` VALUES (1, 'B222', 1, 2022, NULL, '2026-04-25 09:10:14');
INSERT INTO `sys_class` VALUES (2, 'B221', 1, 2021, NULL, '2026-04-25 09:10:14');
INSERT INTO `sys_class` VALUES (3, 'B223', 1, 2023, NULL, '2026-04-25 09:10:14');
INSERT INTO `sys_class` VALUES (4, '信管B241', 1, 2024, 2, '2026-05-09 16:44:35');
INSERT INTO `sys_class` VALUES (5, '信管B242', 1, 2024, 2, '2026-05-09 16:44:35');

-- ----------------------------
-- Table structure for sys_department
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '院系名称',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES (1, '计算机与信息工程学院', '2026-04-25 09:10:14');
INSERT INTO `sys_department` VALUES (2, '数学与统计学院', '2026-04-25 09:10:14');
INSERT INTO `sys_department` VALUES (3, '外国语学院', '2026-04-25 09:10:14');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(0) DEFAULT NULL COMMENT '操作用户',
  `module` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '模块',
  `action` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '操作描述',
  `method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'HTTP方法',
  `request_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求URL',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '客户端IP',
  `status` smallint(0) DEFAULT NULL COMMENT 'HTTP状态码',
  `cost_ms` int(0) DEFAULT NULL COMMENT '耗时毫秒',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id`) USING BTREE,
  INDEX `idx_created_at`(`created_at`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统操作日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名/学号/工号',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'BCrypt加密密码',
  `real_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `role` tinyint(0) NOT NULL DEFAULT 2 COMMENT '角色: 0=管理员 1=教师 2=学生',
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '手机号',
  `avatar_url` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像URL',
  `status` tinyint(0) NOT NULL DEFAULT 1 COMMENT '状态: 0=禁用 1=启用',
  `created_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  `deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '逻辑删除: 0=正常 1=删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '系统管理员', 0, NULL, NULL, NULL, 1, '2026-04-25 09:10:14', '2026-05-03 09:58:39', 0);
INSERT INTO `sys_user` VALUES (2, 'teacher01', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '张老师', 1, NULL, NULL, NULL, 1, '2026-04-25 09:10:14', '2026-05-08 22:08:42', 0);
INSERT INTO `sys_user` VALUES (3, '202207034221', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '滕建宏', 2, '2335068896@qq.com', '202207034221', NULL, 1, '2026-04-25 09:10:14', '2026-05-03 09:58:39', 0);
INSERT INTO `sys_user` VALUES (4, '202407034101', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '池佳轩', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (5, '202407034102', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '薛博妍', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (6, '202407034103', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '邢潇月', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (7, '202407034104', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '郭义高', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (8, '202407034105', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '韩子聪', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (9, '202407034106', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘洁', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (10, '202407034107', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '郭佳琛', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (11, '202407034108', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '陈荣', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (12, '202407034109', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '黄雯玲', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (13, '202407034110', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '曹海伟', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (14, '202407034111', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '杨婷鑫', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (15, '202407034113', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '孙佳怡', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (16, '202407034114', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘怡梦', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (17, '202407034116', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '饶娇娇', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (18, '202407034117', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '柳鹏飞', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (19, '202407034118', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘朝霞', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (20, '202407034119', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '纪俊丞', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (21, '202407034120', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '蒲宇舟', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (22, '202407034121', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '张天伟', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (23, '202407034122', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '汪明轩', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (24, '202407034123', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '曹国星', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (25, '202407034125', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '曾凡松', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (26, '202407034126', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '晋新哲', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (27, '202407034127', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '王晓鲁', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (28, '202407034129', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '黎静怡', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (29, '202407034130', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '李厚锋', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (30, '202407034201', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '鱼佳浩', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (31, '202407034202', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘杨河', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (32, '202407034203', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '范欣茹', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (33, '202407034204', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '马紫薇', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (34, '202407034205', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '杨子贤', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (35, '202407034206', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '邵明坤', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (36, '202407034207', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '李忻烨', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (37, '202407034208', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '徐嘉', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (38, '202407034209', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '陈志翔', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (39, '202407034210', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '张静', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (40, '202407034211', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '余国鑫', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (41, '202407034213', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '赵海洋', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (42, '202407034214', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '周均永', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (43, '202407034215', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '李域涵', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (44, '202407034216', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '冯旭豪', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (45, '202407034217', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '马浩', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (46, '202407034218', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '李晓萌', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (47, '202407034219', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '汪小曼', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (48, '202407034220', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '耿硕权', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (49, '202407034221', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '赵仁勋', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (50, '202407034222', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '欧开政', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (51, '202407034223', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '蒋祖辉', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (52, '202407034224', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘睦坤', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (53, '202407034225', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '张梓宁', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (54, '202407034226', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '肖文超', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (55, '202407034227', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '毛美琪', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (56, '202407034228', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '文振州', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (57, '202407034229', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '刘一帆', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);
INSERT INTO `sys_user` VALUES (58, '202407034230', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '陈依琳', 2, NULL, NULL, NULL, 1, '2026-05-09 16:44:35', '2026-05-09 16:44:35', 0);

-- ----------------------------
-- Table structure for teacher_info
-- ----------------------------
DROP TABLE IF EXISTS `teacher_info`;
CREATE TABLE `teacher_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(0) NOT NULL COMMENT '关联sys_user.id',
  `teacher_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '工号',
  `department_id` bigint(0) DEFAULT NULL COMMENT '所属院系',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '职称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_id`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '教师信息扩展表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of teacher_info
-- ----------------------------
INSERT INTO `teacher_info` VALUES (1, 2, 'T20220001', 1, '讲师');

-- ----------------------------
-- 数据库修正脚本（已部署环境的修复 SQL）
-- 用途：清理课程编号误存为 course_id 的重复成绩数据
-- ----------------------------
-- 1. 删除 course_id=244591903 的脏数据（该值为课程编号，非课程表主键）
-- DELETE FROM score WHERE course_id = 244591903;
-- 2. 修正导入批次记录中的课程 ID
-- UPDATE score_import_batch SET course_id = 6 WHERE course_id = 244591903;

-- ----------------------------
-- 知识库文档数据 (14个学科，约160个chunk)
-- 向量化方法: 启动应用后通过 "上传文档" 功能上传 ./uploads/ 下的.md文件
-- 或通过管理端触发 /api/knowledge/vectorize/{docId}
-- ----------------------------
INSERT INTO `knowledge_document` VALUES (1, '数据结构核心知识', '数据结构', '01_数据结构核心知识.md', './uploads/01_数据结构核心知识.md', 'md', 6421, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (2, '操作系统核心知识', '操作系统', '02_操作系统核心知识.md', './uploads/02_操作系统核心知识.md', 'md', 6088, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (3, '计算机网络核心知识', '计算机网络', '03_计算机网络核心知识.md', './uploads/03_计算机网络核心知识.md', 'md', 7197, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (4, '数据库原理核心知识', '数据库', '04_数据库原理核心知识.md', './uploads/04_数据库原理核心知识.md', 'md', 6897, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (5, '算法设计与分析核心知识', '算法', '05_算法设计与分析核心知识.md', './uploads/05_算法设计与分析核心知识.md', 'md', 6578, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (6, 'Java程序设计核心知识', 'Java程序设计', '06_Java程序设计核心知识.md', './uploads/06_Java程序设计核心知识.md', 'md', 6889, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (7, '高等数学基础', '数学', '07_高等数学基础.md', './uploads/07_高等数学基础.md', 'md', 4583, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (8, '大学物理基础', '物理', '08_大学物理基础.md', './uploads/08_大学物理基础.md', 'md', 4464, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (9, '化学基础知识', '化学', '09_化学基础知识.md', './uploads/09_化学基础知识.md', 'md', 5120, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (10, '英语语法基础', '英语', '10_英语语法基础.md', './uploads/10_英语语法基础.md', 'md', 5399, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (11, '语文文学常识', '语文', '11_语文文学常识.md', './uploads/11_语文文学常识.md', 'md', 4330, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (12, '中国历史概要', '历史', '12_中国历史概要.md', './uploads/12_中国历史概要.md', 'md', 4250, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (13, '地理基础知识', '地理', '13_地理基础知识.md', './uploads/13_地理基础知识.md', 'md', 6031, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);
INSERT INTO `knowledge_document` VALUES (14, '生物基础知识', '生物', '14_生物基础知识.md', './uploads/14_生物基础知识.md', 'md', 6143, 0, 0, 2, '2026-05-12 09:00:00', '2026-05-12 09:00:00', 0);

SET FOREIGN_KEY_CHECKS = 1;
