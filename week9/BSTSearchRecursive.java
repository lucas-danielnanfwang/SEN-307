public class BSTSearchRecursive {

    static class Node {
        int data;
        Node left, right;
        Node(int data) { this.data = data; }
    }

    static Node root;
    static int countNodesVisited;

    static Node insert(Node node, int value) {
        if (node == null) return new Node(value);
        if (value < node.data) node.left = insert(node.left, value);
        else if (value > node.data) node.right = insert(node.right, value);
        return node;
    }

    static boolean searchRec(Node node, int target) {
        if (node == null) return false;
        countNodesVisited++;
        if (target == node.data) return true;
        if (target < node.data) return searchRec(node.left, target);
        return searchRec(node.right, target);
    }

    static boolean search(Node node, int target) {
        countNodesVisited = 0;
        return searchRec(node, target);
    }

    public static void main(String[] args) {
        int[] values = {50, 30, 70, 20, 40, 60, 80};
        for (int v : values) root = insert(root, v);

        boolean found = search(root, 60);
        System.out.println("search(60) -> " + found +
                " (comparisons: " + countNodesVisited + ")");

        boolean notFound = search(root, 65);
        System.out.println("search(65) -> " + notFound +
                " (comparisons: " + countNodesVisited + ")");
    }
}
