package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionUtils {
	public static final String HOST = "us-cdbr-iron-east-03.cleardb.net", 
			DBNAME = "ad_b71a9c91b7560a5",
			USER = "be8d7a7c0a1014", 
			PASS = "fae09c5d";
	public static final String URL = "jdbc:mysql://" + HOST + ":3306/" + DBNAME;

	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.jdbc.Driver");
		
		return DriverManager.getConnection(URL, USER, PASS);
	}
}
