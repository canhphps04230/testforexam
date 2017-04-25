package model;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import connection.HibernateUtil;

public class AdvertiseDAO {

	public static List<Advertise> list(String clause) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "from Advertise";
			if (!clause.isEmpty())
				hql += " where name like :clause";
			Query<Advertise> query = session.createQuery(hql);
			if (!clause.isEmpty())
				query.setString("clause", clause);
			List<Advertise> list = query.list();
			tx.commit();
			return list;
		} catch (HibernateException e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return null;
	}

	public static List<Advertise> listNewByProduct(String type, int limit) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "from Advertise as ad";
			if (!type.isEmpty())
				hql += " where ad.prodTypeId = :type";
			hql += " order by ad.dateAdd desc";
			Query<Advertise> query = session.createQuery(hql);
			if (!type.isEmpty())
				query.setString("type", type);
			query.setFirstResult(0);
			query.setMaxResults(limit);
			List<Advertise> list = query.list();
			tx.commit();
			return list;
		} catch (HibernateException e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return null;
	}

	public static Advertise getNewByProduct(String type) {
		List<Advertise> list = listNewByProduct(type, 1);
		if (list.size() > 0)
			return listNewByProduct(type, 1).get(0);
		return null;
	}

	public static List<Advertise> listNewByType(String type, int limit) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "from Advertise as ad";
			if (!type.isEmpty())
				hql += " where ad.advertiseType.id = :type";
			hql += " order by ad.dateAdd desc";
			Query<Advertise> query = session.createQuery(hql);
			if (!type.isEmpty())
				query.setString("type", type);
			query.setFirstResult(0);
			query.setMaxResults(limit);
			List<Advertise> list = query.list();
			tx.commit();
			
			return list;
		} catch (HibernateException e) {
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return null;
	}

	public static Advertise getNewByType(String type) {
		return listNewByType(type, 1).get(0);
	}

}
