package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.User;
import config.DBConfig; 

public class LoginDAO {
	
	private Connection cnn;
	private ResultSet rs;

	public ResultSet validate(User user) throws ClassNotFoundException {

        try {
        	new DBConfig();
    		cnn = DBConfig.connection();
    		
            PreparedStatement preparedStatement =  cnn.prepareStatement("select * from users where name = ? and pass = ? and is_support = ?");
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPass());
            preparedStatement.setBoolean(3, true);

            System.out.println(preparedStatement);
            rs = preparedStatement.executeQuery();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
        
		return rs;
    }
	
	public ResultSet validateAdmin(User user) throws ClassNotFoundException {

        try {
        	new DBConfig();
    		cnn = DBConfig.connection();
    		
            PreparedStatement preparedStatement =  cnn.prepareStatement("select * from users where name = ? and pass = ? and is_admin = ?");
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getPass());
            preparedStatement.setBoolean(3, true);
            
            System.out.println(preparedStatement);
            rs = preparedStatement.executeQuery();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
        
		return rs;
    }
}
