package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {

	public static Connection connection() throws ClassNotFoundException, SQLException {
		 Class.forName("com.mysql.jdbc.Driver");
		 Connection connection = DriverManager
		            .getConnection("jdbc:mysql://localhost:3306/skybook?useSSL=false", "root", "xxx!@");
		 
		 return connection;
		 
	}
}
