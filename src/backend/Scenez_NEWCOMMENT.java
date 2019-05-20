package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class Scenez_NEWCOMMENT {
	
	Scenez_Connection s_con;
	
	//Constructor
	public Scenez_NEWCOMMENT() {
		s_con = new Scenez_Connection();
	}
	
	public Scenez_NEWCOMMENT(Connection con) {
		s_con = new Scenez_Connection(con);
	}
	
	//Method
	private boolean insertCommentHelper(int id, String content, String email, int postId){
		String query = "INSERT INTO project.comment VALUES (?,?,?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, id);
			stmt.setString(2, content);
			stmt.setTimestamp(3, new Timestamp(new Date().getTime()));
			stmt.setString(4, email);
			stmt.setInt(5, postId);
			
			stmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			success = false;
		}
		
		return success;
	}
	
	public void insertComment(String content, String email,int postId) {
		String query = "select max(id) from project.comment;";
		int maxId = 0;
		
		try {
			s_con.getConnection().setAutoCommit(false);
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				maxId = res.getInt(1);
				break;
			}
			if(insertCommentHelper(maxId+1, content, email, postId)==true)
				System.out.println("SUCCESS");
			s_con.getConnection().setAutoCommit(true);
		} catch (SQLException e) {
			try {
				s_con.getConnection().rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				System.out.println("Error! Unable to rollback");
			}
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public int getEventID(int postId) {
		int eventId = 0;
		String query = "select event_id from project.post where id = ?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postId);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				eventId = res.getInt(1);
				break;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventId;
	}
}
