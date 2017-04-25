package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import connection.ConnectionUtils;

public class ProductDAO {
	public static final int ITEMSONPAGE = 10;
	public static final String IMAGEPATH = "img/product/", THUMBNAILPATH = "img/product/thumbnail/";
	Connection conn = null;
	Statement stm = null;
	PreparedStatement pst = null;
	ResultSet rs = null;

	public List<Product> list() {
		try {
			conn = ConnectionUtils.getConnection();
			String sql = "SELECT * FROM Product";
			stm = conn.createStatement();
			rs = stm.executeQuery(sql);
			List<Product> list = new ArrayList<>();
			while (rs.next()) {
				String id = rs.getString("ID");
				String name = rs.getString("Name");
				String typeId = rs.getString("TypeID");
				String image = rs.getString("Image");
				float price = rs.getFloat("Price");
				int quantity = rs.getInt("Quantity");
				Product p = new Product(id, name, price, quantity, image, typeId);
				list.add(p);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Product> listHot() {
		try {
			conn = ConnectionUtils.getConnection();
			String sql = "SELECT * FROM Product ORDER BY Price DESC LIMIT 5";
			stm = conn.createStatement();
			rs = stm.executeQuery(sql);
			List<Product> list = new ArrayList<>();
			while (rs.next()) {
				String id = rs.getString("ID");
				String name = rs.getString("Name");
				String typeId = rs.getString("TypeID");
				String image = rs.getString("Image");
				float price = rs.getFloat("Price");
				int quantity = rs.getInt("Quantity");
				Product p = new Product(id, name, price, quantity, image, typeId);
				list.add(p);
			}
			closeConnection();
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public List<Product> listByType(String typeId) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT * FROM Product";
		if (typeId != null && !typeId.isEmpty())
			sql += " WHERE TypeID='" + typeId + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		List<Product> list = new ArrayList<>();
		while (rs.next()) {
			String id = rs.getString("ID");
			String name = rs.getString("Name");
			String type = rs.getString("TypeID");
			String image = rs.getString("Image");
			float price = rs.getFloat("Price");
			int quantity = rs.getInt("Quantity");
			Product p = new Product(id, name, price, quantity, image, type);
			list.add(p);
		}
		closeConnection();
		return list;
	}

	public List<Product> listByTypeWithLimit(String typeId, int begin, int end)
			throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT * FROM Product";
		if (!typeId.isEmpty())
			sql += " WHERE TypeID='" + typeId + "'";
		sql += " LIMIT " + begin + ", " + end;
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		List<Product> list = new ArrayList<>();
		while (rs.next()) {
			String id = rs.getString("ID");
			String name = rs.getString("Name");
			String type = rs.getString("TypeID");
			String image = rs.getString("Image");
			float price = rs.getFloat("Price");
			int quantity = rs.getInt("Quantity");
			Product p = new Product(id, name, price, quantity, image, type);
			list.add(p);
		}
		closeConnection();
		return list;
	}

	public List<Product> listByTypeWithPage(String typeId, int page) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		int begin = (page - 1) * ITEMSONPAGE;
		String sql = "SELECT * FROM Product";
		if (!typeId.isEmpty())
			sql += " WHERE TypeID='" + typeId + "'";
		sql += " LIMIT " + begin + ", " + ITEMSONPAGE;
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		List<Product> list = new ArrayList<>();
		while (rs.next()) {
			String id = rs.getString("ID");
			String name = rs.getString("Name");
			String type = rs.getString("TypeID");
			String image = rs.getString("Image");
			float price = rs.getFloat("Price");
			int quantity = rs.getInt("Quantity");
			Product p = new Product(id, name, price, quantity, image, type);
			list.add(p);
		}
		closeConnection();
		return list;
	}

	// public List<Product> listWithClause(String type, String name, float min,
	// float max, int itemsOnPage, int page) {
	// String countSql = "SELECT (ID) From Product";
	// String sql = "SELECT * FROM Product";
	// String where = "";
	// if (!type.isEmpty())
	// where += " TypeId ='" + type + "' AND";
	// if (!name.isEmpty())
	// where += " Name LIKE '%" + name + "%' AND";
	// if (min > 0)
	// where += "Price >=" + min + " AND";
	// if (max > 0)
	// where += " Price <=" + max + " AND";
	// if (!where.isEmpty()) {
	// countSql = countSql + " WHERE" + where.substring(0, where.length() - 4);
	// sql = sql + " WHERE" + where.substring(0, where.length() - 4);
	// }
	// }

	public int getTotalByType(String typeId) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT COUNT(ID) AS Total FROM Product";
		if (!typeId.isEmpty())
			sql += " WHERE TypeID='" + typeId + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		int result = 0;
		if (rs.next())
			result = rs.getInt("Total");
		closeConnection();
		return result;
	}

	public int getPageByType(String typeId) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT COUNT(ID) AS Total FROM Product";
		if (!typeId.isEmpty())
			sql += " WHERE TypeID='" + typeId + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		double total;
		int result = 1;
		if (rs.next()) {
			total = rs.getInt("Total") * 1.0 / ITEMSONPAGE;
			result = (int) Math.ceil(total);
		}
		closeConnection();
		return result;
	}

