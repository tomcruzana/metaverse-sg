package com.sg.mv.dao;

import java.sql.SQLException;

import org.hibernate.Session;

import com.sg.mv.entity.AvatarPlayer;
import com.sg.mv.entity.UserAdmin;
import com.sg.mv.util.HibernateUtil;

public class UserAdminDao {

	public int find(String username, String password) {
		UserAdmin ua = null;
		try {
			Session session = HibernateUtil.getSessionFactory().openSession();
			session.beginTransaction();

			// there's only one user and its id is 1
			ua = session.get(UserAdmin.class, 1);

			if (username.equals(ua.getUsername()) && password.equals(ua.getPassword()) && ua.getIsActive() == true) {
				return 1;
			}

			session.getTransaction().commit();
			session.close();

		} catch (Exception e) {
			System.out.println(e);
		}

		return -1;
	}
}
