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
            		+ "issue_master, issue, description, new_issue, new_solution, status, terminal, current_release)" 
            		+ " values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, log.getUser().getId().toString());
            preparedStatement.setString(2, log.getLogDate());
            preparedStatement.setString(3, log.getLogTime());
            preparedStatement.setBoolean(4, log.getIsVoicemail());
            preparedStatement.setBoolean(5, log.getIsInstructed());
            preparedStatement.setString(6, log.getDealer().getId().toString());
            preparedStatement.setString(7, log.getDealerTechnician().getId().toString());
            preparedStatement.setString(8, log.getSerial());
            preparedStatement.setString(9, log.getIssueMaster().getId().toString());
            preparedStatement.setString(10, log.getIssue().getId().toString());
            preparedStatement.setString(11, log.getDescription());
            preparedStatement.setString(12, log.getNewIssue());
            preparedStatement.setString(13, log.getNewSolution());
            preparedStatement.setString(14, log.getStatus().getId().toString());
            
            if(log.getTerminal() != null) {
            	preparedStatement.setString(15, log.getTerminal().getId().toString());
            } else {
            	preparedStatement.setString(15, null);
            }
            
            if(log.getCurrentRelease() != null) {
            	preparedStatement.setString(16, log.getCurrentRelease().getId().toString());
            } else {
            	preparedStatement.setString(16, null);
            }
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
        }
		return rs;
	}
	
	public Boolean update(Log log) {
		
		try {
        	
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update logs set "
            		+ "description = ?, new_issue = ?, new_solution = ?, status = ? "
            		+ "WHERE id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, log.getDescription());
            preparedStatement.setString(2, log.getNewIssue());
            preparedStatement.setString(3, log.getNewSolution());
            preparedStatement.setString(4, log.getStatus().getId().toString());
            preparedStatement.setString(5, log.getId().toString());
            
            System.out.println(preparedStatement);
            preparedStatement.executeUpdate();
            
            rs = preparedStatement.getGeneratedKeys();
            
        } catch (SQLException e) {
           	e.printStackTrace();
           	return false;
        }
		return true;
	}
}
