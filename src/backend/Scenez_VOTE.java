package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

	public class Scenez_VOTE {
		
	Scenez_Connection s_con;
		
	public Scenez_VOTE()
	{
		s_con = new Scenez_Connection();
	}
		
	public Scenez_VOTE(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	// Methods
	
	// ------------------------------COMMENT VOTE METHODS-------------------------------------------------------------------
	public boolean giveUpVote(int commentID, String email) {
		String query = "INSERT INTO project.vote_comment VALUES (?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commentID);
			stmt.setString(2, email);
			stmt.setInt(3, 1);
			
			stmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			success = false;
		}
		
		return success;
	}
	
	public boolean giveDownVote(int commentID, String email) {
		String query = "INSERT INTO project.vote_comment VALUES (?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commentID);
			stmt.setString(2, email);
			stmt.setInt(3, -1);
			
			stmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			success = false;
		}
		
		return success;
	}
	
	public int getEventID(int commentID) {
		Scenez_NEWCOMMENT comm = new Scenez_NEWCOMMENT(s_con.getConnection());
		
		int postId = 0;
		int eventId = 0;
		
		String query = "select post_id from project.comment where id=?";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commentID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				postId = res.getInt(1);
				break;
			}
			
			eventId = comm.getEventID(postId);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventId;
	}
	
	// ---------------------------------POST VOTE METHODS ------------------------------------------------------------------------
	public boolean upVotePost(int postID, String email) {
		String query = "INSERT INTO project.vote_post VALUES (?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postID);
			stmt.setString(2, email);
			stmt.setInt(3, 1);
			
			stmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			success = false;
		}
		
		return success;
	}
	
	public boolean downVotePost(int postID, String email) {
		String query = "INSERT INTO project.vote_post VALUES (?,?,?);";
		boolean success = false;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postID);
			stmt.setString(2, email);
			stmt.setInt(3, -1);
			
			stmt.executeUpdate();
			success = true;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			success = false;
		}
		
		return success;
	}
	
	
} //End of Class
