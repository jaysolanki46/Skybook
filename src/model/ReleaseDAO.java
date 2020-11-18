package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Dealer;
import bean.Release;
import config.DBConfig;

public class ReleaseDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(Release release) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into releases "
            		+ "(name)" 
            		+ " values (?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, release.getName());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public ResultSet delete(Release release) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Delete from releases where id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, release.getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
