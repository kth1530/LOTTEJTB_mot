package test.Thread;

import java.util.ArrayList;

//public class ThreadTest extends Thread{
public class ThreadTest2 implements Runnable{
    
    private int seq = 0;
    
    @Override
    public void run(){
        System.out.println(this.seq+" thread start.");
        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            ///e.printStackTrace();
        	System.err.println("Thread Error!");
        }
        addSeq();
        System.out.println(this.seq+" thread end.");
    }
    
    synchronized void addSeq(){
        seq = seq + 1;
        System.out.println("current seq : "+seq);
    }
    
    public static void main(String[] args) throws InterruptedException{
        System.out.println("main start.");
        
        Runnable r = new ThreadTest2(); // 실제 구현한 Runnable 인터페이스
        ArrayList<Thread> threadList= new ArrayList<Thread>(); // 쓰레드들을 담을 객체
        
        for(int intLoop=0;intLoop<10;intLoop++){
            //Thread t = new ThreadTest(intLoop);
            Thread t = new Thread(r);
            t.start();// 이 메소드를 실행하면 Thread 내의 run()을 수행한다.
            threadList.add(t);// 생성한 쓰레드를 리스트에 삽입
        }
        for(Thread t : threadList ){
            //Thread t = threads.get(intLoop);
            t.join();
        }
        System.out.println("main end.");
    }
    
}