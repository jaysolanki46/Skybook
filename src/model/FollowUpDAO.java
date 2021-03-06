package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.FollowUp;
import bean.Log;
import bean.User;
import config.DBConfig;

public class FollowUpDAO {

	private Connection cnn;
	private ResultSet rs;

	public ResultSet insert(FollowUp followUp) throws ClassNotFoundException {

		try {
			new DBConfig();
			cnn = DBConfig.connection();
			
			PreparedStatement preparedStatement = cnn.prepareStatement("Insert into follow_ups "
					+ "(follow_up_date, follow_up_time, contact, note, is_completed, log)"
					+ "values (?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
			preparedStatement.setString(1, followUp.getFollowUpDate());
			preparedStatement.setString(2, followUp.getFollowUpTime());
			preparedStatement.setString(3, followUp.getFollowUpContact());
			preparedStatement.setString(4, followUp.getNote());
			preparedStatement.setBoolean(5, followUp.getStatus());
			preparedStatement.setString(6, followUp.getLog().getId().toString());

			System.out.println(preparedStatement);
			preparedStatement.executeUpdate();

			rs = preparedStatement.getGeneratedKeys();

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	public Boolean update(FollowUp followUp) throws ClassNotFoundException {
		
		try {
			
			new DBConfig();
			cnn = DBConfig.connection();
			
            PreparedStatement preparedStatement =  cnn.prepareStatement("Update follow_ups set "
            		+ "follow_up_date = ?, follow_up_time = ?, contact = ?, note = ?, is_completed = ?, updated_by = ?, updated_on = ?"
            		+ "WHERE id = ?", Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, followUp.getFollowUpDate());
			preparedStatement.setString(2, followUp.getFollowUpTime());
			preparedStatement.setString(3, followUp.getFollowUpContact());
			preparedStatement.setString(4, followUp.getNote());
			preparedStatement.setBoolean(5, followUp.getStatus());
			preparedStatement.setString(6, followUp.getUpdatedBy().getId().toString());
			preparedStatement.setString(7, followUp.getUpdatedOn());
			preparedStatement.setString(8, followUp.getId().toString());
            
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
