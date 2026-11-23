public class ExamBST {

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

    static int height(Node node) {
        if (node == null) return -1;
        return 1 + Math.max(height(node.left), height(node.right));
    }

    static boolean isBalancedNaive(Node node) {
        if (node == null) return true;
        int diff = Math.abs(height(node.left) - height(node.right));
        return diff <= 1 && isBalancedNaive(node.left) && isBalancedNaive(node.right);
    }

    static final int UNBALANCED = Integer.MIN_VALUE;

    static int checkHeight(Node node) {
        if (node == null) return -1;
        int l = checkHeight(node.left);
        if (l == UNBALANCED) return UNBALANCED;
        int r = checkHeight(node.right);
        if (r == UNBALANCED) return UNBALANCED;
        if (Math.abs(l - r) > 1) return UNBALANCED;
        return 1 + Math.max(l, r);
    }

    static boolean isBalanced(Node node) {
        return checkHeight(node) != UNBALANCED;
    }

    static void inorder(Node node, StringBuilder sb) {
        if (node == null) return;
        inorder(node.left, sb);
        sb.append(node.data).append(" ");
        inorder(node.right, sb);
    }

    static void run(String label, int[] values) {
        root = null;
        for (int v : values) root = insert(root, v);
        StringBuilder sb = new StringBuilder();
        inorder(root, sb);
        System.out.println(label);
        System.out.println("  In-order : " + sb.toString().trim());
        System.out.println("  Height   : " + height(root));
        System.out.println("  Balanced : " + isBalanced(root)
                + " (naive agrees: " + isBalancedNaive(root) + ")");
    }

    public static void main(String[] args) {
        run("Required array {50,30,70,20,40,60,80}", new int[]{50, 30, 70, 20, 40, 60, 80});
        run("Part (b) trace {45,25,65,15,35,55,75,30}", new int[]{45, 25, 65, 15, 35, 55, 75, 30});
        run("Skewed {10,20,30,40,50}", new int[]{10, 20, 30, 40, 50});
    }
}
