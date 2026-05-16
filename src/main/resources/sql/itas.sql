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

 Date: 15/05/2026 21:18:03
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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对话消息表' ROW_FORMAT = Dynamic;

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
INSERT INTO `chat_message` VALUES (24, 18, 'user', '什么是栈？栈和队列有什么区别？', NULL, NULL, NULL, '2026-05-14 21:31:22');
INSERT INTO `chat_message` VALUES (25, 18, 'assistant', '**栈**是一种操作受限的线性表，仅允许在一端（称为栈顶）进行插入（push）和删除（pop）操作，另一端固定称为栈底。它遵循**后进先出（LIFO，Last In First Out）**的原则，即最后进入栈的元素最先被取出。栈在计算机科学中应用广泛，例如函数调用栈、表达式求值、括号匹配等。\n\n**栈和队列的主要区别**可以从以下方面对比：\n\n| 维度 | 栈 | 队列 |\n|------|----|------|\n| **操作原则** | 后进先出（LIFO） | 先进先出（FIFO，First In First Out） |\n| **操作端点** | 只能在栈顶进行插入和删除 | 在队尾插入（enqueue），在队头删除（dequeue） |\n| **结构与访问** | 一端开放，另一端封闭 | 两端开放，一端入，一端出 |\n| **典型操作** | push（入栈）、pop（出栈） | enqueue（入队）、dequeue（出队） |\n| **常见应用场景** | 函数调用栈、递归、表达式求值、括号匹配 | 任务调度、消息队列、广度优先搜索（BFS） |\n\n**补充说明**：还有一种数据结构叫双端队列（Deque），它融合了栈和队列的特点，允许在两端进行插入和删除操作。\n\n> 以上内容整理自：《数据结构考题1》《数据结构 - 二、栈与队列》', '[来源: 数据结构考题1]\n题目：栈和队列的主要区别是什么？答案：栈是后进先出（LIFO）的数据结构，只允许在栈顶进行插入和删除操作；队列是先进先出（FIFO）的数据结构，允许在队尾插入、队首删除。解析：栈的操作包括push（入栈）和pop（出栈），常用场景有函数调用栈、表达式求值、括号匹配等。队列的操作包括enqueue（入队）和dequeue（出队），常用场景有任务调度、消息队列、BFS遍历等。双端队列（Deque）结合了两者特性，允许在两端进行插入和删除。\n\n---\n\n[来源: 数据结构 - 二、栈与队列]\n栈是限定仅在表尾进行插入和删除操作的线性表，遵循后进先出（LIFO）原则。栈顶是允许操作的一端，栈底是固定的一端。栈的基本操作包括入栈（push）和出栈（pop）。栈在函数调用、表达式求值、括号匹配等场景广泛应用。 队列是限定在表的一端插入、另一端删除的线性表，遵循先进先出（FIFO）原则。允许插入的一端称为队尾，允许删除的一端称为队头。循环队列通过取模运算实现空间的高效利用，解决了顺序队列的假溢出问题。\n\n---\n\n[来源: 数据结构 - 一、线性表]\n线性表是n个数据元素的有限序列，是最基本、最简单、最常用的一种数据结构。线性表有两种存储结构：顺序存储和链式存储。 顺序表 顺序表用一组地址连续的存储单元依次存储线性表的数据元素。其特点是逻辑上相邻的元素在物理位置上也相邻，因此可以随机存取任一元素，时间复杂度为O(1)。但在插入和删除操作时需要移动大量元素，平均时间复杂度为O(n)。 链表 链表通过指针将一系列结点连接起来。每个结点包含数据域和指针域。链表包括单链表、双链表和循环链表。单链表的结点只有一个指向后继的指针；双链表有两个指针，分别指向前驱和后继。链表的插入和删除操作只需修改指针，时间复杂度为O(1)，但查找操作需要遍历，时间复杂度为O(n)。\n\n---\n\n[来源: 数据结构 - 三、树与二叉树]\n树是n个结点的有限集，n=0时为空树。任意非空树有且仅有一个根结点。树的基本术语包括结点的度、树的度、叶子结点、分支结点、路径、树的深度等。 二叉树每个结点最多有两棵子树，分为左子树和右子树。满二叉树是深度为k且有2^k-1个结点的二叉树。完全二叉树是除最后一层外每层结点都达到最大值，且最后一层结点连续集中在左边的二叉树。 二叉树的遍历分为前序遍历（根-左-右）、中序遍历（左-根-右）、后序遍历（左-右-根）和层序遍历。二叉树可以用顺序存储或链式存储（二叉链表、三叉链表）。 二叉搜索树（BST）满足左子树所有结点值小于根结点值小于右子树所有结点值。平衡二叉树（AVL）任意结点左右子树高度差不超过1。红黑树通过颜色属性维持近似平衡，查找、插入、删除时间复杂度均为O(log n)。 堆是一种特殊的完全二叉树，分为大顶堆和小顶堆。大顶堆每个结点的值都大于或等于其左右孩子结点的值。堆排序利用堆的性质进行排序，时间复杂度O(nlog n)。 哈夫曼树（最优二叉树）是带权路径长度WPL最小的二叉树，用于数据压缩编码。哈夫曼编码是前缀编码，任何字符的编码都不是另一个字符编码的前缀。\n\n---\n\n[来源: 数据结构 - 六、排序]\n的出现次数，时间复杂度O(n+k)。桶排序将数据分到有限数量的桶里，每个桶分别排序。基数排序按位数从低位到高位依次排序，适用于整数和字符串。', '49,99,98,100,105', NULL, '2026-05-14 21:31:38');

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
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '对话会话表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_session
-- ----------------------------
INSERT INTO `chat_session` VALUES (13, 'a664752f05364d07b7f6bb4685ebd299', 3, '你好', 'CHAT', '2026-05-03 10:13:13', '2026-05-09 17:32:27', 1);
INSERT INTO `chat_session` VALUES (15, '97f00eca628243fa9bdb12ad60b3f0d5', 3, '你好', 'CHAT', '2026-05-08 20:24:13', '2026-05-09 17:32:29', 1);
INSERT INTO `chat_session` VALUES (16, '05382ae6a1054cdfbdfc507efe700aea', 3, '盐的化学式', 'CHAT', '2026-05-08 22:07:23', '2026-05-09 17:32:30', 1);
INSERT INTO `chat_session` VALUES (17, '7ebe9976d1f44c85b6a9011befb3588e', 3, '你好', 'CHAT', '2026-05-09 17:32:39', '2026-05-09 17:32:39', 0);
INSERT INTO `chat_session` VALUES (18, '4036841d728a47be9a61bc28d51c64ec', 1, '什么是栈？栈和队列有什么区别？', 'CHAT', '2026-05-14 21:31:22', '2026-05-14 21:31:22', 0);

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
  `content_hash` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'SHA-256哈希，用于去重',
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'upload' COMMENT '来源: upload/k12textbook/ceval',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_doc_id`(`doc_id`) USING BTREE,
  INDEX `idx_milvus_id`(`milvus_id`) USING BTREE,
  INDEX `idx_content_hash`(`content_hash`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 152 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库文档分块表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_chunk
-- ----------------------------
INSERT INTO `knowledge_chunk` VALUES (7, 2, 0, '# 数据结构核心知识 ## 一、线性表 线性表是n个数据元素的有限序列，是最基本、最简单、最常用的一种数据结构。线性表有两种存储结构：顺序存储和链式存储。 ### 顺序表 顺序表用一组地址连续的存储单元依次存储线性表的数据元素。其特点是逻辑上相邻的元素在物理位置上也相邻，因此可以随机存取任一元素，时间复杂度为O(1)。但在插入和删除操作时需要移动大量元素，平均时间复杂度为O(n)。 ### 链表 链表通过指针将一系列结点连接起来。每个结点包含数据域和指针域。链表包括单链表、双链表和循环链表。单链表的结点只有一个指向后继的指针；双链表有两个指针，分别指向前驱和后继。链表的插入和删除操作只需修改指针，时间复杂度为O(1)，但查找操作需要遍历，时间复杂度为O(n)。 ## 二、栈与队列 栈是限定仅在表尾进行插入和删除操作的线性表，遵循后进先出（LIFO）原则。栈顶是允许操作的一端，栈底是固定的一端。栈的基本操作包括入栈（push）和出栈（pop）。栈在函数调用、表达式求值、括号匹配等场景广泛应用。 队列是限定在表的一端插入、另一端删除的线性表，遵循先进先出（FIFO）原则。允许插入的一端称为队尾，允许删除的一端称为', 256, 466218070695941699, '2026-05-12 20:34:17', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (8, 2, 1, '端插入、另一端删除的线性表，遵循先进先出（FIFO）原则。允许插入的一端称为队尾，允许删除的一端称为队头。循环队列通过取模运算实现空间的高效利用，解决了顺序队列的假溢出问题。 ## 三、树与二叉树 树是n个结点的有限集，n=0时为空树。任意非空树有且仅有一个根结点。树的基本术语包括结点的度、树的度、叶子结点、分支结点、路径、树的深度等。 二叉树每个结点最多有两棵子树，分为左子树和右子树。满二叉树是深度为k且有2^k-1个结点的二叉树。完全二叉树是除最后一层外每层结点都达到最大值，且最后一层结点连续集中在左边的二叉树。 二叉树的遍历分为前序遍历（根-左-右）、中序遍历（左-根-右）、后序遍历（左-右-根）和层序遍历。二叉树可以用顺序存储或链式存储（二叉链表、三叉链表）。 二叉搜索树（BST）满足左子树所有结点值小于根结点值小于右子树所有结点值。平衡二叉树（AVL）任意结点左右子树高度差不超过1。红黑树通过颜色属性维持近似平衡，查找、插入、删除时间复杂度均为O(log n)。 堆是一种特殊的完全二叉树，分为大顶堆和小顶堆。大顶堆每个结点的值都大于或等于其左右孩子结点的值。堆排序利用堆的性质进行排序，时间复杂度O(', 256, 466218070695941700, '2026-05-12 20:34:18', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (9, 2, 2, '小顶堆。大顶堆每个结点的值都大于或等于其左右孩子结点的值。堆排序利用堆的性质进行排序，时间复杂度O(nlog n)。 哈夫曼树（最优二叉树）是带权路径长度WPL最小的二叉树，用于数据压缩编码。哈夫曼编码是前缀编码，任何字符的编码都不是另一个字符编码的前缀。 ## 四、图 图G由顶点集V和边集E组成。按边有无方向分为有向图和无向图；按边是否带权值分为带权图和不带权图。 图的存储结构：邻接矩阵用二维数组存储顶点间关系，空间复杂度O(n^2)，适合稠密图；邻接表为每个顶点建立单链表存储其邻接点，空间复杂度O(n+e)，适合稀疏图。 图的遍历：深度优先搜索（DFS）类似树的前序遍历，用递归或栈实现；广度优先搜索（BFS）类似树的层序遍历，用队列实现。DFS和BFS的时间复杂度在邻接表存储下均为O(n+e)。 最小生成树：Prim算法从任意顶点开始逐步扩展，适合稠密图，时间复杂度O(n^2)；Kruskal算法按边权递增顺序选取，适合稀疏图，时间复杂度O(e log e)。 最短路径：Dijkstra算法求单源最短路径，要求边权非负，时间复杂度O(n^2)；Floyd算法求任意两点间最短路径，时间复杂度O(n^3)。 ', 256, 466218070695941701, '2026-05-12 20:34:18', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (10, 2, 3, '要求边权非负，时间复杂度O(n^2)；Floyd算法求任意两点间最短路径，时间复杂度O(n^3)。 拓扑排序是对有向无环图（DAG）顶点的线性排序，常用BFS入度表法实现。关键路径是AOE网中从源点到汇点的最长路径，决定工程的最短完成时间。 ## 五、查找 顺序查找从表的一端开始逐个比较，平均查找长度ASL为(n+1)/2，适用于顺序表和链表。 折半查找（二分查找）要求查找表为有序顺序表。每次将查找范围缩小一半，时间复杂度O(log n)。判定树可用于分析查找过程。 分块查找（索引顺序查找）将表分成若干块，块间有序、块内无序，建立索引表。查找效率介于顺序查找和折半查找之间。 二叉搜索树的查找效率取决于树的高度，最坏情况下退化为链表，时间复杂度O(n)。 散列表（哈希表）通过散列函数H(key)建立关键字与存储位置的映射。处理冲突的方法：开放定址法（线性探测、二次探测、伪随机探测）和链地址法。散列表的平均查找长度取决于装填因子α，α越大越容易冲突。 ## 六、排序 内部排序按算法复杂度分为：简单排序（冒泡、选择、插入）时间复杂度O(n^2)；先进排序（快速、归并、堆排序）时间复杂度O(nlog n)；基数排序时', 256, 466218070695941702, '2026-05-12 20:34:19', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (11, 2, 4, '插入）时间复杂度O(n^2)；先进排序（快速、归并、堆排序）时间复杂度O(nlog n)；基数排序时间复杂度O(d(n+r))。 冒泡排序通过相邻元素两两比较交换，每趟将最大元素移到末尾。改进版增加标志位判断是否发生交换。 快速排序采用分治思想，选取基准元素将序列划分为两个子序列，递归排序。平均时间复杂度O(nlog n)，最坏O(n^2)。优化方法包括三数取中法选基准和小数组转插入排序。 归并排序将两个有序表合并成一个有序表，采用分治递归。需要O(n)辅助空间，是稳定排序。 堆排序利用大顶堆进行选择排序。建堆时间复杂度O(n)，每次调整O(log n)，总时间复杂度O(nlog n)，不稳定。 直接插入排序将待排序元素插入到已排序序列的适当位置。希尔排序是插入排序的改进，通过缩小增量分组排序，时间复杂度约为O(n^1.3)。 简单选择排序每趟选出最小元素与当前趟首位交换。堆排序对选择排序的改进在于用堆来选择最值。 计数排序适用于取值范围有限的整数排序，统计每个值的出现次数，时间复杂度O(n+k)。桶排序将数据分到有限数量的桶里，每个桶分别排序。基数排序按位数从低位到高位依次排序，适用于整数和字符串。', 254, 466218070695941703, '2026-05-12 20:34:19', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (12, 2, 5, '分到有限数量的桶里，每个桶分别排序。基数排序按位数从低位到高位依次排序，适用于整数和字符串。', 23, 466218070695941704, '2026-05-12 20:34:19', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (13, 3, 0, '# 操作系统核心知识 ## 一、操作系统概述 操作系统是管理计算机硬件与软件资源的系统软件，也是计算机系统的内核与基石。操作系统的基本功能包括进程管理、内存管理、文件管理、设备管理和用户接口。 操作系统分类：批处理系统、分时系统、实时系统、网络操作系统、分布式操作系统。现代主流操作系统包括Windows、Linux、macOS、Android、iOS等。 ## 二、进程与线程 进程是程序的一次执行过程，是系统资源分配和调度的基本单位。进程具有动态性、并发性、独立性和异步性等特征。进程由程序段、数据段和进程控制块（PCB）组成。PCB包含进程标识符、进程状态、程序计数器、寄存器、内存管理信息等。 进程状态包括创建、就绪、运行、阻塞和终止。就绪态进程等待CPU调度，运行态进程占用CPU执行，阻塞态进程等待某事件发生。状态转换由调度程序控制。 线程是进程内的一个执行单元，是CPU调度的基本单位。同一进程内的线程共享进程的地址空间和资源，但拥有独立的栈和寄存器。线程切换开销远小于进程切换。 多线程模型：用户级线程（由线程库管理，内核感知不到）和内核级线程（由操作系统内核管理）。混合模型结合两者优势。 ## 三、进程同', 256, 466218070695945142, '2026-05-12 20:47:18', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (14, 3, 1, '程库管理，内核感知不到）和内核级线程（由操作系统内核管理）。混合模型结合两者优势。 ## 三、进程同步与死锁 临界资源是一次仅允许一个进程使用的共享资源。临界区是访问临界资源的代码段。同步机制应满足互斥、前进、有限等待和让权等待四个条件。 信号量是一种用于进程同步的变量。P操作（wait）使信号量减1，V操作（signal）使信号量加1。二元信号量（互斥锁）取值0或1，用于实现互斥；计数信号量用于控制资源数量。 经典同步问题：生产者-消费者问题、读者-写者问题、哲学家就餐问题。这些问题的解决方案展示了信号量和互斥锁的实际应用。 死锁是多个进程因争夺资源而无限等待的状态。死锁产生的四个必要条件：互斥条件、请求保持条件、不可抢占条件、循环等待条件。破坏任一条件即可预防死锁：破坏互斥（不可行，因为互斥是资源固有特性）、破坏请求保持（一次性申请全部资源）、破坏不可抢占（允许抢占资源）、破坏循环等待（按序申请资源）。 银行家算法通过判断系统是否处于安全状态来避免死锁。安全状态是存在一个安全序列，按此序列分配资源不会导致死锁。死锁检测和恢复是在死锁发生后通过撤销进程或抢占资源来解除。 ## 四、内存管理 内存管理的目标：', 256, 466218070695945143, '2026-05-12 20:47:18', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (15, 3, 2, '锁。死锁检测和恢复是在死锁发生后通过撤销进程或抢占资源来解除。 ## 四、内存管理 内存管理的目标：地址转换、内存分配、内存保护、内存扩充。 连续分配：单一连续分配（仅用于单道系统）、固定分区分配（产生内部碎片）、动态分区分配（产生外部碎片）。动态分区分配算法：首次适应（FF）、循环首次适应（NF）、最佳适应（BF）、最差适应（WF）。 离散分配：分页存储管理将进程的逻辑地址空间和物理内存都分成固定大小的页和页框。页表记录逻辑页号到物理页框号的映射。地址转换通过页表实现，每次访存需要两次内存访问（页表+数据），快表（TLB）缓存页表项以加速转换。 分段存储管理按程序逻辑段（如代码段、数据段、栈段）进行分配。段表记录段号、段长和段基址。段页式管理结合分段和分页的优势。 虚拟内存允许进程的部分地址空间驻留在外存，实现逻辑地址空间大于物理内存。虚拟内存基于程序执行的局部性原理。请求分页在基本分页基础上增加了缺页中断处理和页面置换功能。 页面置换算法：最佳置换（OPT，不可实现但作为理论比较基准）、先进先出（FIFO，可能产生Belady异常）、最近最久未使用（LRU，近似最佳）、时钟算法（Clock/NRU，LRU', 256, 466218070695945144, '2026-05-12 20:47:18', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (16, 3, 3, '可能产生Belady异常）、最近最久未使用（LRU，近似最佳）、时钟算法（Clock/NRU，LRU的近似实现）、改进型时钟算法（考虑修改位）。 ## 五、文件系统 文件是信息的逻辑存储单位。文件系统负责文件的组织、存储、检索、命名、共享和保护。 文件的逻辑结构：无结构文件（流式文件）和有结构文件（记录式文件）。文件的物理结构：连续分配（顺序存取效率高，但产生外部碎片）、链接分配（隐式链接和显式链接FAT，无外部碎片但随机存取效率低）、索引分配（每个文件有索引块，支持随机存取，但索引块占用额外空间）。 文件目录结构：单级目录、两级目录、树形目录、无环图目录。目录项包含文件名、文件属性和文件物理地址信息。 文件存储空间管理：空闲表法、空闲链表法、位示图法、成组链接法。位示图用二进制位（0表示空闲、1表示占用）表示磁盘块使用情况，是常用的管理方法。 文件共享：基于索引节点的硬链接共享（多个目录项指向同一inode）和符号链接（软链接，存储目标文件路径）。硬链接不能跨文件系统，删除原文件不影响硬链接；软链接可以跨文件系统，原文件删除后软链接失效。 ## 六、I/O设备管理 I/O控制方式：程序直接控制（轮询）、中断', 256, 466218070695945145, '2026-05-12 20:47:19', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (17, 3, 4, '系统，原文件删除后软链接失效。 ## 六、I/O设备管理 I/O控制方式：程序直接控制（轮询）、中断驱动方式、DMA方式（直接存储器访问，数据块传输由DMA控制器完成）、通道方式（通道是专门负责I/O处理的处理器）。DMA方式下，CPU仅在开始和结束时干预，中间传输由DMA控制器完成。 磁盘调度算法：先来先服务（FCFS，公平但效率低）、最短寻道时间优先（SSTF，可能产生饥饿）、扫描算法（SCAN/电梯算法，磁头单向移动）、循环扫描算法（C-SCAN，磁头单向移动到底后快速返回）。 SPOOLing技术（假脱机）通过在磁盘上建立输入井和输出井，将独占设备改造为共享设备，实现虚拟设备功能，提高了设备利用率和系统效率。', 156, 466218070695945146, '2026-05-12 20:47:19', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (18, 4, 0, '# 计算机网络核心知识 ## 一、计算机网络概述 计算机网络是将分散在不同地理位置的计算机系统通过通信设备和线路连接起来，实现资源共享和数据通信的系统。计算机网络按覆盖范围分为：个域网（PAN）、局域网（LAN）、城域网（MAN）、广域网（WAN）和互联网（Internet）。 计算机网络的性能指标：速率（bps）、带宽（Hz或bps）、吞吐量、时延（发送时延、传播时延、处理时延、排队时延）、时延带宽积、往返时间（RTT）、利用率。 计算机网络体系结构：OSI七层模型（物理层-数据链路层-网络层-传输层-会话层-表示层-应用层）和TCP/IP四层模型（网络接口层-网际层-传输层-应用层）。实际教学中通常使用五层模型：物理层-数据链路层-网络层-传输层-应用层。 ## 二、物理层 物理层负责在物理媒介上透明传输比特流。主要技术包括信号编码（曼彻斯特编码、差分曼彻斯特编码）、信道复用（频分复用FDM、时分复用TDM、波分复用WDM、码分复用CDM）。 香农定理给出了信道容量的理论上限：C = W × log2(1 + S/N)，其中C为信道容量，W为信道带宽，S/N为信噪比。奈奎斯特准则给出了无噪声信道的最大数据', 256, 466218070695945197, '2026-05-12 20:47:30', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (19, 4, 1, '+ S/N)，其中C为信道容量，W为信道带宽，S/N为信噪比。奈奎斯特准则给出了无噪声信道的最大数据率：Cmax = 2W × log2(M)，其中M为信号状态数。 物理层传输介质：双绞线（STP/UTP，用于以太网）、同轴电缆、光纤（单模和多模，利用全反射原理）、无线介质（无线电波、微波、红外线、激光）。 ## 三、数据链路层 数据链路层负责将网络层的数据报封装成帧，在相邻结点间可靠传输。主要功能：成帧、差错控制、流量控制、介质访问控制。 成帧方法：字符计数法、字符填充法（用特殊字符标记帧边界）、零比特填充法（每5个连续的1后插入一个0）、违规编码法。 差错检测：奇偶校验码、循环冗余校验（CRC）。CRC生成多项式如CRC-16和CRC-32广泛应用于网络协议。检验和（Checksum）用于IP头部检验。 点对点协议（PPP）：广泛用于广域网链路。包含LCP（链路控制协议）建立、配置和测试链路，NCP（网络控制协议）支持多种网络层协议。 介质访问控制（MAC）：信道划分协议（FDM/TDM/CDMA）、随机接入协议（ALOHA、CSMA、CSMA/CD、CSMA/CA）和轮流协议（令牌传递、轮询）。 CSM', 256, 466218070695945198, '2026-05-12 20:47:30', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (20, 4, 2, '入协议（ALOHA、CSMA、CSMA/CD、CSMA/CA）和轮流协议（令牌传递、轮询）。 CSMA/CD（载波监听多点接入/碰撞检测）是以太网的核心协议：先听后发、边听边发、冲突停发、随机重发。使用截断二进制指数退避算法确定重传等待时间。 CSMA/CA（碰撞避免）是无线局域网的核心协议，使用RTS/CTS握手机制预约信道，减少碰撞概率。 以太网帧格式：目的MAC地址（6B）+ 源MAC地址（6B）+ 类型/长度（2B）+ 数据（46-1500B）+ FCS校验（4B）。MAC地址共48位，前24位为厂商标识，后24位为设备标识。 交换机通过自学习算法建立MAC地址表，实现帧的转发和过滤。生成树协议（STP）用于消除环路。 ## 四、网络层 网络层负责将分组从源主机路由到目的主机。核心功能：路由选择和分组转发。 IP协议是TCP/IP体系的核心协议。IPv4地址为32位，采用点分十进制表示，分为A/B/C/D/E五类地址。CIDR（无类别域间路由）使用网络前缀代替分类地址，斜线记法如192.168.1.0/24。 子网划分：从主机号中借用若干位作为子网号，子网掩码用于区分网络位和主机位。VLSM（可变长子', 256, 466218070695945199, '2026-05-12 20:47:30', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (21, 4, 3, '24。 子网划分：从主机号中借用若干位作为子网号，子网掩码用于区分网络位和主机位。VLSM（可变长子网掩码）允许对一个网络使用不同长度的子网掩码。 特殊IP地址：网络地址（主机号全0）、广播地址（主机号全1）、环回地址（127.0.0.1）、私有地址（10.0.0.0/8、172.16.0.0/12、192.168.0.0/16）。 IPv6地址为128位，采用冒号十六进制表示。IPv6相比IPv4的改进：更大的地址空间、更简洁的首部格式、更好的QoS支持、原生支持IPSec安全机制。 ARP（地址解析协议）用于通过IP地址获取MAC地址，工作于广播域内。RARP（逆ARP）通过MAC地址获取IP地址，已被DHCP取代。 ICMP（互联网控制报文协议）用于报告网络错误和诊断信息。PING命令使用ICMP回显请求和回显应答。Traceroute利用ICMP超时报文追踪路由路径。 路由选择协议：内部网关协议包括RIP（基于距离向量算法，最大跳数15）、OSPF（基于链路状态算法，使用Dijkstra最短路径）、EIGRP（思科专有，混合型）。外部网关协议主要是BGP-4（边界网关协议，基于路径向量算法，是互联网的', 256, 466218070695945200, '2026-05-12 20:47:30', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (22, 4, 4, 'GRP（思科专有，混合型）。外部网关协议主要是BGP-4（边界网关协议，基于路径向量算法，是互联网的核心路由协议）。 NAT（网络地址转换）允许多个主机共享一个公网IP地址访问互联网，通过映射表转换私有地址和公网地址及端口号。 ## 五、传输层 传输层为应用进程间提供端到端的逻辑通信。两个主要协议：TCP和UDP。 UDP（用户数据报协议）是无连接的尽最大努力交付协议，首部仅8字节（源端口、目的端口、长度、检验和）。适用于DNS查询、流媒体、实时通信等对实时性要求高的场景。 TCP（传输控制协议）是面向连接的可靠传输协议。TCP首部20字节固定部分加可变选项。关键字段：序号（字节流编号）、确认号（期望收到的下一字节序号）、窗口（流量控制）、标志位（SYN/ACK/FIN/RST/PSH/URG）。 TCP连接管理：三次握手建立连接（SYN → SYN+ACK → ACK），四次挥手释放连接（FIN → ACK → FIN → ACK）。TIME-WAIT状态持续2MSL时间确保最后一个ACK到达。 TCP可靠传输：超时重传（自适应超时算法）、累计确认、选择确认（SACK）。TCP流量控制使用滑动窗口机制，接收', 256, 466218070695945201, '2026-05-12 20:47:30', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (23, 4, 5, '输：超时重传（自适应超时算法）、累计确认、选择确认（SACK）。TCP流量控制使用滑动窗口机制，接收方通过窗口字段告知发送方可接收的字节数。 TCP拥塞控制：慢开始（指数增长拥塞窗口）、拥塞避免（线性增长）、快重传（收到3个重复ACK直接重传）、快恢复（将拥塞窗口减半而非降到1）。拥塞窗口cwnd和慢开始门限ssthresh共同控制发送速率。 ## 六、应用层 DNS（域名系统）：将域名解析为IP地址的分层分布式数据库。域名空间是树形结构，根域、顶级域（gTLD和ccTLD）、二级域、子域。递归查询和迭代查询两种解析方式。 HTTP（超文本传输协议）：无状态的请求-响应协议。HTTP/1.0每请求一个对象建立一次TCP连接；HTTP/1.1支持持久连接和流水线；HTTP/2采用二进制分帧、头部压缩和多路复用；HTTP/3基于QUIC协议。 HTTPS是HTTP over TLS/SSL，通过证书认证和加密通信确保安全性。TLS握手过程：ClientHello → ServerHello + 证书 → 密钥交换 → 加密通信。 FTP（文件传输协议）使用控制连接（端口21）和数据连接（端口20），支持主动模式和', 256, 466218070695945202, '2026-05-12 20:47:31', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (24, 4, 6, '→ 加密通信。 FTP（文件传输协议）使用控制连接（端口21）和数据连接（端口20），支持主动模式和被动模式。 SMTP用于发送邮件（端口25），POP3（端口110）和IMAP（端口143）用于接收邮件。 DHCP（动态主机配置协议）自动分配IP地址。过程：DHCP Discover → Offer → Request → ACK。', 84, 466218070695945203, '2026-05-12 20:47:31', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (25, 5, 0, '# 数据库原理核心知识 ## 一、数据库系统概述 数据库是长期存储在计算机内、有组织、可共享的大量数据的集合。数据库管理系统（DBMS）是管理数据库的系统软件，提供数据定义、数据操纵、数据控制等功能。 数据模型的三要素：数据结构、数据操作和完整性约束。层次模型（树形结构）、网状模型（图结构）和关系模型（二维表结构）是三种主要的数据模型。关系模型由E.F.Codd于1970年提出，是目前最广泛使用的数据模型。 数据库系统的三级模式结构：外模式（用户视图）、模式（逻辑模式）和内模式（存储模式）。两级映像：外模式/模式映像和模式/内模式映像，实现了数据的逻辑独立性和物理独立性。 ## 二、关系数据库 关系是一组域的笛卡尔积的子集，直观上是一个二维表。关系模型的术语：关系（表）、元组（行）、属性（列）、候选码（能唯一标识元组的最小属性组）、主码（选定的候选码）、外码（引用其他关系主码的属性）。 关系代数是以关系为运算对象的一组高级运算集合。基本运算：并（∪）、差（-）、笛卡尔积（×）、选择（σ）、投影（π）。派生运算：交（∩）、连接（⋈，包括等值连接、自然连接、外连接）和除（÷）。 完整性约束：实体完整性（主码不能为', 256, 466218070697146637, '2026-05-12 20:47:41', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (26, 5, 1, '交（∩）、连接（⋈，包括等值连接、自然连接、外连接）和除（÷）。 完整性约束：实体完整性（主码不能为空）、参照完整性（外码必须匹配被参照关系的主码或为空）和用户定义完整性（如年龄不能为负）。这些约束保证了数据库的一致性。 ## 三、SQL语言 SQL（结构化查询语言）是关系数据库的标准语言，由ANSI和ISO标准化。SQL是集DDL、DML、DCL于一体的非过程化语言。 数据定义（DDL）：CREATE创建数据库对象（TABLE、INDEX、VIEW）；ALTER修改对象结构；DROP删除对象。数据类型包括INT、VARCHAR(n)、DECIMAL(p,s)、DATE、TIMESTAMP等。 数据查询（DML核心）：SELECT语句的基本结构为SELECT-FROM-WHERE-GROUP BY-HAVING-ORDER BY。执行顺序为FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY。 连接查询：INNER JOIN返回匹配行；LEFT JOIN返回左表所有行；RIGHT JOIN返回右表所有行；FULL JOIN返回所有行。自连接将表与自身进行连接', 256, 466218070697146638, '2026-05-12 20:47:42', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (27, 5, 2, '表所有行；RIGHT JOIN返回右表所有行；FULL JOIN返回所有行。自连接将表与自身进行连接。 子查询：嵌套在另一个查询中的SELECT语句。标量子查询返回单个值；行子查询返回单行；列子查询返回单列多行；表子查询返回多行多列。相关子查询引用外部查询的属性值。EXISTS和NOT EXISTS用于检查子查询是否返回行。 集合操作：UNION（合并去重）、INTERSECT（交集）、EXCEPT（差集）。UNION ALL保留重复行。 窗口函数：ROW_NUMBER()生成行号；RANK()和DENSE_RANK()生成排名（处理平局方式不同）；SUM() OVER()计算累计和。 数据操纵（DML）：INSERT INTO插入行；UPDATE修改行；DELETE FROM删除行。事务控制语句包括COMMIT和ROLLBACK。 ## 四、数据库设计 数据库设计分为需求分析、概念结构设计、逻辑结构设计、物理结构设计、实施和运行维护六个阶段。 概念结构设计使用E-R模型（实体-联系模型）。实体用矩形表示，属性用椭圆表示，联系用菱形表示。联系类型：一对一（1:1）、一对多（1:N）、多对多（M:N）。 E-R', 256, 466218070697146639, '2026-05-12 20:47:42', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (28, 5, 3, '用椭圆表示，联系用菱形表示。联系类型：一对一（1:1）、一对多（1:N）、多对多（M:N）。 E-R图向关系模型的转换：实体转换为关系模式；1:1联系可与任一端合并；1:N联系可与N端合并；M:N联系必须转为独立关系模式，包含两端主码作为外码。 规范化理论：函数依赖是指属性集X决定属性集Y（记为X→Y）。部分函数依赖、完全函数依赖和传递函数依赖用于判定范式等级。 范式等级：第一范式（1NF）要求属性不可再分；第二范式（2NF）要求消除部分函数依赖；第三范式（3NF）要求消除传递函数依赖；BCNF（巴斯-科德范式）要求每一个决定因素都包含候选码。第四范式（4NF）消除多值依赖。 通常在实际应用中，达到3NF或BCNF是合理的平衡点。规范化避免数据冗余和更新异常，但可能导致查询时需要更多连接操作。反规范化在性能要求高的场景下可能有意引入冗余。 ## 五、事务与并发控制 事务是用户定义的一组数据库操作序列，是不可分割的工作单位。事务具有ACID特性：原子性（Atomicity，要么全做要么全不做）、一致性（Consistency，事务前后数据库保持一致性状态）、隔离性（Isolation，并发事务互不干扰）、持久性', 256, 466218070697146640, '2026-05-12 20:47:42', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (29, 5, 4, 'stency，事务前后数据库保持一致性状态）、隔离性（Isolation，并发事务互不干扰）、持久性（Durability，已提交事务的修改永久保存）。 并发操作可能引发的问题：丢失修改（两个事务同时修改同一数据）、不可重复读（同一事务两次读取结果不同）、脏读（读到未提交的修改）、幻读（同一事务两次查询返回不同行数）。 封锁是实现并发控制的基本方法。排他锁（X锁，写锁）禁止其他事务再加任何锁；共享锁（S锁，读锁）允许其他事务加S锁但禁止加X锁。两段锁协议保证可串行化：所有加锁操作在解锁操作之前。 事务隔离级别（SQL标准）：读未提交（Read Uncommitted，允许脏读）；读已提交（Read Committed，禁止脏读，大多数数据库默认）；可重复读（Repeatable Read，禁止脏读和不可重复读，MySQL InnoDB默认）；可串行化（Serializable，禁止所有并发问题）。 快照隔离（MVCC多版本并发控制）通过维护数据的多个版本来实现高并发。InnoDB的MVCC基于undo log和ReadView实现，读操作不阻塞写操作。 ## 六、索引与查询优化 索引是加速数据检索的数据结构。', 256, 466218070697146641, '2026-05-12 20:47:42', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (30, 5, 5, 'ReadView实现，读操作不阻塞写操作。 ## 六、索引与查询优化 索引是加速数据检索的数据结构。B+树索引是最常用的数据库索引结构。B+树所有数据记录存储在叶子结点，内部结点仅存储索引键值用于导航。叶子结点通过双向链表连接，支持范围查询和顺序扫描。B+树的阶数决定每个结点的最大子结点数，通常与磁盘页大小匹配。 聚集索引决定表中数据的物理存储顺序，每张表只能有一个聚集索引。非聚集索引存储索引键值和指向数据行的指针（书签或聚集索引键）。 哈希索引基于哈希表，支持等值查询（O(1)），但无法支持范围查询。位图索引适用于基数较低的列。 复合索引按列顺序组织，符合最左前缀匹配原则。覆盖索引是指索引包含查询所需的所有列，避免回表查询。 查询优化：EXPLAIN命令分析执行计划。type字段（访问类型）从好到差：system > const > eq_ref > ref > range > index > ALL。优化策略包括创建合适的索引、避免在WHERE子句中对列使用函数、使用覆盖索引、小表驱动大表、避免SELECT *等。', 233, 466218070697146642, '2026-05-12 20:47:42', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (31, 5, 6, ' *等。', 2, 466218070697146643, '2026-05-12 20:47:43', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (32, 6, 0, '# 算法设计与分析核心知识 ## 一、算法基础 算法是解决特定问题求解步骤的描述，是有限序列的指令集合。算法的五大特征：有穷性、确定性、可行性、输入和输出。 算法分析的两个核心指标：时间复杂度和空间复杂度。时间复杂度T(n)是算法执行时间随输入规模n增长的增长率。使用大O记号表示渐进上界。常见时间复杂度从小到大排列：O(1) < O(log n) < O(n) < O(nlog n) < O(n²) < O(n³) < O(2ⁿ) < O(n!)。 渐进记号：大O（上界）、大Ω（下界）、大Θ（紧界）。空间复杂度S(n)是算法需要的额外存储空间。 ## 二、分治法 分治法将原问题分解为若干个规模较小的子问题，递归求解子问题，然后合并子问题的解。分治法的步骤：分解（Divide）、解决（Conquer）、合并（Combine）。 归并排序是典型的分治算法。将数组递归地分成两半，分别排序，然后合并两个有序子数组。归并排序是稳定的，时间复杂度O(nlog n)，空间复杂度O(n)。 快速排序通过选取基准元素分区，递归排序左右子区间。平均时间复杂度O(nlog n)，最坏O(n²)。空间复杂度O(log n)（递归栈深', 256, 466218070695945256, '2026-05-12 20:47:52', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (33, 6, 1, '序左右子区间。平均时间复杂度O(nlog n)，最坏O(n²)。空间复杂度O(log n)（递归栈深度）。 最大子数组问题：寻找数组中连续子数组使其和最大。分治解法将数组二分，最大子数组可能完全在左半部分、完全在右半部分或跨越中点。Kadane算法给出了O(n)的动态规划解法。 Strassen矩阵乘法：将两个n×n矩阵相乘的分治算法。通过7次子矩阵乘法（而非直接分治的8次）将时间复杂度从O(n³)降为约O(n^2.81)。 ## 三、动态规划 动态规划用于求解具有最优子结构和重叠子问题性质的优化问题。核心思想是用空间换时间，存储子问题结果避免重复计算。 动态规划的基本步骤：分析最优解的结构特征、递归定义最优解的值、自底向上计算最优值、根据计算结果构造最优解。 背包问题：0-1背包（每种物品只能选一次）用二维DP，f[i][j]表示前i件物品放入容量j的背包的最大价值。完全背包（每种物品可选无限次）优化为一维DP。多重背包（每种物品有限件）可二进制拆分优化。 最长公共子序列（LCS）：求两个序列的最长公共子序列。状态转移：若x[i]=y[j]，则f[i][j]=f[i-1][j-1]+1；否则f[i][j]=', 256, 466218070695945257, '2026-05-12 20:47:52', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (34, 6, 2, '。状态转移：若x[i]=y[j]，则f[i][j]=f[i-1][j-1]+1；否则f[i][j]=max(f[i-1][j], f[i][j-1])。 最长递增子序列（LIS）：求数组中严格递增的最长子序列长度。O(n²)的DP解法；O(nlog n)的贪心+二分解法使用tails数组来记录各长度递增子序列的最小末尾值。 编辑距离：将一个字符串转换为另一个字符串的最少操作次数（增删改）。状态转移与LCS类似，广泛应用于拼写检查和DNA序列比对。 矩阵链乘法：选择最优的矩阵乘法顺序使标量乘法次数最少。m[i][j]记录从矩阵i到j的最少乘法次数。 Floyd-Warshall算法：求所有顶点对间的最短路径。d[i][j] = min(d[i][j], d[i][k] + d[k][j])，O(n³)。 ## 四、贪心算法 贪心算法在每一步都选择当前看起来最优的选择，不考虑整体最优。贪心算法需要证明贪心选择性质和最优子结构性质。 活动选择问题：选择最多互不重叠的活动。贪心策略：按结束时间排序，每次选择结束最早且不冲突的活动。可证明此贪心策略得到最优解。 哈夫曼编码：根据字符出现频率构建最优前缀编码。贪心策略：每', 256, 466218070695945258, '2026-05-12 20:47:52', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (35, 6, 3, '冲突的活动。可证明此贪心策略得到最优解。 哈夫曼编码：根据字符出现频率构建最优前缀编码。贪心策略：每次从优先队列取出频率最小的两个结点合并为新结点，重复直到只剩一个根结点。哈夫曼编码是平均码长最短的前缀编码。 最小生成树：Prim算法从任意顶点开始，每次选择与当前生成树相连的最小权边；Kruskal算法每次选择全局最小权边（不构成环）。两者都是贪心算法且得到最优解。 Dijkstra最短路径：从源点开始，每次选择距离最短的未访问顶点，并松弛其邻接点。要求边权非负。 ## 五、搜索与回溯 深度优先搜索（DFS）沿着一条路径走到底，回溯后再尝试其他路径。使用递归或栈实现。适用于连通性判断、拓扑排序、二分图检测、强连通分量等问题。 广度优先搜索（BFS）逐层扩展，使用队列实现。适用于最短路径（无权图）、层次遍历等。BFS在无权图中找到的路径是最短路径。 回溯法是系统搜索问题解空间的方法。从根结点出发，按深度优先策略搜索解空间树。当搜索到某一结点发现不可能得到解时，回溯到父结点尝试其他分支。 N皇后问题：在N×N棋盘上放置N个皇后使互不攻击。回溯法逐行放置皇后，检查是否与已放置的皇后冲突（同列、同对角线）。 子集和问', 256, 466218070695945259, '2026-05-12 20:47:53', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (36, 6, 4, '放置N个皇后使互不攻击。回溯法逐行放置皇后，检查是否与已放置的皇后冲突（同列、同对角线）。 子集和问题：判断是否存在子集其元素之和等于目标值。回溯法枚举每个元素选或不选，通过剪枝（剩余元素和小于目标、当前和超出目标）提高效率。 图的着色问题：用最少颜色给图顶点着色，使相邻顶点颜色不同。回溯法尝试为每个顶点分配颜色，Welsh-Powell算法给出了贪心近似解。 ## 六、字符串匹配算法 朴素匹配：逐个比较模式串和文本串的每个位置，最坏时间复杂度O(mn)。 KMP算法利用模式串的部分匹配表（next数组）实现高效跳跃。next[i]表示模式串前i个字符的最长相同前后缀长度。匹配失败时模式串右移i-next[i]位。时间复杂度O(m+n)。 Boyer-Moore算法从右向左匹配，使用坏字符规则和好后缀规则决定跳跃距离。在实践中最快，尤其适合大字符集。 Rabin-Karp算法使用哈希指纹比较子串。通过滚动哈希在O(1)时间内计算下一个子串的哈希值。需要处理哈希冲突。 ## 七、计算复杂性理论 P类问题：可以在多项式时间内用确定性算法求解的问题。 NP类问题：可以在多项式时间内用非确定性算法求解的问题（即给定一', 256, 466218070695945260, '2026-05-12 20:47:53', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (37, 6, 5, '项式时间内用确定性算法求解的问题。 NP类问题：可以在多项式时间内用非确定性算法求解的问题（即给定一个解，可以在多项式时间内验证）。 NP完全问题：属于NP类，且所有NP问题都可以多项式归约到它的问题。如布尔可满足性问题（SAT）、旅行商问题（TSP）、顶点覆盖问题、子集和问题等。 NP难问题：至少与NP完全问题一样难，但不一定属于NP类。 遇到NP完全问题时，可使用近似算法（如最小顶点覆盖的2-近似算法）、参数化算法、启发式算法或对小规模输入使用精确算法。', 115, 466218070695945261, '2026-05-12 20:47:53', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (38, 7, 0, '# Java程序设计核心知识 ## 一、Java语言基础 Java是Sun Microsystems公司于1995年发布的面向对象编程语言。Java的设计目标：简单性、面向对象、分布式、健壮性、安全性、体系结构中立、可移植性、解释执行、高性能、多线程和动态性。 Java运行机制：源代码（.java）经编译器（javac）编译为字节码（.class），再由JVM（Java虚拟机）解释执行或JIT即时编译为本地机器码。这种\"一次编写、到处运行\"的特性是Java跨平台的基础。 JVM内存区域：方法区（存储类信息、常量、静态变量）、堆（对象实例和数组，GC管理的主区域）、虚拟机栈（线程私有，存储局部变量表、操作数栈等）、本地方法栈、程序计数器。 ## 二、面向对象编程 面向对象的三大特征：封装、继承、多态。 封装隐藏对象的内部状态和行为实现细节，仅对外暴露公开接口。通过访问修饰符实现：private（本类可见）、default（同包可见）、protected（同包和子类可见）、public（全局可见）。 继承允许一个类（子类）继承另一个类（父类）的属性和方法。Java是单继承（一个类只能有一个直接父类），但可以通过接', 256, 466218070695945265, '2026-05-12 20:48:02', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (39, 7, 1, '（子类）继承另一个类（父类）的属性和方法。Java是单继承（一个类只能有一个直接父类），但可以通过接口实现多继承效果。子类使用extends关键字继承父类，通过super调用父类构造器和方法。 多态是指同一操作作用于不同对象表现出不同行为。重载（编译时多态）：同方法名，参数列表不同；重写（运行时多态）：子类重写父类方法，通过父类引用指向子类对象实现动态绑定。 抽象类（abstract）可以有抽象方法（无方法体）和具体方法，不能被实例化，必须被子类继承并实现其抽象方法。接口（interface）在Java 8后可以包含默认方法和静态方法，接口的方法默认是public abstract。 内部类定义在另一个类内部的类。静态内部类不持有外部类引用；成员内部类持有外部类引用；局部内部类定义在方法内；匿名内部类通常用于简化接口实现。 ## 三、异常处理 Java异常体系：Throwable是所有异常和错误的根类。Error表示JVM无法处理的严重问题（如OutOfMemoryError、StackOverflowError），不应被捕获。Exception分为检查异常（Checked Exception，编译时强制处理', 256, 466218070695945266, '2026-05-12 20:48:02', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (40, 7, 2, 'r），不应被捕获。Exception分为检查异常（Checked Exception，编译时强制处理，如IOException、SQLException）和非检查异常（Unchecked Exception，运行时异常，如NullPointerException、IndexOutOfBoundsException）。 异常处理机制：try块包含可能抛出异常的代码；catch块捕获并处理特定类型的异常（可多个，按子类到父类顺序）；finally块无论是否发生异常都会执行（通常用于释放资源）。try-with-resources（Java 7+）自动关闭实现了AutoCloseable接口的资源。 自定义异常：继承Exception（检查异常）或RuntimeException（非检查异常），提供构造器以设置异常消息。 ## 四、集合框架 Java集合框架提供了一套统一的数据结构接口和实现。 Collection接口：List（有序、可重复，ArrayList基于数组、LinkedList基于双向链表、Vector线程安全）、Set（无序、不可重复，HashSet基于HashMap、TreeSet基于TreeMa', 256, 466218070695945267, '2026-05-12 20:48:02', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (41, 7, 3, '线程安全）、Set（无序、不可重复，HashSet基于HashMap、TreeSet基于TreeMap实现排序）、Queue（队列，LinkedList实现了Deque双端队列、PriorityQueue优先队列）。 Map接口：HashMap（基于哈希表，允许null键值，非线程安全）、LinkedHashMap（维护插入顺序）、TreeMap（基于红黑树，按键排序）、ConcurrentHashMap（线程安全的HashMap，分段锁机制）、Hashtable（遗留类，线程安全但不推荐使用）。 HashMap原理：JDK 8中，HashMap由数组+链表+红黑树实现。通过key的hashCode计算桶索引，哈希冲突时使用链地址法。当链表长度超过8且数组长度≥64时，链表转为红黑树以提高查询效率。默认初始容量16，负载因子0.75，扩容时容量翻倍。 排序接口：Comparable（自然排序，实现compareTo方法）和Comparator（定制排序，实现compare方法）。 ## 五、多线程与并发 创建线程的方式：继承Thread类并重写run方法；实现Runnable接口；实现Callable接口（有', 256, 466218070695945268, '2026-05-12 20:48:02', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (42, 7, 4, '程的方式：继承Thread类并重写run方法；实现Runnable接口；实现Callable接口（有返回值，配合Future使用）；使用线程池（ExecutorService）。 线程的生命周期：NEW（新建）→ RUNNABLE（就绪+运行）→ BLOCKED（阻塞）→ WAITING（无限等待）→ TIMED_WAITING（计时等待）→ TERMINATED（终止）。 synchronized关键字：修饰实例方法锁定this对象；修饰静态方法锁定类的Class对象；修饰代码块锁定指定对象。synchronized是可重入锁。 volatile关键字保证变量对所有线程的可见性，禁止指令重排序，但不保证原子性。 Lock接口（java.util.concurrent.locks）提供比synchronized更灵活的锁操作。ReentrantLock是可重入的排他锁，支持公平锁、可中断获取锁、超时获取锁。ReadWriteLock分离读锁（共享）和写锁（排他），适合读多写少场景。 线程池（Executor框架）：Executors工厂类创建线程池。newFixedThreadPool创建固定大小线程池；ne', 256, 466218070695945269, '2026-05-12 20:48:03', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (43, 7, 5, '）：Executors工厂类创建线程池。newFixedThreadPool创建固定大小线程池；newCachedThreadPool创建可缓存线程池；newSingleThreadExecutor创建单线程池；newScheduledThreadPool支持定时和周期任务。实际开发推荐使用ThreadPoolExecutor直接指定参数，避免Executors可能的OOM风险。 ThreadPoolExecutor核心参数：corePoolSize（核心线程数）、maximumPoolSize（最大线程数）、keepAliveTime（空闲线程存活时间）、workQueue（任务队列）、threadFactory（线程工厂）、rejectedExecutionHandler（拒绝策略）。 ## 六、Java新特性 Java 8核心新特性：Lambda表达式（(参数) -> {函数体}）、函数式接口（@FunctionalInterface，如Predicate、Function、Consumer、Supplier）、Stream API（流式操作，filter-map-reduce模式，惰性求值）、Opti', 256, 466218070695945270, '2026-05-12 20:48:03', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (44, 7, 6, 'er）、Stream API（流式操作，filter-map-reduce模式，惰性求值）、Optional类（避免null检查）、新的日期时间API（LocalDate、LocalTime、LocalDateTime、Duration、Period）。 Stream操作分为中间操作（filter过滤、map映射、sorted排序、distinct去重、limit截取、skip跳过）和终端操作（forEach遍历、collect收集、reduce归约、count计数、anyMatch/allMatch/noneMatch匹配、findFirst/findAny查找）。 方法引用：静态方法引用（ClassName::staticMethod）、实例方法引用（instance::method）、特定类型的任意对象方法引用（ClassName::method）、构造器引用（ClassName::new）。 Java 9-17演进：模块化系统（Java 9）、var局部变量类型推断（Java 10）、switch表达式和文本块（Java 14/13）、record记录类（Java 14/16，不可变数据载体）、sea', 256, 466218070695945271, '2026-05-12 20:48:03', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (45, 7, 7, '和文本块（Java 14/13）、record记录类（Java 14/16，不可变数据载体）、sealed密封类（Java 17，限制哪些类可以继承）、Pattern Matching模式匹配（Java 17 preview）。', 57, 466218070695945272, '2026-05-12 20:48:03', NULL, 'upload');
INSERT INTO `knowledge_chunk` VALUES (46, 8, 0, '一元二次方程的标准形式为ax²+bx+c=0（a≠0）。求解方法有三种：一、因式分解法：将方程化为(px+q)(rx+s)=0的形式，则x=-q/p或x=-s/r。二、配方法：将方程变形为(x+b/2a)²=(b²-4ac)/4a²，然后开方求解。三、公式法：使用求根公式x=[-b±√(b²-4ac)]/2a直接计算。判别式Δ=b²-4ac决定根的情况：Δ>0有两个不等实根，Δ=0有两个相等实根，Δ<0无实根。', 103, 466218075175622713, '2026-05-14 21:16:33', '466fb865cbdb18b15c6add864b3653848b3d8ecbfa909617571c7fe550ca5c1b', 'k12textbook');
INSERT INTO `knowledge_chunk` VALUES (47, 9, 0, '勾股定理是几何学中的基本定理，也称为毕达哥拉斯定理。定理内容：在直角三角形中，两条直角边的平方和等于斜边的平方。即a²+b²=c²，其中a和b为直角边，c为斜边。勾股定理的逆定理也成立：如果三角形三边满足a²+b²=c²，则该三角形为直角三角形，且c边所对的角为直角。常见的勾股数有：(3,4,5)、(5,12,13)、(6,8,10)、(7,24,25)、(8,15,17)等。', 95, 466218075175622714, '2026-05-14 21:16:33', '0bf3f9f67f85a2c4c2898b68bca482ce1893e5b9d945d77459c3731c33cf59ee', 'k12textbook');
INSERT INTO `knowledge_chunk` VALUES (48, 10, 0, '三角函数是描述角度与边长关系的函数。基本三角函数包括：正弦函数sin、余弦函数cos、正切函数tan。在直角三角形中，sinA=对边/斜边，cosA=邻边/斜边，tanA=对边/邻边。特殊角的三角函数值需要牢记：sin30°=1/2，sin45°=√2/2，sin60°=√3/2；cos30°=√3/2，cos45°=√2/2，cos60°=1/2；tan30°=√3/3，tan45°=1，tan60°=√3。', 103, 466218075175622715, '2026-05-14 21:16:33', 'd5c3abefe83fa7ef1c732d3fbfb96518662f05ab89dcf3f6e1c5bda1199d1957', 'k12textbook');
INSERT INTO `knowledge_chunk` VALUES (49, 11, 0, '题目：栈和队列的主要区别是什么？答案：栈是后进先出（LIFO）的数据结构，只允许在栈顶进行插入和删除操作；队列是先进先出（FIFO）的数据结构，允许在队尾插入、队首删除。解析：栈的操作包括push（入栈）和pop（出栈），常用场景有函数调用栈、表达式求值、括号匹配等。队列的操作包括enqueue（入队）和dequeue（出队），常用场景有任务调度、消息队列、BFS遍历等。双端队列（Deque）结合了两者特性，允许在两端进行插入和删除。', 109, 466218075175622718, '2026-05-14 21:16:34', '1e0c59b54788747d80710e96106d90ae8433a4d515f2ffeb0f5605acacbd3ede', 'ceval');
INSERT INTO `knowledge_chunk` VALUES (50, 12, 0, '题目：二叉搜索树（BST）的查找时间复杂度是多少？如何保证O(log n)？答案：BST的平均查找时间复杂度为O(log n)，最坏情况下退化为O(n)。为保证O(log n)，需要使用平衡二叉搜索树，如AVL树或红黑树。解析：AVL树通过维护平衡因子（左右子树高度差不超过1）并在插入删除时进行旋转操作来保持平衡。红黑树通过颜色标记和旋转操作满足五条性质：根黑、叶黑、红不邻、同黑高、新红。红黑树在工程中更常用（如Java TreeMap、C++ std::map）。', 117, 466218075175622719, '2026-05-14 21:16:34', 'd15907cd9abe071ea76df6c8df66b792dedbafd069955970a56de174b4498f16', 'ceval');
INSERT INTO `knowledge_chunk` VALUES (51, 13, 0, '题目：哈希表的冲突解决方法有哪些？答案：主要分为开放地址法和链地址法。开放地址法包括线性探测、二次探测和双哈希；链地址法使用链表或红黑树存储冲突元素。解析：开放地址法的线性探测容易产生聚集现象；二次探测避免了主聚集但仍存在次聚集；双哈希使用第二个哈希函数计算步长，效果最好。链地址法实现简单，Java的HashMap在链表长度超过8且数组长度≥64时转为红黑树，以提高查找效率。', 94, 466218075175622720, '2026-05-14 21:16:34', 'a684fe6a36807fdfb948388541e4f3008a60a3541c2691cc750cc38d6db59849', 'ceval');
INSERT INTO `knowledge_chunk` VALUES (52, 17, 0, 'Java是Sun Microsystems公司于1995年发布的面向对象编程语言。Java的设计目标：简单性、面向对象、分布式、健壮性、安全性、体系结构中立、可移植性、解释执行、高性能、多线程和动态性。 Java运行机制：源代码（.java）经编译器（javac）编译为字节码（.class），再由JVM（Java虚拟机）解释执行或JIT即时编译为本地机器码。这种\"一次编写、到处运行\"的特性是Java跨平台的基础。 JVM内存区域：方法区（存储类信息、常量、静态变量）、堆（对象实例和数组，GC管理的主区域）、虚拟机栈（线程私有，存储局部变量表、操作数栈等）、本地方法栈、程序计数器。', 146, 466218074913739087, '2026-05-14 21:28:47', '856879cd0affe2e0e1f9677cb9ab2da326865afaa89625e5f6cdd606e76b200e', 'local');
INSERT INTO `knowledge_chunk` VALUES (53, 18, 0, '面向对象的三大特征：封装、继承、多态。 封装隐藏对象的内部状态和行为实现细节，仅对外暴露公开接口。通过访问修饰符实现：private（本类可见）、default（同包可见）、protected（同包和子类可见）、public（全局可见）。 继承允许一个类（子类）继承另一个类（父类）的属性和方法。Java是单继承（一个类只能有一个直接父类），但可以通过接口实现多继承效果。子类使用extends关键字继承父类，通过super调用父类构造器和方法。 多态是指同一操作作用于不同对象表现出不同行为。重载（编译时多态）：同方法名，参数列表不同；重写（运行时多态）：子类重写父类方法，通过父类引用指向子类对象实现动态绑定。 抽象类（abstract）可以有抽象方法（无方法体）和具体方法，不能被实例化，必须被子类继承并实现其抽象方法。接口（interface）在Java 8后可以包含默认方法和静态方法，接口的方法默认是public abstract。 内部类定义在另一个类内部的类。静态内部类不持有外部类引用；成员内部类持有外部类引用；局部内部类定义在方法内；匿名内部类通常用于简化接口实现。', 246, 466218074913739088, '2026-05-14 21:28:47', '77b8f3b7334af7492591c19ead281a35cba54c2a53515a6ae219b7a0ad09c2aa', 'local');
INSERT INTO `knowledge_chunk` VALUES (54, 18, 1, '引用；局部内部类定义在方法内；匿名内部类通常用于简化接口实现。', 15, 466218074913739089, '2026-05-14 21:28:47', '24f1e104fc52638b52b2cbcb9ba34f8bf6a23d4c6e0b8a85e1440a93f7bbb021', 'local');
INSERT INTO `knowledge_chunk` VALUES (55, 19, 0, 'Java异常体系：Throwable是所有异常和错误的根类。Error表示JVM无法处理的严重问题（如OutOfMemoryError、StackOverflowError），不应被捕获。Exception分为检查异常（Checked Exception，编译时强制处理，如IOException、SQLException）和非检查异常（Unchecked Exception，运行时异常，如NullPointerException、IndexOutOfBoundsException）。 异常处理机制：try块包含可能抛出异常的代码；catch块捕获并处理特定类型的异常（可多个，按子类到父类顺序）；finally块无论是否发生异常都会执行（通常用于释放资源）。try-with-resources（Java 7+）自动关闭实现了AutoCloseable接口的资源。 自定义异常：继承Exception（检查异常）或RuntimeException（非检查异常），提供构造器以设置异常消息。', 223, 466218074913739090, '2026-05-14 21:28:47', '5e696900e331ed5c50fbb6458064cc0e7d147bc020b0c1c52d276cc9e922c098', 'local');
INSERT INTO `knowledge_chunk` VALUES (56, 20, 0, 'Java集合框架提供了一套统一的数据结构接口和实现。 Collection接口：List（有序、可重复，ArrayList基于数组、LinkedList基于双向链表、Vector线程安全）、Set（无序、不可重复，HashSet基于HashMap、TreeSet基于TreeMap实现排序）、Queue（队列，LinkedList实现了Deque双端队列、PriorityQueue优先队列）。 Map接口：HashMap（基于哈希表，允许null键值，非线程安全）、LinkedHashMap（维护插入顺序）、TreeMap（基于红黑树，按键排序）、ConcurrentHashMap（线程安全的HashMap，分段锁机制）、Hashtable（遗留类，线程安全但不推荐使用）。 HashMap原理：JDK 8中，HashMap由数组+链表+红黑树实现。通过key的hashCode计算桶索引，哈希冲突时使用链地址法。当链表长度超过8且数组长度≥64时，链表转为红黑树以提高查询效率。默认初始容量16，负载因子0.75，扩容时容量翻倍。 排序接口：Comparable（自然排序，实现compareTo方法）和Compar', 256, 466218074913739091, '2026-05-14 21:28:47', '22ae101227d8b77a8b40ae35896cd59b78a7c38c6b4e655662edcd796af823e1', 'local');
INSERT INTO `knowledge_chunk` VALUES (57, 20, 1, '容时容量翻倍。 排序接口：Comparable（自然排序，实现compareTo方法）和Comparator（定制排序，实现compare方法）。', 36, 466218074913739092, '2026-05-14 21:28:47', 'e8408f1cc9c87b00f40d97d3f80c2717cfd0f5627b08d388c4163744864cd519', 'local');
INSERT INTO `knowledge_chunk` VALUES (58, 21, 0, '创建线程的方式：继承Thread类并重写run方法；实现Runnable接口；实现Callable接口（有返回值，配合Future使用）；使用线程池（ExecutorService）。 线程的生命周期：NEW（新建）→ RUNNABLE（就绪+运行）→ BLOCKED（阻塞）→ WAITING（无限等待）→ TIMED_WAITING（计时等待）→ TERMINATED（终止）。 synchronized关键字：修饰实例方法锁定this对象；修饰静态方法锁定类的Class对象；修饰代码块锁定指定对象。synchronized是可重入锁。 volatile关键字保证变量对所有线程的可见性，禁止指令重排序，但不保证原子性。 Lock接口（java.util.concurrent.locks）提供比synchronized更灵活的锁操作。ReentrantLock是可重入的排他锁，支持公平锁、可中断获取锁、超时获取锁。ReadWriteLock分离读锁（共享）和写锁（排他），适合读多写少场景。 线程池（Executor框架）：Executors工厂类创建线程池。newFixedThreadPool创建固定大小线程池', 256, 466218074913739093, '2026-05-14 21:28:47', '20820a9635f6ee980c018dfe45fa7912f96db5b7a31cd95486348283ec01649f', 'local');
INSERT INTO `knowledge_chunk` VALUES (59, 21, 1, 'r框架）：Executors工厂类创建线程池。newFixedThreadPool创建固定大小线程池；newCachedThreadPool创建可缓存线程池；newSingleThreadExecutor创建单线程池；newScheduledThreadPool支持定时和周期任务。实际开发推荐使用ThreadPoolExecutor直接指定参数，避免Executors可能的OOM风险。 ThreadPoolExecutor核心参数：corePoolSize（核心线程数）、maximumPoolSize（最大线程数）、keepAliveTime（空闲线程存活时间）、workQueue（任务队列）、threadFactory（线程工厂）、rejectedExecutionHandler（拒绝策略）。', 176, 466218074913739094, '2026-05-14 21:28:47', '027fb9c55af631628a54a832b5564c40c666dff7d0f0ebcdcc001fe04da075c8', 'local');
INSERT INTO `knowledge_chunk` VALUES (60, 22, 0, 'Java 8核心新特性：Lambda表达式（(参数) -> {函数体}）、函数式接口（@FunctionalInterface，如Predicate、Function、Consumer、Supplier）、Stream API（流式操作，filter-map-reduce模式，惰性求值）、Optional类（避免null检查）、新的日期时间API（LocalDate、LocalTime、LocalDateTime、Duration、Period）。 Stream操作分为中间操作（filter过滤、map映射、sorted排序、distinct去重、limit截取、skip跳过）和终端操作（forEach遍历、collect收集、reduce归约、count计数、anyMatch/allMatch/noneMatch匹配、findFirst/findAny查找）。 方法引用：静态方法引用（ClassName::staticMethod）、实例方法引用（instance::method）、特定类型的任意对象方法引用（ClassName::method）、构造器引用（ClassName::new）。 Java 9-', 256, 466218074913739095, '2026-05-14 21:28:47', 'd214aca1025056ff45db3d258c7de381a90d61cac70d2389abe0141677bb6d74', 'local');
INSERT INTO `knowledge_chunk` VALUES (61, 22, 1, '（ClassName::method）、构造器引用（ClassName::new）。 Java 9-17演进：模块化系统（Java 9）、var局部变量类型推断（Java 10）、switch表达式和文本块（Java 14/13）、record记录类（Java 14/16，不可变数据载体）、sealed密封类（Java 17，限制哪些类可以继承）、Pattern Matching模式匹配（Java 17 preview）。', 106, 466218074913739096, '2026-05-14 21:28:47', 'a043be8e79ecdf74a8cc6ff3feb234e02a579bcd4a56443fd4c4f6c8b3061773', 'local');
INSERT INTO `knowledge_chunk` VALUES (62, 23, 0, '夏朝是中国史书中记载的第一个世袭制王朝，约公元前2070年至公元前1600年。大禹治水三过家门而不入，其子启建立夏朝，世袭制取代禅让制。 商朝（约公元前1600年-公元前1046年）是中国有直接文字记载（甲骨文）的第一个王朝。青铜器铸造技术成熟，后母戊鼎是现存最大的青铜器。盘庚迁殷后商朝稳定发展。 西周（公元前1046年-公元前771年）实行分封制和宗法制。周公旦制礼作乐，奠定了中国古代政治制度的基础。公元前841年国人暴动导致共和行政，是中国历史有确切纪年的开始。 春秋战国（公元前770年-公元前221年）：周王室衰微，诸侯争霸。春秋五霸有齐桓公、晋文公、楚庄王等。战国七雄齐楚燕韩赵魏秦相互兼并。百家争鸣是思想文化空前繁荣的时期。铁器和牛耕的推广促进了农业生产力的发展。', 170, 466218074913739131, '2026-05-14 21:28:49', 'bea35070bdb70bb1f6f166bb3cd1ace885039cdecca696d97f35a7ef22c2c6e1', 'local');
INSERT INTO `knowledge_chunk` VALUES (63, 24, 0, '公元前221年，秦王嬴政统一六国，建立中国历史上第一个大一统王朝——秦朝。推行郡县制、统一文字（小篆）、统一度量衡、统一车轨。修筑万里长城抵御匈奴。秦朝因严刑峻法和繁重徭役迅速衰落。公元前209年陈胜吴广起义揭开了中国历史上第一次大规模农民起义的序幕。 汉朝（公元前202年-公元220年）分西汉和东汉。汉武帝刘彻在位54年，采纳董仲舒\"罢黜百家，独尊儒术\"的建议，儒学成为官学。张骞出使西域开辟了丝绸之路，连接中国与中亚、西亚乃至欧洲。卫青、霍去病大破匈奴。 东汉时期蔡伦改进造纸术，是中国古代四大发明之一。张衡发明地动仪。公元184年黄巾起义爆发，东汉名存实亡，进入三国时期。', 145, 466218074913739132, '2026-05-14 21:28:49', '599ff0ca88086815709ba66ee1fe2a4f659e63d437566989429cea2ad5c922bf', 'local');
INSERT INTO `knowledge_chunk` VALUES (64, 25, 0, '三国时期（220-280年）：曹操占据北方，刘备据益州，孙权割据江东。赤壁之战（208年）奠定了三分天下格局。西晋短暂统一后因八王之乱迅速衰落。 南北朝时期（420-589年）：江南地区得到大规模开发。北魏孝文帝推行汉化改革。佛教广泛传播，艺术上形成了敦煌莫高窟、云冈石窟、龙门石窟等佛教艺术宝库。 隋朝（581-618年）：隋文帝杨坚统一南北。隋炀帝开凿大运河，连接南北交通，但过度征发民力导致隋末农民大起义。 唐朝（618-907年）：中国封建社会鼎盛时期。唐太宗李世民贞观之治，选贤任能，国力强盛。武则天是中国历史上唯一的女皇帝。唐玄宗开元盛世是唐朝极盛时期，安史之乱后由盛转衰。唐诗是中国古典文学的巅峰。雕版印刷术普及，火药开始用于军事。', 161, 466218074913739133, '2026-05-14 21:28:49', '08c4202c3854c55dd0cd94c60fbd7bb6a0deea0470fa500dd52d9627fb3a0a9f', 'local');
INSERT INTO `knowledge_chunk` VALUES (65, 26, 0, '宋朝（960-1279年）：北宋定都开封。赵匡胤杯酒释兵权加强中央集权。宋代经济高度发达，出现世界上最早的纸币交子。海外贸易繁盛，指南针应用于航海。活字印刷术由毕昇发明。南宋偏安江南，岳飞抗金被秦桧以莫须有的罪名杀害。程朱理学成为官方哲学。 元朝（1271-1368年）：蒙古族建立的大一统王朝。忽必烈定都大都（北京）。实行行省制度，有效管理辽阔疆土。元曲是元代文学的代表，关汉卿《窦娥冤》揭露社会黑暗。', 101, 466218074913739134, '2026-05-14 21:28:49', 'ba08aa5c30738240c074eece51b73324931e7bdb5c10f0f5ddcab6f42e449815', 'local');
INSERT INTO `knowledge_chunk` VALUES (66, 27, 0, '明朝（1368-1644年）：朱元璋建立明朝，定都南京，后明成祖朱棣迁都北京。郑和七下西洋（1405-1433年）到达东非海岸，宣扬国威。明朝中后期出现资本主义萌芽。戚继光平定倭寇。张居正推行一条鞭法改革。李自成领导的农民起义推翻明朝。 清朝（1644-1912年）：满族入关建立全国政权。康熙、雍正、乾隆三朝史称康乾盛世。1840年鸦片战争是中国近代史的开端，清政府战败签订《南京条约》。太平天国运动（1851-1864年）持续14年。洋务运动主张师夷长技以自强。1895年甲午战争清政府战败签订《马关条约》。1898年戊戌变法仅维持103天。1911年辛亥革命推翻了中国两千多年的封建帝制。1912年1月1日中华民国成立，孙中山任临时大总统。', 161, 466218074913739135, '2026-05-14 21:28:49', '638a96db1a0e8de587bc47c142c1100ef60a97f68b00c13054f9efefcdeaad4f', 'local');
INSERT INTO `knowledge_chunk` VALUES (67, 28, 0, '原子由原子核（质子和中子）和核外电子组成。原子序数Z=质子数=核外电子数；质量数A=质子数+中子数。同位素是质子数相同、中子数不同的原子。 核外电子排布遵循泡利不相容原理（每个轨道最多2个电子）、能量最低原理和洪特规则（等价轨道上电子尽可能自旋平行）。电子层K、L、M、N对应主量子数n=1,2,3,4。各层最大电子数2n²。 元素周期表按原子序数递增排列，共7个周期、18个族。同周期从左到右，原子半径减小，电负性增大，金属性减弱；同族从上到下，原子半径增大，电负性减小，金属性增强。 化学键：离子键通过阴阳离子间的静电引力形成（如NaCl），无方向性和饱和性；共价键通过共用电子对形成，有方向性和饱和性。极性键中电子对偏向电负性大的原子一方。配位键中电子对由单方提供。 分子间作用力：范德华力随分子量增大而增强，决定物理性质（熔点、沸点）；氢键（F-H、O-H、N-H）强度介于化学键和范德华力之间，导致水有异常高的沸点，DNA双螺旋靠氢键维持。', 212, 466218074913739158, '2026-05-14 21:28:51', '46e70db1cfe8bb47886a2943431db3fedeadf5cc1506ef5fff69ab444abe7f4c', 'local');
INSERT INTO `knowledge_chunk` VALUES (68, 29, 0, '化学反应的类型：化合反应（A+B→AB）、分解反应（AB→A+B）、置换反应（A+BC→AC+B）、复分解反应（AB+CD→AD+CB）。氧化还原反应涉及电子转移，氧化数变化的元素被氧化（升高）或被还原（降低）。 热化学方程式标有反应热ΔH。放热反应ΔH<0（如燃烧），吸热反应ΔH>0（如碳酸钙分解）。盖斯定律：反应热只取决于始态和终态，与途径无关。 化学反应速率v与浓度、温度、压强（气体）和催化剂有关。速率方程v=k[A]^m[B]^n，m+n为反应级数。阿伦尼乌斯公式k=Ae^(-Ea/RT)描述速率常数与温度的关系，活化能Ea越低，反应越快。 催化剂降低活化能但不改变平衡位置，在反应前后质量和化学性质不变。酶是生物催化剂，具有高效性和专一性。 化学平衡常数K=[C]^c[D]^d/[A]^a[B]^b。勒夏特列原理：改变平衡条件，平衡向减弱改变的方向移动。升温→吸热方向；增压→分子数减少方向；加反应物→正反应方向。', 208, 466218074913739159, '2026-05-14 21:28:51', 'f9e5c1ba8ea0f5042eff29ec882bb5aa5493e8eac30b2a07bc77650f4bf77103', 'local');
INSERT INTO `knowledge_chunk` VALUES (69, 30, 0, '酸：在水溶液中电离出的阳离子全部是H+的化合物。强酸（HCl、HNO₃、H₂SO₄）完全电离；弱酸（CH₃COOH、H₂CO₃）部分电离。溶液的pH=-lg[H+]。 碱：在水溶液中电离出的阴离子全部是OH-的化合物。强碱（NaOH、KOH、Ca(OH)₂）完全电离；弱碱（NH₃·H₂O、Fe(OH)₃）部分电离。 盐是酸碱中和的产物。正盐（NaCl）不含可电离氢或氢氧根；酸式盐（NaHCO₃）含可电离氢；碱式盐（Mg(OH)Cl）含氢氧根。盐的水解使溶液呈酸性或碱性。 重要的金属及其化合物：钠（Na+H₂O剧烈反应生成NaOH和H₂）、铁（Fe在潮湿空气中生锈Fe₂O₃·xH₂O，纯铁银白色）、铝（Al₂O₃致密氧化膜保护）、铜（Cu在潮湿空气中生成铜绿Cu₂(OH)₂CO₃）。', 172, 466218074913739160, '2026-05-14 21:28:51', '54cc6c02279e41bc4a89db24d4bf7243f9135cf53c9c2d4aa428d87a06fb764b', 'local');
INSERT INTO `knowledge_chunk` VALUES (70, 31, 0, '有机化合物是含碳化合物。碳原子sp³杂化（四面体，109.5°）、sp²杂化（平面三角形，120°）和sp杂化（直线形，180°）决定了分子的空间构型。 官能团决定有机物化学性质：羟基-OH（醇、酚）、羰基>C=O（醛、酮）、羧基-COOH（羧酸）、氨基-NH₂（胺）、酯基-COOR（酯）。 烃的分类：烷烃（CnH2n+2，碳碳单键）、烯烃（CnH2n，含>C=C<双键）、炔烃（CnH2n-2，含-C≡C-叁键）、芳香烃（含苯环）。苯C₆H₆具有特殊的芳香性大π键结构。 重要的有机反应：取代反应（如烷烃卤代、苯的硝化）、加成反应（烯烃加氢、加卤素）、消去反应（醇脱水制烯烃）、酯化反应（醇+酸→酯+水）、水解反应（酯+水→醇+酸）、聚合反应（加聚和缩聚）。', 165, 466218074913739161, '2026-05-14 21:28:51', '0cc712a796b7ec54b53468a5b488718f7c3a403475e454cf532abc91e9583c8c', 'local');
INSERT INTO `knowledge_chunk` VALUES (71, 32, 0, '原电池将化学能转化为电能。以铜锌原电池（丹尼尔电池）为例：负极Zn-2e⁻→Zn²⁺（氧化），正极Cu²⁺+2e⁻→Cu（还原）。电动势E=E⁰正-E⁰负。 标准电极电势E⁰（相对于标准氢电极，φ⁰=0V）越大，氧化型的氧化能力越强。能斯特方程：E=E⁰-(RT/nF)lnQ，修正了非标准浓度下的电极电势。 电解池将电能转化为化学能。阳极发生氧化反应（接电源正极），阴极发生还原反应（接电源负极）。法拉第电解定律：m=(Q/F)(M/n)，其中Q为电量，F为法拉第常数96485 C/mol。 电解精炼铜：粗铜作阳极，纯铜作阴极，Cu²⁺在阴极还原析出纯铜。电镀利用电解原理在金属表面沉积一层金属或合金。 金属腐蚀主要是电化学腐蚀。铁在潮湿空气中形成原电池：铁作负极被氧化Fe-2e⁻→Fe²⁺，碳或杂质作正极。防护方法包括涂漆、电镀、牺牲阳极的阴极保护法（连接更活泼的金属如锌）。', 196, 466218074913739162, '2026-05-14 21:28:51', '55b1bb2fda91312f0e01fc0d112482d320139aca9479bfe31731416055505928', 'local');
INSERT INTO `knowledge_chunk` VALUES (72, 33, 0, '地球的圈层结构：外部圈层包括大气圈、水圈和生物圈；内部圈层分为地壳（平均厚度约17km，大陆地壳较厚可达70km，海洋地壳较薄约5-10km）、地幔（莫霍面至古登堡面之间，约2900km厚）和地核（液态外核和固态内核）。 地球的自转和公转：自转周期约24小时，产生昼夜交替和地转偏向力（北半球向右偏，南半球向左偏）；公转周期约365.25天，轨道为椭圆形。黄赤交角约23°26\'导致太阳直射点在回归线间回归运动，产生四季变化和昼夜长短变化。 大气环流：低纬度信风带、中纬度盛行西风带、极地东风带。三圈环流模型解释了全球气压带和风带的分布。海陆热力差异产生季风，东亚季风冬季吹西北风，夏季吹东南风。 气候类型：热带雨林气候（全年高温多雨，赤道附近）、热带草原气候（干湿季分明）、热带沙漠气候（全年炎热干燥，回归线附近大陆西岸）、地中海气候（夏季炎热干燥，冬季温和多雨，30°-40°大陆西岸）、温带海洋性气候（全年温和多雨，40°-60°大陆西岸）、温带季风气候（夏季高温多雨，冬季寒冷干燥，东亚）、温带大陆性气候（冬冷夏热，全年干旱，内陆地区）、亚寒带针叶林气候（冬季漫长严寒）、极地气候（终年严寒）。 水循环包括蒸发（蒸腾', 256, 466218074913739188, '2026-05-14 21:28:52', 'eff1edc8add04d3ae66f9f33dcfd1eeb5a86ce924957af4d439a3afcb22beb6d', 'local');
INSERT INTO `knowledge_chunk` VALUES (73, 33, 1, '全年干旱，内陆地区）、亚寒带针叶林气候（冬季漫长严寒）、极地气候（终年严寒）。 水循环包括蒸发（蒸腾）、水汽输送、降水和径流（地表径流和地下径流）。海陆间循环是全球规模最大的水循环。河流补给方式包括雨水补给（东部季风区）、季节性积雪融水补给（东北地区）、永久性积雪和冰川融水补给（西北地区）。 地表形态变化：内力作用（地壳运动、岩浆活动、变质作用、地震）使地表变得高低不平；外力作用（风化、侵蚀、搬运、沉积、固结成岩）削高填低。褶皱（背斜和向斜）和断层（地垒和地堑）是地壳运动的结果。', 121, 466218074913739189, '2026-05-14 21:28:52', 'cf9cdd2f9f728ecd00fac61c51856873ca6d8cda1128bbbeba600a302bc838ec', 'local');
INSERT INTO `knowledge_chunk` VALUES (74, 34, 0, '人口增长模式：原始型（高出生高死亡低自然增长）→传统型（高出生低死亡高自然增长）→现代型（低出生低死亡低自然增长）。中国自计划生育政策实施以来，人口增长模式已进入现代型。 城市化：人口和产业向城市集聚的过程。城市化水平通常用城市人口占总人口的比例衡量。发达国家城市化水平高（>70%）、速度慢；发展中国家城市化水平低、速度快。城市化进程中出现的问题：交通拥堵、住房紧张、环境污染、城市热岛效应等。 农业地域类型：亚洲水稻种植业（劳动密集型，单位面积产量高）、商品谷物农业（大规模机械化，美国、加拿大为典型）、大牧场放牧业、乳畜业（城市周边的鲜奶生产）、混合农业（澳大利亚墨累-达令盆地）、地中海式农业等。 工业地域类型：原料指向型（制糖）、市场指向型（啤酒）、动力指向型（炼铝，需大量电力）、劳动力指向型（服装）、技术指向型（集成电路）。工业集聚可以降低运输成本、共享基础设施和促进信息交流。 交通运输对聚落和商业网点布局有重要影响。古代城市多沿河流分布，现代城市沿交通线扩展。商业网点分布遵循市场最优和交通最优原则。', 229, 466218074913739190, '2026-05-14 21:28:52', '0353738c10982687c50aa95fac1ae9030966d400a4dfb619146bd527818dc3d5', 'local');
INSERT INTO `knowledge_chunk` VALUES (75, 35, 0, '中国位于亚洲东部，太平洋西岸。领土最北端在黑龙江省漠河，最南端在南沙群岛曾母暗沙，最东端在黑龙江与乌苏里江主航道中心线汇合处，最西端在新疆帕米尔高原。 地形三大阶梯：第一阶梯为青藏高原（平均海拔4000米以上）；第二阶梯以高原盆地为主（内蒙古高原、黄土高原、云贵高原、塔里木盆地、准噶尔盆地、四川盆地，海拔1000-2000米）；第三阶梯以平原丘陵为主（东北平原、华北平原、长江中下游平原、东南丘陵，海拔500米以下）。 中国主要山脉：东西走向的天山-阴山、昆仑山-秦岭、南岭；东北-西南走向的大兴安岭-太行山-巫山-雪峰山、长白山-武夷山；西北-东南走向的阿尔泰山、祁连山；南北走向的横断山脉。 主要河流：长江发源于唐古拉山，全长约6300公里，是中国第一长河，注入东海；黄河发源于巴颜喀拉山，全长约5464公里，注入渤海，因流经黄土高原而含沙量大。 四大地理分区：北方地区（温带季风气候，冬季寒冷干燥）；南方地区（亚热带季风气候，温暖湿润）；西北地区（温带大陆性气候，干旱少雨）；青藏地区（高原气候，高寒）。', 228, 466218074913739191, '2026-05-14 21:28:52', 'f769780288eaeb62b65b3b7dc3e92356b0cbe86c2daf1d22c75960082d776f7b', 'local');
INSERT INTO `knowledge_chunk` VALUES (76, 36, 0, '七大洲：亚洲（最大，约4400万km²）、非洲、北美洲、南美洲、南极洲、欧洲、大洋洲（最小）。四大洋：太平洋（最大最深）、大西洋、印度洋、北冰洋。 日本是岛国，多火山地震，富士山是最高峰（3776米），经济以加工贸易为主。东南亚地处亚洲与大洋洲、太平洋与印度洋的十字路口位置，马六甲海峡是重要的海上通道。南亚热带季风气候显著，印度是南亚最大国家。 中东是\"三洲五海之地\"（亚欧非三洲交界，连接里海、黑海、地中海、红海、阿拉伯海），石油资源丰富，淡水缺乏。欧洲西部是发达国家最集中的地区，大西洋沿岸温带海洋性气候显著。 撒哈拉以南的非洲是黑色人种的故乡，矿产资源丰富。澳大利亚是大洋洲最大国家，特有动物有袋鼠、考拉、鸭嘴兽等。美国本土位于北美洲中部，东临大西洋，西临太平洋，是世界最大的经济体。 巴西是拉丁美洲最大国家，亚马孙雨林是世界上面积最大的热带雨林，有地球之肺之称。俄罗斯地跨欧亚两洲，是世界上面积最大的国家，西伯利亚大铁路横贯东西。', 210, 466218074913739192, '2026-05-14 21:28:52', '0c7dd76ee0621e3fc360c6809f6bd4f6266b2212ea0479f3c652a37523c3c2f5', 'local');
INSERT INTO `knowledge_chunk` VALUES (77, 37, 0, '牛顿运动定律：第一定律（惯性定律）指出物体在不受外力时保持静止或匀速直线运动状态；第二定律F=ma定量描述了力与加速度的关系；第三定律指出作用力与反作用力大小相等、方向相反、作用在不同物体上。 动量守恒定律：系统不受外力或合外力为零时，系统总动量保持不变。动量p=mv是矢量。冲量I=∫Fdt是力对时间的累积效应，等于动量的变化。 功和能：功W=∫F·dr是力对空间的累积效应。动能Ek=mv²/2。保守力做功与路径无关（如重力、弹性力、万有引力），对应的势能Ep=∫F·dr。机械能守恒定律：只有保守力做功时，系统机械能守恒。非保守力（摩擦力）做功转化为内能。 刚体定轴转动：转动惯量I=∫r²dm是描述刚体转动惯性的物理量。平行轴定理I=Ic+md²。角动量L=Iω。力矩M=Iα（转动定律）。角动量守恒：合外力矩为零时角动量守恒。', 184, 466218075175624045, '2026-05-14 21:28:53', '29605484b3f39f1f5a7a85d5cd69c60c7cc722659eeff6ccce865aacd1bdd97d', 'local');
INSERT INTO `knowledge_chunk` VALUES (78, 38, 0, '库仑定律：真空中两个点电荷间的作用力F=kq1q2/r²，方向沿连线。k=1/(4πε0)≈9×10⁹ N·m²/C²。 电场强度E=F/q（单位正电荷受到的力）。高斯定理：闭合面的电通量等于面内电荷的代数和除以ε0。可根据对称性计算电场分布。 电势V=∫E·dr表示单位正电荷在各点的电势能。电势差UAB=VA-VB。 欧姆定律：U=IR。焦耳定律：P=I²R=U²/R。基尔霍夫定律：节点电流定律ΣI入=ΣI出（KCL）和回路电压定律ΣU=ΣE（KVL）。 毕奥-萨伐尔定律：电流元Idl在空间某点产生的磁感应强度dB=μ0Idl×r/(4πr³)。安培环路定理：磁场强度H沿闭合路径的线积分等于穿过该路径的电流代数和。 法拉第电磁感应定律：ε=-dΦ/dt。感应电动势的大小等于磁通量变化率的负值。楞次定律判断感应电流的方向：感应电流的磁通量总是阻碍原磁通量的变化。 麦克斯韦方程组统一描述了电磁学规律：∇·D=ρ（高斯定律）、∇·B=0（磁通连续）、∇×E=-∂B/∂t（法拉第定律）、∇×H=J+∂D/∂t（安培-麦克斯韦定律）。', 235, 466218075175624046, '2026-05-14 21:28:53', 'b12fe56ce3fa51d532a2b899faa946dc2689f385450de1a5206954ac3f96c2a4', 'local');
INSERT INTO `knowledge_chunk` VALUES (79, 38, 1, '麦克斯韦定律）。', 4, 466218075175624047, '2026-05-14 21:28:53', 'bee72b7dd6150c621e217dd1112cde54f57ad238839af53f8e4c643309cbd80c', 'local');
INSERT INTO `knowledge_chunk` VALUES (80, 39, 0, '理想气体状态方程：pV=nRT。温度是分子平均平动动能的量度。麦克斯韦速率分布描述了气体分子速率的统计规律。 热力学第一定律：ΔU=Q+W。内能变化等于吸收热量与外界做功之和。比热容和摩尔热容：Cp-Cv=R（迈耶公式）。热力学第二定律的克劳修斯表述：热量不能自发地从低温物体传到高温物体。开尔文表述：不可能从单一热源吸热完全转化为功而不产生其他影响。 卡诺循环是理想热机循环，效率η=1-T2/T1。熵是系统无序度的度量，dS=dQ/T。熵增原理：孤立系统的熵永不减少。', 118, 466218075175624048, '2026-05-14 21:28:53', '99dce15cca77348626c85ef002f76cb5e482b576f7eee494c69c6f872854a253', 'local');
INSERT INTO `knowledge_chunk` VALUES (81, 40, 0, '光的干涉：同频率、同振动方向、相位差恒定的两列光波叠加。杨氏双缝干涉条纹间距Δx=Lλ/d。薄膜干涉（等厚干涉和等倾干涉）产生彩色条纹，应用于增透膜和反射膜。 光的衍射：光遇到障碍物偏离直线传播。单缝衍射暗纹条件asinθ=kλ（k=1,2,3...）。光栅衍射主明纹条件dsinθ=kλ。瑞利判据确定光学仪器的分辨极限。 光的偏振：光是横波。马吕斯定律I=I0cos²θ。布儒斯特定律：入射角满足tan iB=n2/n1时反射光为完全线偏振光。', 111, 466218075175624049, '2026-05-14 21:28:53', 'd6272e3f05e02820d4137964f445996d173e3c0b1d12bab5e5cc961b5f0eaafc', 'local');
INSERT INTO `knowledge_chunk` VALUES (82, 41, 0, '光电效应：光照射金属表面逸出电子。实验规律：存在截止频率、瞬时性、光电子最大初动能与频率成正比。爱因斯坦光电方程：hν=W+Ek。光子能量E=hν，动量p=h/λ。 康普顿散射证实了光具有粒子性。Δλ=h(1-cosθ)/(m0c)。 玻尔氢原子理论：电子在特定轨道上运动不辐射能量，能级En=-13.6/n² eV（n=1,2,3...）。从高能级跃迁到低能级辐射光子，光子能量hν=|E2-E1|。 德布罗意物质波：微观粒子具有波粒二象性，λ=h/p=h/(mv)。不确定关系：ΔxΔpx≥h/4π，不能同时精确测量粒子的位置和动量。 薛定谔方程是量子力学的基本方程：iħ∂Ψ/∂t=ĤΨ。波函数的模的平方|Ψ|²表示粒子出现的概率密度。 狭义相对论基本假设：光速不变原理和相对性原理。洛伦兹变换取代伽利略变换。时间膨胀Δt=Δt0/√(1-v²/c²)，长度收缩L=L0√(1-v²/c²)，质量-能量关系E=mc²。', 206, 466218075175624050, '2026-05-14 21:28:53', '1918b0056f56f84a6b6987ca7fc223689e36dece2e8b65f9c48ab2406a188793', 'local');
INSERT INTO `knowledge_chunk` VALUES (83, 42, 0, '操作系统是管理计算机硬件与软件资源的系统软件，也是计算机系统的内核与基石。操作系统的基本功能包括进程管理、内存管理、文件管理、设备管理和用户接口。 操作系统分类：批处理系统、分时系统、实时系统、网络操作系统、分布式操作系统。现代主流操作系统包括Windows、Linux、macOS、Android、iOS等。', 77, 466218075175624062, '2026-05-14 21:28:55', '06d94500aa684423216ed936346cc1cf4659726b1f34ac8911e0516d43f18698', 'local');
INSERT INTO `knowledge_chunk` VALUES (84, 43, 0, '进程是程序的一次执行过程，是系统资源分配和调度的基本单位。进程具有动态性、并发性、独立性和异步性等特征。进程由程序段、数据段和进程控制块（PCB）组成。PCB包含进程标识符、进程状态、程序计数器、寄存器、内存管理信息等。 进程状态包括创建、就绪、运行、阻塞和终止。就绪态进程等待CPU调度，运行态进程占用CPU执行，阻塞态进程等待某事件发生。状态转换由调度程序控制。 线程是进程内的一个执行单元，是CPU调度的基本单位。同一进程内的线程共享进程的地址空间和资源，但拥有独立的栈和寄存器。线程切换开销远小于进程切换。 多线程模型：用户级线程（由线程库管理，内核感知不到）和内核级线程（由操作系统内核管理）。混合模型结合两者优势。', 156, 466218075175624063, '2026-05-14 21:28:55', '82112072be6947da4be666c7bc343dd1cbdc9f7e0091d34ce3ec8d6ee372e1dc', 'local');
INSERT INTO `knowledge_chunk` VALUES (85, 44, 0, '临界资源是一次仅允许一个进程使用的共享资源。临界区是访问临界资源的代码段。同步机制应满足互斥、前进、有限等待和让权等待四个条件。 信号量是一种用于进程同步的变量。P操作（wait）使信号量减1，V操作（signal）使信号量加1。二元信号量（互斥锁）取值0或1，用于实现互斥；计数信号量用于控制资源数量。 经典同步问题：生产者-消费者问题、读者-写者问题、哲学家就餐问题。这些问题的解决方案展示了信号量和互斥锁的实际应用。 死锁是多个进程因争夺资源而无限等待的状态。死锁产生的四个必要条件：互斥条件、请求保持条件、不可抢占条件、循环等待条件。破坏任一条件即可预防死锁：破坏互斥（不可行，因为互斥是资源固有特性）、破坏请求保持（一次性申请全部资源）、破坏不可抢占（允许抢占资源）、破坏循环等待（按序申请资源）。 银行家算法通过判断系统是否处于安全状态来避免死锁。安全状态是存在一个安全序列，按此序列分配资源不会导致死锁。死锁检测和恢复是在死锁发生后通过撤销进程或抢占资源来解除。', 219, 466218075175624064, '2026-05-14 21:28:55', '7f3578ec33c8c3e9b0b6331aee91e2662f7b90a07e058fac807a7afb391698ba', 'local');
INSERT INTO `knowledge_chunk` VALUES (86, 45, 0, '内存管理的目标：地址转换、内存分配、内存保护、内存扩充。 连续分配：单一连续分配（仅用于单道系统）、固定分区分配（产生内部碎片）、动态分区分配（产生外部碎片）。动态分区分配算法：首次适应（FF）、循环首次适应（NF）、最佳适应（BF）、最差适应（WF）。 离散分配：分页存储管理将进程的逻辑地址空间和物理内存都分成固定大小的页和页框。页表记录逻辑页号到物理页框号的映射。地址转换通过页表实现，每次访存需要两次内存访问（页表+数据），快表（TLB）缓存页表项以加速转换。 分段存储管理按程序逻辑段（如代码段、数据段、栈段）进行分配。段表记录段号、段长和段基址。段页式管理结合分段和分页的优势。 虚拟内存允许进程的部分地址空间驻留在外存，实现逻辑地址空间大于物理内存。虚拟内存基于程序执行的局部性原理。请求分页在基本分页基础上增加了缺页中断处理和页面置换功能。 页面置换算法：最佳置换（OPT，不可实现但作为理论比较基准）、先进先出（FIFO，可能产生Belady异常）、最近最久未使用（LRU，近似最佳）、时钟算法（Clock/NRU，LRU的近似实现）、改进型时钟算法（考虑修改位）。', 246, 466218075175624065, '2026-05-14 21:28:55', 'be8a6e3eb9044fbbb7487da2d47e0ec61bad0580200a77a142ac3b93c59256db', 'local');
INSERT INTO `knowledge_chunk` VALUES (87, 45, 1, '/NRU，LRU的近似实现）、改进型时钟算法（考虑修改位）。', 15, 466218075175624066, '2026-05-14 21:28:55', 'c3676b166aa70aee4389e9cc4dae9211ce5fc2706b2c0e9dcbdc618f8027cdd0', 'local');
INSERT INTO `knowledge_chunk` VALUES (88, 46, 0, '文件是信息的逻辑存储单位。文件系统负责文件的组织、存储、检索、命名、共享和保护。 文件的逻辑结构：无结构文件（流式文件）和有结构文件（记录式文件）。文件的物理结构：连续分配（顺序存取效率高，但产生外部碎片）、链接分配（隐式链接和显式链接FAT，无外部碎片但随机存取效率低）、索引分配（每个文件有索引块，支持随机存取，但索引块占用额外空间）。 文件目录结构：单级目录、两级目录、树形目录、无环图目录。目录项包含文件名、文件属性和文件物理地址信息。 文件存储空间管理：空闲表法、空闲链表法、位示图法、成组链接法。位示图用二进制位（0表示空闲、1表示占用）表示磁盘块使用情况，是常用的管理方法。 文件共享：基于索引节点的硬链接共享（多个目录项指向同一inode）和符号链接（软链接，存储目标文件路径）。硬链接不能跨文件系统，删除原文件不影响硬链接；软链接可以跨文件系统，原文件删除后软链接失效。', 197, 466218075175624067, '2026-05-14 21:28:55', 'a7ba0e1f1ed6f88d733ce23ab9b3bd0f7aa84394975f4199099ab7519e43d0c9', 'local');
INSERT INTO `knowledge_chunk` VALUES (89, 47, 0, 'I/O控制方式：程序直接控制（轮询）、中断驱动方式、DMA方式（直接存储器访问，数据块传输由DMA控制器完成）、通道方式（通道是专门负责I/O处理的处理器）。DMA方式下，CPU仅在开始和结束时干预，中间传输由DMA控制器完成。 磁盘调度算法：先来先服务（FCFS，公平但效率低）、最短寻道时间优先（SSTF，可能产生饥饿）、扫描算法（SCAN/电梯算法，磁头单向移动）、循环扫描算法（C-SCAN，磁头单向移动到底后快速返回）。 SPOOLing技术（假脱机）通过在磁盘上建立输入井和输出井，将独占设备改造为共享设备，实现虚拟设备功能，提高了设备利用率和系统效率。', 141, 466218075175624068, '2026-05-14 21:28:55', '259eb8f6c4efc4fd943e02b8b784e27559a6e7a4ec10dd5624c70570e406d941', 'local');
INSERT INTO `knowledge_chunk` VALUES (90, 48, 0, '数据库是长期存储在计算机内、有组织、可共享的大量数据的集合。数据库管理系统（DBMS）是管理数据库的系统软件，提供数据定义、数据操纵、数据控制等功能。 数据模型的三要素：数据结构、数据操作和完整性约束。层次模型（树形结构）、网状模型（图结构）和关系模型（二维表结构）是三种主要的数据模型。关系模型由E.F.Codd于1970年提出，是目前最广泛使用的数据模型。 数据库系统的三级模式结构：外模式（用户视图）、模式（逻辑模式）和内模式（存储模式）。两级映像：外模式/模式映像和模式/内模式映像，实现了数据的逻辑独立性和物理独立性。', 132, 466218075175624099, '2026-05-14 21:28:56', '62ec6cbb9a67e672b143bc12dfdabf0b7ac4183684933bf79b8f156245238d7d', 'local');
INSERT INTO `knowledge_chunk` VALUES (91, 49, 0, '关系是一组域的笛卡尔积的子集，直观上是一个二维表。关系模型的术语：关系（表）、元组（行）、属性（列）、候选码（能唯一标识元组的最小属性组）、主码（选定的候选码）、外码（引用其他关系主码的属性）。 关系代数是以关系为运算对象的一组高级运算集合。基本运算：并（∪）、差（-）、笛卡尔积（×）、选择（σ）、投影（π）。派生运算：交（∩）、连接（⋈，包括等值连接、自然连接、外连接）和除（÷）。 完整性约束：实体完整性（主码不能为空）、参照完整性（外码必须匹配被参照关系的主码或为空）和用户定义完整性（如年龄不能为负）。这些约束保证了数据库的一致性。', 135, 466218075175624100, '2026-05-14 21:28:56', '81eb6bb7b3be15053b70bfec402cb0b305dfc7885ce2423126140a405a0a0bce', 'local');
INSERT INTO `knowledge_chunk` VALUES (92, 50, 0, 'SQL（结构化查询语言）是关系数据库的标准语言，由ANSI和ISO标准化。SQL是集DDL、DML、DCL于一体的非过程化语言。 数据定义（DDL）：CREATE创建数据库对象（TABLE、INDEX、VIEW）；ALTER修改对象结构；DROP删除对象。数据类型包括INT、VARCHAR(n)、DECIMAL(p,s)、DATE、TIMESTAMP等。 数据查询（DML核心）：SELECT语句的基本结构为SELECT-FROM-WHERE-GROUP BY-HAVING-ORDER BY。执行顺序为FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY。 连接查询：INNER JOIN返回匹配行；LEFT JOIN返回左表所有行；RIGHT JOIN返回右表所有行；FULL JOIN返回所有行。自连接将表与自身进行连接。 子查询：嵌套在另一个查询中的SELECT语句。标量子查询返回单个值；行子查询返回单行；列子查询返回单列多行；表子查询返回多行多列。相关子查询引用外部查询的属性值。EXISTS和NOT EXISTS用于检查子查询是否返回行。 集合操作：UNI', 256, 466218075175624101, '2026-05-14 21:28:56', '990eff584b25bb287a636c9108b357901537d34881d1e837ecc88bd9fb7f9880', 'local');
INSERT INTO `knowledge_chunk` VALUES (93, 50, 1, '引用外部查询的属性值。EXISTS和NOT EXISTS用于检查子查询是否返回行。 集合操作：UNION（合并去重）、INTERSECT（交集）、EXCEPT（差集）。UNION ALL保留重复行。 窗口函数：ROW_NUMBER()生成行号；RANK()和DENSE_RANK()生成排名（处理平局方式不同）；SUM() OVER()计算累计和。 数据操纵（DML）：INSERT INTO插入行；UPDATE修改行；DELETE FROM删除行。事务控制语句包括COMMIT和ROLLBACK。', 124, 466218075175624102, '2026-05-14 21:28:56', '4b3323780246ee64a0477a841128c1a21ca835b702c1d830af6870d0678e4db1', 'local');
INSERT INTO `knowledge_chunk` VALUES (94, 51, 0, '数据库设计分为需求分析、概念结构设计、逻辑结构设计、物理结构设计、实施和运行维护六个阶段。 概念结构设计使用E-R模型（实体-联系模型）。实体用矩形表示，属性用椭圆表示，联系用菱形表示。联系类型：一对一（1:1）、一对多（1:N）、多对多（M:N）。 E-R图向关系模型的转换：实体转换为关系模式；1:1联系可与任一端合并；1:N联系可与N端合并；M:N联系必须转为独立关系模式，包含两端主码作为外码。 规范化理论：函数依赖是指属性集X决定属性集Y（记为X→Y）。部分函数依赖、完全函数依赖和传递函数依赖用于判定范式等级。 范式等级：第一范式（1NF）要求属性不可再分；第二范式（2NF）要求消除部分函数依赖；第三范式（3NF）要求消除传递函数依赖；BCNF（巴斯-科德范式）要求每一个决定因素都包含候选码。第四范式（4NF）消除多值依赖。 通常在实际应用中，达到3NF或BCNF是合理的平衡点。规范化避免数据冗余和更新异常，但可能导致查询时需要更多连接操作。反规范化在性能要求高的场景下可能有意引入冗余。', 226, 466218075175624103, '2026-05-14 21:28:56', '4ea9f58ec1ba3975db8816f86390745fd9fa9643eb078bb2f56a4a1e36f461a2', 'local');
INSERT INTO `knowledge_chunk` VALUES (95, 52, 0, '事务是用户定义的一组数据库操作序列，是不可分割的工作单位。事务具有ACID特性：原子性（Atomicity，要么全做要么全不做）、一致性（Consistency，事务前后数据库保持一致性状态）、隔离性（Isolation，并发事务互不干扰）、持久性（Durability，已提交事务的修改永久保存）。 并发操作可能引发的问题：丢失修改（两个事务同时修改同一数据）、不可重复读（同一事务两次读取结果不同）、脏读（读到未提交的修改）、幻读（同一事务两次查询返回不同行数）。 封锁是实现并发控制的基本方法。排他锁（X锁，写锁）禁止其他事务再加任何锁；共享锁（S锁，读锁）允许其他事务加S锁但禁止加X锁。两段锁协议保证可串行化：所有加锁操作在解锁操作之前。 事务隔离级别（SQL标准）：读未提交（Read Uncommitted，允许脏读）；读已提交（Read Committed，禁止脏读，大多数数据库默认）；可重复读（Repeatable Read，禁止脏读和不可重复读，MySQL InnoDB默认）；可串行化（Serializable，禁止所有并发问题）。 快照隔离（MVCC多版本并发控制）通过维护数据的多个版本来实现高并', 256, 466218075175624104, '2026-05-14 21:28:56', '10454c5bf3fb527ffc35e31cf72e7c56d96b9cfa027e313a242ad2f1fa2c10bf', 'local');
INSERT INTO `knowledge_chunk` VALUES (96, 52, 1, 'zable，禁止所有并发问题）。 快照隔离（MVCC多版本并发控制）通过维护数据的多个版本来实现高并发。InnoDB的MVCC基于undo log和ReadView实现，读操作不阻塞写操作。', 47, 466218075175624105, '2026-05-14 21:28:56', '780a5ba5c36cd4bdb388ba4f618c6f30b786cb2c0f49eae138799cbb76d16d38', 'local');
INSERT INTO `knowledge_chunk` VALUES (97, 53, 0, '索引是加速数据检索的数据结构。B+树索引是最常用的数据库索引结构。B+树所有数据记录存储在叶子结点，内部结点仅存储索引键值用于导航。叶子结点通过双向链表连接，支持范围查询和顺序扫描。B+树的阶数决定每个结点的最大子结点数，通常与磁盘页大小匹配。 聚集索引决定表中数据的物理存储顺序，每张表只能有一个聚集索引。非聚集索引存储索引键值和指向数据行的指针（书签或聚集索引键）。 哈希索引基于哈希表，支持等值查询（O(1)），但无法支持范围查询。位图索引适用于基数较低的列。 复合索引按列顺序组织，符合最左前缀匹配原则。覆盖索引是指索引包含查询所需的所有列，避免回表查询。 查询优化：EXPLAIN命令分析执行计划。type字段（访问类型）从好到差：system > const > eq_ref > ref > range > index > ALL。优化策略包括创建合适的索引、避免在WHERE子句中对列使用函数、使用覆盖索引、小表驱动大表、避免SELECT *等。', 215, 466218075175624106, '2026-05-14 21:28:56', 'fa9e157c2f279a9904cfe71cd66acf712cd72df8b679c5d6ed52628b98068a02', 'local');
INSERT INTO `knowledge_chunk` VALUES (98, 54, 0, '线性表是n个数据元素的有限序列，是最基本、最简单、最常用的一种数据结构。线性表有两种存储结构：顺序存储和链式存储。 顺序表 顺序表用一组地址连续的存储单元依次存储线性表的数据元素。其特点是逻辑上相邻的元素在物理位置上也相邻，因此可以随机存取任一元素，时间复杂度为O(1)。但在插入和删除操作时需要移动大量元素，平均时间复杂度为O(n)。 链表 链表通过指针将一系列结点连接起来。每个结点包含数据域和指针域。链表包括单链表、双链表和循环链表。单链表的结点只有一个指向后继的指针；双链表有两个指针，分别指向前驱和后继。链表的插入和删除操作只需修改指针，时间复杂度为O(1)，但查找操作需要遍历，时间复杂度为O(n)。', 153, 466218075175624134, '2026-05-14 21:28:58', '4377515fc94708760308c0aabb5957d9a85db7beb1dc383d81957d2c540b185e', 'local');
INSERT INTO `knowledge_chunk` VALUES (99, 55, 0, '栈是限定仅在表尾进行插入和删除操作的线性表，遵循后进先出（LIFO）原则。栈顶是允许操作的一端，栈底是固定的一端。栈的基本操作包括入栈（push）和出栈（pop）。栈在函数调用、表达式求值、括号匹配等场景广泛应用。 队列是限定在表的一端插入、另一端删除的线性表，遵循先进先出（FIFO）原则。允许插入的一端称为队尾，允许删除的一端称为队头。循环队列通过取模运算实现空间的高效利用，解决了顺序队列的假溢出问题。', 102, 466218075175624135, '2026-05-14 21:28:58', '25662600d2b13a3193a9b8e4c70c30776f924d75b8711fe584b4279f4a1cc51a', 'local');
INSERT INTO `knowledge_chunk` VALUES (100, 56, 0, '树是n个结点的有限集，n=0时为空树。任意非空树有且仅有一个根结点。树的基本术语包括结点的度、树的度、叶子结点、分支结点、路径、树的深度等。 二叉树每个结点最多有两棵子树，分为左子树和右子树。满二叉树是深度为k且有2^k-1个结点的二叉树。完全二叉树是除最后一层外每层结点都达到最大值，且最后一层结点连续集中在左边的二叉树。 二叉树的遍历分为前序遍历（根-左-右）、中序遍历（左-根-右）、后序遍历（左-右-根）和层序遍历。二叉树可以用顺序存储或链式存储（二叉链表、三叉链表）。 二叉搜索树（BST）满足左子树所有结点值小于根结点值小于右子树所有结点值。平衡二叉树（AVL）任意结点左右子树高度差不超过1。红黑树通过颜色属性维持近似平衡，查找、插入、删除时间复杂度均为O(log n)。 堆是一种特殊的完全二叉树，分为大顶堆和小顶堆。大顶堆每个结点的值都大于或等于其左右孩子结点的值。堆排序利用堆的性质进行排序，时间复杂度O(nlog n)。 哈夫曼树（最优二叉树）是带权路径长度WPL最小的二叉树，用于数据压缩编码。哈夫曼编码是前缀编码，任何字符的编码都不是另一个字符编码的前缀。', 245, 466218075175624136, '2026-05-14 21:28:58', '789256c12f3e54289f6f76f68169623d9e18cec5218b3ff261b75c247c292637', 'local');
INSERT INTO `knowledge_chunk` VALUES (101, 56, 1, '编码是前缀编码，任何字符的编码都不是另一个字符编码的前缀。', 14, 466218075175624137, '2026-05-14 21:28:58', '24bcd284c04295fb640f91733cc0fd49be6f6923ae9d1720df11b3563a1489b6', 'local');
INSERT INTO `knowledge_chunk` VALUES (102, 57, 0, '图G由顶点集V和边集E组成。按边有无方向分为有向图和无向图；按边是否带权值分为带权图和不带权图。 图的存储结构：邻接矩阵用二维数组存储顶点间关系，空间复杂度O(n^2)，适合稠密图；邻接表为每个顶点建立单链表存储其邻接点，空间复杂度O(n+e)，适合稀疏图。 图的遍历：深度优先搜索（DFS）类似树的前序遍历，用递归或栈实现；广度优先搜索（BFS）类似树的层序遍历，用队列实现。DFS和BFS的时间复杂度在邻接表存储下均为O(n+e)。 最小生成树：Prim算法从任意顶点开始逐步扩展，适合稠密图，时间复杂度O(n^2)；Kruskal算法按边权递增顺序选取，适合稀疏图，时间复杂度O(e log e)。 最短路径：Dijkstra算法求单源最短路径，要求边权非负，时间复杂度O(n^2)；Floyd算法求任意两点间最短路径，时间复杂度O(n^3)。 拓扑排序是对有向无环图（DAG）顶点的线性排序，常用BFS入度表法实现。关键路径是AOE网中从源点到汇点的最长路径，决定工程的最短完成时间。', 223, 466218075175624138, '2026-05-14 21:28:58', '07317556c02308b5216fe5619a635929d24d625c76800d5d5f9bacd02d9f0b4f', 'local');
INSERT INTO `knowledge_chunk` VALUES (103, 58, 0, '顺序查找从表的一端开始逐个比较，平均查找长度ASL为(n+1)/2，适用于顺序表和链表。 折半查找（二分查找）要求查找表为有序顺序表。每次将查找范围缩小一半，时间复杂度O(log n)。判定树可用于分析查找过程。 分块查找（索引顺序查找）将表分成若干块，块间有序、块内无序，建立索引表。查找效率介于顺序查找和折半查找之间。 二叉搜索树的查找效率取决于树的高度，最坏情况下退化为链表，时间复杂度O(n)。 散列表（哈希表）通过散列函数H(key)建立关键字与存储位置的映射。处理冲突的方法：开放定址法（线性探测、二次探测、伪随机探测）和链地址法。散列表的平均查找长度取决于装填因子α，α越大越容易冲突。', 150, 466218075175624139, '2026-05-14 21:28:58', '2473442abfe8632164af1af7aff131558fe2c426806e86b1881a295cee4e5052', 'local');
INSERT INTO `knowledge_chunk` VALUES (104, 59, 0, '内部排序按算法复杂度分为：简单排序（冒泡、选择、插入）时间复杂度O(n^2)；先进排序（快速、归并、堆排序）时间复杂度O(nlog n)；基数排序时间复杂度O(d(n+r))。 冒泡排序通过相邻元素两两比较交换，每趟将最大元素移到末尾。改进版增加标志位判断是否发生交换。 快速排序采用分治思想，选取基准元素将序列划分为两个子序列，递归排序。平均时间复杂度O(nlog n)，最坏O(n^2)。优化方法包括三数取中法选基准和小数组转插入排序。 归并排序将两个有序表合并成一个有序表，采用分治递归。需要O(n)辅助空间，是稳定排序。 堆排序利用大顶堆进行选择排序。建堆时间复杂度O(n)，每次调整O(log n)，总时间复杂度O(nlog n)，不稳定。 直接插入排序将待排序元素插入到已排序序列的适当位置。希尔排序是插入排序的改进，通过缩小增量分组排序，时间复杂度约为O(n^1.3)。 简单选择排序每趟选出最小元素与当前趟首位交换。堆排序对选择排序的改进在于用堆来选择最值。 计数排序适用于取值范围有限的整数排序，统计每个值的出现次数，时间复杂度O(n+k)。桶排序将数据分到有限数量的桶里，每个桶分别排序。基数排序按位数从', 256, 466218075175624140, '2026-05-14 21:28:58', 'd5a2f97878e263d1408f9481aa31615b49d6d11e0d371ea5e92b61127f6accf7', 'local');
INSERT INTO `knowledge_chunk` VALUES (105, 59, 1, '的出现次数，时间复杂度O(n+k)。桶排序将数据分到有限数量的桶里，每个桶分别排序。基数排序按位数从低位到高位依次排序，适用于整数和字符串。', 35, 466218075175624141, '2026-05-14 21:28:58', 'fc723124cb48eb6dad50404ca9a7208c22b9a60cbb2ff7e35e6c5762f8187180', 'local');
INSERT INTO `knowledge_chunk` VALUES (106, 60, 0, '细胞学说的主要内容：所有生物体由细胞组成；细胞是生物体结构和功能的基本单位；新细胞由已存在的细胞分裂产生。细胞学说由施莱登和施旺在1838-1839年提出，被恩格斯誉为19世纪自然科学三大发现之一。 原核细胞和真核细胞的主要区别：原核细胞无成形的细胞核（无核膜），仅有拟核区域，无膜性细胞器，如细菌和蓝细菌；真核细胞有核膜包围的细胞核，有各种膜性细胞器（线粒体、内质网、高尔基体等）。 细胞膜是选择性透过膜，主要由磷脂双分子层和蛋白质组成。流动镶嵌模型由辛格和尼科尔森于1972年提出。物质跨膜运输方式：被动运输（自由扩散、协助扩散）不耗能顺浓度梯度；主动运输耗能逆浓度梯度，需要载体蛋白；胞吞和胞吐涉及膜的融合和分离。 线粒体是细胞有氧呼吸的主要场所，具有双层膜结构，内膜向内折叠形成嵴。线粒体含有自身的DNA和核糖体，能自主合成部分蛋白质。叶绿体是光合作用的场所，也含自身DNA，具有双层膜和类囊体结构（光反应场所）。 细胞核是遗传信息库，控制细胞的代谢和遗传。染色质和染色体是同种物质在不同细胞周期阶段的两种形态。核仁与核糖体的形成有关。', 236, 466218074913739303, '2026-05-14 21:29:00', '3b2b0b5cacbaf3c7611129ca7f8979a215d1e8e9c51cfef9a8b390d4b4ffdff5', 'local');
INSERT INTO `knowledge_chunk` VALUES (107, 60, 1, '与核糖体的形成有关。', 5, 466218074913739304, '2026-05-14 21:29:00', 'd7c26ba61e23e4026f42d02abc3c1a4ff7c3edafbde2e93f524b77f7a230cba4', 'local');
INSERT INTO `knowledge_chunk` VALUES (108, 61, 0, '酶是生物催化剂，绝大多数是蛋白质，少数是RNA（核酶）。酶的高效性（比无机催化剂效率高10⁷~10¹³倍）、专一性（锁钥模型和诱导契合模型）和作用条件的温和性（适宜温度和pH）。温度过低酶活性受抑制（可恢复），过高酶变性失活（不可恢复）。 ATP（三磷酸腺苷）是细胞的能量通货。ATP↔ADP+Pi的相互转化伴随着能量的储存和释放。 光合作用总反应式：6CO₂+12H₂O→(光,叶绿体)→C₆H₁₂O₆+6O₂+6H₂O。光反应在类囊体薄膜上进行，水分解产生O₂和[H]，同时ADP磷酸化生成ATP。暗反应（卡尔文循环）在叶绿体基质中进行，利用光反应产生的[H]和ATP将CO₂固定和还原为糖类。 有氧呼吸总反应式：C₆H₁₂O₆+6O₂+6H₂O→6CO₂+12H₂O+能量。三个阶段：糖酵解（细胞质基质，1分子葡萄糖→2分子丙酮酸+少量ATP+[H]）、柠檬酸循环（线粒体基质，丙酮酸彻底分解产生CO₂+[H]+少量ATP）、氧化磷酸化（线粒体内膜，[H]经呼吸链传递最终与O₂结合生成H₂O，释放大量ATP）。1分子葡萄糖有氧呼吸可产生约30-32分子ATP。', 242, 466218074913739305, '2026-05-14 21:29:00', 'ecb8993a22df62e50eeb3a8eb312bba3c5dd66f8e384312d8879fe3359ce28e5', 'local');
INSERT INTO `knowledge_chunk` VALUES (109, 61, 1, '葡萄糖有氧呼吸可产生约30-32分子ATP。', 11, 466218074913739306, '2026-05-14 21:29:00', 'b813527d525d295c3c3e45464293fd61ee27a57831dcce60fceac81764087cc6', 'local');
INSERT INTO `knowledge_chunk` VALUES (110, 62, 0, '孟德尔遗传定律：分离定律（等位基因在形成配子时分离）和自由组合定律（非同源染色体上的非等位基因自由组合）。分离比为3:1（显性:隐性）和9:3:3:1（双杂合子杂交）。 DNA的双螺旋结构由沃森和克里克于1953年提出。DNA由两条反向平行多核苷酸链组成，碱基互补配对A=T、G≡C。DNA复制是半保留复制，需要解旋酶解旋和DNA聚合酶催化新链合成。DNA聚合酶只能沿5\'→3\'方向合成，导致后随链形成冈崎片段的不连续合成。 中心法则描述了遗传信息的流动方向：DNA→RNA→蛋白质。转录在细胞核中进行，以DNA的一条链为模板合成mRNA。翻译在核糖体上进行，mRNA上的三联密码子决定氨基酸，tRNA携带对应的氨基酸。 基因突变是DNA分子中发生碱基对的替换、增添或缺失引起的基因结构的改变。镰刀型细胞贫血症是碱基替换导致血红蛋白异常的经典案例。基因重组是生物变异的另一来源，发生在减数分裂过程中（交叉互换和自由组合）。染色体变异包括结构变异（缺失、重复、倒位、易位）和数目变异（整倍体和非整倍体变异）。', 226, 466218074913739307, '2026-05-14 21:29:00', '6e2e161e2e0a32e76625081c2109d21ec5eb7bc6ae3ab00064ab2c5062f03e26', 'local');
INSERT INTO `knowledge_chunk` VALUES (111, 63, 0, '达尔文自然选择学说的核心内容：过度繁殖、生存斗争、遗传变异和适者生存。种群是生物进化的基本单位。基因库是一个种群全部个体所含的全部基因。基因频率的改变是进化的本质。 物种形成的基本环节：突变和基因重组（提供原材料）、自然选择（决定进化方向）、隔离（新物种形成的必要条件）。地理隔离导致生殖隔离是异地物种形成的主要方式。 现代生物进化理论认为，进化是种群基因频率的定向改变，自然选择作用于个体表型但进化体现在种群层面。', 104, 466218074913739308, '2026-05-14 21:29:00', '5949a9794c4f3e6efd659da9e3d09fb9a635a18eeb9dd83be6999f0675cb4319', 'local');
INSERT INTO `knowledge_chunk` VALUES (112, 64, 0, '生态系统的结构包括非生物的物质和能量（阳光、水、无机盐等）、生产者（自养生物，主要是绿色植物）、消费者（异养生物，草食动物、肉食动物、杂食动物）和分解者（细菌、真菌等微生物）。 食物链和食物网描述了生态系统中生物间的营养关系。能量流动是单向递减的（能量沿食物链逐级减少，传递效率约10%-20%），营养素可以循环利用。 物质循环：碳循环中CO₂通过光合作用进入生物群落，通过呼吸作用、燃烧和分解返回大气。氮循环包括固氮作用（将N₂转化为NH₃）、硝化作用（NH₃→NO₂⁻→NO₃⁻）、反硝化作用（NO₃⁻→N₂）。 种群的数量特征：种群密度（最基本的数量特征）、出生率和死亡率、迁入率和迁出率、年龄结构（增长型、稳定型、衰退型）、性别比例。种群增长的J型曲线（理想条件下指数增长）和S型曲线（受环境容纳量K限制的逻辑斯蒂增长）。 群落演替：初生演替从没有植被覆盖的地面开始（如裸岩、沙丘），次生演替从原有植被被破坏但保持土壤条件的地方开始（如弃耕农田）。顶级群落是演替发展到与当地气候条件相适应的稳定阶段。 生态系统稳定性：抵抗力稳定性（抵抗干扰保持原状的能力）和恢复力稳定性（受破坏后恢复原状的能力），两者通常呈负相关。', 256, 466218074913739309, '2026-05-14 21:29:00', '75e740dddd3b89204085adcda4479ae21edd301ccfd76639072c64f1720d7314', 'local');
INSERT INTO `knowledge_chunk` VALUES (113, 64, 1, '：抵抗力稳定性（抵抗干扰保持原状的能力）和恢复力稳定性（受破坏后恢复原状的能力），两者通常呈负相关。生物多样性越高，生态系统的抵抗力稳定性越强。', 36, 466218074913739310, '2026-05-14 21:29:00', '457db8ead02b923c0c52cba87265e21a24e9c1b1b06db4da29d4da2814935b03', 'local');
INSERT INTO `knowledge_chunk` VALUES (114, 65, 0, '算法是解决特定问题求解步骤的描述，是有限序列的指令集合。算法的五大特征：有穷性、确定性、可行性、输入和输出。 算法分析的两个核心指标：时间复杂度和空间复杂度。时间复杂度T(n)是算法执行时间随输入规模n增长的增长率。使用大O记号表示渐进上界。常见时间复杂度从小到大排列：O(1) < O(log n) < O(n) < O(nlog n) < O(n²) < O(n³) < O(2ⁿ) < O(n!)。 渐进记号：大O（上界）、大Ω（下界）、大Θ（紧界）。空间复杂度S(n)是算法需要的额外存储空间。', 125, 466218075175624201, '2026-05-14 21:29:01', '63d77e7e12385df12541adbe19498060615928a567f411dc676c4bf0e912641b', 'local');
INSERT INTO `knowledge_chunk` VALUES (115, 66, 0, '分治法将原问题分解为若干个规模较小的子问题，递归求解子问题，然后合并子问题的解。分治法的步骤：分解（Divide）、解决（Conquer）、合并（Combine）。 归并排序是典型的分治算法。将数组递归地分成两半，分别排序，然后合并两个有序子数组。归并排序是稳定的，时间复杂度O(nlog n)，空间复杂度O(n)。 快速排序通过选取基准元素分区，递归排序左右子区间。平均时间复杂度O(nlog n)，最坏O(n²)。空间复杂度O(log n)（递归栈深度）。 最大子数组问题：寻找数组中连续子数组使其和最大。分治解法将数组二分，最大子数组可能完全在左半部分、完全在右半部分或跨越中点。Kadane算法给出了O(n)的动态规划解法。 Strassen矩阵乘法：将两个n×n矩阵相乘的分治算法。通过7次子矩阵乘法（而非直接分治的8次）将时间复杂度从O(n³)降为约O(n^2.81)。', 195, 466218075175624202, '2026-05-14 21:29:01', '304e8615a4e5c1a84c572e46fbdc03e89bfb68518d3dc498eec80bacc7ee82c3', 'local');
INSERT INTO `knowledge_chunk` VALUES (116, 67, 0, '动态规划用于求解具有最优子结构和重叠子问题性质的优化问题。核心思想是用空间换时间，存储子问题结果避免重复计算。 动态规划的基本步骤：分析最优解的结构特征、递归定义最优解的值、自底向上计算最优值、根据计算结果构造最优解。 背包问题：0-1背包（每种物品只能选一次）用二维DP，f[i][j]表示前i件物品放入容量j的背包的最大价值。完全背包（每种物品可选无限次）优化为一维DP。多重背包（每种物品有限件）可二进制拆分优化。 最长公共子序列（LCS）：求两个序列的最长公共子序列。状态转移：若x[i]=y[j]，则f[i][j]=f[i-1][j-1]+1；否则f[i][j]=max(f[i-1][j], f[i][j-1])。 最长递增子序列（LIS）：求数组中严格递增的最长子序列长度。O(n²)的DP解法；O(nlog n)的贪心+二分解法使用tails数组来记录各长度递增子序列的最小末尾值。 编辑距离：将一个字符串转换为另一个字符串的最少操作次数（增删改）。状态转移与LCS类似，广泛应用于拼写检查和DNA序列比对。 矩阵链乘法：选择最优的矩阵乘法顺序使标量乘法次数最少。m[i][j]记录从矩阵i到j的最少乘法次数', 256, 466218075175624203, '2026-05-14 21:29:01', 'ae05e281f1dfca34aa252acf80cb18ae3c319631c00e98d6f9d780f8d2e32bbf', 'local');
INSERT INTO `knowledge_chunk` VALUES (117, 67, 1, ' 矩阵链乘法：选择最优的矩阵乘法顺序使标量乘法次数最少。m[i][j]记录从矩阵i到j的最少乘法次数。 Floyd-Warshall算法：求所有顶点对间的最短路径。d[i][j] = min(d[i][j], d[i][k] + d[k][j])，O(n³)。', 65, 466218075175624204, '2026-05-14 21:29:01', 'b5a8fe096a7c3be214e88f8aedcabf5738e82d4c663bccb468ae04da858b5b05', 'local');
INSERT INTO `knowledge_chunk` VALUES (118, 68, 0, '贪心算法在每一步都选择当前看起来最优的选择，不考虑整体最优。贪心算法需要证明贪心选择性质和最优子结构性质。 活动选择问题：选择最多互不重叠的活动。贪心策略：按结束时间排序，每次选择结束最早且不冲突的活动。可证明此贪心策略得到最优解。 哈夫曼编码：根据字符出现频率构建最优前缀编码。贪心策略：每次从优先队列取出频率最小的两个结点合并为新结点，重复直到只剩一个根结点。哈夫曼编码是平均码长最短的前缀编码。 最小生成树：Prim算法从任意顶点开始，每次选择与当前生成树相连的最小权边；Kruskal算法每次选择全局最小权边（不构成环）。两者都是贪心算法且得到最优解。 Dijkstra最短路径：从源点开始，每次选择距离最短的未访问顶点，并松弛其邻接点。要求边权非负。', 165, 466218075175624205, '2026-05-14 21:29:01', '6c0eede113d699399427c0d46389126c567987b8e1dabbd45f76faf2b232dd06', 'local');
INSERT INTO `knowledge_chunk` VALUES (119, 69, 0, '深度优先搜索（DFS）沿着一条路径走到底，回溯后再尝试其他路径。使用递归或栈实现。适用于连通性判断、拓扑排序、二分图检测、强连通分量等问题。 广度优先搜索（BFS）逐层扩展，使用队列实现。适用于最短路径（无权图）、层次遍历等。BFS在无权图中找到的路径是最短路径。 回溯法是系统搜索问题解空间的方法。从根结点出发，按深度优先策略搜索解空间树。当搜索到某一结点发现不可能得到解时，回溯到父结点尝试其他分支。 N皇后问题：在N×N棋盘上放置N个皇后使互不攻击。回溯法逐行放置皇后，检查是否与已放置的皇后冲突（同列、同对角线）。 子集和问题：判断是否存在子集其元素之和等于目标值。回溯法枚举每个元素选或不选，通过剪枝（剩余元素和小于目标、当前和超出目标）提高效率。 图的着色问题：用最少颜色给图顶点着色，使相邻顶点颜色不同。回溯法尝试为每个顶点分配颜色，Welsh-Powell算法给出了贪心近似解。', 198, 466218075175624206, '2026-05-14 21:29:01', '5dc56d0fd3daa7e5b5c6a5739eb3ec84f8f2f8b4053d6268a5672bbafeb5d91b', 'local');
INSERT INTO `knowledge_chunk` VALUES (120, 70, 0, '朴素匹配：逐个比较模式串和文本串的每个位置，最坏时间复杂度O(mn)。 KMP算法利用模式串的部分匹配表（next数组）实现高效跳跃。next[i]表示模式串前i个字符的最长相同前后缀长度。匹配失败时模式串右移i-next[i]位。时间复杂度O(m+n)。 Boyer-Moore算法从右向左匹配，使用坏字符规则和好后缀规则决定跳跃距离。在实践中最快，尤其适合大字符集。 Rabin-Karp算法使用哈希指纹比较子串。通过滚动哈希在O(1)时间内计算下一个子串的哈希值。需要处理哈希冲突。', 122, 466218075175624207, '2026-05-14 21:29:01', 'c527901d040a93997401c3a87122829799d3d1b6e00062fb76d5484e31addeb5', 'local');
INSERT INTO `knowledge_chunk` VALUES (121, 71, 0, 'P类问题：可以在多项式时间内用确定性算法求解的问题。 NP类问题：可以在多项式时间内用非确定性算法求解的问题（即给定一个解，可以在多项式时间内验证）。 NP完全问题：属于NP类，且所有NP问题都可以多项式归约到它的问题。如布尔可满足性问题（SAT）、旅行商问题（TSP）、顶点覆盖问题、子集和问题等。 NP难问题：至少与NP完全问题一样难，但不一定属于NP类。 遇到NP完全问题时，可使用近似算法（如最小顶点覆盖的2-近似算法）、参数化算法、启发式算法或对小规模输入使用精确算法。', 120, 466218075175624208, '2026-05-14 21:29:01', '65da96cd07a8e667ddbbbcf48b18242586d7e9aa670f44df9fce376c2606c478', 'local');
INSERT INTO `knowledge_chunk` VALUES (122, 72, 0, '英语十大词类：名词（Noun）、代词（Pronoun）、动词（Verb）、形容词（Adjective）、副词（Adverb）、介词（Preposition）、连词（Conjunction）、冠词（Article）、数词（Numeral）、感叹词（Interjection）。 名词可分为可数名词和不可数名词。可数名词有单复数形式，规则复数加-s或-es（以s/x/ch/sh结尾加-es，以辅音+y结尾变y为i加-es）。不可数名词如water、information、advice等，可用量词表达数量（a piece of advice）。 名词所有格：有生命的名词加\'s（Tom\'s book），以s结尾的复数名词加\'（students\' dormitory），无生命的名词用of结构（the cover of the book）。 动词分为实义动词、系动词（be, become, seem, feel等）、情态动词（can, may, must, should等）和助动词（do, have, be）。情态动词表示能力（can）、许可（may）、义务（must）、推测（must/may/might）、建议（shou', 256, 466218075175624230, '2026-05-14 21:29:03', '03d2fe36441abe5ba1611fdcd9acbd9d71648bec6d168db00bcd1e0d29bb010c', 'local');
INSERT INTO `knowledge_chunk` VALUES (123, 72, 1, '力（can）、许可（may）、义务（must）、推测（must/may/might）、建议（should）。', 27, 466218075175624231, '2026-05-14 21:29:03', '575a3d0fb37678ff26586e28857cc611caffd4c97101f345f5c8e2ed33a1bc7a', 'local');
INSERT INTO `knowledge_chunk` VALUES (124, 73, 0, '英语共16种时态，常用8种：一般现在时（do/does）、一般过去时（did）、一般将来时（will do）、现在进行时（am/is/are doing）、过去进行时（was/were doing）、现在完成时（have/has done）、过去完成时（had done）、现在完成进行时（have/has been doing）。 一般现在时：表示经常性动作、客观真理、习惯。标志词：often, usually, always, every day。第三人称单数动词加-s或-es。 现在完成时：强调过去动作对现在的影响或动作从过去延续到现在。have/has + 过去分词。标志词：already, yet, ever, never, since, for, recently。与一般过去时的区别：一般过去时只说明过去发生，与现在无关。 过去完成时：had + 过去分词，表示\"过去的过去\"，即在过去某一时间之前已经完成的动作。常用于描述发生在主句谓语动词之前的动作。 将来时表达方式：will do（客观将来）、be going to do（计划打算）、be about to do（即将）、be to do（安排注', 256, 466218075175624232, '2026-05-14 21:29:03', '7d6f1d218cc6030bb23b1d92e6d13b8df0b61a005122946dc983983c4ad53e70', 'local');
INSERT INTO `knowledge_chunk` VALUES (125, 73, 1, ' going to do（计划打算）、be about to do（即将）、be to do（安排注定）、一般现在时表将来（按时刻表发生）、现在进行时表将来（已安排好的计划）。', 44, 466218075175624233, '2026-05-14 21:29:03', '4e9159c4bba5de48aa3a38401c97cc7745c9c50c9ae40da1ed82013de1d05167', 'local');
INSERT INTO `knowledge_chunk` VALUES (126, 74, 0, '主动语态：主语是动作的执行者。被动语态：主语是动作的承受者，结构为be + 过去分词。被动语态各时态形式通过be动词的变化体现：一般现在时am/is/are done，一般过去时was/were done，现在完成时have/has been done，将来时will be done。 被动语态的使用情境：不知道动作执行者或没必要指出、强调动作承受者、客观描述（学术写作常用）。不及物动词没有被动语态（如happen, appear, disappear, die）。', 117, 466218075175624234, '2026-05-14 21:29:03', '492aff7d77a29de0b5ec5eb037844630015bee2c2f3e810345a3151f2db038b3', 'local');
INSERT INTO `knowledge_chunk` VALUES (127, 75, 0, '名词性从句在句中作主语、宾语、表语或同位语。引导词：that（无词义）、whether/if（是否）、wh-疑问词（what, who, when, where, why, how）。主语从句常用it作形式主语：It is important that...。 定语从句修饰名词或代词。关系代词：who（人，主格）、whom（人，宾格）、whose（所有格）、which（物）、that（人或物）。限制性定语从句不可省略，非限制性定语从句用逗号隔开（不能用that）。关系副词：when（时间）、where（地点）、why（原因）。 状语从句表示时间（when, while, as, before, after, since, until）、条件（if, unless, as long as）、原因（because, since, as）、让步（although, though, even if）、目的（so that, in order that）、结果（so...that, such...that）、比较（as...as, than）等。', 237, 466218075175624235, '2026-05-14 21:29:03', 'f1379144d27d036da17f883c38c8a0d2ff6ad6c16c9947fe4b8d155858b836a8', 'local');
INSERT INTO `knowledge_chunk` VALUES (128, 75, 1, '..as, than）等。', 6, 466218075175624236, '2026-05-14 21:29:03', '2484261f90a1be301c7b6a5b63515558200abe1b07d4c61123261953687d7685', 'local');
INSERT INTO `knowledge_chunk` VALUES (129, 76, 0, '动名词（Gerund）：动词-ing形式作名词用。如Swimming is good exercise。某些动词后只跟动名词：enjoy, avoid, suggest, finish, mind, practice, consider等。 不定式（Infinitive）：to + 动词原形。表示目的、结果、原因等。如I came to see you。某些动词后只跟不定式：decide, hope, want, plan, promise, refuse等。某些动词后两者均可但意义不同：remember/forget/stop/try/regret + doing（已做的事）vs + to do（要做的事）。 分词（Participle）：现在分词（doing，主动/进行）和过去分词（done，被动/完成）。分词作状语表示时间、原因、条件、伴随等，逻辑主语与主句主语一致。独立主格结构中分词有自己的逻辑主语。', 205, 466218075175624237, '2026-05-14 21:29:03', '7b4ba118154e604c6d14a98a71710ef3491229593277af29e069a4d5a813b184', 'local');
INSERT INTO `knowledge_chunk` VALUES (130, 77, 0, '虚拟语气表示假设、愿望、建议等非真实情况。条件句中：与现在事实相反—If I were you, I would go（从句过去式，主句would+动词原形）；与过去事实相反—If I had known, I would have told you（从句had done，主句would have done）；与将来事实相反—If it should rain, the match would be canceled（从句should do，主句would do）。 名词性从句中的虚拟语气：在suggest, recommend, insist, demand, require, request等动词后的that从句中用(should) + 动词原形。It is necessary/important/essential that...中的从句也用虚拟语气。 wish后的宾语从句用虚拟：现在愿望用过去式、过去愿望用had done、将来愿望用would/could do。as if/though引导的从句中，与现在事实相反用过去式，与过去事实相反用had done。', 245, 466218075175624238, '2026-05-14 21:29:03', '261b35dd864b5ade62e82225ccacec3257bb138cfb380ef16862c77d95b25b74', 'local');
INSERT INTO `knowledge_chunk` VALUES (131, 77, 1, '现在事实相反用过去式，与过去事实相反用had done。', 14, 466218075175624239, '2026-05-14 21:29:03', '743e0bb25176ec02360b7d8335181d0019aafa985b39508f10d99f855e98d423', 'local');
INSERT INTO `knowledge_chunk` VALUES (132, 78, 0, '计算机网络是将分散在不同地理位置的计算机系统通过通信设备和线路连接起来，实现资源共享和数据通信的系统。计算机网络按覆盖范围分为：个域网（PAN）、局域网（LAN）、城域网（MAN）、广域网（WAN）和互联网（Internet）。 计算机网络的性能指标：速率（bps）、带宽（Hz或bps）、吞吐量、时延（发送时延、传播时延、处理时延、排队时延）、时延带宽积、往返时间（RTT）、利用率。 计算机网络体系结构：OSI七层模型（物理层-数据链路层-网络层-传输层-会话层-表示层-应用层）和TCP/IP四层模型（网络接口层-网际层-传输层-应用层）。实际教学中通常使用五层模型：物理层-数据链路层-网络层-传输层-应用层。', 154, 466218075175624288, '2026-05-14 21:29:04', 'e4ea81d61ad312068939ca8b50b81e8645f8540629fa3158b353c1e1dcdbb9cc', 'local');
INSERT INTO `knowledge_chunk` VALUES (133, 79, 0, '物理层负责在物理媒介上透明传输比特流。主要技术包括信号编码（曼彻斯特编码、差分曼彻斯特编码）、信道复用（频分复用FDM、时分复用TDM、波分复用WDM、码分复用CDM）。 香农定理给出了信道容量的理论上限：C = W × log2(1 + S/N)，其中C为信道容量，W为信道带宽，S/N为信噪比。奈奎斯特准则给出了无噪声信道的最大数据率：Cmax = 2W × log2(M)，其中M为信号状态数。 物理层传输介质：双绞线（STP/UTP，用于以太网）、同轴电缆、光纤（单模和多模，利用全反射原理）、无线介质（无线电波、微波、红外线、激光）。', 136, 466218075175624289, '2026-05-14 21:29:04', '4f4b08cbadb0a6199e59169edd0d808481fad060a5fef8c3d08b78977afc26a5', 'local');
INSERT INTO `knowledge_chunk` VALUES (134, 80, 0, '数据链路层负责将网络层的数据报封装成帧，在相邻结点间可靠传输。主要功能：成帧、差错控制、流量控制、介质访问控制。 成帧方法：字符计数法、字符填充法（用特殊字符标记帧边界）、零比特填充法（每5个连续的1后插入一个0）、违规编码法。 差错检测：奇偶校验码、循环冗余校验（CRC）。CRC生成多项式如CRC-16和CRC-32广泛应用于网络协议。检验和（Checksum）用于IP头部检验。 点对点协议（PPP）：广泛用于广域网链路。包含LCP（链路控制协议）建立、配置和测试链路，NCP（网络控制协议）支持多种网络层协议。 介质访问控制（MAC）：信道划分协议（FDM/TDM/CDMA）、随机接入协议（ALOHA、CSMA、CSMA/CD、CSMA/CA）和轮流协议（令牌传递、轮询）。 CSMA/CD（载波监听多点接入/碰撞检测）是以太网的核心协议：先听后发、边听边发、冲突停发、随机重发。使用截断二进制指数退避算法确定重传等待时间。 CSMA/CA（碰撞避免）是无线局域网的核心协议，使用RTS/CTS握手机制预约信道，减少碰撞概率。 以太网帧格式：目的MAC地址（6B）+ 源MAC地址（6B）+ 类型/长度（2B）+ ', 256, 466218075175624290, '2026-05-14 21:29:04', '310aca71465b621270b8f7ab203bdf2c914624de9c8dbc47718ae49edd7a87fe', 'local');
INSERT INTO `knowledge_chunk` VALUES (135, 80, 1, '少碰撞概率。 以太网帧格式：目的MAC地址（6B）+ 源MAC地址（6B）+ 类型/长度（2B）+ 数据（46-1500B）+ FCS校验（4B）。MAC地址共48位，前24位为厂商标识，后24位为设备标识。 交换机通过自学习算法建立MAC地址表，实现帧的转发和过滤。生成树协议（STP）用于消除环路。', 75, 466218075175624291, '2026-05-14 21:29:04', 'be560f3375685069c817f5d6467708c2d3d516f49bbe74172ca6c825c728f050', 'local');
INSERT INTO `knowledge_chunk` VALUES (136, 81, 0, '网络层负责将分组从源主机路由到目的主机。核心功能：路由选择和分组转发。 IP协议是TCP/IP体系的核心协议。IPv4地址为32位，采用点分十进制表示，分为A/B/C/D/E五类地址。CIDR（无类别域间路由）使用网络前缀代替分类地址，斜线记法如192.168.1.0/24。 子网划分：从主机号中借用若干位作为子网号，子网掩码用于区分网络位和主机位。VLSM（可变长子网掩码）允许对一个网络使用不同长度的子网掩码。 特殊IP地址：网络地址（主机号全0）、广播地址（主机号全1）、环回地址（127.0.0.1）、私有地址（10.0.0.0/8、172.16.0.0/12、192.168.0.0/16）。 IPv6地址为128位，采用冒号十六进制表示。IPv6相比IPv4的改进：更大的地址空间、更简洁的首部格式、更好的QoS支持、原生支持IPSec安全机制。 ARP（地址解析协议）用于通过IP地址获取MAC地址，工作于广播域内。RARP（逆ARP）通过MAC地址获取IP地址，已被DHCP取代。 ICMP（互联网控制报文协议）用于报告网络错误和诊断信息。PING命令使用ICMP回显请求和回显应答。Traceroute利', 256, 466218075175624292, '2026-05-14 21:29:04', 'ac98b51b0b8aafe79313abd1f9057a0689eefe1db8a61dacdc43a71cdde693cb', 'local');
INSERT INTO `knowledge_chunk` VALUES (137, 81, 1, '协议）用于报告网络错误和诊断信息。PING命令使用ICMP回显请求和回显应答。Traceroute利用ICMP超时报文追踪路由路径。 路由选择协议：内部网关协议包括RIP（基于距离向量算法，最大跳数15）、OSPF（基于链路状态算法，使用Dijkstra最短路径）、EIGRP（思科专有，混合型）。外部网关协议主要是BGP-4（边界网关协议，基于路径向量算法，是互联网的核心路由协议）。 NAT（网络地址转换）允许多个主机共享一个公网IP地址访问互联网，通过映射表转换私有地址和公网地址及端口号。', 124, 466218075175624293, '2026-05-14 21:29:04', 'a437ee11d8bf35abb6002683b07503929eb832a78ca9290a42566b85e3e98bdb', 'local');
INSERT INTO `knowledge_chunk` VALUES (138, 82, 0, '传输层为应用进程间提供端到端的逻辑通信。两个主要协议：TCP和UDP。 UDP（用户数据报协议）是无连接的尽最大努力交付协议，首部仅8字节（源端口、目的端口、长度、检验和）。适用于DNS查询、流媒体、实时通信等对实时性要求高的场景。 TCP（传输控制协议）是面向连接的可靠传输协议。TCP首部20字节固定部分加可变选项。关键字段：序号（字节流编号）、确认号（期望收到的下一字节序号）、窗口（流量控制）、标志位（SYN/ACK/FIN/RST/PSH/URG）。 TCP连接管理：三次握手建立连接（SYN → SYN+ACK → ACK），四次挥手释放连接（FIN → ACK → FIN → ACK）。TIME-WAIT状态持续2MSL时间确保最后一个ACK到达。 TCP可靠传输：超时重传（自适应超时算法）、累计确认、选择确认（SACK）。TCP流量控制使用滑动窗口机制，接收方通过窗口字段告知发送方可接收的字节数。 TCP拥塞控制：慢开始（指数增长拥塞窗口）、拥塞避免（线性增长）、快重传（收到3个重复ACK直接重传）、快恢复（将拥塞窗口减半而非降到1）。拥塞窗口cwnd和慢开始门限ssthresh共同控制发送速率。', 255, 466218075175624294, '2026-05-14 21:29:04', '3f5c430625c2e27b9fb8ee8d98af2d283a27468c14f99e84716f827d993ffa82', 'local');
INSERT INTO `knowledge_chunk` VALUES (139, 82, 1, '快恢复（将拥塞窗口减半而非降到1）。拥塞窗口cwnd和慢开始门限ssthresh共同控制发送速率。', 24, 466218075175624295, '2026-05-14 21:29:04', '418cb3be157af50b083d6fb93a142b1b33c8a038d8634c2fa0efcb9e7734ac77', 'local');
INSERT INTO `knowledge_chunk` VALUES (140, 83, 0, 'DNS（域名系统）：将域名解析为IP地址的分层分布式数据库。域名空间是树形结构，根域、顶级域（gTLD和ccTLD）、二级域、子域。递归查询和迭代查询两种解析方式。 HTTP（超文本传输协议）：无状态的请求-响应协议。HTTP/1.0每请求一个对象建立一次TCP连接；HTTP/1.1支持持久连接和流水线；HTTP/2采用二进制分帧、头部压缩和多路复用；HTTP/3基于QUIC协议。 HTTPS是HTTP over TLS/SSL，通过证书认证和加密通信确保安全性。TLS握手过程：ClientHello → ServerHello + 证书 → 密钥交换 → 加密通信。 FTP（文件传输协议）使用控制连接（端口21）和数据连接（端口20），支持主动模式和被动模式。 SMTP用于发送邮件（端口25），POP3（端口110）和IMAP（端口143）用于接收邮件。 DHCP（动态主机配置协议）自动分配IP地址。过程：DHCP Discover → Offer → Request → ACK。', 224, 466218075175624296, '2026-05-14 21:29:04', 'a19b1489cf587b496303ff87de8716644b8d2530abc2fcb1d70c51ab0cf10ffe', 'local');
INSERT INTO `knowledge_chunk` VALUES (141, 84, 0, '先秦文学：诗经是中国最早的诗歌总集，收录305篇，分为风（民歌）、雅（宫廷音乐）、颂（祭祀音乐）。赋比兴是诗经的三种表现手法。楚辞以屈原的《离骚》为代表，具有浓厚的浪漫主义色彩和楚地文化特色。先秦散文分为历史散文（《尚书》《左传》《国语》《战国策》）和诸子散文（《论语》《孟子》《庄子》《荀子》《韩非子》）。 两汉文学：汉赋是汉代最具代表性的文体，司马相如《子虚赋》、班固《两都赋》为名篇。汉代乐府诗继承了诗经传统，《孔雀东南飞》是汉乐府叙事诗的高峰。古诗十九首是汉代文人五言诗的杰出代表。司马迁《史记》是中国第一部纪传体通史，被鲁迅赞为\"史家之绝唱，无韵之离骚\"。 魏晋南北朝：建安文学以三曹（曹操、曹丕、曹植）和建安七子为代表，风格慷慨悲凉。陶渊明是田园诗派创始人，代表作《归去来兮辞》《桃花源记》。谢灵运开创山水诗派。干宝《搜神记》和刘义庆《世说新语》分别代表志怪小说和志人小说。 唐代文学：唐诗是中国诗歌的巅峰。初唐四杰（王勃、杨炯、卢照邻、骆宾王）开创新风。盛唐以李白（浪漫主义，\"诗仙\"）、杜甫（现实主义，\"诗圣\"）为代表。边塞诗派有高适、岑参；山水田园诗派有王维、孟浩然。中唐白居易倡导新乐府运动。晚唐李商隐、', 256, 466218075175624316, '2026-05-14 21:29:07', '9fe619513b57e16c1d99a4721ae70fc61b64effe3b1ab4a25a622c8c5dbc8fff', 'local');
INSERT INTO `knowledge_chunk` VALUES (142, 84, 1, '\"）为代表。边塞诗派有高适、岑参；山水田园诗派有王维、孟浩然。中唐白居易倡导新乐府运动。晚唐李商隐、杜牧以含蓄婉约著称。韩愈、柳宗元倡导古文运动。唐传奇标志着中国小说进入成熟阶段。 宋代文学：宋词是宋代文学的代表。婉约派以柳永、李清照为代表（\"杨柳岸晓风残月\"）；豪放派以苏轼、辛弃疾为代表（\"大江东去\"）。苏轼开创了以诗为词的风格。陆游是南宋伟大的爱国诗人。古文方面，欧阳修、王安石、曾巩、苏洵、苏轼、苏辙继承古文运动。 元明清文学：元曲分杂剧和散曲。关汉卿《窦娥冤》、王实甫《西厢记》为杂剧名作。明代四大奇书：《三国演义》《水浒传》《西游记》《金瓶梅》。清代曹雪芹《红楼梦》是中国古典小说巅峰之作。蒲松龄《聊斋志异》为文言短篇小说集。吴敬梓《儒林外史》是杰出的讽刺小说。', 168, 466218075175624317, '2026-05-14 21:29:07', '5a953b07feae69353d04bd5ab648c0b62e568b595d2096eec0dcde94f4e909b3', 'local');
INSERT INTO `knowledge_chunk` VALUES (143, 85, 0, '鲁迅是中国现代文学的奠基人，代表作短篇小说集《呐喊》《彷徨》，散文诗集《野草》，杂文集《且介亭杂文》等。《狂人日记》是中国第一部现代白话小说。 郭沫若的《女神》开创新诗一代诗风。茅盾《子夜》是30年代左翼文学代表作。巴金《家》是家庭小说的经典。老舍《骆驼祥子》描写北京底层市民生活。沈从文《边城》展现湘西风土人情。钱钟书《围城》以讽刺手法描写知识分子。', 88, 466218075175624318, '2026-05-14 21:29:07', '041fd03e65d34b1a7b876ff42c9f698824770fa3dc0465ad86a89769274a7dd7', 'local');
INSERT INTO `knowledge_chunk` VALUES (144, 86, 0, '比喻：用相似的事物说明另一事物。明喻（用\"像\"\"如\"连接）、暗喻（\"是\"\"成为\"）、借喻（直接代指）。比拟：拟人（赋物以人性）和拟物（人以物性）。夸张：对事物的特征进行夸大或缩小的描述。对偶：字数相等、结构相同、意义相关的两个句子。排比：三个或以上结构相似的句子排列，增强语势。反复：有意重复使用某词语或句子，增强表达效果。设问：自问自答，引起思考。反问：用疑问句式表达肯定或否定的意思。', 97, 466218075175624319, '2026-05-14 21:29:07', '98f2815c75870435f1e100542680a59147975b637097b4e64c19e572ca94f50c', 'local');
INSERT INTO `knowledge_chunk` VALUES (145, 87, 0, '记叙文的六要素：时间、地点、人物、起因、经过、结果。记叙顺序包括顺叙（按时间）、倒叙（先写结局）、插叙（插入相关回忆）。描写方法：正面描写、侧面描写；语言描写、动作描写、神态描写、心理描写、外貌描写。 议论文三要素：论点（作者观点）、论据（事实论据、道理论据）、论证（举例论证、道理论证、对比论证、比喻论证、引用论证）。论证结构有总分式、平行式和递进式。 说明文的说明方法：举例子、列数字、作比较、打比方、分类别、下定义、作诠释、摹状貌、画图表等。说明顺序：时间顺序、空间顺序、逻辑顺序。', 122, 466218075175624320, '2026-05-14 21:29:07', 'dc498e49deca877a28ea2e43f99a2e6e01f96a5341d7bfcc5e4aabefeb21976a', 'local');
INSERT INTO `knowledge_chunk` VALUES (146, 88, 0, '函数是两个集合之间的映射关系f: X→Y，使得X中的每个元素x在Y中都有唯一确定的元素y与之对应。基本初等函数包括常函数、幂函数、指数函数、对数函数、三角函数和反三角函数。 数列极限定义：对于任意ε>0，存在正整数N，当n>N时，|xn-A|<ε，则称数列{xn}以A为极限。函数极限：x趋近于x0时，f(x)趋近于A，即对于任意ε>0，存在δ>0，使0<|x-x0|<δ时，|f(x)-A|<ε。 两个重要极限：lim(x→0) sinx/x = 1和lim(x→∞) (1+1/x)^x = e。e是无理数，约等于2.71828，是自然对数的底数。 无穷小量是以0为极限的变量。无穷小量的比较：若lim(α/β)=0，称α是β的高阶无穷小；若lim(α/β)=c(非零常数)，称α和β是同阶无穷小；若lim(α/β)=1，称α和β是等价无穷小。等价无穷小替换是求极限的重要方法。', 195, 466218074913739471, '2026-05-14 21:29:08', '1fd08994e494f3eb27478f1446e1331cdf62479e289265f8c43a87dd5d5875ce', 'local');
INSERT INTO `knowledge_chunk` VALUES (147, 89, 0, '导数定义：f\'(x0) = lim(Δx→0) [f(x0+Δx)-f(x0)]/Δx。导数表示函数在某点处的瞬时变化率，几何意义是曲线在该点切线的斜率。 求导法则：四则运算求导法则、复合函数链式法则、反函数求导法则、隐函数求导法、参数方程求导法。基本导数公式：(x^n)\' = nx^(n-1)、(sinx)\' = cosx、(cosx)\' = -sinx、(e^x)\' = e^x、(lnx)\' = 1/x。 微分定义：dy = f\'(x)dx。微分是函数增量的线性主要部分。一阶微分形式不变性：无论x是自变量还是中间变量，dy = f\'(u)du始终成立。 高阶导数：f\'\'(x) = (f\'(x))\'。莱布尼茨公式用于求两个函数乘积的n阶导数。 中值定理：罗尔定理（端点值相等，必存在点使导数为0）、拉格朗日中值定理（必存在点使切线斜率等于割线斜率）、柯西中值定理（两个函数的变化率之比等于其导数之比）。 洛必达法则：对于0/0或∞/∞型未定式，lim f(x)/g(x) = lim f\'(x)/g\'(x)（若导函数比值的极限存在）。需注意验证条件。 泰勒公式：f(x) = f(x0) + f\'(x0)(x-x0', 256, 466218074913739472, '2026-05-14 21:29:08', '6fb04ecfec53bedf695a0f2ac5ad2b4618f2c4ab6232fa671545b365148eb41c', 'local');
INSERT INTO `knowledge_chunk` VALUES (148, 89, 1, '数比值的极限存在）。需注意验证条件。 泰勒公式：f(x) = f(x0) + f\'(x0)(x-x0) + f\'\'(x0)(x-x0)²/2! + ... + f(n)(x0)(x-x0)^n/n! + Rn(x)。麦克劳林公式是x0=0的特例。常见函数的麦克劳林展开：e^x = 1 + x + x²/2! + x³/3! + ...；sinx = x - x³/3! + x⁵/5! - ...；cosx = 1 - x²/2! + x⁴/4! - ...。', 115, 466218074913739473, '2026-05-14 21:29:08', 'cbe8cf9d063be5dbe3965bc06a9246fb9d5674901f59cbc54132d542e0344c1d', 'local');
INSERT INTO `knowledge_chunk` VALUES (149, 90, 0, '不定积分是求导的逆运算，∫f(x)dx = F(x) + C，其中F\'(x) = f(x)。积分法：直接积分法、第一类换元法（凑微分法）、第二类换元法（三角代换、根式代换）、分部积分法∫udv = uv - ∫vdu。 定积分∫[a,b]f(x)dx的几何意义是曲线下与x轴之间的有向面积。牛顿-莱布尼茨公式∫[a,b]f(x)dx = F(b) - F(a)沟通了定积分与不定积分。 定积分的应用：求平面图形的面积（直角坐标和极坐标）、旋转体的体积、曲线的弧长、变力做功、液体压力、函数平均值。', 124, 466218074913739474, '2026-05-14 21:29:08', 'c5e74c477c290a3fa98283bca2b434d04e6225ec1ede342a8fc8e5e30f958cff', 'local');
INSERT INTO `knowledge_chunk` VALUES (150, 91, 0, '多元函数的偏导数：∂f/∂x表示固定y后对x求导。全微分：dz = (∂z/∂x)dx + (∂z/∂y)dy。方向导数表示函数沿某方向的变化率；梯度∇f = (∂f/∂x, ∂f/∂y)是方向导数取最大值的方向。 二重积分∬f(x,y)dxdy表示曲顶柱体的体积。计算时转化为二次积分（先对x积分再对y积分，或相反）。极坐标变换：x=rcosθ, y=rsinθ, dxdy=rdrdθ。', 97, 466218074913739475, '2026-05-14 21:29:08', 'ea119f6c5230584207fa5b9b0997048c07f019049a2cc733b6f359cfa7306bab', 'local');
INSERT INTO `knowledge_chunk` VALUES (151, 92, 0, '微分方程是包含未知函数及其导数的方程。常微分方程（ODE）的阶数是出现的最高阶导数的阶数。 一阶微分方程：可分离变量方程dy/dx=g(x)h(y)；齐次方程dy/dx=f(y/x)；一阶线性方程dy/dx+P(x)y=Q(x)，通解公式y=e^(-∫Pdx)[∫Qe^(∫Pdx)dx+C]。 二阶常系数齐次线性微分方程y\'\'+py\'+qy=0的特征方程r²+pr+q=0。若两不等实根r1≠r2，通解y=C1e^(r1x)+C2e^(r2x)；若相等实根r，y=(C1+C2x)e^(rx)；若共轭复根α±βi，通解y=e^(αx)(C1cosβx+C2sinβx)。', 143, 466218074913739476, '2026-05-14 21:29:08', '26f847825f3832b881949295f17bf58ba4c88b1f8d8494c0db864cad7170b651', 'local');
INSERT INTO `knowledge_chunk` VALUES (152, 93, 0, '数项级数Σan的部分和Sn=∑an，若lim Sn=S存在，称级数收敛于S。等比级数（几何级数）Σar^n在|r|<1时收敛，和a/(1-r)。p-级数Σ1/n^p当p>1时收敛，p≤1时发散。 幂级数Σan(x-x0)^n的收敛半径R由比值法或根值法确定。在(-R,R)内收敛（端点需单独判断）。和函数在收敛区间内可逐项求导和逐项积分。 傅里叶级数：周期函数f(x)展开为三角函数级数。a0/2 + Σ(an cos nx + bn sin nx)，其中an和bn由欧拉-傅里叶公式确定。傅里叶级数在信号处理、热传导等领域广泛应用。', 133, 466218074913739477, '2026-05-14 21:29:08', 'bf6d5c4e3191dfe57fd2d206524248acf60773bef987740076eb45a2d32acf12', 'local');

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
  `source` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'upload' COMMENT '来源: upload/k12textbook/ceval',
  `source_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '原始来源URL或数据集ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_subject`(`subject`) USING BTREE,
  INDEX `idx_status`(`status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库文档表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_document
-- ----------------------------
INSERT INTO `knowledge_document` VALUES (2, '01_数据结构核心知识', '通用', '01_数据结构核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778589256564_01_数据结构核心知识.docx', 'docx', 18049, 6, 2, 2, '2026-05-12 20:34:17', '2026-05-12 20:34:17', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (3, '02_操作系统核心知识', '通用', '02_操作系统核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778590037546_02_操作系统核心知识.docx', 'docx', 17418, 5, 2, 2, '2026-05-12 20:47:18', '2026-05-12 20:47:18', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (4, '03_计算机网络核心知识', '通用', '03_计算机网络核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778590049649_03_计算机网络核心知识.docx', 'docx', 20566, 7, 2, 2, '2026-05-12 20:47:30', '2026-05-12 20:47:30', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (5, '04_数据库原理核心知识', '通用', '04_数据库原理核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778590061215_04_数据库原理核心知识.docx', 'docx', 20499, 7, 2, 2, '2026-05-12 20:47:41', '2026-05-12 20:47:41', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (6, '05_算法设计与分析核心知识', '通用', '05_算法设计与分析核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778590071810_05_算法设计与分析核心知识.docx', 'docx', 20346, 6, 2, 2, '2026-05-12 20:47:52', '2026-05-12 20:47:52', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (7, '06_Java程序设计核心知识', '通用', '06_Java程序设计核心知识.docx', 'E:\\t\\桌面\\毕业设计\\毕设项目代码\\itas-backend\\uploads\\1778590081617_06_Java程序设计核心知识.docx', 'docx', 20048, 8, 2, 2, '2026-05-12 20:48:02', '2026-05-12 20:48:02', 0, 'upload', NULL);
INSERT INTO `knowledge_document` VALUES (8, '一元二次方程求解', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 207, 1, 2, 1, '2026-05-14 21:16:33', '2026-05-14 21:16:33', 0, 'k12textbook', 'k12-math-quadratic');
INSERT INTO `knowledge_document` VALUES (9, '勾股定理', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 190, 1, 2, 1, '2026-05-14 21:16:33', '2026-05-14 21:16:33', 0, 'k12textbook', 'k12-math-pythagorean');
INSERT INTO `knowledge_document` VALUES (10, '三角函数基础', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 207, 1, 2, 1, '2026-05-14 21:16:33', '2026-05-14 21:16:33', 0, 'k12textbook', 'k12-math-trigonometry');
INSERT INTO `knowledge_document` VALUES (11, '数据结构考题1', '数据结构', 'ceval.jsonl', '', 'jsonl', 219, 1, 2, 1, '2026-05-14 21:16:34', '2026-05-14 21:16:34', 0, 'ceval', 'ceval-ds-stack-queue');
INSERT INTO `knowledge_document` VALUES (12, '数据结构考题2', '数据结构', 'ceval.jsonl', '', 'jsonl', 235, 1, 2, 1, '2026-05-14 21:16:34', '2026-05-14 21:16:34', 0, 'ceval', 'ceval-ds-bst');
INSERT INTO `knowledge_document` VALUES (13, '数据结构考题3', '数据结构', 'ceval.jsonl', '', 'jsonl', 189, 1, 2, 1, '2026-05-14 21:16:34', '2026-05-14 21:16:34', 0, 'ceval', 'ceval-ds-hash');
INSERT INTO `knowledge_document` VALUES (14, '一元二次方程求解', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 207, 0, 2, 1, '2026-05-14 21:17:08', '2026-05-14 21:17:08', 0, 'k12textbook', 'k12-math-quadratic');
INSERT INTO `knowledge_document` VALUES (15, '勾股定理', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 190, 0, 2, 1, '2026-05-14 21:17:08', '2026-05-14 21:17:08', 0, 'k12textbook', 'k12-math-pythagorean');
INSERT INTO `knowledge_document` VALUES (16, '三角函数基础', '高等数学', 'k12textbook.jsonl', '', 'jsonl', 207, 0, 2, 1, '2026-05-14 21:17:08', '2026-05-14 21:17:08', 0, 'k12textbook', 'k12-math-trigonometry');
INSERT INTO `knowledge_document` VALUES (17, 'Java程序设计 - 一、Java语言基础', 'Java程序设计', 'local.jsonl', '', 'jsonl', 295, 1, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s00');
INSERT INTO `knowledge_document` VALUES (18, 'Java程序设计 - 二、面向对象编程', 'Java程序设计', 'local.jsonl', '', 'jsonl', 498, 2, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s01');
INSERT INTO `knowledge_document` VALUES (19, 'Java程序设计 - 三、异常处理', 'Java程序设计', 'local.jsonl', '', 'jsonl', 449, 1, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s02');
INSERT INTO `knowledge_document` VALUES (20, 'Java程序设计 - 四、集合框架', 'Java程序设计', 'local.jsonl', '', 'jsonl', 539, 2, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s03');
INSERT INTO `knowledge_document` VALUES (21, 'Java程序设计 - 五、多线程与并发', 'Java程序设计', 'local.jsonl', '', 'jsonl', 820, 2, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s04');
INSERT INTO `knowledge_document` VALUES (22, 'Java程序设计 - 六、Java新特性', 'Java程序设计', 'local.jsonl', '', 'jsonl', 678, 2, 2, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47', 0, 'local', '06_Java程序设计核心知识-s05');
INSERT INTO `knowledge_document` VALUES (23, '中国历史 - 一、先秦时期', '中国历史', 'local.jsonl', '', 'jsonl', 343, 1, 2, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49', 0, 'local', '12_中国历史概要-s00');
INSERT INTO `knowledge_document` VALUES (24, '中国历史 - 二、秦汉时期', '中国历史', 'local.jsonl', '', 'jsonl', 292, 1, 2, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49', 0, 'local', '12_中国历史概要-s01');
INSERT INTO `knowledge_document` VALUES (25, '中国历史 - 三、魏晋南北朝至隋唐', '中国历史', 'local.jsonl', '', 'jsonl', 326, 1, 2, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49', 0, 'local', '12_中国历史概要-s02');
INSERT INTO `knowledge_document` VALUES (26, '中国历史 - 四、宋元时期', '中国历史', 'local.jsonl', '', 'jsonl', 203, 1, 2, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49', 0, 'local', '12_中国历史概要-s03');
INSERT INTO `knowledge_document` VALUES (27, '中国历史 - 五、明清时期', '中国历史', 'local.jsonl', '', 'jsonl', 324, 1, 2, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49', 0, 'local', '12_中国历史概要-s04');
INSERT INTO `knowledge_document` VALUES (28, '化学基础 - 一、物质结构与元素周期律', '化学基础', 'local.jsonl', '', 'jsonl', 429, 1, 2, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51', 0, 'local', '09_化学基础知识-s00');
INSERT INTO `knowledge_document` VALUES (29, '化学基础 - 二、化学反应与能量', '化学基础', 'local.jsonl', '', 'jsonl', 420, 1, 2, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51', 0, 'local', '09_化学基础知识-s01');
INSERT INTO `knowledge_document` VALUES (30, '化学基础 - 三、重要的无机物', '化学基础', 'local.jsonl', '', 'jsonl', 348, 1, 2, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51', 0, 'local', '09_化学基础知识-s02');
INSERT INTO `knowledge_document` VALUES (31, '化学基础 - 四、有机化学基础', '化学基础', 'local.jsonl', '', 'jsonl', 334, 1, 2, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51', 0, 'local', '09_化学基础知识-s03');
INSERT INTO `knowledge_document` VALUES (32, '化学基础 - 五、电化学', '化学基础', 'local.jsonl', '', 'jsonl', 396, 1, 2, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51', 0, 'local', '09_化学基础知识-s04');
INSERT INTO `knowledge_document` VALUES (33, '地理基础 - 一、自然地理', '地理基础', 'local.jsonl', '', 'jsonl', 709, 2, 2, 1, '2026-05-14 21:28:52', '2026-05-14 21:28:52', 0, 'local', '13_地理基础知识-s00');
INSERT INTO `knowledge_document` VALUES (34, '地理基础 - 二、人文地理', '地理基础', 'local.jsonl', '', 'jsonl', 463, 1, 2, 1, '2026-05-14 21:28:52', '2026-05-14 21:28:52', 0, 'local', '13_地理基础知识-s01');
INSERT INTO `knowledge_document` VALUES (35, '地理基础 - 三、中国地理', '地理基础', 'local.jsonl', '', 'jsonl', 460, 1, 2, 1, '2026-05-14 21:28:52', '2026-05-14 21:28:52', 0, 'local', '13_地理基础知识-s02');
INSERT INTO `knowledge_document` VALUES (36, '地理基础 - 四、世界地理', '地理基础', 'local.jsonl', '', 'jsonl', 424, 1, 2, 1, '2026-05-14 21:28:52', '2026-05-14 21:28:52', 0, 'local', '13_地理基础知识-s03');
INSERT INTO `knowledge_document` VALUES (37, '大学物理 - 一、力学', '大学物理', 'local.jsonl', '', 'jsonl', 371, 1, 2, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53', 0, 'local', '08_大学物理基础-s00');
INSERT INTO `knowledge_document` VALUES (38, '大学物理 - 二、电磁学', '大学物理', 'local.jsonl', '', 'jsonl', 476, 2, 2, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53', 0, 'local', '08_大学物理基础-s01');
INSERT INTO `knowledge_document` VALUES (39, '大学物理 - 三、热学', '大学物理', 'local.jsonl', '', 'jsonl', 238, 1, 2, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53', 0, 'local', '08_大学物理基础-s02');
INSERT INTO `knowledge_document` VALUES (40, '大学物理 - 四、光学', '大学物理', 'local.jsonl', '', 'jsonl', 225, 1, 2, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53', 0, 'local', '08_大学物理基础-s03');
INSERT INTO `knowledge_document` VALUES (41, '大学物理 - 五、近代物理', '大学物理', 'local.jsonl', '', 'jsonl', 417, 1, 2, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53', 0, 'local', '08_大学物理基础-s04');
INSERT INTO `knowledge_document` VALUES (42, '操作系统 - 一、操作系统概述', '操作系统', 'local.jsonl', '', 'jsonl', 156, 1, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s00');
INSERT INTO `knowledge_document` VALUES (43, '操作系统 - 二、进程与线程', '操作系统', 'local.jsonl', '', 'jsonl', 316, 1, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s01');
INSERT INTO `knowledge_document` VALUES (44, '操作系统 - 三、进程同步与死锁', '操作系统', 'local.jsonl', '', 'jsonl', 442, 1, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s02');
INSERT INTO `knowledge_document` VALUES (45, '操作系统 - 四、内存管理', '操作系统', 'local.jsonl', '', 'jsonl', 497, 2, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s03');
INSERT INTO `knowledge_document` VALUES (46, '操作系统 - 五、文件系统', '操作系统', 'local.jsonl', '', 'jsonl', 398, 1, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s04');
INSERT INTO `knowledge_document` VALUES (47, '操作系统 - 六、I/O设备管理', '操作系统', 'local.jsonl', '', 'jsonl', 285, 1, 2, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55', 0, 'local', '02_操作系统核心知识-s05');
INSERT INTO `knowledge_document` VALUES (48, '数据库原理 - 一、数据库系统概述', '数据库原理', 'local.jsonl', '', 'jsonl', 266, 1, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s00');
INSERT INTO `knowledge_document` VALUES (49, '数据库原理 - 二、关系数据库', '数据库原理', 'local.jsonl', '', 'jsonl', 273, 1, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s01');
INSERT INTO `knowledge_document` VALUES (50, '数据库原理 - 三、SQL语言', '数据库原理', 'local.jsonl', '', 'jsonl', 718, 2, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s02');
INSERT INTO `knowledge_document` VALUES (51, '数据库原理 - 四、数据库设计', '数据库原理', 'local.jsonl', '', 'jsonl', 458, 1, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s03');
INSERT INTO `knowledge_document` VALUES (52, '数据库原理 - 五、事务与并发控制', '数据库原理', 'local.jsonl', '', 'jsonl', 561, 2, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s04');
INSERT INTO `knowledge_document` VALUES (53, '数据库原理 - 六、索引与查询优化', '数据库原理', 'local.jsonl', '', 'jsonl', 435, 1, 2, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56', 0, 'local', '04_数据库原理核心知识-s05');
INSERT INTO `knowledge_document` VALUES (54, '数据结构 - 一、线性表', '数据结构', 'local.jsonl', '', 'jsonl', 308, 1, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s00');
INSERT INTO `knowledge_document` VALUES (55, '数据结构 - 二、栈与队列', '数据结构', 'local.jsonl', '', 'jsonl', 205, 1, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s01');
INSERT INTO `knowledge_document` VALUES (56, '数据结构 - 三、树与二叉树', '数据结构', 'local.jsonl', '', 'jsonl', 496, 2, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s02');
INSERT INTO `knowledge_document` VALUES (57, '数据结构 - 四、图', '数据结构', 'local.jsonl', '', 'jsonl', 451, 1, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s03');
INSERT INTO `knowledge_document` VALUES (58, '数据结构 - 五、查找', '数据结构', 'local.jsonl', '', 'jsonl', 304, 1, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s04');
INSERT INTO `knowledge_document` VALUES (59, '数据结构 - 六、排序', '数据结构', 'local.jsonl', '', 'jsonl', 539, 2, 2, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58', 0, 'local', '01_数据结构核心知识-s05');
INSERT INTO `knowledge_document` VALUES (60, '生物基础 - 一、细胞——生命的基本单位', '生物基础', 'local.jsonl', '', 'jsonl', 476, 2, 2, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00', 0, 'local', '14_生物基础知识-s00');
INSERT INTO `knowledge_document` VALUES (61, '生物基础 - 二、细胞代谢', '生物基础', 'local.jsonl', '', 'jsonl', 487, 2, 2, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00', 0, 'local', '14_生物基础知识-s01');
INSERT INTO `knowledge_document` VALUES (62, '生物基础 - 三、遗传与变异', '生物基础', 'local.jsonl', '', 'jsonl', 456, 1, 2, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00', 0, 'local', '14_生物基础知识-s02');
INSERT INTO `knowledge_document` VALUES (63, '生物基础 - 四、进化', '生物基础', 'local.jsonl', '', 'jsonl', 210, 1, 2, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00', 0, 'local', '14_生物基础知识-s03');
INSERT INTO `knowledge_document` VALUES (64, '生物基础 - 五、生态学', '生物基础', 'local.jsonl', '', 'jsonl', 539, 2, 2, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00', 0, 'local', '14_生物基础知识-s04');
INSERT INTO `knowledge_document` VALUES (65, '算法设计与分析 - 一、算法基础', '算法设计与分析', 'local.jsonl', '', 'jsonl', 253, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s00');
INSERT INTO `knowledge_document` VALUES (66, '算法设计与分析 - 二、分治法', '算法设计与分析', 'local.jsonl', '', 'jsonl', 395, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s01');
INSERT INTO `knowledge_document` VALUES (67, '算法设计与分析 - 三、动态规划', '算法设计与分析', 'local.jsonl', '', 'jsonl', 599, 2, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s02');
INSERT INTO `knowledge_document` VALUES (68, '算法设计与分析 - 四、贪心算法', '算法设计与分析', 'local.jsonl', '', 'jsonl', 334, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s03');
INSERT INTO `knowledge_document` VALUES (69, '算法设计与分析 - 五、搜索与回溯', '算法设计与分析', 'local.jsonl', '', 'jsonl', 402, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s04');
INSERT INTO `knowledge_document` VALUES (70, '算法设计与分析 - 六、字符串匹配算法', '算法设计与分析', 'local.jsonl', '', 'jsonl', 247, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s05');
INSERT INTO `knowledge_document` VALUES (71, '算法设计与分析 - 七、计算复杂性理论', '算法设计与分析', 'local.jsonl', '', 'jsonl', 241, 1, 2, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01', 0, 'local', '05_算法设计与分析核心知识-s06');
INSERT INTO `knowledge_document` VALUES (72, '英语语法 - 一、词类（Parts of Speech）', '英语语法', 'local.jsonl', '', 'jsonl', 519, 2, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s00');
INSERT INTO `knowledge_document` VALUES (73, '英语语法 - 二、时态（Tenses）', '英语语法', 'local.jsonl', '', 'jsonl', 554, 2, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s01');
INSERT INTO `knowledge_document` VALUES (74, '英语语法 - 三、语态（Voice）', '英语语法', 'local.jsonl', '', 'jsonl', 236, 1, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s02');
INSERT INTO `knowledge_document` VALUES (75, '英语语法 - 四、从句（Clauses）', '英语语法', 'local.jsonl', '', 'jsonl', 477, 2, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s03');
INSERT INTO `knowledge_document` VALUES (76, '英语语法 - 五、非谓语动词（Non-finite Verbs）', '英语语法', 'local.jsonl', '', 'jsonl', 412, 1, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s04');
INSERT INTO `knowledge_document` VALUES (77, '英语语法 - 六、虚拟语气（Subjunctive Mood）', '英语语法', 'local.jsonl', '', 'jsonl', 492, 2, 2, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03', 0, 'local', '10_英语语法基础-s05');
INSERT INTO `knowledge_document` VALUES (78, '计算机网络 - 一、计算机网络概述', '计算机网络', 'local.jsonl', '', 'jsonl', 311, 1, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s00');
INSERT INTO `knowledge_document` VALUES (79, '计算机网络 - 二、物理层', '计算机网络', 'local.jsonl', '', 'jsonl', 274, 1, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s01');
INSERT INTO `knowledge_document` VALUES (80, '计算机网络 - 三、数据链路层', '计算机网络', 'local.jsonl', '', 'jsonl', 621, 2, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s02');
INSERT INTO `knowledge_document` VALUES (81, '计算机网络 - 四、网络层', '计算机网络', 'local.jsonl', '', 'jsonl', 718, 2, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s03');
INSERT INTO `knowledge_document` VALUES (82, '计算机网络 - 五、传输层', '计算机网络', 'local.jsonl', '', 'jsonl', 516, 2, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s04');
INSERT INTO `knowledge_document` VALUES (83, '计算机网络 - 六、应用层', '计算机网络', 'local.jsonl', '', 'jsonl', 453, 1, 2, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04', 0, 'local', '03_计算机网络核心知识-s05');
INSERT INTO `knowledge_document` VALUES (84, '语文文学 - 一、中国古代文学', '语文文学', 'local.jsonl', '', 'jsonl', 804, 2, 2, 1, '2026-05-14 21:29:07', '2026-05-14 21:29:07', 0, 'local', '11_语文文学常识-s00');
INSERT INTO `knowledge_document` VALUES (85, '语文文学 - 二、中国现代文学', '语文文学', 'local.jsonl', '', 'jsonl', 177, 1, 2, 1, '2026-05-14 21:29:07', '2026-05-14 21:29:07', 0, 'local', '11_语文文学常识-s01');
INSERT INTO `knowledge_document` VALUES (86, '语文文学 - 三、常见修辞手法', '语文文学', 'local.jsonl', '', 'jsonl', 194, 1, 2, 1, '2026-05-14 21:29:07', '2026-05-14 21:29:07', 0, 'local', '11_语文文学常识-s02');
INSERT INTO `knowledge_document` VALUES (87, '语文文学 - 四、写作基本要素', '语文文学', 'local.jsonl', '', 'jsonl', 246, 1, 2, 1, '2026-05-14 21:29:07', '2026-05-14 21:29:07', 0, 'local', '11_语文文学常识-s03');
INSERT INTO `knowledge_document` VALUES (88, '高等数学 - 一、函数与极限', '高等数学', 'local.jsonl', '', 'jsonl', 394, 1, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s00');
INSERT INTO `knowledge_document` VALUES (89, '高等数学 - 二、导数与微分', '高等数学', 'local.jsonl', '', 'jsonl', 699, 2, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s01');
INSERT INTO `knowledge_document` VALUES (90, '高等数学 - 三、不定积分与定积分', '高等数学', 'local.jsonl', '', 'jsonl', 250, 1, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s02');
INSERT INTO `knowledge_document` VALUES (91, '高等数学 - 四、多元函数微积分', '高等数学', 'local.jsonl', '', 'jsonl', 196, 1, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s03');
INSERT INTO `knowledge_document` VALUES (92, '高等数学 - 五、微分方程', '高等数学', 'local.jsonl', '', 'jsonl', 288, 1, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s04');
INSERT INTO `knowledge_document` VALUES (93, '高等数学 - 六、无穷级数', '高等数学', 'local.jsonl', '', 'jsonl', 269, 1, 2, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08', 0, 'local', '07_高等数学基础-s05');

-- ----------------------------
-- Table structure for knowledge_import_task
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_import_task`;
CREATE TABLE `knowledge_import_task`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `batch_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '批次号',
  `dataset_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '数据集名称',
  `subject` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '导入学科',
  `total_items` int(0) DEFAULT 0 COMMENT '总条数',
  `success_items` int(0) DEFAULT 0 COMMENT '成功数',
  `skip_items` int(0) DEFAULT 0 COMMENT '跳过数',
  `fail_items` int(0) DEFAULT 0 COMMENT '失败数',
  `total_chunks` int(0) DEFAULT 0 COMMENT '总chunk数',
  `status` tinyint(0) DEFAULT 0 COMMENT '0=进行中,1=完成,2=失败',
  `error_msg` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '错误信息',
  `operator_id` bigint(0) DEFAULT NULL COMMENT '操作人ID',
  `created_at` datetime(0) DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime(0) DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `batch_no`(`batch_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '知识库批量导入任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of knowledge_import_task
-- ----------------------------
INSERT INTO `knowledge_import_task` VALUES (1, 'd5a59b0af43546b8', 'k12textbook', NULL, 3, 3, 0, 0, 3, 1, NULL, 1, '2026-05-14 21:16:33', '2026-05-14 21:16:33');
INSERT INTO `knowledge_import_task` VALUES (2, '8657f647035b4a69', 'ceval', NULL, 3, 3, 0, 0, 3, 1, NULL, 1, '2026-05-14 21:16:34', '2026-05-14 21:16:34');
INSERT INTO `knowledge_import_task` VALUES (3, '816f59167e9340d7', 'k12textbook', NULL, 3, 0, 3, 0, 0, 1, NULL, 1, '2026-05-14 21:17:08', '2026-05-14 21:17:08');
INSERT INTO `knowledge_import_task` VALUES (4, 'dbbab9a9ef674666', 'k12textbook', NULL, 3, 0, 3, 0, 0, 1, NULL, 1, '2026-05-14 21:19:53', '2026-05-14 21:19:53');
INSERT INTO `knowledge_import_task` VALUES (5, '9387ba0a544b4a91', 'local', NULL, 6, 6, 0, 0, 10, 1, NULL, 1, '2026-05-14 21:28:47', '2026-05-14 21:28:47');
INSERT INTO `knowledge_import_task` VALUES (6, '3a8455a9b6314b37', 'local', NULL, 5, 5, 0, 0, 5, 1, NULL, 1, '2026-05-14 21:28:49', '2026-05-14 21:28:49');
INSERT INTO `knowledge_import_task` VALUES (7, 'b1a09e5c514548f4', 'local', NULL, 5, 5, 0, 0, 5, 1, NULL, 1, '2026-05-14 21:28:51', '2026-05-14 21:28:51');
INSERT INTO `knowledge_import_task` VALUES (8, '865466940628497a', 'local', NULL, 4, 4, 0, 0, 5, 1, NULL, 1, '2026-05-14 21:28:52', '2026-05-14 21:28:52');
INSERT INTO `knowledge_import_task` VALUES (9, '3ed236e931204a54', 'local', NULL, 5, 5, 0, 0, 6, 1, NULL, 1, '2026-05-14 21:28:53', '2026-05-14 21:28:53');
INSERT INTO `knowledge_import_task` VALUES (10, '9a99afce5abc4c1c', 'local', NULL, 6, 6, 0, 0, 7, 1, NULL, 1, '2026-05-14 21:28:55', '2026-05-14 21:28:55');
INSERT INTO `knowledge_import_task` VALUES (11, 'f491441e9bf74711', 'local', NULL, 6, 6, 0, 0, 8, 1, NULL, 1, '2026-05-14 21:28:56', '2026-05-14 21:28:56');
INSERT INTO `knowledge_import_task` VALUES (12, '1c14f24670d041ee', 'local', NULL, 6, 6, 0, 0, 8, 1, NULL, 1, '2026-05-14 21:28:58', '2026-05-14 21:28:58');
INSERT INTO `knowledge_import_task` VALUES (13, '43979052ed5743a9', 'local', NULL, 5, 5, 0, 0, 8, 1, NULL, 1, '2026-05-14 21:29:00', '2026-05-14 21:29:00');
INSERT INTO `knowledge_import_task` VALUES (14, 'f0e59946f1d140d1', 'local', NULL, 7, 7, 0, 0, 8, 1, NULL, 1, '2026-05-14 21:29:01', '2026-05-14 21:29:01');
INSERT INTO `knowledge_import_task` VALUES (15, '205a03a634b143a1', 'local', NULL, 6, 6, 0, 0, 10, 1, NULL, 1, '2026-05-14 21:29:03', '2026-05-14 21:29:03');
INSERT INTO `knowledge_import_task` VALUES (16, '9733e72691734f06', 'local', NULL, 6, 6, 0, 0, 9, 1, NULL, 1, '2026-05-14 21:29:04', '2026-05-14 21:29:04');
INSERT INTO `knowledge_import_task` VALUES (17, '7e1ab73057c44538', 'local', NULL, 4, 4, 0, 0, 5, 1, NULL, 1, '2026-05-14 21:29:07', '2026-05-14 21:29:07');
INSERT INTO `knowledge_import_task` VALUES (18, '69763540682944b8', 'local', NULL, 6, 6, 0, 0, 7, 1, NULL, 1, '2026-05-14 21:29:08', '2026-05-14 21:29:08');

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习计划表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of learning_plan
-- ----------------------------
INSERT INTO `learning_plan` VALUES (3, 3, '个性化学习计划 - 滕建宏', '滕建宏同学，你好！我是你的ITAS智能教学助手。我已经仔细分析了你的成绩数据，看得出你在算法和网络方面有很好的基础，但也要注意到存在薄弱环节。下面我们一起梳理一下，找到提升的方向。\n\n---\n\n## 一、各科成绩统计\n\n首先，我把你的各科成绩按照等级和简要评价整理了出来，一目了然。\n\n| 课程名称 | 综合成绩 | 等级 | 评价 |\n|----------|:--------:|:----:|------|\n| 算法设计与分析 | 87.10 | 良好 | 掌握扎实，继续保持 |\n| 计算机网络 | 91.00 | 优秀 | 表现突出，学有余力 |\n| **数据库原理** | **50.90** | **不及格** | **亟需重点突破** |\n| 数据结构 | 82.50 | 良好 | 基础较牢，仍有提升空间 |\n| 操作系统 | 70.10 | 中等 | 知识掌握不够系统 |\n\n> 评分标准参考：≥90优秀，80~89良好，70~79中等，60~69及格，<60不及格。\n\n---\n\n## 二、薄弱科目识别与原因分析\n\n从表格中可以很直观地看到，**数据库原理（50.90分）是唯一一门不及格的科目，也是最明显的薄弱环节**。同时还注意到操作系统（70.10分）处于中等偏下水平，需要引起重视。\n\n**数据库原理不及格的原因可能包括：**\n- **知识点抽象且零碎**：范式理论、ER图转换、事务并发控制等概念比较抽象，容易混淆。\n- **缺乏动手实践**：SQL语句的编写、存储过程、触发器等如果缺少实际练习，考试时很容易出错或写不出来。\n- **与其他课程关联较少**：数据库在上学期（2023-2024-2）和计算机网络同期，可能时间分配不均，复习不够深入。\n\n**操作系统成绩偏低的原因猜测：**\n- **记忆负担重**：进程管理、内存管理、文件系统等章节理论多，需要记忆的内容多。\n- **综合应用能力不足**：比如页面置换算法、磁盘调度算法等，如果只记公式而不理解背后的原理，容易在灵活题型中失分。\n\n---\n\n## 三、成绩趋势分析\n\n按照时间顺序整理你的成绩：\n\n| 学期 | 修读课程 | 成绩 | 学期平均分 | 趋势判断 |\n|------|----------|:----:|:----------:|----------|\n| 2023-2024-1 | 数据结构<br>操作系统 | 82.50<br>70.10 | 76.30 | 起步平稳，但存在偏科 |\n| 2023-2024-2 | 计算机网络<br>数据库原理 | 91.00<br>50.90 | 70.95 | 分化严重，**出现挂科** |\n| 2024-2025-1 | 算法设计与分析 | 87.10 | 87.10 | 成绩回升，强势学科持续发力 |\n\n**趋势总结：**\n- 你的**算法与数据结构类课程（数据结构→算法设计与分析）始终保持在良好水平**，说明逻辑思维和编程基础不错。\n- 计算机网络拿到了优秀，说明你具备学好一门课的能力，但同期的数据库却 **“断崖式”挂科**，反映了 **学习重心偏移或知识吸收方式不匹配** 的问题。\n- 最近一个学期（2024-2025-1）只有一门课且成绩不错，**整体趋势有向好迹象**，但数据库的漏洞必须尽快补上，否则会影响后续毕业和综合绩点。\n\n---\n\n## 四、针对性学习建议\n\n**1. 优先攻克数据库原理（最紧急）**\n- **重回课本，系统梳理**：不要只背题，从ER图、关系模式、范式、SQL、事务处理这条主线重新梳理，确保每个知识点能用自己的话讲出来。\n- **大量练手**：SQL语句要熟练到“肌肉记忆”，每天至少写5-10条不同复杂度的查询，包括多表连接、分组过滤、子查询等。\n- **巧用ITAS系统**：如果系统有数据库知识点图谱或错题本功能，立即诊断你的知识盲区，集中火力消灭薄弱点。\n\n**2. 稳固并提升操作系统**\n- **分模块攻克**：进程同步（PV操作）、内存管理、文件系统是重点也是难点，可以找经典考研或期末题专项突破。\n- **类比理解**：把操作系统管理和现实生活管理做对比（如进程调度就像排队打饭），降低抽象感。\n\n**3. 保持优势科目的节奏**\n- 你的算法和网络底子很好，**不要因为要补差就完全放手**。可以适当保持每周1-2道算法题保持手感，网络的知识可以周期性复习，防止遗忘。\n\n---\n\n## 五、个性化学习计划（3-5个可执行任务）\n\n根据你的现状，我为你设计了本周就可以启动的 **“1+1+1”补差保优计划**，请务必坚持执行。\n\n**任务一：数据库每日“30分钟补课”**\n- **具体内容**：每天拿出30分钟，前15分钟重读教材一个章节（按范式-ER图-SQL-事务的顺序），后15分钟做该章节对应的5-8道选择题或2道大题。周末进行一次综合小测。\n- **目标**：两周内能独立完整画出一个小型系统的ER图并写出建表及查询语句。\n\n**任务二：完成一套数据库真题并逐题分析**\n- **具体内容**：找一份本校近年的数据库期末考试卷，严格按考试时间完成。做完后，**把每一道错题涉及的知识点标记出来**，用ITAS系统记录并寻找同类题强化。\n- **目标**：彻底暴露所有知识漏洞，至少保证同类题目不再出错。\n\n**任务三：操作系统重难点“手画思维导图”**\n- **具体内容**：不翻书的情况下，用笔画出一张包含进程、内存、文件三大模块的思维导图，再对照课本补充。每周攻克一个自己最不理解的子主题（如PV操作）。\n- **目标**：期中前达到面对任何一道中等题都能说出解题思路的程度。\n\n**任务四：算法周练保持手感**\n- **具体内容**：每周完成2道LeetCode中等难度题（可以选和课堂内容相关的排序、图论题），用中文写出解题思路，上传到自己的学习空间。\n- **目标**：不让算法能力生疏，为大三下的综合实践或竞赛蓄力。\n\n**任务五：利用ITAS系统进行月度自检**\n- **具体内容**：每月1号，用系统的学科评估功能对数据库、操作系统做一次诊断，查看薄弱知识点变化，对比进步。\n- **目标**：确保数据库在下次考试前模拟分数稳定在75分以上。\n\n---\n\n**最后想对你说：**\n一门课程暂时的失利不代表能力不足，你已经在算法和网络课上证明了自己的学习能力。数据库原理内容虽杂，但只要方法对路、投入足够，完全可以逆袭。**现在开始，把“补数据库”当成一个待调试的程序，冷静分析、逐步修复，你一定能跑通它！**\n\n有任何需要细化分析的地方，随时叫我，我陪你一起进步！', '数据库', NULL, 'AI', 1, '2026-05-12 21:52:19', '2026-05-12 21:52:19');

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
) ENGINE = InnoDB AUTO_INCREMENT = 60 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '学习计划任务项' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of learning_plan_item
-- ----------------------------
INSERT INTO `learning_plan_item` VALUES (37, 3, '数据库', '**知识点抽象且零碎**：范式理论、ER图转换、事务并发控制等概念比较抽象，容易混淆。', NULL, 1, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (38, 3, '数据库', '**缺乏动手实践**：SQL语句的编写、存储过程、触发器等如果缺少实际练习，考试时很容易出错或写不出来。', NULL, 2, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (39, 3, '数据库', '**与其他课程关联较少**：数据库在上学期（2023-2024-2）和计算机网络同期，可能时间分配不均，复习不够深入。', NULL, 3, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (40, 3, '数据库', '**记忆负担重**：进程管理、内存管理、文件系统等章节理论多，需要记忆的内容多。', NULL, 4, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (41, 3, '数据库', '**综合应用能力不足**：比如页面置换算法、磁盘调度算法等，如果只记公式而不理解背后的原理，容易在灵活题型中失分。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (42, 3, '数据库', '你的**算法与数据结构类课程（数据结构→算法设计与分析）始终保持在良好水平**，说明逻辑思维和编程基础不错。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (43, 3, '数据库', '计算机网络拿到了优秀，说明你具备学好一门课的能力，但同期的数据库却 **“断崖式”挂科**，反映了 **学习重心偏移或知识吸收方式不匹配** 的问题。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (44, 3, '数据库', '最近一个学期（2024-2025-1）只有一门课且成绩不错，**整体趋势有向好迹象**，但数据库的漏洞必须尽快补上，否则会影响后续毕业和综合绩点。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (45, 3, '数据库', '**重回课本，系统梳理**：不要只背题，从ER图、关系模式、范式、SQL、事务处理这条主线重新梳理，确保每个知识点能用自己的话讲出来。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (46, 3, '数据库', '**大量练手**：SQL语句要熟练到“肌肉记忆”，每天至少写5-10条不同复杂度的查询，包括多表连接、分组过滤、子查询等。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (47, 3, '数据库', '**巧用ITAS系统**：如果系统有数据库知识点图谱或错题本功能，立即诊断你的知识盲区，集中火力消灭薄弱点。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (48, 3, '数据库', '**分模块攻克**：进程同步（PV操作）、内存管理、文件系统是重点也是难点，可以找经典考研或期末题专项突破。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (49, 3, '数据库', '**类比理解**：把操作系统管理和现实生活管理做对比（如进程调度就像排队打饭），降低抽象感。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (50, 3, '数据库', '你的算法和网络底子很好，**不要因为要补差就完全放手**。可以适当保持每周1-2道算法题保持手感，网络的知识可以周期性复习，防止遗忘。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (51, 3, '数据库', '**具体内容**：每天拿出30分钟，前15分钟重读教材一个章节（按范式-ER图-SQL-事务的顺序），后15分钟做该章节对应的5-8道选择题或2道大题。周末进行一次综合小测。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (52, 3, '数据库', '**目标**：两周内能独立完整画出一个小型系统的ER图并写出建表及查询语句。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (53, 3, '数据库', '**具体内容**：找一份本校近年的数据库期末考试卷，严格按考试时间完成。做完后，**把每一道错题涉及的知识点标记出来**，用ITAS系统记录并寻找同类题强化。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (54, 3, '数据库', '**目标**：彻底暴露所有知识漏洞，至少保证同类题目不再出错。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (55, 3, '数据库', '**具体内容**：不翻书的情况下，用笔画出一张包含进程、内存、文件三大模块的思维导图，再对照课本补充。每周攻克一个自己最不理解的子主题（如PV操作）。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (56, 3, '数据库', '**目标**：期中前达到面对任何一道中等题都能说出解题思路的程度。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (57, 3, '数据库', '**具体内容**：每周完成2道LeetCode中等难度题（可以选和课堂内容相关的排序、图论题），用中文写出解题思路，上传到自己的学习空间。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (58, 3, '数据库', '**目标**：不让算法能力生疏，为大三下的综合实践或竞赛蓄力。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (59, 3, '数据库', '**具体内容**：每月1号，用系统的学科评估功能对数据库、操作系统做一次诊断，查看薄弱知识点变化，对比进步。', NULL, 5, 0, NULL);
INSERT INTO `learning_plan_item` VALUES (60, 3, '数据库', '**目标**：确保数据库在下次考试前模拟分数稳定在75分以上。', NULL, 5, 0, NULL);

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
INSERT INTO `learning_resource` VALUES (1, '浙江大学数据结构精讲', '数据结构', 'VIDEO', 'https://www.icourse163.org/course/ZJU-93001', '浙江大学陈越、何钦铭教授主讲，涵盖线性结构、树、图、排序等核心内容，配有编程作业', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (2, 'LeetCode数据结构经典题集', '数据结构', 'EXERCISE', 'https://leetcode.cn/problemset/all/', '精选150道数据结构高频面试题，涵盖数组、链表、栈、队列、二叉树、图等经典题型', 3, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (3, '清华大学操作系统课程', '操作系统', 'VIDEO', 'https://www.icourse163.org/course/THU-1000024000', '清华大学计算机系操作系统精品课程，深入讲解进程管理、内存管理、文件系统等核心知识', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (4, '操作系统核心概念详解', '操作系统', 'ARTICLE', 'https://blog.csdn.net/qq_38220914/article/details/119881601', '通俗易懂的操作系统入门到进阶文章，图解进程线程、死锁、内存分配、磁盘调度算法', 1, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (5, '韩立刚计算机网络课程', '计算机网络', 'VIDEO', 'https://www.bilibili.com/video/BV1Qr4y1w7ZM', '深入浅出讲解计算机网络五层模型，从物理层到应用层全面覆盖，适合考研与面试备考', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (6, 'TCP/IP详解卷一电子版', '计算机网络', 'BOOK', 'https://book.douban.com/subject/1088054/', '计算机网络领域经典著作，详细讲解TCP/IP协议族各层协议的设计与实现原理', 3, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (7, 'SQL实战50题', '数据库原理', 'EXERCISE', 'https://www.nowcoder.com/ta/sql', '牛客网SQL实战题库，涵盖增删改查、多表联查、子查询、聚合函数、窗口函数等考点', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (8, 'MySQL索引优化指南', '数据库原理', 'ARTICLE', 'https://javaguide.cn/database/mysql/mysql-index.html', '全面讲解B+树索引原理、索引类型、最左前缀法则、索引优化策略、慢查询分析与调优', 2, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (9, 'MIT算法导论公开课', '算法设计与分析', 'VIDEO', 'https://www.bilibili.com/video/BV1Tb411M7FA', '麻省理工学院经典算法课程，系统讲解分治、动态规划、贪心、图算法及NP完全性问题', 3, 2, 0, '2026-04-25 09:10:14', 0);
INSERT INTO `learning_resource` VALUES (10, 'Java核心技术电子版', 'Java程序设计', 'BOOK', 'https://book.douban.com/subject/34898994/', 'Java入门到精通权威书籍，涵盖基础语法、面向对象、集合框架、多线程、IO流等核心知识', 1, 2, 0, '2026-04-25 09:10:14', 0);

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
INSERT INTO `score` VALUES (69, 2, 244591903, 74.70, 78.50, 61.00, 68.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (70, 3, 244591903, 52.00, 81.50, 58.50, 61.20, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (71, 4, 244591903, 55.40, 74.50, 85.00, 74.00, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (72, 5, 244591903, 52.00, 39.00, 44.00, 45.40, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (73, 6, 244591903, 47.00, 55.50, 65.50, 58.00, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (74, 7, 244591903, 69.00, 95.50, 93.50, 86.60, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (75, 8, 244591903, 64.00, 69.50, 50.50, 58.40, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (76, 9, 244591903, 74.00, 83.00, 89.00, 83.30, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (77, 10, 244591903, 68.00, 51.50, 86.50, 74.00, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (78, 11, 244591903, 70.00, 79.00, 80.00, 76.80, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (79, 12, 244591903, 65.50, 57.50, 68.00, 65.20, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (80, 13, 244591903, 55.00, 87.00, 98.00, 82.90, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (81, 14, 244591903, 68.00, 80.00, 61.00, 66.90, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (82, 15, 244591903, 86.00, 98.00, 86.50, 88.70, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (83, 16, 244591903, 55.00, 69.50, 76.00, 68.40, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (84, 17, 244591903, 46.70, 46.50, 84.50, 65.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (85, 18, 244591903, 39.70, 83.50, 75.50, 66.40, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (86, 19, 244591903, 60.00, 81.00, 64.00, 66.20, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (87, 20, 244591903, 57.00, 67.50, 54.00, 57.60, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (88, 21, 244591903, 57.00, 69.50, 62.50, 62.30, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (89, 22, 244591903, 63.00, 48.50, 76.00, 66.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (90, 23, 244591903, 69.00, 75.00, 70.50, 71.00, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (91, 24, 244591903, 66.00, 71.00, 65.00, 66.50, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (92, 25, 244591903, 86.00, 69.00, 40.50, 59.90, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (93, 26, 244591903, 74.00, 68.00, 65.50, 68.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (94, 27, 244591903, 42.50, 62.00, 79.00, 64.70, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (95, 28, 244591903, 66.00, 84.00, 60.50, 66.90, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (96, 29, 244591903, 71.00, 59.50, 53.00, 59.70, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (97, 30, 244591903, 91.00, 93.00, 93.00, 92.40, 'A', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (98, 31, 244591903, 80.00, 71.50, 59.50, 68.10, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (99, 32, 244591903, 57.00, 86.00, 64.00, 66.30, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (100, 33, 244591903, 41.00, 47.50, 71.50, 57.60, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (101, 34, 244591903, 80.00, 84.50, 74.50, 78.20, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (102, 35, 244591903, 76.00, 71.50, 87.00, 80.60, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (103, 36, 244591903, 72.00, 65.00, 52.00, 60.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (104, 37, 244591903, 70.00, 64.00, 79.00, 73.30, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (105, 38, 244591903, 54.00, 61.50, 45.50, 51.30, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (106, 39, 244591903, 83.00, 78.50, 71.00, 76.10, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (107, 40, 244591903, 66.00, 66.50, 66.50, 66.40, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (108, 41, 244591903, 77.30, 77.00, 68.00, 72.60, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (109, 42, 244591903, 34.00, 64.00, 45.50, 45.80, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (110, 43, 244591903, 55.40, 50.00, 68.00, 60.60, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (111, 44, 244591903, 58.00, 75.00, 93.50, 79.20, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (112, 45, 244591903, 55.00, 56.00, 69.50, 62.50, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (113, 46, 244591903, 68.00, 64.50, 78.50, 72.60, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (114, 47, 244591903, 45.00, 60.00, 58.50, 54.80, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (115, 48, 244591903, 48.00, 53.00, 57.00, 53.50, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (116, 49, 244591903, 37.00, 51.50, 61.00, 51.90, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (117, 50, 244591903, 61.00, 18.50, NULL, 22.00, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 21:39:41');
INSERT INTO `score` VALUES (118, 51, 244591903, 54.00, 83.00, 59.00, 62.30, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (119, 52, 244591903, 40.00, 60.00, 67.50, 57.80, 'F', 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (120, 53, 244591903, 58.00, 89.50, 76.50, 73.60, 'C', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (121, 54, 244591903, 80.00, 73.50, 88.00, 82.70, 'B', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (122, 55, 244591903, NULL, NULL, NULL, NULL, NULL, 0, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');
INSERT INTO `score` VALUES (123, 56, 244591903, 55.00, 63.00, 73.50, 65.90, 'D', 1, '2025-2026-1', NULL, 2, '2026-05-09 16:46:48', '2026-05-09 16:46:48');

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
INSERT INTO `score_import_batch` VALUES (1, '07a8bbbb4ee249e68e6a98bfb131ad8a', 'itas_import_scores.xlsx', 244591903, '2025-2026-1', 55, 55, 0, 1, 2, '2026-05-09 16:46:47');

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

SET FOREIGN_KEY_CHECKS = 1;

-- Generated scores for students 2-56, courses 1-5
INSERT INTO `score` VALUES (124, 2, 1, 89.18, 63.75, 75.25, 77.13, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (125, 2, 2, 63.7, 72.09, 75.3, 71.18, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (126, 2, 3, 100, 75.61, 89.66, 89.95, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (127, 2, 4, 40.89, 41.56, 48.16, 44.66, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (128, 2, 5, 73.8, 75.97, 91.5, 83.08, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (129, 3, 1, 86.35, 69.61, 84.68, 82.17, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (130, 3, 2, 81.28, 50.19, 79.17, 74.01, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (131, 3, 3, 95.94, 83.21, 81.66, 86.25, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (132, 3, 4, 68.72, 45.1, 35.78, 47.53, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (133, 3, 5, 75.9, 95.42, 90.11, 86.91, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (134, 4, 1, 94.21, 84.89, 83.09, 86.79, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (135, 4, 2, 86.19, 61.36, 71.56, 73.91, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (136, 4, 3, 99.88, 91.56, 100, 98.28, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (137, 4, 4, 57.32, 56.14, 34.37, 45.61, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (138, 4, 5, 79.84, 78.68, 74.39, 76.88, 'C', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (139, 5, 1, 76.98, 66.03, 75.34, 73.97, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (140, 5, 2, 76.07, 60.94, 66.11, 68.06, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (141, 5, 3, 81.29, 81.01, 100, 90.59, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (142, 5, 4, 59.44, 53.27, 38.13, 47.55, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (143, 5, 5, 94.87, 74.9, 83.38, 85.13, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (144, 6, 1, 99.69, 82.2, 83.71, 88.2, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (145, 6, 2, 77.54, 75.29, 78.28, 77.46, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (146, 6, 3, 81.87, 73.96, 86.46, 82.58, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (147, 6, 4, 48.03, 41.33, 61.29, 53.32, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (148, 6, 5, 99.29, 79.44, 91.66, 91.5, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (149, 7, 1, 81.87, 90.44, 80.77, 83.03, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (150, 7, 2, 64.95, 57.4, 71.84, 66.89, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (151, 7, 3, 82.88, 90.54, 100, 92.97, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (152, 7, 4, 51.98, 41.58, 62.93, 55.38, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (153, 7, 5, 88.29, 72.73, 73.41, 77.74, 'C', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (154, 8, 1, 73.29, 81.82, 90.76, 83.73, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (155, 8, 2, 69.66, 51.91, 66.45, 64.5, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (156, 8, 3, 100, 88.87, 100, 97.77, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (157, 8, 4, 65.82, 35.34, 54.62, 54.12, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (158, 8, 5, 93.45, 86.11, 80.0, 85.26, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (159, 9, 1, 89.23, 66.35, 80.04, 80.06, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (160, 9, 2, 70.61, 78.61, 81.28, 77.55, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (161, 9, 3, 82.9, 88.02, 82.36, 83.65, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (162, 9, 4, 67.38, 61.12, 41.95, 53.41, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (163, 9, 5, 92.17, 88.27, 76.59, 83.6, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (164, 10, 1, 92.88, 79.18, 90.36, 88.88, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (165, 10, 2, 72.91, 50.02, 64.72, 64.24, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (166, 10, 3, 75.58, 100, 100, 92.67, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (167, 10, 4, 64.95, 44.23, 34.74, 45.7, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (168, 10, 5, 99.34, 98.41, 74.57, 86.77, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (169, 11, 1, 84.58, 65.08, 89.82, 83.3, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (170, 11, 2, 79.98, 53.85, 69.26, 69.39, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (171, 11, 3, 91.49, 80.95, 100, 93.64, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (172, 11, 4, 52.69, 41.35, 49.18, 48.67, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (173, 11, 5, 94.9, 76.03, 81.35, 84.35, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (174, 12, 1, 99.85, 82.5, 80.14, 86.53, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (175, 12, 2, 72.53, 53.63, 61.74, 63.36, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (176, 12, 3, 85.14, 90.65, 83.9, 85.62, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (177, 12, 4, 46.61, 37.13, 51.93, 47.37, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (178, 12, 5, 79.87, 97.16, 97.79, 92.29, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (179, 13, 1, 72.13, 70.14, 87.07, 79.2, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (180, 13, 2, 63.43, 53.97, 83.07, 71.36, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (181, 13, 3, 92.13, 87.18, 100, 95.08, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (182, 13, 4, 64.22, 40.71, 35.91, 45.36, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (183, 13, 5, 85.93, 82.71, 86.01, 85.33, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (184, 14, 1, 91.87, 83.2, 96.52, 92.46, 'A', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (185, 14, 2, 59.95, 62.08, 65.18, 62.99, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (186, 14, 3, 100, 80.46, 82.71, 87.45, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (187, 14, 4, 53.46, 47.66, 41.36, 46.25, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (188, 14, 5, 80.49, 97.7, 85.29, 86.33, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (189, 15, 1, 95.84, 79.51, 68.52, 78.91, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (190, 15, 2, 86.98, 75.08, 84.07, 83.14, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (191, 15, 3, 100, 98.46, 81.99, 90.69, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (192, 15, 4, 54.57, 41.41, 45.03, 47.17, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (193, 15, 5, 74.76, 81.37, 100, 88.7, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (194, 16, 1, 77.96, 86.52, 80.65, 81.02, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (195, 16, 2, 69.69, 78.72, 84.86, 79.08, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (196, 16, 3, 91.67, 94.55, 81.64, 87.23, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (197, 16, 4, 48.9, 64.06, 50.38, 52.67, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (198, 16, 5, 89.27, 92.44, 73.71, 82.12, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (199, 17, 1, 87.53, 78.09, 92.58, 88.17, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (200, 17, 2, 61.72, 78.82, 57.4, 62.98, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (201, 17, 3, 80.57, 90.85, 97.26, 90.97, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (202, 17, 4, 47.06, 38.6, 59.71, 51.69, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (203, 17, 5, 80.39, 87.84, 90.58, 86.97, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (204, 18, 1, 82.58, 80.51, 82.68, 82.22, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (205, 18, 2, 85.04, 56.13, 76.49, 74.98, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (206, 18, 3, 82.16, 84.87, 97.15, 90.2, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (207, 18, 4, 49.0, 44.49, 55.56, 51.38, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (208, 18, 5, 75.18, 83.75, 100, 89.3, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (209, 19, 1, 99.88, 65.2, 73.39, 79.7, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (210, 19, 2, 64.96, 78.0, 81.43, 75.8, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (211, 19, 3, 100, 84.09, 81.73, 87.68, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (212, 19, 4, 65.01, 56.11, 51.35, 56.4, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (213, 19, 5, 100, 89.62, 72.23, 84.04, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (214, 20, 1, 94.51, 71.98, 86.9, 86.2, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (215, 20, 2, 85.17, 54.03, 58.46, 65.59, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (216, 20, 3, 78.21, 89.6, 85.17, 83.97, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (217, 20, 4, 58.14, 56.53, 39.11, 48.3, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (218, 20, 5, 92.03, 77.92, 86.66, 86.52, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (219, 21, 1, 97.16, 88.38, 69.77, 81.71, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (220, 21, 2, 69.71, 58.3, 55.11, 60.13, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (221, 21, 3, 98.13, 92.11, 84.86, 90.29, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (222, 21, 4, 62.24, 51.55, 45.83, 51.9, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (223, 21, 5, 73.29, 72.26, 98.49, 85.68, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (224, 22, 1, 97.12, 79.37, 92.04, 91.03, 'A', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (225, 22, 2, 74.48, 54.44, 58.82, 62.64, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (226, 22, 3, 84.25, 99.97, 100, 95.27, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (227, 22, 4, 65.82, 61.97, 39.3, 51.79, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (228, 22, 5, 80.49, 73.08, 95.4, 86.46, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (229, 23, 1, 96.52, 75.19, 85.62, 86.8, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (230, 23, 2, 61.64, 77.9, 80.94, 74.54, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (231, 23, 3, 100, 97.32, 100, 99.46, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (232, 23, 4, 40.74, 57.1, 42.97, 45.13, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (233, 23, 5, 100, 94.07, 97.92, 97.77, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (234, 24, 1, 94.32, 71.0, 90.62, 87.81, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (235, 24, 2, 60.24, 76.17, 80.76, 73.69, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (236, 24, 3, 81.67, 97.5, 90.81, 89.41, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (237, 24, 4, 49.16, 58.86, 39.83, 46.43, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (238, 24, 5, 73.71, 75.79, 81.85, 78.2, 'C', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (239, 25, 1, 95.93, 92.01, 75.37, 84.87, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (240, 25, 2, 76.24, 61.99, 84.43, 77.48, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (241, 25, 3, 91.09, 100, 80.46, 87.56, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (242, 25, 4, 69.11, 40.36, 61.88, 59.75, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (243, 25, 5, 80.96, 73.25, 85.04, 81.46, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (244, 26, 1, 91.86, 72.41, 85.19, 84.63, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (245, 26, 2, 72.34, 61.56, 72.3, 70.16, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (246, 26, 3, 82.64, 94.26, 77.05, 82.17, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (247, 26, 4, 67.77, 51.15, 54.58, 57.85, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (248, 26, 5, 95.26, 90.12, 82.93, 88.07, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (249, 27, 1, 72.1, 82.93, 76.91, 76.67, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (250, 27, 2, 66.42, 75.44, 76.59, 73.31, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (251, 27, 3, 84.01, 82.28, 89.25, 86.28, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (252, 27, 4, 52.07, 43.87, 36.82, 42.8, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (253, 27, 5, 85.61, 98.21, 92.32, 91.48, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (254, 28, 1, 97.08, 81.47, 76.03, 83.43, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (255, 28, 2, 73.44, 50.01, 63.61, 63.84, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (256, 28, 3, 87.9, 90.4, 96.64, 92.77, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (257, 28, 4, 53.95, 48.26, 39.41, 45.54, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (258, 28, 5, 87.2, 97.04, 95.88, 93.51, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (259, 29, 1, 75.09, 65.54, 82.46, 76.87, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (260, 29, 2, 75.99, 60.06, 79.55, 74.58, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (261, 29, 3, 97.53, 93.18, 83.74, 89.77, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (262, 29, 4, 45.97, 35.73, 40.35, 41.11, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (263, 29, 5, 87.25, 95.49, 74.18, 82.36, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (264, 30, 1, 82.43, 81.89, 72.83, 77.52, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (265, 30, 2, 77.89, 64.83, 62.32, 67.49, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (266, 30, 3, 94.68, 73.17, 99.53, 92.8, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (267, 30, 4, 63.1, 38.2, 45.75, 49.45, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (268, 30, 5, 78.28, 98.74, 87.54, 87.0, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (269, 31, 1, 71.51, 70.48, 92.45, 81.77, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (270, 31, 2, 70.69, 74.04, 75.03, 73.53, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (271, 31, 3, 100, 90.86, 100, 98.17, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (272, 31, 4, 66.74, 53.38, 54.58, 57.99, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (273, 31, 5, 88.14, 94.92, 88.44, 89.65, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (274, 32, 1, 96.92, 85.31, 81.24, 86.76, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (275, 32, 2, 64.78, 57.42, 74.13, 67.98, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (276, 32, 3, 97.97, 88.64, 95.8, 95.02, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (277, 32, 4, 48.24, 37.32, 41.57, 42.72, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (278, 32, 5, 81.15, 79.59, 88.2, 84.36, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (279, 33, 1, 74.15, 69.94, 87.82, 80.14, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (280, 33, 2, 78.19, 51.93, 67.23, 67.46, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (281, 33, 3, 91.28, 85.47, 83.21, 86.08, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (282, 33, 4, 52.6, 62.15, 50.52, 53.47, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (283, 33, 5, 93.87, 95.7, 94.97, 94.79, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (284, 34, 1, 81.41, 63.18, 77.55, 75.83, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (285, 34, 2, 79.6, 75.6, 83.6, 80.8, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (286, 34, 3, 87.57, 95.43, 93.38, 92.05, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (287, 34, 4, 58.1, 41.62, 39.58, 45.54, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (288, 34, 5, 86.08, 70.87, 82.08, 81.04, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (289, 35, 1, 90.37, 75.13, 71.95, 78.11, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (290, 35, 2, 71.02, 53.83, 73.67, 68.91, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (291, 35, 3, 75.81, 84.82, 93.93, 86.67, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (292, 35, 4, 40.81, 54.28, 37.07, 41.63, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (293, 35, 5, 86.85, 71.51, 83.37, 82.04, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (294, 36, 1, 76.35, 72.81, 89.84, 82.39, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (295, 36, 2, 68.37, 72.56, 79.96, 75.0, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (296, 36, 3, 82.57, 75.46, 77.58, 78.65, 'C', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (297, 36, 4, 56.18, 65.0, 43.5, 51.6, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (298, 36, 5, 92.5, 93.44, 91.55, 92.21, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (299, 37, 1, 92.63, 91.49, 72.98, 82.58, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (300, 37, 2, 57.61, 54.57, 58.79, 57.59, 'F', 0, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (301, 37, 3, 95.08, 89.92, 83.54, 88.28, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (302, 37, 4, 60.98, 58.01, 38.03, 48.91, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (303, 37, 5, 91.22, 92.44, 75.44, 83.57, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (304, 38, 1, 94.58, 91.94, 70.24, 81.88, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (305, 38, 2, 57.77, 59.36, 75.32, 66.86, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (306, 38, 3, 100, 84.9, 98.45, 96.21, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (307, 38, 4, 42.28, 55.72, 51.82, 49.74, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (308, 38, 5, 76.06, 93.17, 97.51, 90.21, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (309, 39, 1, 88.01, 66.63, 96.52, 87.99, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (310, 39, 2, 80.48, 60.42, 67.85, 70.15, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (311, 39, 3, 86.12, 88.18, 87.24, 87.09, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (312, 39, 4, 65.49, 59.67, 36.17, 49.67, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (313, 39, 5, 100, 89.07, 96.86, 96.24, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (314, 40, 1, 91.22, 76.06, 89.01, 87.08, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (315, 40, 2, 85.96, 58.1, 79.25, 77.03, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (316, 40, 3, 91.15, 87.5, 90.07, 89.88, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (317, 40, 4, 61.93, 43.05, 58.55, 56.46, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (318, 40, 5, 97.92, 72.6, 98.45, 93.12, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (319, 41, 1, 77.32, 76.94, 85.31, 81.24, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (320, 41, 2, 68.37, 50.86, 80.53, 70.95, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (321, 41, 3, 80.46, 79.36, 100, 90.01, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (322, 41, 4, 50.21, 61.41, 54.04, 54.36, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (323, 41, 5, 81.29, 70.3, 100, 88.45, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (324, 42, 1, 72.57, 84.6, 81.66, 79.52, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (325, 42, 2, 79.74, 70.72, 74.38, 75.26, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (326, 42, 3, 89.72, 96.79, 79.79, 86.17, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (327, 42, 4, 46.65, 55.75, 42.19, 46.24, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (328, 42, 5, 90.45, 84.2, 87.93, 87.94, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (329, 43, 1, 82.77, 85.38, 76.92, 80.37, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (330, 43, 2, 78.09, 58.13, 62.54, 66.32, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (331, 43, 3, 78.62, 78.78, 80.59, 79.64, 'C', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (332, 43, 4, 56.08, 57.87, 38.55, 47.67, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (333, 43, 5, 79.49, 84.53, 93.74, 87.62, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (334, 44, 1, 99.3, 78.74, 75.49, 83.28, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (335, 44, 2, 60.02, 55.82, 61.82, 60.08, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (336, 44, 3, 80.38, 73.42, 93.02, 85.31, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (337, 44, 4, 48.23, 64.23, 49.6, 52.11, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (338, 44, 5, 93.92, 73.79, 98.05, 91.96, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (339, 45, 1, 84.73, 89.18, 84.22, 85.37, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (340, 45, 2, 71.08, 63.21, 60.53, 64.23, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (341, 45, 3, 76.54, 100, 91.33, 88.63, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (342, 45, 4, 64.66, 47.02, 35.22, 46.41, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (343, 45, 5, 91.88, 71.61, 76.48, 80.13, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (344, 46, 1, 86.89, 72.12, 96.82, 88.9, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (345, 46, 2, 60.55, 72.93, 73.19, 69.35, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (346, 46, 3, 98.72, 79.77, 92.68, 91.91, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (347, 46, 4, 53.52, 48.28, 58.8, 55.11, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (348, 46, 5, 100, 79.16, 90.63, 91.15, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (349, 47, 1, 88.29, 85.2, 95.43, 91.24, 'A', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (350, 47, 2, 63.23, 56.33, 74.81, 67.64, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (351, 47, 3, 79.71, 78.21, 79.25, 79.18, 'C', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (352, 47, 4, 40.08, 48.52, 50.81, 47.13, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (353, 47, 5, 81.74, 76.94, 93.21, 86.51, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (354, 48, 1, 91.09, 76.62, 87.62, 86.46, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (355, 48, 2, 84.72, 73.63, 73.75, 77.02, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (356, 48, 3, 94.84, 100, 89.75, 93.33, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (357, 48, 4, 56.34, 54.43, 60.25, 57.91, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (358, 48, 5, 97.8, 72.14, 76.98, 82.26, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (359, 49, 1, 79.23, 85.47, 84.08, 82.9, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (360, 49, 2, 65.66, 53.73, 75.66, 68.27, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (361, 49, 3, 95.99, 100, 92.01, 94.8, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (362, 49, 4, 54.81, 37.41, 34.2, 41.03, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (363, 49, 5, 85.96, 79.67, 79.51, 81.48, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (364, 50, 1, 72.74, 91.86, 92.08, 86.23, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (365, 50, 2, 74.26, 78.52, 84.99, 80.48, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (366, 50, 3, 95.17, 81.09, 78.21, 83.87, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (367, 50, 4, 62.69, 49.12, 52.55, 54.91, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (368, 50, 5, 100, 75.44, 89.56, 89.87, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (369, 51, 1, 89.04, 77.75, 69.74, 77.13, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (370, 51, 2, 67.44, 60.0, 75.1, 69.78, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (371, 51, 3, 100, 82.89, 97.81, 95.48, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (372, 51, 4, 48.65, 63.36, 57.41, 55.97, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (373, 51, 5, 89.5, 83.64, 81.44, 84.3, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (374, 52, 1, 79.7, 92.11, 79.13, 81.9, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (375, 52, 2, 72.44, 79.64, 74.73, 75.03, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (376, 52, 3, 91.28, 85.4, 82.63, 85.78, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (377, 52, 4, 50.85, 57.69, 51.76, 52.67, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (378, 52, 5, 95.8, 76.11, 88.48, 88.2, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (379, 53, 1, 97.83, 76.14, 87.95, 88.55, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (380, 53, 2, 60.64, 79.19, 73.27, 70.66, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (381, 53, 3, 82.18, 77.75, 93.53, 86.97, 'B', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (382, 53, 4, 56.57, 37.8, 62.77, 55.92, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (383, 53, 5, 100, 83.84, 75.52, 84.53, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (384, 54, 1, 94.96, 77.95, 88.5, 88.33, 'B', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (385, 54, 2, 72.27, 58.2, 80.04, 73.34, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (386, 54, 3, 100, 80.31, 93.54, 92.83, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (387, 54, 4, 51.51, 62.66, 48.25, 52.11, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (388, 54, 5, 99.38, 95.92, 80.29, 89.14, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (389, 55, 1, 93.7, 75.45, 95.03, 90.72, 'A', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (390, 55, 2, 72.23, 74.62, 63.49, 68.34, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (391, 55, 3, 83.96, 90.61, 100, 93.31, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (392, 55, 4, 54.69, 39.46, 49.16, 48.88, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (393, 55, 5, 83.35, 86.56, 88.3, 86.47, 'B', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (394, 56, 1, 83.66, 72.65, 72.66, 75.96, 'C', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (395, 56, 2, 77.92, 67.15, 62.01, 67.81, 'D', 1, '2023-2024-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (396, 56, 3, 98.27, 74.31, 99.34, 94.01, 'A', 1, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (397, 56, 4, 61.16, 59.34, 44.58, 52.51, 'F', 0, '2023-2024-2', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
INSERT INTO `score` VALUES (398, 56, 5, 92.91, 94.62, 100, 96.8, 'A', 1, '2024-2025-1', NULL, 2, '2026-05-09 16:44:35', '2026-05-09 16:44:35');
