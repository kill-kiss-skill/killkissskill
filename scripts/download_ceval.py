#!/usr/bin/env python3
"""下载 C-Eval 数据集，按学科输出 JSONL 文件。

用法：
  python download_ceval.py --output-dir ./import_data/ceval --max-per-subject 100
"""

import os
import json
import argparse

os.environ["HF_ENDPOINT"] = "https://hf-mirror.com"

from datasets import load_dataset  # noqa: E402

CEVAL_SUBJECTS = [
    "高等数学", "大学物理", "数据结构", "操作系统", "计算机网络",
    "数据库", "Java程序设计", "大学化学", "算法设计与分析",
    "计算机组成原理", "编译原理", "软件工程",
    "历史", "地理", "生物", "化学", "物理", "英语", "语文",
]


def download_subject(dataset, subject, output_file, max_count):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    count = 0
    with open(output_file, "w", encoding="utf-8") as f:
        for item in dataset:
            item_subject = item.get("subject", "") or item.get("category", "") or ""
            if item_subject != subject:
                continue

            question = item.get("question", "") or ""
            answer = item.get("answer", "") or ""
            explanation = item.get("explanation", "") or ""

            content_parts = [f"题目：{question}"]
            if answer:
                content_parts.append(f"答案：{answer}")
            if explanation:
                content_parts.append(f"解析：{explanation}")

            record = {
                "title": f"{subject}考题{count + 1}",
                "subject": subject,
                "content": "\n".join(content_parts),
                "source": "ceval",
                "source_id": f"ceval-{subject}-{item.get('id', count)}",
            }
            f.write(json.dumps(record, ensure_ascii=False) + "\n")
            count += 1
            if count >= max_count:
                break
    return count


def main():
    parser = argparse.ArgumentParser(description="下载 C-Eval 数据集")
    parser.add_argument("--output-dir", default="./import_data/ceval",
                        help="JSONL 输出目录")
    parser.add_argument("--max-per-subject", type=int, default=100,
                        help="每个学科最多下载条数")
    args = parser.parse_args()

    print("Loading C-Eval dataset (streaming)...")
    ds = load_dataset("ceval/ceval-exam", split="val",
                      streaming=True, trust_remote_code=True)
    print("Dataset loaded. Starting download by subject...")

    total = 0
    for subject in CEVAL_SUBJECTS:
        output_file = os.path.join(args.output_dir, f"{subject}.jsonl")
        count = download_subject(ds, subject, output_file,
                                 args.max_per_subject)
        print(f"  {subject}: {count} 条")
        total += count

    print(f"\nDone. Total: {total} 条记录 -> {args.output_dir}")


if __name__ == "__main__":
    main()
