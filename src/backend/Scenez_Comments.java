package backend;

import java.sql.*;
import java.util.ArrayList;

public class Scenez_Comments {
	
	//Properties
	Scenez_Connection s_con;
	
	//Constructor
	public  Scenez_Comments() {
		// TODO Auto-generated constructor stub
		s_con = new Scenez_Connection();
	}
		
	public Scenez_Comments(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	//Methods
	public ArrayList<Scenez_CommentBean> getCommentsOfPostAsList(int postId){
		ArrayList<Scenez_CommentBean> commentList = new ArrayList<Scenez_CommentBean>();
		String query = "SELECT * from project.comment where post_id = ? "
						+ "order by timestamp desc;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postId);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				Scenez_CommentBean currCommentBean = new Scenez_CommentBean();
				currCommentBean.setId(res.getInt(1));
				currCommentBean.setContent(res.getString(2));
				currCommentBean.setTimestamp(res.getTimestamp(3));
				currCommentBean.setEmail(res.getString(4));
				currCommentBean.setPost_id(res.getInt(5));
				
				commentList.add(currCommentBean);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return commentList;
	}
	
	public ArrayList<String> getNameofCommenter(int commID){
		ArrayList<String> fullName = new ArrayList<String>();
		
		String query = "select first_name, last_name from project.user where email in "
				   		+ "(select email from project.comment where id = ?);";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commID);
			
			ResultSet res = stmt.executeQuery();
			
			fullName.add(res.getString(1));
			fullName.add(res.getString(2));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fullName;
	}
	
	public String getFirstName(int commID) {
		String query = "select first_name from project.user where email in "
				   		+ "(select email from project.comment where id = ?);";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				return res.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	public String getLastName(int commID) {
		String query = "select last_name from project.user where email in "
				   		+ "(select email from project.comment where id = ?);";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				return res.getString(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	//Delete Comment
	public void deleteComment(int commentID) {
		String query = "delete from project.comment where id=?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commentID);
			
			stmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//Id of post from comment
	public int getEventID(int commentID) {
		String query = "select post_id from project.comment where id=?;";
		int postID = 0;
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commentID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				postID = res.getInt(1);
				break;
			}
			
			Scenez_POST eventofPost = new Scenez_POST(s_con.getConnection());
			
			return eventofPost.getEventID(postID);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int getUpVoteCountForComment(int commID) {
		String query = "select count(*) from project.vote_comment where comment_id=? and vote_type=1;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				return res.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public int getDownVoteCountForComment(int commID) {
		String query = "select count(*) from project.vote_comment where comment_id=? and vote_type=-1;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, commID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				return res.getInt(1);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return 0;
	}
	
} //End of class
