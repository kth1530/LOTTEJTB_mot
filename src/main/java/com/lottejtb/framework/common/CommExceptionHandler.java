package com.lottejtb.framework.common;

import org.apache.log4j.Logger;

import egovframework.rte.fdl.cmmn.exception.handler.ExceptionHandler;

public class CommExceptionHandler implements ExceptionHandler {

    private static final Logger LOGGER = Logger.getLogger(CommExceptionHandler.class);

    public void occur(Exception ex, String packageName) {
		try {
			if(LOGGER.isDebugEnabled()){
				LOGGER.debug(" SampleExcepHndlr try ");
			};
		} catch (Exception e) {
			StackTraceElement[] elem = e.getStackTrace();
			for (int i = 0; i < elem.length; i++) {
				if(LOGGER.isDebugEnabled()){
					LOGGER.error(elem[i]);
				}
            }
		}
    }

}
