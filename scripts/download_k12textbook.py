#!/usr/bin/env python3
"""下载 K12textbook 数据集，按学科输出 JSONL 文件。

用法：
  python download_k12textbook.py --output-dir ./import_data/k12textbook --max-per-subject 100
"""

import os
import json
import argparse

os.environ["HF_ENDPOINT"] = "https://hf-mirror.com"

from datasets import load_dataset  # noqa: E402

SUBJECTS = ["语文", "数学", "英语", "物理", "化学", "历史", "地理", "生物"]

K12_SUBJECT_MAP = {
    "语文": ["语文"],
    "数学": ["数学"],
    "英语": ["英语"],
    "物理": ["物理"],
    "化学": ["化学"],
    "历史": ["历史"],
    "地理": ["地理"],
    "生物": ["生物"],
}


def download_subject(dataset, subject, keywords, output_file, max_count):
    os.makedirs(os.path.dirname(output_file), exist_ok=True)
    count = 0
    with open(output_file, "w", encoding="utf-8") as f:
        for item in dataset:
            item_subject = item.get("subject", "") or ""
            if item_subject not in keywords:
                continue
            text = item.get("text", "") or item.get("content", "") or ""
            if len(text) < 50:
                continue
            record = {
                "title": item.get("title", "") or f"{subject}知识点{count + 1}",
                "subject": subject,
                "content": text.strip(),
                "source": "k12textbook",
                "source_id": f"k12-{subject}-{item.get('id', count)}",
            }
            f.write(json.dumps(record, ensure_ascii=False) + "\n")
            count += 1
            if count >= max_count:
                break
    return count


def main():
    parser = argparse.ArgumentParser(description="下载 K12textbook 数据集")
    parser.add_argument("--output-dir", default="./import_data/k12textbook",
                        help="JSONL 输出目录")
    parser.add_argument("--max-per-subject", type=int, default=100,
                        help="每个学科最多下载条数")
    parser.add_argument("--split", default="train", help="数据集 split")
    args = parser.parse_args()

    print("Loading K12textbook dataset (streaming)...")
    ds = load_dataset("opendatalab/K12textbook", split=args.split,
                      streaming=True, trust_remote_code=True)
    print("Dataset loaded. Starting download by subject...")

    total = 0
    for subject, keywords in K12_SUBJECT_MAP.items():
        output_file = os.path.join(args.output_dir, f"{subject}.jsonl")
        count = download_subject(ds, subject, keywords, output_file,
                                 args.max_per_subject)
        print(f"  {subject}: {count} 条")
        total += count

    print(f"\nDone. Total: {total} 条记录 -> {args.output_dir}")


if __name__ == "__main__":
    main()
