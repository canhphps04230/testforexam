package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import connection.ConnectionUtils;
import connection.HibernateUtil;

public class ProductTypeDAO {
	public static final int ITEMSONPAGE = 12;
	Connection conn = null;
	Statement stm = null;
	PreparedStatement pst = null;
	ResultSet rs = null;

	public String getName(String id) throws ClassNotFoundException, SQLException {
		String name = "";
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT * FROM ProductType WHERE ID ='" + id + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		if (rs.next())
			name = rs.getString("Name");
		closeConnection();
		return name;
	}
	
	public static String getNameById(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "select name from ProductType where id = :id";
			Query<String> query = session.createQuery(hql);
			query.setString("id", id);
			String result = query.uniqueResult();
			tx.commit();
			return result;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return "";
	}

	public List<ProductType> list() throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT * FROM ProductType";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		List<ProductType> list = new ArrayList<ProductType>();
		while (rs.next()) {
			String id = rs.getString("ID");
			String name = rs.getString("Name");
			ProductType pt = new ProductType(id, name);
			list.add(pt);
		}
		closeConnection();
		return list;
	}

	private void closeConnection() throws SQLException {
		if (rs != null) {
			rs.close();
			rs = null;
		}
		if (pst != null) {
			pst.close();
			pst = null;
		}
		if (stm != null) {
			stm.close();
			stm = null;
		}
		if (conn != null) {
			conn.close();
			conn = null;
		}
	}

	public static List<ProductType> getComboBox() {
		List<ProductType> list = new ArrayList<>();
		list.add(new ProductType());
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		if (!tx.isActive())
			tx.begin();
		Query<ProductType> query = session.createQuery("from ProductType");
		list.addAll(query.list());
		tx.commit();
		return list;
	}

	public static ProductType getProductTypeById(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			ProductType productType = session.get(ProductType.class, id);
			session.getTransaction().commit();
			return productType;
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			// session.close();
		}
		return null;
	}

	public static int getTotal(String clause) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			String sql = "select count(id) from ProductType";
			if (!clause.isEmpty())
				sql += " where name like :clause";
			Query query = session.createQuery(sql);
			if (!clause.isEmpty())
				query.setString("clause", "%" + clause + "%");
			return (int) ((long) query.uniqueResult());
		} catch (HibernateException e) {
			// TODO: handle exception
		} finally {
			session.getTransaction().commit();
		}
		return 0;
	}

	public static int getPage(String clause, int itemsOnPage) {
		return (int) Math.ceil(getTotal(clause) * 1.0 / itemsOnPage);
	}

	public static List<ProductType> list(String clause) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		if (!session.getTransaction().isActive())
			session.beginTransaction();

		String sql = "from ProductType";
		if (!clause.isEmpty())
			sql += " where name like :clause";
		Query query = session.createQuery(clause);
		if (!clause.isEmpty())
			query.setString("clause", "%" + clause + "%");
		List<ProductType> list = query.list();
		session.beginTransaction().commit();
		return list;
	}

	public static List<ProductType> listByPage(String clause, int pageNumber, int itemsOnPage) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			tx = session.getTransaction();
			if (!tx.isActive())
				tx.begin();
			String sql = "from ProductType";
			if (!clause.isEmpty())
				sql += " where name like :clause";
			Query query = session.createQuery(sql);
			if (!clause.isEmpty())
				query.setString("clause", "%" + clause + "%");
			query.setFirstResult(itemsOnPage * (pageNumber - 1));
			query.setMaxResults(itemsOnPage);
			List<ProductType> list = query.list();
			tx.commit();
			return list;
		} catch (HibernateException e) {
			if (tx.isActive()) {
				tx.rollback();
			}
			e.printStackTrace();
			return null;
		}
	}

	public static String getNewId() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "select id from ProductType order by id desc";
			Query<String> query = session.createQuery(hql);
			query.setMaxResults(1);
			String id = query.uniqueResult();
			tx.commit();
			int num = Integer.parseInt(id.substring(2, id.length()));
			return "PT" + String.format("%05d", num + 1);
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return "";
	}

	public static boolean insert(ProductType productType) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			if (!session.getTransaction().isActive())
				tx = session.beginTransaction();
			session.persist(productType);
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

	public static boolean update(ProductType productType) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = null;
		try {
			if (!session.getTransaction().isActive())
				tx = session.beginTransaction();
			session.update(productType);
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
		Transaction tx = null;
		try {
			if (!session.getTransaction().isActive())
				tx = session.beginTransaction();
			ProductType productType = session.get(ProductType.class, id);
			session.delete(productType);
			tx.commit();
			return true;
		} catch (Exception e) {
			// TODO: handle exception
			if (tx != null)
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally {
			// session.close();
		}
	}

}
