package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Scenez_POST {
	
	Scenez_Connection s_con;
	
	public Scenez_POST()
	{
		s_con = new Scenez_Connection();
	}
	
	public Scenez_POST(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	
	public ArrayList<String> getPostsofEventAsList(int eventId){
		ArrayList<String> eventPostList = new ArrayList<String>();
		
		String query = "SELECT content FROM project.post where event_id=?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, eventId);
			
			ResultSet res = stmt.executeQuery();
			while(res.next()) {
				eventPostList.add(res.getString(1));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventPostList;
	}
	
	public Scenez_PostBean getSinglePostBean(int postId) {
		Scenez_PostBean postBean = new Scenez_PostBean();
		String query = "SELECT * FROM project.post where event_id=?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postId);
			
			ResultSet res = stmt.executeQuery();
			while(res.next()) {
				postBean.setId(res.getInt(1));
				postBean.setTitle(res.getString(2));
				postBean.setContent(res.getString(3));
				postBean.setTimestamp(res.getTimestamp(4));
				postBean.setEmail(res.getString(5));
				postBean.setEvent_id(res.getInt(6));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return postBean;
	}
	
	public ArrayList<String> nameofPoster(int postId) {
		ArrayList<String> fullName = new ArrayList<String>();
		
		String query = "select first_name, last_name from project.user where email in "
						+ "(select email from project.post where id = ?)";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, postId);
			
			ResultSet res = stmt.executeQuery();
			
			fullName.add(res.getString(1));
			fullName.add(res.getString(2));
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fullName;
	}

}
