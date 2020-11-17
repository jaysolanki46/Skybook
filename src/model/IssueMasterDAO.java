package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.IssueMaster;
import config.DBConfig;

public class IssueMasterDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(IssueMaster issueMaster) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into issue_master "
            		+ "(name)" 
            		+ " values (?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, issueMaster.getName());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
