package com.hib;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;

import com.sg.mv.dao.AvatarPlayerDao;
import com.sg.mv.dao.UserAdminDao;
import com.sg.mv.entity.AvatarPlayer;

/**
 * Unit test for simple App.
 */
public class AppTest {
	/**
	 * Rigorous Test :-)
	 */
	private UserAdminDao uad = new UserAdminDao();
	private AvatarPlayerDao apd = new AvatarPlayerDao();
	
	@Test
	public void shouldAnswerWithTrue() {
		assertTrue(true);
	}
	
	@Test
	public void loginTest() {
		int res = uad.find("admin", "password123");
		assertEquals(1, res);
	}

	@Test
	public void readByIdAvatarPlayer() {
		// fail();
		AvatarPlayer ap;
		ap = apd.findOne(1);
		assertNotNull("Found an object!", apd);
	}

	@Test
	public void readAllAvatarPlayer() {
		// fail();
		List<AvatarPlayer> all = new ArrayList<>();
		all = apd.findAll();
		System.out.println(all.size());
	}

	@Test
	public void registerAvatarPlayer() {
		// fail();
		AvatarPlayer thePlayer = new AvatarPlayer();
		thePlayer.setUuid("6928b907-8330-445b-ad2d-7eadca85e4b7");
		thePlayer.setUsername("rurouni20");
		thePlayer.setDisplayName("mojaco");
		thePlayer.setWins(0);

		Date date = new Date(); // This object contains the current date value
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(formatter.format(date));

		thePlayer.setDateJoined(date);
		thePlayer.setRegion("Why Not");
		thePlayer.setCoordinates("<197.10670, 228.56920, 23.56642>");

		apd.create(thePlayer);
	}

	@Test
	public void updateAvatarPlayer() {
		// fail();
		int id = 4;
		AvatarPlayer ap = apd.findOne(id);

		ap.setDisplayName("tom primswitch");
		apd.update(id, ap);
	}

	@Test
	public void deleteAvatarPlayer() {
		// fail();
		apd.deleteById(2);
	}
	
	@Test
	public void findTopThreePlayers() {
		// fail();
		apd.findTopThreePlayers();
	}
	
	@Test
	public void findPlayerByName() {
		// fail();
		 System.out.println(apd.findByName("tom"));
	}
}
