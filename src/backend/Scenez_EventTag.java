package backend;

import java.sql.*;
import java.util.ArrayList;

public class Scenez_EventTag {
	//Properties
	Scenez_Connection s_con;
	Statement smt = null;
		
	//Constructor
	public Scenez_EventTag() {
			//Set up connection here
			s_con = new Scenez_Connection();
		}
	
	//Get tags for popular tag column --> curDate < eventDate
	public ArrayList<String> getPopularTagsAsList(){
		ArrayList<String> popularTags = new ArrayList<String>();
		
		try {
			String query = "select tag, count(*) from project.event_tag where event_id in "
					 		+ "(select id from project.event where event_date > curdate()) " + 
					 		"group by tag order by count(*) desc;";
			
			Statement stmt = s_con.getConnection().createStatement();
			
			ResultSet rs_set = stmt.executeQuery(query);
			
			while(rs_set.next()) {
				popularTags.add(rs_set.getString(1));
			}
				
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return popularTags;
	}
	
	
}//End of class
