package com.sg.mv.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sg.mv.dao.AvatarPlayerDao;
import com.sg.mv.entity.AvatarPlayer;

@SuppressWarnings("serial")
@WebServlet("/register")
public class RegisterController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String secret_key = req.getParameter("secret_key");
		String uuid = req.getParameter("uuid");
		String username = req.getParameter("username");
		String displayName = req.getParameter("displayname");
		String wins = req.getParameter("wins");
		String dateJoined = req.getParameter("datejoined");
		String region = req.getParameter("region");
		String coordinates = req.getParameter("coordinates");

		final String SECRET_KEY = "FUCKYOU!";
		if (SECRET_KEY.equals(secret_key)) {
			AvatarPlayerDao apd = new AvatarPlayerDao();
			AvatarPlayer thePlayer = new AvatarPlayer();

			// check if player already exists
			List<AvatarPlayer> aplist = apd.findByUuid(uuid);

			// if player doesn't exist
			if (aplist.isEmpty()) {
				DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				Date date;
				try {
					// no need to set the id
					thePlayer.setUuid(uuid);
					thePlayer.setUsername(username);
					thePlayer.setDisplayName(displayName);
					thePlayer.setWins(Integer.valueOf(wins));
					date = formatter.parse(dateJoined);
					thePlayer.setDateJoined(date);
					thePlayer.setRegion(region);
					thePlayer.setCoordinates(coordinates);

					apd.create(thePlayer);

					// response body: user created
					resp.setContentType("text/plain");
					resp.setCharacterEncoding("UTF-8");
					resp.getWriter().write("user registered successfully");
				} catch (ParseException e) {
					e.printStackTrace();
				} catch (Exception e) {
					e.printStackTrace();
				}

			} else {
				// response body: user already exists
				resp.setContentType("text/plain");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().write("user already exists");
			}

		}

	}
}
