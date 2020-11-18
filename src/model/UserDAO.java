package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Dealer;
import bean.User;
import config.DBConfig;

public class UserDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(User user) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into users "
            		+ "(name, pass, email, is_admin, is_support)" 
            		+ " values (?, ?, ? ,?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPass());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setBoolean(4, user.isIs_admin());
            preparedStatement.setBoolean(5, user.isIs_support());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public ResultSet delete(User user) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Delete from users where id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, user.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
