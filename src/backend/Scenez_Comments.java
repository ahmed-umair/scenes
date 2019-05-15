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
	
} //End of class
