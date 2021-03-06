package com.sg.mv.dao;

import java.io.Serializable;
import java.util.List;

public interface GenericDao<T extends Serializable> {
	//void setClazz(Class<T> clazzToSet);

	T findOne(final int id);

	List<T> findAll();

	T create(final T entity);

	T update(final int id, T entity);

	void deleteById(final int id);
}