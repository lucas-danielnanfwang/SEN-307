public class BSTSortedInsert {

    static class Node {
        int data;
        Node left, right;
        Node(int data) { this.data = data; }
    }

    static Node root;
    static int comparisons;

    static Node insert(Node node, int value) {
        if (node == null) return new Node(value);
        comparisons++;
        if (value < node.data) node.left = insert(node.left, value);
        else if (value > node.data) node.right = insert(node.right, value);
        return node;
    }

    static void inorder(Node node, StringBuilder sb) {
        if (node == null) return;
        inorder(node.left, sb);
        sb.append(node.data).append(" ");
        inorder(node.right, sb);
    }

    static int height(Node node) {
        if (node == null) return -1;
        return 1 + Math.max(height(node.left), height(node.right));
    }

    public static void main(String[] args) {
        int[] values = {10, 20, 30, 40, 50};
        for (int v : values) {
            comparisons = 0;
            root = insert(root, v);
            System.out.println("Inserted " + v + " -> comparisons: " + comparisons);
        }
        StringBuilder sb = new StringBuilder();
        inorder(root, sb);
        System.out.println("In-order traversal: " + sb.toString().trim());
        System.out.println("Height (edges): " + height(root));
    }
}
