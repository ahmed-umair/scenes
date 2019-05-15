package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

public class Scenes_USER {
	
	Scenez_Connection s_con;
	
	public Scenes_USER()
	{
		s_con = new Scenez_Connection();
	}
	
	public Scenes_USER(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	public ArrayList<String> getEmailAsList()
	{
		String query = "SELECT email FROM project.user";
		ArrayList<String> emails = new ArrayList<String>();
		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next())
			{
				emails.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return emails;
	}
	
	public boolean addUser(String fname, String lname, String email, String pword, String date, String gender, int avgRating) {
		String query = "INSERT INTO project.user VALUES (?,?,?,?,?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			st.setString(2, pword);
			st.setString(3, fname);
			st.setString(4, lname);
			st.setString(5, date);
			st.setString(6, gender);
			st.setInt(7, avgRating);
			st.executeUpdate();
			
			success = true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			success = false;
		}
		return success;
	}
	
	public String getPasswordAsSingle(String email)
	{
		String query = "SELECT password FROM project.user where email =?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<String> getFirstNameAsList()
	{
		String query = "SELECT first_name FROM project.user";
		ArrayList<String> firstNames = new ArrayList<String>();
		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next())
			{
				firstNames.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return firstNames;
	}
	
	public ArrayList<String> getLNameAsList()
	{
		String query = "SELECT first_name FROM project.user";
		ArrayList<String> lastNames = new ArrayList<String>();
		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next())
			{
				lastNames.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return lastNames;
	}
	
	public Date getDateAsSingle(String email)
	{
		String query = "SELECT dob FROM project.user where email =?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getDate(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getGenderAsSingle(String email)
	{
		String query = "SELECT gender FROM project.user where email =?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getAvgRatingAsSingle(String email)
	{
		String query = "SELECT avg_rating FROM project.user where email =?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getFirstNameAsString(String email)
	{
		String query = "SELECT first_name FROM project.user WHERE email = ?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getLastNameAsString(String email)
	{
		String query = "SELECT last_name FROM project.user WHERE email = ?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public boolean checkUniqueEmail(String email) {
		String query = "SELECT email FROM project.user WHERE email=?";
		boolean isUnique = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setString(1, email);
			
			ResultSet set = stmt.executeQuery();
			
			if (!set.isBeforeFirst()) {    
			    isUnique = true;
			} 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isUnique;
	}
	
}
