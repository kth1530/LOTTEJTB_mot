package test;

public class test{
    
    public static void main(String args[]) throws Exception {
        
        try {
            String aaa[] = new String[1];
            
            aaa[0]="1";
            
            System.out.println(aaa[0]);    
        } catch (Exception e) {
           //e.printStackTrace();
        	System.err.println("Array Error!");
        }
        
        
    }
}