package model;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.query.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.exception.ConstraintViolationException;

import connection.HibernateUtil;

public class ProductHibernateDAO {
	public static final int ITEMSONPAGE = 12;

	public static Product getProductById(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			if (!session.getTransaction().isActive())
				session.beginTransaction();
			Product product = session.get(Product.class, id);
			session.getTransaction().commit();
			return product;
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return null;
	}

	public static long getTotal(String clause, String type) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		try {
			if (!session.getTransaction().isActive())
				session.beginTransaction();
			String sql = "select count(id) from Product";
			String where = "";
			if (!clause.isEmpty())
				where += " name like :clause and";
			if (!type.isEmpty())
				where += " typeId = :type and";
			if (!where.isEmpty())
				sql = sql + " where" + where.substring(0, where.length() - 4);
			Query query = session.createQuery(sql);
			if (!clause.isEmpty())
				query.setString("clause", "%" + clause + "%");
			if (!type.isEmpty())
				query.setString("type", type);
			return (long) query.uniqueResult();
		} catch (HibernateException e) {
			// TODO: handle exception
		} finally {
			session.getTransaction().commit();
		}
		return 0;
	}

	public static int getPage(String clause, String type, int itemsOnPage) {
		return (int) Math.ceil(getTotal(clause, type) * 1.0 / itemsOnPage);
	}

	public static List<Product> list(String clause, String type) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		if (!session.getTransaction().isActive())
			session.beginTransaction();

		String sql = "from Product";
		String where = "";
		if (!clause.isEmpty())
			where += " name like :clause and";
		if (!type.isEmpty())
			where += " typeId = :type and";
		if (!where.isEmpty())
			sql = sql + " where" + where.substring(0, where.length() - 4);
		Query query = session.createQuery(sql);
		if (!clause.isEmpty())
			query.setString("clause", "%" + clause + "%");
		if (!type.isEmpty())
			query.setString("type", type);
		List<Product> list = query.list();
		session.getTransaction().commit();
		return list;
	}
	
	public static List<Product> list(String clause, String type, int limit) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		if (!session.getTransaction().isActive())
			session.beginTransaction();

		String sql = "from Product";
		String where = "";
		if (!clause.isEmpty())
			where += " name like :clause and";
		if (!type.isEmpty())
			where += " typeId = :type and";
		if (!where.isEmpty())
			sql = sql + " where" + where.substring(0, where.length() - 4);
		Query query = session.createQuery(sql);
		query.setMaxResults(limit);
		if (!clause.isEmpty())
			query.setString("clause", "%" + clause + "%");
		if (!type.isEmpty())
			query.setString("type", type);
		List<Product> list = query.list();
		session.getTransaction().commit();
		return list;
	}

	public static List<Product> listByPage(String clause, String type, int pageNumber, int itemsOnPage) {
		int pageTotal = getPage(clause, type, itemsOnPage);
		if (pageNumber > pageTotal)
			pageNumber = pageTotal;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		List<Product> list = null;
		try {
			tx = session.getTransaction();
			if (!tx.isActive())
				tx.begin();
			String sql = "from Product";
			String where = "";
			if (!clause.isEmpty())
				where += " name like :clause and";
			if (!type.isEmpty())
				where += " typeId = :type and";
			if (!where.isEmpty())
				sql = sql + " where" + where.substring(0, where.length() - 4);
			Query query = session.createQuery(sql);
			if (!clause.isEmpty())
				query.setString("clause", "%" + clause + "%");
			if (!type.isEmpty())
				query.setString("type", type);
			query.setFirstResult(itemsOnPage * (pageNumber - 1));
			query.setMaxResults(itemsOnPage);
			list = query.list();
			tx.commit();
		} catch (HibernateException e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			e.printStackTrace();
		}
		return list;
	}
	
	public static String getNewId(){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "select id from Product order by id desc";
			Query<String> query = session.createQuery(hql);
			query.setMaxResults(1);
			String id = query.uniqueResult();
			tx.commit();
			int num = Integer.parseInt(id.substring(2, id.length()));
			return "PS" + String.format("%05d", num+1);
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return "";
	}

	public static boolean insert(Product product) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.getTransaction();
			if (!tx.isActive())
				tx.begin();
			session.persist(product);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			// session.close();
		}
	}

	public static boolean update(Product product) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.getTransaction();
			if (!tx.isActive())
				tx.begin();
			session.update(product);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			// session.close();
		}
	}

	public static boolean delete(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			Product product = session.get(Product.class, id);
			session.delete(product);
			tx.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			// session.close();
		}
	}
	
	public static boolean delete (List<Product> list){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			for (Product product:list)
				session.delete(product);
			tx.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			session.close();
		}
	}
}
