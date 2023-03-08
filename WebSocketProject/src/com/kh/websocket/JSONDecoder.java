package com.kh.websocket;

import javax.websocket.Decoder.Text;
import javax.websocket.EndpointConfig;

import com.google.gson.Gson;
import com.kh.websocket.model.vo.Message;

public class JSONDecoder implements Text<Message>{

	@Override
	public void destroy() {
		
	}
	
	@Override
	public void init(EndpointConfig arg0) {
		
	}
	
	@Override
	public Message decode(String msg) {
		return new Gson().fromJson(msg, Message.class);
	}
	
	@Override
	public boolean willDecode(String msg) {
		return true;
	}
}
