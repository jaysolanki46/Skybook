package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import bean.FollowUp;
import bean.Log;
import bean.User;
import db.DBConfig;

public class FollowUpDAO {

	private Connection cnn;
	private ResultSet rs;

	public FollowUpDAO() throws ClassNotFoundException, SQLException {
		// TODO Auto-generated constructor stub
		new DBConfig();
		cnn = DBConfig.connection();
	}

	public ResultSet insert(FollowUp followUp) {

		try {

			PreparedStatement preparedStatement = cnn.prepareStatement("Insert into follow_up "
					+ "(follow_up_date, follow_up_time, contact, note, status, log)"
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
}
