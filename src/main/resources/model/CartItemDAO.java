package model;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import connection.HibernateUtil;

public class CartItemDAO {

	public static int getNewId() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "select id from CartItem order by id desc";
			Query query = session.createQuery(hql);
			query.setMaxResults(1);
			int id = (Integer) query.uniqueResult();
			tx.commit();
			return id;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return -1;
	}

	public static List<CartItem> listByCart(String cartId) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "from CartItem where cartId = :cartId";
			Query<CartItem> query = session.createQuery(hql);
			query.setString("cartId", cartId);
			List<CartItem> cartList = query.list();
			tx.commit();
			return cartList;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public static boolean delete(CartItem item) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			session.remove(item);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (!tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}

	public static boolean deleteByCart(Cart cart) {
		for (CartItem item : listByCart(cart.getId())) {
			if (!delete(item))
				return false;
		}
		return true;
	}

}
