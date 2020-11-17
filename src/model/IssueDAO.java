package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import bean.Issue;
import config.DBConfig;

public class IssueDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(Issue issue) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into issues "
            		+ "(name, solution, issue_master)" 
            		+ " values (?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, issue.getName());
            preparedStatement.setString(2, issue.getSolution());
            preparedStatement.setInt(3, issue.getIssueMaster().getId());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
