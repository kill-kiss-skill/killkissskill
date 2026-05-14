#!/usr/bin/env python3
"""将 knowledge_docs/*.md 按章节拆分，输出 JSONL 格式，用于批量导入。

用法：
  python scripts/convert_md_to_jsonl.py --output-dir ./import_data/local
"""

import os
import re
import json
import argparse
import glob

SUBJECT_MAP = {
    "01_数据结构核心知识": "数据结构",
    "02_操作系统核心知识": "操作系统",
    "03_计算机网络核心知识": "计算机网络",
    "04_数据库原理核心知识": "数据库原理",
    "05_算法设计与分析核心知识": "算法设计与分析",
    "06_Java程序设计核心知识": "Java程序设计",
    "07_高等数学基础": "高等数学",
    "08_大学物理基础": "大学物理",
    "09_化学基础知识": "化学基础",
    "10_英语语法基础": "英语语法",
    "11_语文文学常识": "语文文学",
    "12_中国历史概要": "中国历史",
    "13_地理基础知识": "地理基础",
    "14_生物基础知识": "生物基础",
}


def parse_md_sections(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()

    filename = os.path.splitext(os.path.basename(filepath))[0]
    subject = SUBJECT_MAP.get(filename, "综合")

    # 按 ## 标题拆分
    sections = []
    parts = re.split(r"\n## ", text)

    for part in parts:
        part = part.strip()
        if not part:
            continue

        # 第一行是标题
        lines = part.split("\n", 1)
        heading = lines[0].strip().lstrip("#").strip()

        if heading.startswith("# "):
            # 这是 H1 标题（文档总标题），跳过
            continue

        content = lines[1].strip() if len(lines) > 1 else ""

        # 清除 ### 子标题标记，保留文本
        content = re.sub(r"^###\s+", "", content, flags=re.MULTILINE)

        if len(content) < 100:
            continue

        sections.append({
            "title": f"{subject} - {heading}",
            "subject": subject,
            "content": content,
        })

    return sections


def main():
    parser = argparse.ArgumentParser(description="转换 knowledge_docs/*.md 为 JSONL")
    parser.add_argument("--input-dir", default="./knowledge_docs",
                        help="MD 文件目录")
    parser.add_argument("--output-dir", default="./import_data/local",
                        help="JSONL 输出目录")
    parser.add_argument("--min-chars", type=int, default=100,
                        help="章节最少字符数")
    args = parser.parse_args()

    md_files = sorted(glob.glob(os.path.join(args.input_dir, "*.md")))
    if not md_files:
        print(f"No .md files found in {args.input_dir}")
        return

    os.makedirs(args.output_dir, exist_ok=True)

    total = 0
    by_subject = {}

    for md_file in md_files:
        sections = parse_md_sections(md_file)
        if not sections:
            continue

        filename = os.path.splitext(os.path.basename(md_file))[0]
        subject = SUBJECT_MAP.get(filename, "综合")

        # 按学科分组
        if subject not in by_subject:
            by_subject[subject] = []

        for i, sec in enumerate(sections):
            record = {
                "title": sec["title"],
                "subject": sec["subject"],
                "content": sec["content"],
                "source": "local",
                "source_id": f"{filename}-s{i:02d}",
            }
            by_subject[subject].append(record)

    # 按学科输出 JSONL 文件
    for subject, records in by_subject.items():
        output_file = os.path.join(args.output_dir, f"{subject}.jsonl")
        with open(output_file, "w", encoding="utf-8") as f:
            for record in records:
                f.write(json.dumps(record, ensure_ascii=False) + "\n")
        print(f"  {subject}: {len(records)} 条 -> {output_file}")
        total += len(records)

    print(f"\nDone. 共 {len(by_subject)} 个学科, {total} 条记录 -> {args.output_dir}")


if __name__ == "__main__":
    main()
