package com.blog.util;

import org.apache.shiro.crypto.hash.Md5Hash;

public class CryptographyUtil {

	public static String MD5(String source, String salt) {
		return new Md5Hash(source, salt).toString();
	}
	
	public static void main(String[] args) {
		MD5("123456","admin");
		System.out.println(MD5("123456","admin"));
	}
}


