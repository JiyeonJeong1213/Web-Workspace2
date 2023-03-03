package com.kh.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.nio.charset.Charset;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;

// 양방향 암호화 지원하는 클래스
// java.api에서 기본적으로 제공하고 있음
// javax.crypto, java.security패키지 안에 구성되어 있음

public class AEScryptor {
	// 나만의 key를 만들 예정. key는 프로젝트당 하나만 있어야 하며, 보안이 굉장히 중요함
	
	private static SecretKey key; // 암호화를 위한 key객체
	private String path; // 파일로 저장된 암호화키의 위치
	
	public AEScryptor() {
		// 클래스가 생성될 때 기본설정을 해줘야 함
		// 1. key파일에 객체가 생성되어 있다면 key파일에서 Scretkey객체를 불러오고
		// 생성되어있지 않다면 Scretkey객체를 생성하여 파일로 저장시킨다.
		
		this.path = AEScryptor.class.getResource("/").getPath();
		this.path = this.path.substring(0, this.path.indexOf("classes"));
		
		File f = new File(this.path+"/bsl.bs");
		// key를 저장하고 있는 파일 이름이 bsl.bs -> SecretKey객체가 내장되어있음
		
		if(f.exists()) {
			// key를 저장하고 있는 파일이 있다면
			try (ObjectInputStream ois = new ObjectInputStream(new FileInputStream(f))) {
				
				try {
					this.key = (SecretKey)ois.readObject();
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				
			} catch(IOException e) {
				e.printStackTrace();
			}
		}else {
			// SecretKey객체 생성
			if(key == null) {
				getGenerator(); // key값을 생성해주는 메소드
			}
		}
	}
	
	private void getGenerator() {
		// secretKey객체 생성하는 메소드
		SecureRandom ser = new SecureRandom();
		// key를 생성해주는 클래스
		KeyGenerator keygen = null;
		
		try {
			// 1. 적용할 알고리즘 AES => 키가 한개짜리인 알고리즘
			keygen = KeyGenerator.getInstance("AES");
			
			// 키값 생성
			keygen.init(128, ser);
			this.key = keygen.generateKey();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		
		// 생성된 키 객체를 정해진 경로에 파일로 저장해서 관리하기
		File f = new File(this.path+"/bsl.bs");
		
		try(ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream(f))) {
			oos.writeObject(this.key);
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public static String encrypt(String str) { // email, phone, address
		// key를 가지고 암호화 처리하는 클래스(Cipher)
		
		String resultValue = "";
		
		try {
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.ENCRYPT_MODE, AEScryptor.key);
			
			// 매개변수로 넘어온 정보 암호화 처리
			byte[] encrypt = str.getBytes(Charset.forName("UTF-8"));
			byte[] result = cipher.doFinal(encrypt);
			
			resultValue = Base64.getEncoder().encodeToString(result);
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return resultValue;
	}
	
	// 암호화된 데이터를 다시 복호화(원본값으로 변경)하는 메소드 -> key가 필요함
	public static String decrypt(String encryptedStr) {
		
		String originValue = "";
		
		try {
			Cipher cipher = Cipher.getInstance("AES");
			cipher.init(Cipher.DECRYPT_MODE, AEScryptor.key);
			
			byte[] decodedStr = Base64.getDecoder().decode(encryptedStr.getBytes(Charset.forName("UTF-8")));
			originValue = new String(cipher.doFinal(decodedStr));
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (NoSuchPaddingException e) {
			e.printStackTrace();
		} catch (InvalidKeyException e) {
			e.printStackTrace();
		} catch (IllegalBlockSizeException e) {
			e.printStackTrace();
		} catch (BadPaddingException e) {
			e.printStackTrace();
		}
		return originValue;
	}
}
