package com.sg.mv.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@SuppressWarnings("serial")
@WebServlet("/logout")
public class LogoutController extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		// get current session
		HttpSession hs = req.getSession(false);

		if (hs == null) {
			// if no session is present
			req.setAttribute("msg", "<span class='red-txt'>Session Expired...<br></span>");
		} else {
			// destroy current session
			hs.invalidate();
			req.setAttribute("msg", "<span class='green-txt'>User Logged out Successfully...<br></span>");
		}
		req.getRequestDispatcher("loginfail.jsp").forward(req, res);
	}
}
