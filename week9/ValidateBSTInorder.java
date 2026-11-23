import java.util.ArrayList;
import java.util.List;

public class ValidateBSTInorder {

    static class Node {
        int data;
        Node left, right;
        Node(int data) { this.data = data; }
    }

    static boolean isValidBST(Node node, Integer min, Integer max) {
        if (node == null) return true;
        if ((min != null && node.data <= min) ||
            (max != null && node.data >= max)) return false;
        return isValidBST(node.left, min, node.data) &&
               isValidBST(node.right, node.data, max);
    }

    static void collect(Node node, List<Integer> list) {
        if (node == null) return;
        collect(node.left, list);
        list.add(node.data);
        collect(node.right, list);
    }

    static boolean isValidBSTInorder(Node root) {
        List<Integer> list = new ArrayList<>();
        collect(root, list);
        for (int i = 1; i < list.size(); i++) {
            if (list.get(i) <= list.get(i - 1)) return false;
        }
        return true;
    }

    public static void main(String[] args) {
        Node invalidRoot = new Node(10);
        invalidRoot.left = new Node(5);
        invalidRoot.right = new Node(15);
        invalidRoot.right.left = new Node(6);
        invalidRoot.right.right = new Node(20);

        Node validRoot = new Node(10);
        validRoot.left = new Node(5);
        validRoot.right = new Node(15);
        validRoot.right.left = new Node(12);
        validRoot.right.right = new Node(20);

        System.out.println("Invalid tree -> range: " + isValidBST(invalidRoot, null, null)
                + " | in-order list: " + isValidBSTInorder(invalidRoot));
        System.out.println("Valid tree   -> range: " + isValidBST(validRoot, null, null)
                + " | in-order list: " + isValidBSTInorder(validRoot));
    }
}
