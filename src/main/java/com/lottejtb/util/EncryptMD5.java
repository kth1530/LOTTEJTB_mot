package com.lottejtb.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EncryptMD5 {
	/**
	 * 
	 */
	public EncryptMD5 () {

		// TODO Auto-generated constructor stub
	}
	
	/**
	 * @param strData
	 * @return
	 */
	public String encrypt(String strData) {

		MessageDigest md;
		StringBuffer sb = new StringBuffer();
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(strData.getBytes());
			byte[] digest = md.digest();
			for (int i = 0; i < digest.length; i++) {
				sb.append(String.format("%02x", 0xFF & digest[i]));
			}
		} catch (NoSuchAlgorithmException e) {
			//e.printStackTrace();
			System.err.println("No Such Algorithm Error!");
		}
		return sb.toString();
	}
	
	
}
