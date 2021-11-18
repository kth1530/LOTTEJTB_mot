package test.Thread;

public class SimpleThread2 extends Thread {

    int delay;



    public static void main (String[] args) {

          // 쓰레드 생성 명령을 내림

          SimpleThread2 a = new SimpleThread2("쓰레드 a");

          SimpleThread2 b = new SimpleThread2("쓰레드 b");

          SimpleThread2 c = new SimpleThread2("쓰레드 c");

          SimpleThread2 d = new SimpleThread2("쓰레드 d");



          // 쓰레드의 우선 순위 설정

          // 별도의 설정을 하지 않으면 디폴트 값인 5가 들어간다.

          b.setPriority(MIN_PRIORITY);

          c.setPriority(MAX_PRIORITY);

          d.setPriority(7);

          

             System.out.println("각 쓰레드의 우선 순위 : ");

             System.out.println(" a = " + a.getPriority() + " "  + " b = " + b.getPriority());

             System.out.println(" c = " + c.getPriority() + " "  + " d = " + d.getPriority() ); 



    // 쓰레드의 실행시작을 명령한다

          a.start();

          b.start();

          c.start();

          d.start();

    }



    // 쓰레드를 생성하는 부분

    public SimpleThread2(String str) {

           super(str);

           System.out.println(getName()+" 실행 시작");

    }



    // 쓰레드 실행 명령을 받으면 run 부분을 실행함

    public void run() {

           for (int i = 0; i < 6; i++) {

               System.out.println("["+i+"] " +  getName() + " 실행중; ");

           }

           System.out.println(getName()+" 실행 마침");

    }

}
