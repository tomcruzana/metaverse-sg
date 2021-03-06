package com.sg.mv.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sg.mv.dao.AvatarPlayerDao;
import com.sg.mv.entity.AvatarPlayer;

@SuppressWarnings("serial")
@WebServlet("/records")
public class RecordsController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// get current session
		HttpSession hs = req.getSession(false);
		System.out.println(req.getParameter("username"));
		if (hs != null) {
			AvatarPlayerDao apd = new AvatarPlayerDao();
			String username = req.getParameter("username");
			List<AvatarPlayer> registeredPlayersList = apd.findByName(username);

			hs.setAttribute("registeredplayerlist", registeredPlayersList);

			req.getRequestDispatcher("playerrecords.jsp").include(req, resp);
		} else {
			req.getRequestDispatcher("adminlogin.html").forward(req, resp);
		}
	}

	// update player win record
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// get current session
		HttpSession hs = req.getSession(false);

		if (hs != null) {
			// fetch exisiting record
			AvatarPlayerDao apd = new AvatarPlayerDao();
			Integer id = Integer.valueOf(req.getParameter("id"));
			AvatarPlayer ap = apd.findOne(id);

			// prepare parameter data
//			String uuid = req.getParameter("uuid");
//			String username = req.getParameter("username");
//			String displayName = req.getParameter("displayname");
			Integer wins = Integer.valueOf(req.getParameter("wins"));
//			String dateJoined = req.getParameter("datejoined");
//			String region = req.getParameter("region");
//			String coordinates = req.getParameter("coordinates");

			// prepare formatter for parsing date data
//			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//			Date date;
			try {
				// no need to set the id
//				ap.setUuid(uuid);
//				ap.setUsername(username);
//				ap.setDisplayName(displayName);
				ap.setWins(wins);
//				date = formatter.parse(dateJoined);
//				ap.setDateJoined(date);
//				ap.setRegion(region);
//				ap.setCoordinates(coordinates);

				// update player info
				apd.update(id, ap);

			} // catch (ParseException e) {
				// e.printStackTrace(); }
			catch (Exception e) {
				e.printStackTrace();
			}
			req.getRequestDispatcher("playerrecords.jsp").include(req, resp);
		} else {
			req.getRequestDispatcher("adminlogin.html").forward(req, resp);
		}

	}

	@Override
	protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// get current session
		HttpSession hs = req.getSession(false);

		if (hs != null) {
			String avatarPlayerId = req.getParameter("id");
			int parsedId = Integer.parseInt(avatarPlayerId);
			AvatarPlayerDao apd = new AvatarPlayerDao();
			apd.deleteById(parsedId);
			req.getRequestDispatcher("playerrecords.jsp").include(req, resp);
		} else {
			req.getRequestDispatcher("adminlogin.html").forward(req, resp);
		}

	}
}
