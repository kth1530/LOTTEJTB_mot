package test.Thread;

class Bank {
    private int money = 0;
    public void add(int yen) {
           int tmp = money;                      // 현재 잔액 읽기
           System.out.println(Thread.currentThread().getName() +  ": 현재액=" + tmp + " 가산액=" + yen + "합계액" + (tmp+yen));
           tmp += yen;                           // 금액 가산
           money = tmp;                          // 새로운 잔액을 기입
    }
    public int getMoney() {                    // 잔액 취득 메소드
           return money;
    }
}
class User extends Thread {                          // 고객의 입금 조작
    Bank bank;
    public User(String name, Bank a) {
           super (name);                         // 이름을 설정
           bank=a;                               // 데이터를 설정
    }
    public void run() {
        for( int intLoop=0;intLoop<10;intLoop++){
            synchronized(bank) {
                bank.add(10);                 // 10원을 3번 예금한다
            }
        }
    }
}
public class JbDoki1 {
    public static void main(String args[]) {
                   // 계좌 작성     
                   Bank bank = new Bank();
                   // 스레드의 작성과 실행
                   User usr1=new User("스레드1", bank);
                   User usr2=new User("스레드2", bank);
                   usr1.start();
                   usr2.start();
                   // 스레드의 종료를 기다린다
                   try {
                          usr1.join();
                          usr2.join();
                   }catch (InterruptedException e) {}
                   // 계좌 잔액을 표시한다
                   System.out.println("최종 잔액=" + bank.getMoney());
    }
}
