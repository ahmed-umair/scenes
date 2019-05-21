package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Scenez_SEARCH {
	
	//Properties
	Scenez_Connection s_con;
	
	//Constructor
	public Scenez_SEARCH() {
		//Set up connection here
		s_con = new Scenez_Connection();
	}
		
	public Scenez_SEARCH(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	
	//Methods
	public ArrayList<Scenez_USERBEAN> searchUser(String username){
		ArrayList<Scenez_USERBEAN> userSearchBean = new ArrayList<Scenez_USERBEAN>();
		//user_name can either be first only, last only or first+last
		String query = "select * from project.user where first_name LIKE ? or last_name LIKE ?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setString(1, username+"%");
			stmt.setString(2, "%"+username);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				Scenez_USERBEAN userBean = new Scenez_USERBEAN();
				userBean.setEmail(res.getString(1));
				userBean.setPassword(res.getString(2));
				userBean.setFirst_name(res.getString(3));
				userBean.setLast_name(res.getString(4));
				userBean.setDob(res.getDate(5));
				userBean.setGender(res.getString(6));
				userBean.setAvg_rating(res.getInt(7));
				
				userSearchBean.add(userBean);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return userSearchBean;
	}

}