	public Product getProductById(String id) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT * FROM Product WHERE ID='" + id + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		if (rs.next()) {
			String name = rs.getString("Name");
			String type = rs.getString("TypeID");
			String image = rs.getString("Image");
			float price = rs.getFloat("Price");
			int quantity = rs.getInt("Quantity");
			return new Product(id, name, price, quantity, image, type);
		}
		closeConnection();
		return null;
	}

	public float getPriceMinByType(String type) throws ClassNotFoundException, SQLException {
		Float price = null;
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT MIN(Price) AS 'MinPrice' FROM Product";
		if (!type.isEmpty())
			sql += " WHERE type ='" + type + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		if (rs.next()) {
			price = rs.getFloat("MinPrice");
		}
		closeConnection();
		return price;
	}

	public float getPriceMaxByType(String type) throws ClassNotFoundException, SQLException {
		Float price = null;
		conn = ConnectionUtils.getConnection();
		String sql = "SELECT MAX(Price) AS 'MaxPrice' FROM Product";
		if (!type.isEmpty())
			sql += " WHERE type ='" + type + "'";
		stm = conn.createStatement();
		rs = stm.executeQuery(sql);
		if (rs.next()) {
			price = rs.getFloat("MaxPrice");
		}
		closeConnection();
		return price;
	}

	public boolean insert(Product product) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "INSERT INTO Product(ID, Name, Price, Quantity, Image, TypeID) VALUES(?,?,?,?,?,?)";
		pst = conn.prepareStatement(sql);
		pst.setString(1, product.getId());
		pst.setString(2, product.getName());
		pst.setFloat(3, product.getPrice());
		pst.setInt(4, product.getQuantity());
		pst.setString(5, product.getImage());
		pst.setString(6, product.getTypeId());
		int result = pst.executeUpdate();
		closeConnection();
		if (result > 0)
			return true;
		return false;
	}

	public boolean update(Product product) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "UPDATE Product SET Name=?, Price=?, Quantity=?, Image=?, TypeID=? WHERE ID=?";
		pst = conn.prepareStatement(sql);
		pst.setString(1, product.getName());
		pst.setFloat(2, product.getPrice());
		pst.setInt(3, product.getQuantity());
		pst.setString(4, product.getImage());
		pst.setString(5, product.getTypeId());
		pst.setString(6, product.getId());
		int result = pst.executeUpdate();
		closeConnection();
		if (result > 0)
			return true;
		return false;
	}

	public boolean delete(String id) throws ClassNotFoundException, SQLException {
		conn = ConnectionUtils.getConnection();
		String sql = "DELETE FROM Product WHERE ID='" + id + "'";
		stm = conn.createStatement();
		int result = stm.executeUpdate(sql);
		closeConnection();
		if (result > 0)
			return true;
		return false;
	}

	private void closeConnection() {
		try {
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
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
