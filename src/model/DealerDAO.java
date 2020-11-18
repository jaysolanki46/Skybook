package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.Dealer;
import config.DBConfig;

public class DealerDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(Dealer dealer) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into dealers "
            		+ "(name)" 
            		+ " values (?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, dealer.getName());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public ResultSet delete(Dealer dealer) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Delete from dealers where id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, dealer.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
