public class BSTDeleteTests {

    static class Node {
        int data;
        Node left, right;
        Node(int data) { this.data = data; }
    }

    static Node root;

    static Node insert(Node node, int value) {
        if (node == null) return new Node(value);
        if (value < node.data) node.left = insert(node.left, value);
        else if (value > node.data) node.right = insert(node.right, value);
        return node;
    }

    static Node delete(Node node, int value) {
        if (node == null) return null;
        if (value < node.data) {
            node.left = delete(node.left, value);
        } else if (value > node.data) {
            node.right = delete(node.right, value);
        } else {
            if (node.left == null && node.right == null) return null;
            if (node.left == null) return node.right;
            if (node.right == null) return node.left;
            Node successor = findMin(node.right);
            node.data = successor.data;
            node.right = delete(node.right, successor.data);
        }
        return node;
    }

    static Node findMin(Node node) {
        while (node.left != null) node = node.left;
        return node;
    }

    static String inorder() {
        StringBuilder sb = new StringBuilder();
        inorder(root, sb);
        return sb.toString().trim();
    }

    static void inorder(Node node, StringBuilder sb) {
        if (node == null) return;
        inorder(node.left, sb);
        sb.append(node.data).append(" ");
        inorder(node.right, sb);
    }

    public static void main(String[] args) {
        int[] values = {50, 30, 70, 20, 40, 60, 80};
        for (int v : values) root = insert(root, v);

        System.out.println("Before delete(20): " + inorder());
        root = delete(root, 20);
        System.out.println("After  delete(20): " + inorder());
        System.out.println();

        System.out.println("Before delete(80): " + inorder());
        root = delete(root, 80);
        System.out.println("After  delete(80): " + inorder());
        System.out.println();

        System.out.println("Before delete(70): " + inorder());
        root = delete(root, 70);
        System.out.println("After  delete(70): " + inorder());
    }
}
