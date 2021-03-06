<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="error.jsp"
	import="com.sg.mv.entity.AvatarPlayer, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="https://unpkg.com/98.css" />
<link rel="stylesheet" href="./styles/default.css" />
<title>Records | Meta SG</title>
</head>
<body>
	<div class="admin-profile">
		<%
		String adminName = (String) session.getAttribute("adminname");
		if (adminName != null) {
			out.println("<div>Welcome Admin : " + adminName + "</div>");
		} else {
			out.println("<div>Invalid Session!!!</div>");
			response.sendRedirect("/DollSquidGame");
			return;
		}
		%>
		<a href="logout">Logout</a>
	</div>

	<%
	List<AvatarPlayer> topThreePlayersList = new ArrayList<>();
	topThreePlayersList = (List<AvatarPlayer>) session.getAttribute("topthreeplayerlist");
	%>
	<div class="top-3-table">
		<h4>Top 3 Winners</h4>
		<table>
			<tr>
				<th>id</th>
				<th>rank</th>
				<th>uuid</th>
				<th>avatar name</th>
				<th>name</th>
				<th>wins</th>
				<th>date joined</th>
			</tr>
			<%
			for (AvatarPlayer ap1 : topThreePlayersList) {
				out.println("<tr><td>" + ap1.getId() + "</td><td>🥈</td><td>" + ap1.getUuid() + "</td><td>" + ap1.getDisplayName()
				+ "</td><td>" + ap1.getUsername() + "</td><td>" + ap1.getWins() + "</td><td>" + ap1.getDateJoined()
				+ "</td></tr>");
			}
			%>
		</table>
	</div>

	<div class="field-row">
		<form action="records" method="GET">
			<label for="searchp">Search Player by Name</label> <input
				id="searchp" name="username" type="text" /> <input type="submit"
				value="Find" />
		</form>
	</div>
	<div class="player-table">
		<p class="div-title">Registered Players</p>

		<%
		List<AvatarPlayer> registeredPlayersList = new ArrayList<>();
		registeredPlayersList = (List<AvatarPlayer>) session.getAttribute("registeredplayerlist");
		%>
		<table>
			<tr>
				<th>id</th>
				<th>uuid</th>
				<th>avatar name</th>
				<th>name</th>
				<th>wins</th>
				<th>date joined</th>
				<th>action</th>
			</tr>

			<%
			for (AvatarPlayer ap : registeredPlayersList) {
				out.println("<tr><td>" + ap.getId() + "</td><td>" + ap.getUuid() + "</td><td >" + ap.getDisplayName() + "</td><td>"
				+ ap.getUsername() + "</td><td id=" + "'w" + ap.getId() + "'" + "class='green-txt' contenteditable='true'>"
				+ ap.getWins() + "</td><td>" + ap.getDateJoined() + "</td><td><button id=" + "'u" + ap.getId() + "'"
				+ "class='update-btn'>update</button><button id=" + "'d" + ap.getId() + "'"
				+ " class='delete-btn'>delete</button></td></tr>");
			}
			%>

		</table>
	</div>

	<script src="./scripts/playerrecords.js"></script>
</body>
</html>