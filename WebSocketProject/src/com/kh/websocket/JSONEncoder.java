package com.kh.websocket;

import javax.websocket.Encoder.Text;
import javax.websocket.EndpointConfig;

import com.google.gson.Gson;
import com.kh.websocket.model.vo.Message;

public class JSONEncoder implements Text<Message> {

	@Override
	public void destroy() {
		
	}
	
	@Override
	public void init(EndpointConfig arg0) {
		
	}
	
	@Override
	public String encode(Message msg) {
		return new Gson().toJson(msg);
	}
}
