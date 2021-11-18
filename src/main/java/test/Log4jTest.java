package test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Log4jTest{

        protected static final Logger logger = LoggerFactory.getLogger(Log4jTest.class);
        public static void main(String[] args){
               System.out.println("logger.isDebugEnabled() : "+logger.isDebugEnabled());
               System.out.println("logger.isInfoEnabled() : "+logger.isInfoEnabled());
               logger.warn("프로그램 WARN");
               logger.error("프로그램 ERROR");
        }
}       
