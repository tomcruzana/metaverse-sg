package com.sg.mv.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.sg.mv.entity.AvatarPlayer;
import com.sg.mv.util.HibernateUtil;

public class AvatarPlayerDao implements GenericDao<AvatarPlayer> {

	@Override
	public AvatarPlayer findOne(int id) {
		AvatarPlayer thePlayer = null;

		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			thePlayer = session.get(AvatarPlayer.class, id);

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return thePlayer;
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<AvatarPlayer> findAll() {
		List<AvatarPlayer> allPlayers = null;

		try {

			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			allPlayers = session.createQuery("from AvatarPlayer").list();

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return allPlayers;
	}

	@Override
	public AvatarPlayer create(AvatarPlayer entity) {
		AvatarPlayer thePlayer = null;
		try {

			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			thePlayer = new AvatarPlayer();
			// no need to set the id
			thePlayer.setUuid(entity.getUuid());
			thePlayer.setUsername(entity.getUsername());
			thePlayer.setDisplayName(entity.getDisplayName());
			thePlayer.setWins(entity.getWins());
			thePlayer.setDateJoined(entity.getDateJoined());
			thePlayer.setRegion(entity.getRegion());
			thePlayer.setCoordinates(entity.getCoordinates());

			session.save(thePlayer);
			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return thePlayer;
	}

	@Override
	public AvatarPlayer update(int id, AvatarPlayer entity) {
		AvatarPlayer thePlayer = null;

		try {

			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			// thePlayer = session.get(AvatarPlayer.class, id);
			thePlayer = entity;

			if (thePlayer != null) {

				// we don't allow the id to be modified
				thePlayer.setUuid(entity.getUuid());
				thePlayer.setUsername(entity.getUsername());
				thePlayer.setDisplayName(entity.getDisplayName());
				thePlayer.setWins(entity.getWins());
				thePlayer.setDateJoined(entity.getDateJoined());
				thePlayer.setRegion(entity.getRegion());
				thePlayer.setCoordinates(entity.getCoordinates());

				session.update(thePlayer);
			}

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return thePlayer;
	}

	@Override
	public void deleteById(int id) {
		AvatarPlayer thePlayer = null;

		try {

			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			thePlayer = session.get(AvatarPlayer.class, id);

			if (thePlayer != null) {
				session.delete(thePlayer);
			}

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

	}

	@SuppressWarnings("unchecked")
	public List<AvatarPlayer> findTopThreePlayers() {
		List<AvatarPlayer> topThree = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			Query<AvatarPlayer> topThreePlayers = session
					.createQuery("FROM AvatarPlayer WHERE Wins > 0 ORDER BY Wins DESC");

			// set limit to 3 in HQL
			topThreePlayers.setMaxResults(3);

			topThree = topThreePlayers.list();

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return topThree;
	}

	@SuppressWarnings("unchecked")
	public List<AvatarPlayer> findByName(String username) {
		List<AvatarPlayer> avatarPlayers = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			Query<AvatarPlayer> topThreePlayers = session
					.createQuery("FROM AvatarPlayer WHERE Username LIKE CONCAT('%',?1,'%')");

			topThreePlayers.setParameter(1, username);

			avatarPlayers = topThreePlayers.list();

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return avatarPlayers;
	}

	@SuppressWarnings("unchecked")
	public List<AvatarPlayer> findByUuid(String uuid) {
		List<AvatarPlayer> avatarPlayer = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			Query<AvatarPlayer> ap = session.createQuery("FROM AvatarPlayer WHERE Uuid = ?1");

			ap.setParameter(1, uuid);

			if (ap != null) {
				avatarPlayer = ap.list();
			}

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return avatarPlayer;
	}

}
