package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Scenez_CATAGORIES {
	
	Scenez_Connection s_con;
	
	public Scenez_CATAGORIES()
	{
		s_con = new Scenez_Connection();
	}
		
	public Scenez_CATAGORIES(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	public ArrayList<String> getCatagories(){
		String query = "SELECT * FROM project.category;";
		ArrayList<String> cats = new ArrayList<String>();
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				cats.add(res.getString(1));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cats;
	}

}
