package model;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

import connection.HibernateUtil;

public class UserDAO {
	public static final int ITEMSONPAGE = 12;

	public static boolean isUser(String email, String password) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			Query<User> query = session.createQuery("from User where email = :email AND password = :password");
			query.setString("email", email);
			query.setString("password", password);
			boolean result = query.uniqueResult() != null;
			tx.commit();
			return result;
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return false;
	}
	
	public static User getUserInfo(String email) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			Query<User> query = session.createQuery("select new User(id, email, name, gender) from User where email = :email");
			query.setString("email", email);
			User result = query.uniqueResult();
			tx.commit();
			return result;
		} catch (HibernateException e) {
			e.printStackTrace();
		} finally {
			session.close();
		}
		return null;
	}

	public static User getUser(String email) {

		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			Query<User> query = session.createQuery("from User where email = :email");
			query.setString("email", email);
			
			User result = query.uniqueResult();
			tx.commit();
			return result;
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx.isActive())
				tx.commit();
		} finally {
			session.close();
		}
		return null;
	}

	public static User getUserById(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			Query<User> query = session.createQuery("from User where id = :id");
			query.setString("id", id);
			User user = query.uniqueResult();
			tx.commit();
			return user;
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx.isActive())
				tx.rollback();
		} finally {
			//session.close();
		}
		return null;
	}
	
	public static User getUserInfoById(String id) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			Query query = session.createQuery("select new User(id, email, name, gender) from User where id = :id");
			query.setString("id", id);
			User user = (User) query.uniqueResult();
			tx.commit();
			return user;
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
			String sql = "select count(id) from User";
			if (!clause.isEmpty())
				sql += " where name like :clause or email like :clause";
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

	public static List<User> list(String clause) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		if (!session.getTransaction().isActive())
			session.beginTransaction();

		String sql = "from User";
		if (!clause.isEmpty())
			sql += " where name like :clause or email like :clause";
		Query query = session.createQuery(clause);
		if (!clause.isEmpty())
			query.setString("clause", "%" + clause + "%");
		List<User> list = query.list();
		session.getTransaction().commit();
		return list;
	}

	public static List<User> listByPage(String clause, int pageNumber, int itemsOnPage) {
		int pageTotal = getPage(clause, itemsOnPage);
		if (pageNumber > pageTotal)
			pageNumber = pageTotal;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		List<User> list = null;
		try {
			if (!tx.isActive())
				tx.begin();
			String sql = "from User";
			if (!clause.isEmpty())
				sql += " where name like :clause or email like :clause";
			Query query = session.createQuery(sql);
			if (!clause.isEmpty())
				query.setString("clause", "%" + clause + "%");
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
			String hql = "select id from User order by id desc";
			Query<String> query = session.createQuery(hql);
			query.setMaxResults(1);
			String id = query.uniqueResult();
			tx.commit();
			int num = Integer.parseInt(id.substring(2, id.length()));
			return "US" + String.format("%05d", num+1);
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return "123";
	}

	public static boolean insert(User user) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			session.persist(user);
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

	public static boolean update(User user) {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			session.update(user);
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
			User user = session.get(User.class, id);
			session.delete(user);
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
