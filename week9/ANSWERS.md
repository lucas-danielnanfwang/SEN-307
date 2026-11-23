# Lab Module 6 (BST): Written Answers

## Problem 1: Sorted insertion (BSTSortedInsert.java)
Output: in-order `10 20 30 40 50`, height 4.
Shape: a right-skewed chain (a linked list), where every node has only a right child.
Why O(n): each new value is larger than everything already stored, so it goes right at every node. Insertion i makes i comparisons (0, 1, 2, 3, 4 in the run), so one insertion costs O(n) and n insertions cost O(n^2) in total. Height h = n - 1, and insertion is O(h).

## Problem 2: Recursive search (BSTSearchRecursive.java)
search(60) gives true with 3 visits, and search(65) gives false with 3 visits. This matches the iterative version.
Recursive search uses O(h) stack space; the iterative version uses O(1).

## Problem 3: Deletion tests (BSTDeleteTests.java)
- delete(20): Case 1 (leaf). Before `20 30 40 50 60 70 80`, after `30 40 50 60 70 80`.
- delete(80): Case 1 (leaf). This is done only so that 70 is left with a single left child (60).
- delete(70): Case 2 (one child). 60 takes 70's place. Before `30 40 50 60 70`, after `30 40 50 60`.
- (Case 3, two children, was shown by delete(30) in the manual.)

## Problem 4: LCA with paths (BSTLcaPaths.java)
Path to 20: 50 -> 30 -> 20
Path to 40: 50 -> 30 -> 40
The paths share 50 and 30, then split (20 goes left of 30, 40 goes right). The last shared node is 30, so it is the deepest common ancestor. 50 is also a common ancestor but not the lowest.

## Problem 5: Range vs in-order validation (ValidateBSTInorder.java)
Both methods agree: invalid tree = false, valid tree = true.
Advantage of the range-based method: it needs no extra O(n) list (only O(h) stack), and it stops at the first violation. The list method must traverse the whole tree and store every value before it can check anything.

## Exam question

### (a) Theory
Invariant: at every node, all values in the left subtree are smaller and all values in the right subtree are larger.
Checking only against the immediate parent is not enough because the invariant applies to every ancestor, not just the parent. In Problem 5, 6 is below 15 in the right subtree of 10. 6 < 15 passes the parent check, but 6 < 10 breaks the ancestor rule. The correct algorithm must carry a (min, max) range down the recursion. Going left tightens max to the parent's value. Going right tightens min to the parent's value.

### (b) Trace: insert 45, 25, 65, 15, 35, 55, 75, 30
```
            45
          /    \
        25      65
       /  \    /  \
     15   35  55   75
          /
        30
```
In-order: 15 25 30 35 45 55 65 75
Height: 3 edges (45 -> 25 -> 35 -> 30)

### (c) Programming
See ExamBST.java. Output on {50,30,70,20,40,60,80}: height 2, balanced true.
Balance check time complexity: O(n). The optimised version makes one bottom-up pass and visits each node once, returning the height or a sentinel for "unbalanced".
Why the naive version can be O(n^2): at every node it calls height(), which itself walks the whole subtree. On a skewed tree, node k has about n - k nodes below it, so the total work is about n + (n-1) + ... + 1 = O(n^2). Heights are recomputed again and again for the same subtrees.

### (d) Short answer
Predecessor works equally well: the largest value in the left subtree is greater than everything else in the left subtree and smaller than everything in the right subtree, so putting it in the deleted node's place keeps the invariant. It has no right child, so removing it is a Case 1 or Case 2 deletion.
Practical reasons to prefer one: use the successor by convention for consistency, or alternate or pick the side from the taller subtree to reduce skew over many deletions (always taking the successor tends to shrink the right side, which unbalances the tree over time).
