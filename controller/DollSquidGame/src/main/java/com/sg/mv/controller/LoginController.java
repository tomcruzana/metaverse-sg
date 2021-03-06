package com.sg.mv.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sg.mv.dao.AvatarPlayerDao;
import com.sg.mv.dao.UserAdminDao;
import com.sg.mv.entity.AvatarPlayer;

@SuppressWarnings("serial")
@WebServlet("/adminlogin")
public class LoginController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("adminlogin.html").forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uname = req.getParameter("uname");
		String upass = req.getParameter("upass");

		UserAdminDao uad = new UserAdminDao();
		int res = uad.find(uname, upass);

		if (res == 1) {
			// login success

			// create session
			HttpSession hs = req.getSession();

			// since there is only one admin by design, we'll just hard code its name
			hs.setAttribute("adminname", "Tom");

			// retrieve all player records from db
			AvatarPlayerDao apd = new AvatarPlayerDao();
			List<AvatarPlayer> topThreePlayersList = new ArrayList<>();
			topThreePlayersList = apd.findTopThreePlayers();
			
			List<AvatarPlayer> registeredPlayersList = new ArrayList<>();
			registeredPlayersList = apd.findAll();

			// store all players into session attribute
			hs.setAttribute("topthreeplayerlist", topThreePlayersList);
			hs.setAttribute("registeredplayerlist", registeredPlayersList);

			req.getRequestDispatcher("playerrecords.jsp").forward(req, resp);
		} else {
			// login failure
			req.setAttribute("msg", "<span class='red-txt'>Invalid Login Process..<br></span>");
			req.getRequestDispatcher("loginfail.jsp").forward(req, resp);
		}
	}
}
