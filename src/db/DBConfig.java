package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {

	public static Connection connection() throws ClassNotFoundException, SQLException {
		 
		// For production
		/* Class.forName("org.mariadb.jdbc.Driver");
		 	Connection connection = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/skybook?useSSL=false", "root", "");
		*/
		
		// For test
		 Class.forName("com.mysql.jdbc.Driver");
		 Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/skybook?useSSL=false", "root", "Js0322!@");
		 return connection;
		 
	}
}
