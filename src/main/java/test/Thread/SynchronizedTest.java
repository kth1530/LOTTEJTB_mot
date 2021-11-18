package test.Thread;

class ATM implements Runnable {
    
    private long depositeMoney = 10000;
    
    @Override
    public void run() {
        for (int i = 0; i < 10; i++) {
            try {
                Thread.sleep(1000);
            } catch (Exception e) {
                //e.printStackTrace();
            	System.err.println("Thread Error!");
            } 
 
            if (getDepositeMoney() <= 0)
                break;
 
            synchronized (this) {
                withDraw(1000);
            }
        }
    } 
 
    public void withDraw(long howMuch) {
        if (getDepositeMoney() > 0) {
            depositeMoney -= howMuch;
            System.out.print(Thread.currentThread().getName() + " , ");
            System.out.printf("잔액 : %,d 원 %n", getDepositeMoney());
        } else {
            System.out.print(Thread.currentThread().getName() + " , ");
            System.out.println("잔액이 부족합니다");
        } // if
    } // withDraw
 
    public long getDepositeMoney() {
        return depositeMoney;
    } // getDepositeMoney
} // ATM
 
public class SynchronizedTest {
    public static void main(String[] args) {
        ATM atm = new ATM();
 
        Thread mother = new Thread(atm, "mother");
        Thread son = new Thread(atm, "son");
 
        mother.start();
        son.start();
    } // main
} // SynchronizedTest