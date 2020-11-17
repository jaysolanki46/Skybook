package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Dealer;
import bean.Terminal;
import config.DBConfig;

public class TerminalDAO {
	
	private Connection cnn;
	private ResultSet rs;
	
	public ResultSet insert(Terminal terminal) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into terminals "
            		+ "(name)" 
            		+ " values (?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, terminal.getName());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
