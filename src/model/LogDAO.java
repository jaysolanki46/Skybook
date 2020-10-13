package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.Log;
import db.DBConfig;

public class LogDAO {

	private Connection cnn;
	private ResultSet rs;
	
	public LogDAO() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated constructor stub
		new DBConfig();
		cnn = DBConfig.connection();
	}
	
	public ResultSet insert(Log log) {
		
		try {
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Insert into logs "
            		+ "(user, log_date, log_time, is_voicemail, is_instructed, dealer, dealer_technician, serial, "
            		+ "terminal, issue_master, issue, description, new_issue, new_solution, status)" 
            		+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, log.getUser().getId().toString());
            preparedStatement.setString(2, log.getLogDate());
            preparedStatement.setString(3, log.getLogTime());
            preparedStatement.setBoolean(4, log.getIsVoicemail());
            preparedStatement.setBoolean(5, log.getIsInstructed());
            preparedStatement.setString(6, log.getDealer().getId().toString());
            preparedStatement.setString(7, log.getDealerTechnician().getId().toString());
            preparedStatement.setString(8, log.getSerial());
            preparedStatement.setString(9, log.getTerminal().getId().toString());
            preparedStatement.setString(10, log.getIssueMaster().getId().toString());
            preparedStatement.setString(11, log.getIssue().getId().toString());
            preparedStatement.setString(12, log.getDescription());
            preparedStatement.setString(13, log.getNewIssue());
            preparedStatement.setString(14, log.getNewSolution());
            preparedStatement.setString(15, log.getStatus().getId().toString());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
}
