package model;

import java.util.Date;
import java.util.HashSet;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import connection.HibernateUtil;

public class CartDAO {
	
	public static final int ITEMSONPAGE = 12;
	
	public static Cart getCart(String id){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "FROM Cart WHERE id =:id";
			Query<Cart> query = session.createQuery(hql);
			query.setString("id", id);
			Cart cart = query.uniqueResult();
			tx.commit();
			return cart;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}finally {
			//session.close();
		}
		return null;
	}
	
	public static Cart getCartDetail(String id){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "select c from Cart as c join fetch c.cartItems as ci join fetch ci.product p where c.id = :id";
			Query query = session.createQuery(hql);
			query.setString("id", id);
			Cart cart = (Cart) query.uniqueResult();
			User user = UserDAO.getUserInfoById(cart.getUser().getId());
			cart.setUser(user);
			//Criteria criteria = session.createCriteria(CartItem.class);
//			for (CartItem item:list){
//				Product product = ProductHibernateDAO.getProductById(item.getProduct().getId());
//				item.setProduct(product);
//			}
//			cart.setCartItems(new HashSet<>(list));
			tx.commit();
			return cart;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}finally {
			session.close();
		}
		return null;
	}
	
	public static int getTotal() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				session.beginTransaction();
			String sql = "select count(id) from Cart";
			Query query = session.createQuery(sql);
			
			return (int) ((long) query.uniqueResult());
		} catch (HibernateException e) {
			// TODO: handle exception
		} finally {
			session.getTransaction().commit();
		}
		return 0;
	}

	public static int getPage(int itemsOnPage) {
		return (int) Math.ceil(getTotal() * 1.0 / itemsOnPage);
	}

	public static List<Cart> list() {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		if (!session.getTransaction().isActive())
			session.beginTransaction();

		String sql = "from Cart";
		Query query = session.createQuery(sql);
		List<Cart> list = query.list();
		session.getTransaction().commit();
		return list;
	}

	public static List<Cart> listByPage(int pageNumber, int itemsOnPage) {
		int pageTotal = getPage(itemsOnPage);
		if (pageNumber > pageTotal)
			pageNumber = pageTotal;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		List<Cart> list = null;
		try {
			if (!tx.isActive())
				tx.begin();
			String hql = "from Cart";
			Query query = session.createQuery(hql);
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
			String hql = "select id from Cart order by id desc";
			Query<String> query = session.createQuery(hql);
			query.setMaxResults(1);
			String id = query.uniqueResult();
			tx.commit();
			int num = Integer.parseInt(id.substring(2, id.length()));
			return "CT" + String.format("%05d", num+1);
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return "";
	}
	
	public static boolean insert(Cart cart){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			session.persist(cart);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return false;
	}
	
	
	public static Cart insert(String userId){
		Session session = HibernateUtil.getSessionFactory().getCurrentSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			Cart cart = new Cart();
			
			session.save(cart);
			tx.commit();
			return cart;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		}
		return null;
	}
	
	public static Cart insert(User user, List<CartItem> list){
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			Cart cart = new Cart();
			cart.setId(getNewId());
			cart.setUser(user);
			cart.setActive(false);
			cart.setDateAdd(new Date());
			session.persist(cart);
			for (CartItem item: list){
				item.setCart(cart);
				Product product = ProductHibernateDAO.getProductById(item.getProduct().getId());
				product.setQuantity(product.getQuantity() - item.getQuantity());
				session.save(item);
				session.update(product);
			}
			session.flush();
			tx.commit();
			
			return cart;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
		} finally{
			session.close();
		}
		return null;
	}
	
	public static boolean delete(Cart cart){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			for (CartItem item:CartItemDAO.listByCart(cart.getId())){
				session.remove(item);
			}
			session.remove(cart);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			// TODO: handle exception
			if (tx.isActive())
				tx.rollback();
			e.printStackTrace();
			return false;
		} finally{
			session.close();
		}
	}
	
	public static boolean delete (List<Cart> cartList){
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = session.getTransaction();
		try {
			if (!tx.isActive())
				tx.begin();
			for (Cart cart:cartList){
				for (CartItem item : CartItemDAO.listByCart(cart.getId())){
					session.remove(item);
				}
				session.remove(cart);
			}
			tx.commit();
			return true;
		} catch (HibernateException e) {
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
