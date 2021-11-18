package test.Thread;

import java.util.ArrayList;

//public class ThreadTest extends Thread{
public class ThreadTest implements Runnable{
    int seq;
    
    public ThreadTest(int seq){
        this.seq = seq;
    }
    
    @Override
    public void run(){
        System.out.println(this.seq+" thread start.");
        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            //e.printStackTrace();
        	System.err.println("Thread Error!");
        }
        System.out.println(this.seq+" thread end.");
    }
    
    public static void main(String[] args){
        ArrayList<Thread> threads = new ArrayList<Thread>();
        for(int intLoop=0;intLoop<10;intLoop++){
            //Thread t = new ThreadTest(intLoop);
            Thread t = new Thread(new ThreadTest(intLoop));
            t.start();
            threads.add(t);
        }
        for(int intLoop=0;intLoop<threads.size();intLoop++){
            Thread t = threads.get(intLoop);
            try {
                t.join();
            } catch (Exception e) {
                //e.printStackTrace();
            	System.err.println("Thread Join Error!");
            }
        }
        System.out.println("main end.");
    }
    
}