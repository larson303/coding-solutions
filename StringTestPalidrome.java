
public class StringTestPalidrome {

    public static void main(String[] args) {
        String str1 = "madam";
        String str2 = "hello";
    
        System.out.println(str1 + " is palindrome : " + isPalindrome(str1));
        System.out.println(str2 + " is palindrome : " + isPalindrome(str2));
    }

    public static String reverseString(String str) {
        char[] charArray = str.toCharArray();
        int start = 0;
        int end = charArray.length - 1;
        while (end > start) {
            char temp = charArray[start];
            charArray[start] = charArray[end];
            charArray[end] = temp;
            end--;
            start++;
        }
        return new String(charArray);
    }

    // the fastest way to reverse a string
    // return (str.equals(new StringBuilder(str).reverse().toString()));

    public static boolean isPalindrome(String str) {
        if (str == null || str.length() == 0) {
            return false;
        }

        String reversed = reverseString(str);
        return str.equals(reversed);
    }

}