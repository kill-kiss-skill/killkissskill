-- ============================================================
-- ITAS 智能教学辅助系统 数据库建表脚本
-- MySQL 8.0+  字符集: utf8mb4
-- ============================================================

CREATE DATABASE IF NOT EXISTS itas DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE itas;

-- ------------------------------------------------------------
-- 1. 用户表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sys_user (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '用户ID',
    username    VARCHAR(64)  NOT NULL COMMENT '用户名/学号/工号',
    password    VARCHAR(128) NOT NULL COMMENT 'BCrypt加密密码',
    real_name   VARCHAR(64)  NOT NULL COMMENT '真实姓名',
    role        TINYINT      NOT NULL DEFAULT 2 COMMENT '角色: 0=管理员 1=教师 2=学生',
    email       VARCHAR(128) DEFAULT NULL COMMENT '邮箱',
    phone       VARCHAR(20)  DEFAULT NULL COMMENT '手机号',
    avatar_url  VARCHAR(256) DEFAULT NULL COMMENT '头像URL',
    status      TINYINT      NOT NULL DEFAULT 1 COMMENT '状态: 0=禁用 1=启用',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT      NOT NULL DEFAULT 0 COMMENT '逻辑删除: 0=正常 1=删除',
    PRIMARY KEY (id),
    UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户表';

-- ------------------------------------------------------------
-- 2. 院系表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sys_department (
    id          BIGINT      NOT NULL AUTO_INCREMENT,
    name        VARCHAR(64) NOT NULL COMMENT '院系名称',
    created_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='院系表';

-- ------------------------------------------------------------
-- 3. 班级表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sys_class (
    id              BIGINT      NOT NULL AUTO_INCREMENT,
    class_name      VARCHAR(64) NOT NULL COMMENT '班级名称，如B222',
    department_id   BIGINT      NOT NULL COMMENT '所属院系',
    grade           SMALLINT    NOT NULL COMMENT '年级，如2022',
    teacher_id      BIGINT      DEFAULT NULL COMMENT '班主任ID',
    created_at      DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_department (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='班级表';

-- ------------------------------------------------------------
-- 4. 学生信息扩展表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS student_info (
    id              BIGINT      NOT NULL AUTO_INCREMENT,
    user_id         BIGINT      NOT NULL COMMENT '关联sys_user.id',
    student_no      VARCHAR(32) NOT NULL COMMENT '学号',
    class_id        BIGINT      NOT NULL COMMENT '所在班级',
    enrollment_year SMALLINT    DEFAULT NULL COMMENT '入学年份',
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_id (user_id),
    UNIQUE KEY uk_student_no (student_no),
    KEY idx_class (class_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学生信息扩展表';

-- ------------------------------------------------------------
-- 5. 教师信息扩展表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS teacher_info (
    id              BIGINT      NOT NULL AUTO_INCREMENT,
    user_id         BIGINT      NOT NULL COMMENT '关联sys_user.id',
    teacher_no      VARCHAR(32) NOT NULL COMMENT '工号',
    department_id   BIGINT      DEFAULT NULL COMMENT '所属院系',
    title           VARCHAR(32) DEFAULT NULL COMMENT '职称',
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='教师信息扩展表';

-- ------------------------------------------------------------
-- 6. 课程表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS course (
    id          BIGINT          NOT NULL AUTO_INCREMENT,
    course_code VARCHAR(32)     NOT NULL COMMENT '课程编号',
    course_name VARCHAR(128)    NOT NULL COMMENT '课程名称',
    subject     VARCHAR(64)     NOT NULL COMMENT '学科分类，对应RAG知识库标签',
    credit      DECIMAL(3,1)    DEFAULT NULL COMMENT '学分',
    teacher_id  BIGINT          DEFAULT NULL COMMENT '授课教师ID',
    semester    VARCHAR(16)     DEFAULT NULL COMMENT '学期，如2024-2025-1',
    class_id    BIGINT          DEFAULT NULL COMMENT '授课班级',
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_code_semester_class (course_code, semester, class_id),
    KEY idx_teacher (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='课程表';

-- ------------------------------------------------------------
-- 7. 成绩表（核心）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS score (
    id              BIGINT          NOT NULL AUTO_INCREMENT,
    student_id      BIGINT          NOT NULL COMMENT '关联student_info.id',
    course_id       BIGINT          NOT NULL COMMENT '关联course.id',
    usual_score     DECIMAL(5,2)    DEFAULT NULL COMMENT '平时成绩',
    mid_score       DECIMAL(5,2)    DEFAULT NULL COMMENT '期中成绩',
    final_score     DECIMAL(5,2)    DEFAULT NULL COMMENT '期末成绩',
    total_score     DECIMAL(5,2)    DEFAULT NULL COMMENT '综合成绩（加权后）',
    grade_level     VARCHAR(8)      DEFAULT NULL COMMENT '等级: A/B/C/D/F',
    is_pass         TINYINT         NOT NULL DEFAULT 1 COMMENT '是否及格: 0=不及格 1=及格',
    semester        VARCHAR(16)     NOT NULL COMMENT '学期',
    remark          VARCHAR(256)    DEFAULT NULL COMMENT '备注',
    created_by      BIGINT          DEFAULT NULL COMMENT '录入人ID',
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_student_course_semester (student_id, course_id, semester),
    KEY idx_student (student_id),
    KEY idx_course (course_id),
    KEY idx_semester (semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成绩表';

-- ------------------------------------------------------------
-- 8. 成绩导入批次记录
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS score_import_batch (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    batch_no    VARCHAR(64)  NOT NULL COMMENT '批次号(UUID)',
    file_name   VARCHAR(256) NOT NULL COMMENT '原始文件名',
    course_id   BIGINT       NOT NULL,
    semester    VARCHAR(16)  NOT NULL,
    total_rows  INT          NOT NULL DEFAULT 0 COMMENT '总行数',
    success_rows INT         NOT NULL DEFAULT 0 COMMENT '成功行数',
    fail_rows   INT          NOT NULL DEFAULT 0 COMMENT '失败行数',
    status      TINYINT      NOT NULL DEFAULT 0 COMMENT '0=处理中 1=完成 2=失败',
    operator_id BIGINT       NOT NULL COMMENT '操作人',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_batch_no (batch_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='成绩导入批次表';

-- ------------------------------------------------------------
-- 9. 知识库文档表（RAG 原始文档）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS knowledge_document (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    title       VARCHAR(256) NOT NULL COMMENT '文档标题',
    subject     VARCHAR(64)  NOT NULL COMMENT '学科标签，与course.subject对应',
    file_name   VARCHAR(256) DEFAULT NULL COMMENT '原始文件名',
    file_path   VARCHAR(512) DEFAULT NULL COMMENT '存储路径',
    file_type   VARCHAR(16)  DEFAULT NULL COMMENT 'pdf/docx/txt/md',
    file_size   BIGINT       DEFAULT NULL COMMENT '文件大小(字节)',
    chunk_count INT          NOT NULL DEFAULT 0 COMMENT '切分后的chunk数量',
    status      TINYINT      NOT NULL DEFAULT 0 COMMENT '0=待处理 1=向量化中 2=完成 3=失败',
    uploader_id BIGINT       NOT NULL COMMENT '上传人ID',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    KEY idx_subject (subject),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识库文档表';

-- ------------------------------------------------------------
-- 10. 知识库文档分块表（RAG chunk，存原文用于展示引用）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS knowledge_chunk (
    id          BIGINT  NOT NULL AUTO_INCREMENT,
    doc_id      BIGINT  NOT NULL COMMENT '关联knowledge_document.id',
    chunk_index INT     NOT NULL COMMENT '分块序号',
    content     TEXT    NOT NULL COMMENT '分块原文',
    token_count INT     DEFAULT NULL COMMENT '估算token数',
    milvus_id   BIGINT  DEFAULT NULL COMMENT '对应Milvus中的向量ID',
    created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_doc_id (doc_id),
    KEY idx_milvus_id (milvus_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识库文档分块表';

-- ------------------------------------------------------------
-- 11. 对话会话表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_session (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    session_key VARCHAR(64)  NOT NULL COMMENT '会话唯一标识(UUID)',
    user_id     BIGINT       NOT NULL COMMENT '发起用户',
    title       VARCHAR(128) DEFAULT NULL COMMENT '会话标题（取首条消息前20字）',
    agent_type  VARCHAR(32)  NOT NULL DEFAULT 'CHAT' COMMENT 'CHAT/ANALYZE/RESOURCE',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted     TINYINT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    UNIQUE KEY uk_session_key (session_key),
    KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对话会话表';

-- ------------------------------------------------------------
-- 12. 对话消息表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_message (
    id              BIGINT       NOT NULL AUTO_INCREMENT,
    session_id      BIGINT       NOT NULL COMMENT '关联chat_session.id',
    role            VARCHAR(16)  NOT NULL COMMENT 'user/assistant/system',
    content         TEXT         NOT NULL COMMENT '消息内容',
    rag_context     TEXT         DEFAULT NULL COMMENT 'RAG检索到的上下文片段(JSON)',
    ref_chunk_ids   VARCHAR(512) DEFAULT NULL COMMENT '引用的chunk_id列表(JSON数组)',
    tokens_used     INT          DEFAULT NULL COMMENT '本次消耗token数',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_session_id (session_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='对话消息表';

-- ------------------------------------------------------------
-- 13. 学习计划表（AI生成）
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS learning_plan (
    id              BIGINT       NOT NULL AUTO_INCREMENT,
    student_id      BIGINT       NOT NULL COMMENT '关联student_info.id',
    plan_title      VARCHAR(128) NOT NULL COMMENT '计划标题',
    content         TEXT         NOT NULL COMMENT '计划内容(Markdown)',
    weak_subjects   VARCHAR(256) DEFAULT NULL COMMENT '薄弱学科列表(JSON)',
    semester        VARCHAR(16)  DEFAULT NULL COMMENT '针对学期',
    generated_by    VARCHAR(32)  NOT NULL DEFAULT 'AI' COMMENT 'AI/TEACHER',
    status          TINYINT      NOT NULL DEFAULT 1 COMMENT '0=草稿 1=生效',
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_student_id (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学习计划表';

-- ------------------------------------------------------------
-- 14. 学习计划任务项
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS learning_plan_item (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    plan_id     BIGINT       NOT NULL COMMENT '关联learning_plan.id',
    subject     VARCHAR(64)  NOT NULL COMMENT '学科',
    task_desc   VARCHAR(512) NOT NULL COMMENT '任务描述',
    resource_url VARCHAR(512) DEFAULT NULL COMMENT '推荐资源链接',
    priority    TINYINT      NOT NULL DEFAULT 1 COMMENT '优先级 1-5',
    status      TINYINT      NOT NULL DEFAULT 0 COMMENT '0=未完成 1=完成',
    due_date    DATE         DEFAULT NULL COMMENT '建议完成日期',
    PRIMARY KEY (id),
    KEY idx_plan_id (plan_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学习计划任务项';

-- ------------------------------------------------------------
-- 15. 学习资源表
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS learning_resource (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    title       VARCHAR(256) NOT NULL COMMENT '资源标题',
    subject     VARCHAR(64)  NOT NULL COMMENT '学科',
    res_type    VARCHAR(32)  NOT NULL COMMENT 'VIDEO/ARTICLE/EXERCISE/BOOK',
    url         VARCHAR(512) DEFAULT NULL COMMENT '资源链接',
    description TEXT         DEFAULT NULL COMMENT '资源描述',
    difficulty  TINYINT      NOT NULL DEFAULT 2 COMMENT '难度 1=简单 2=中等 3=困难',
    uploader_id BIGINT       DEFAULT NULL COMMENT '上传人',
    view_count  INT          NOT NULL DEFAULT 0,
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted     TINYINT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    KEY idx_subject (subject)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='学习资源表';

-- ------------------------------------------------------------
-- 16. 系统操作日志
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sys_log (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    user_id     BIGINT       DEFAULT NULL COMMENT '操作用户',
    module      VARCHAR(64)  DEFAULT NULL COMMENT '模块',
    action      VARCHAR(128) DEFAULT NULL COMMENT '操作描述',
    method      VARCHAR(16)  DEFAULT NULL COMMENT 'HTTP方法',
    request_url VARCHAR(256) DEFAULT NULL COMMENT '请求URL',
    ip          VARCHAR(64)  DEFAULT NULL COMMENT '客户端IP',
    status      SMALLINT     DEFAULT NULL COMMENT 'HTTP状态码',
    cost_ms     INT          DEFAULT NULL COMMENT '耗时毫秒',
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_user_id (user_id),
    KEY idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统操作日志';

-- ============================================================
-- 初始化数据
-- ============================================================

-- 初始化院系
INSERT INTO sys_department (name) VALUES
('计算机与信息工程学院'),
('数学与统计学院'),
('外国语学院');

-- 初始化班级
INSERT INTO sys_class (class_name, department_id, grade) VALUES
('B222', 1, 2022),
('B221', 1, 2021),
('B223', 1, 2023);

-- 初始化用户（密码均为 123456，BCrypt加密）
-- admin: 管理员
-- teacher01: 教师
-- 202207034221: 学生（与任务书学号一致）
INSERT INTO sys_user (username, password, real_name, role, status) VALUES
('admin',        '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '系统管理员', 0, 1),
('teacher01',    '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '张老师',   1, 1),
('202207034221', '$2a$10$gSvKQGR6xoJJQZuP1uwjpeit9N0N8Ara8JE.jy1slnmhWlgl5O8Je', '滕建宏',   2, 1);

-- 初始化教师信息
INSERT INTO teacher_info (user_id, teacher_no, department_id, title) VALUES
(2, 'T20220001', 1, '讲师');

-- 初始化学生信息
INSERT INTO student_info (user_id, student_no, class_id, enrollment_year) VALUES
(3, '202207034221', 1, 2022);

-- 初始化课程
INSERT INTO course (course_code, course_name, subject, credit, teacher_id, semester, class_id) VALUES
('CS101', '数据结构',       '数据结构',   3.0, 2, '2023-2024-1', 1),
('CS102', '操作系统',       '操作系统',   3.0, 2, '2023-2024-1', 1),
('CS103', '计算机网络',     '计算机网络', 3.0, 2, '2023-2024-2', 1),
('CS104', '数据库原理',     '数据库',     3.0, 2, '2023-2024-2', 1),
('CS105', '算法设计与分析', '算法',       3.0, 2, '2024-2025-1', 1);

-- 初始化示例成绩
INSERT INTO score (student_id, course_id, usual_score, mid_score, final_score, total_score, grade_level, is_pass, semester, created_by) VALUES
(1, 1, 85.0, 78.0, 82.0, 82.5, 'B', 1, '2023-2024-1', 2),
(1, 2, 72.0, 65.0, 70.0, 70.1, 'C', 1, '2023-2024-1', 2),
(1, 3, 90.0, 88.0, 92.0, 91.0, 'A', 1, '2023-2024-2', 2),
(1, 4, 55.0, 50.0, 48.0, 50.9, 'F', 0, '2023-2024-2', 2),
(1, 5, 88.0, 85.0, 87.0, 87.1, 'B', 1, '2024-2025-1', 2);

-- 初始化学习资源
INSERT INTO learning_resource (title, subject, res_type, url, description, difficulty, uploader_id) VALUES
('数据结构与算法图解', '数据结构', 'ARTICLE', 'https://example.com/ds', '图文并茂讲解常见数据结构', 2, 2),
('操作系统概念精讲',   '操作系统', 'VIDEO',   'https://example.com/os', '操作系统核心概念视频教程', 2, 2),
('数据库SQL练习题集', '数据库',   'EXERCISE', 'https://example.com/sql', '100道SQL经典练习题',       1, 2);
