package com.meta.sg.controller;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/meta/sg/records")
public class MetaSgRecordsController {
	
	private void doGet(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("get");
	}
	
	private void dopost(HttpServletRequest req, HttpServletResponse res) {
		System.out.println("post");

	}
}
