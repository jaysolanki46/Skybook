package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.User;
import db.DBConfig; 

public class LoginDao {
	
	private boolean status = false;
	private Connection cnn;
	
	public LoginDao() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated constructor stub
		new DBConfig();
		cnn = DBConfig.connection();
	}

	public boolean validate(User user) throws ClassNotFoundException {

        try {
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("select * from users where name = ? and pass = ? ");
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPass());

            System.out.println(preparedStatement);
            ResultSet rs = preparedStatement.executeQuery();
            status = rs.next();

        } catch (SQLException e) {
           	e.printStackTrace();
        }
        return status;
    }
	
}
