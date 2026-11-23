import java.util.ArrayList;
import java.util.List;

public class BSTLcaPaths {

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

    static Node findLCA(Node node, int a, int b) {
        if (node == null) return null;
        if (a < node.data && b < node.data) return findLCA(node.left, a, b);
        if (a > node.data && b > node.data) return findLCA(node.right, a, b);
        return node;
    }

    static List<Integer> pathTo(Node node, int target) {
        List<Integer> path = new ArrayList<>();
        while (node != null) {
            path.add(node.data);
            if (target == node.data) break;
            node = (target < node.data) ? node.left : node.right;
        }
        return path;
    }

    static void report(int a, int b) {
        List<Integer> pa = pathTo(root, a);
        List<Integer> pb = pathTo(root, b);
        System.out.println("Path to " + a + ": " + pa);
        System.out.println("Path to " + b + ": " + pb);
        System.out.println("LCA(" + a + ", " + b + ") = " + findLCA(root, a, b).data);
        System.out.println();
    }

    public static void main(String[] args) {
        int[] values = {50, 30, 70, 20, 40, 60, 80};
        for (int v : values) root = insert(root, v);

        report(20, 60);
        report(20, 40);
    }
}
