#!/bin/bash
javac *.java || exit 1
for c in BSTSortedInsert BSTSearchRecursive BSTDeleteTests BSTLcaPaths ValidateBSTInorder ExamBST; do
  echo "=== $c ==="
  java $c
done
