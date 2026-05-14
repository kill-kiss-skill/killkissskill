-- 批量知识库数据导入 DDL 变更
-- 在 itas 数据库执行

-- knowledge_document 新增来源字段
ALTER TABLE knowledge_document
  ADD COLUMN source VARCHAR(32) NOT NULL DEFAULT 'upload' COMMENT '来源: upload/k12textbook/ceval',
  ADD COLUMN source_url VARCHAR(512) DEFAULT NULL COMMENT '原始来源URL或数据集ID';

-- knowledge_chunk 新增哈希和来源字段
ALTER TABLE knowledge_chunk
  ADD COLUMN content_hash VARCHAR(64) DEFAULT NULL COMMENT 'SHA-256哈希，用于去重',
  ADD COLUMN source VARCHAR(32) DEFAULT 'upload' COMMENT '来源: upload/k12textbook/ceval',
  ADD INDEX idx_content_hash (content_hash);

-- 新建导入任务表
CREATE TABLE IF NOT EXISTS knowledge_import_task (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  batch_no VARCHAR(32) NOT NULL UNIQUE COMMENT '批次号',
  dataset_name VARCHAR(64) NOT NULL COMMENT '数据集名称',
  subject VARCHAR(64) COMMENT '导入学科',
  total_items INT DEFAULT 0 COMMENT '总条数',
  success_items INT DEFAULT 0 COMMENT '成功数',
  skip_items INT DEFAULT 0 COMMENT '跳过数',
  fail_items INT DEFAULT 0 COMMENT '失败数',
  total_chunks INT DEFAULT 0 COMMENT '总chunk数',
  status TINYINT DEFAULT 0 COMMENT '0=进行中,1=完成,2=失败',
  error_msg TEXT COMMENT '错误信息',
  operator_id BIGINT COMMENT '操作人ID',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='知识库批量导入任务';
