package test.Thread;

/* Runnable 쓰레드 프로그램 */
import java.util.ArrayList;
import java.util.Random;

public class RunnableTest{
    public static void main(String[] args) throws InterruptedException {

        System.out.println("Start main method.");

        Runnable r = new ConcreteRunnable(); // 실제 구현한 Runnable 인터페이스
        ArrayList<Thread> threadList = new ArrayList<Thread>(); // 쓰레드들을 담을 객체

        for(int i = 0 ; i < 10 ; i++ ){
            // Runnable 인터페이스를 사용해 새로운 쓰레드를 만듭니다.
            Thread test = new Thread(r);

            test.start(); // 이 메소드를 실행하면 Thread 내의 run()을 수행한다.
            threadList.add(test); // 생성한 쓰레드를 리스트에 삽입
        }

        for(Thread t : threadList){
            t.join(); // 쓰레드의 처리가 끝날때까지 기다립니다.
        }

        System.out.println("End main method.");
    }
}

class ConcreteRunnable implements Runnable{

    private int index = 0;

    @Override
    public void run() {
        System.out.println(this.index+" thread start.");
        Random r = new Random(System.currentTimeMillis());

        long s = r.nextInt(3000); // 3초내로 끝내자.
        try {
            Thread.sleep(s); // 쓰레드를 잠시 멈춤
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        addIndex();
        System.out.println(this.index+" thread end.");
    }

    // 내부 변수를 동기화해서 사용!
    // 동기화 이유가 궁금하다면 synchronized 키워드를 삭제 해서 여러번 돌려보세요!
    synchronized void addIndex(){
        index++;
        System.out.println("current index value: " + index);
    }

}