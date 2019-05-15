package backend;

import java.sql.*;
import java.util.ArrayList;

public class Scenez_EVENT {
	
	//Properties
	Scenez_Connection s_con;
	Statement smt = null;
	
	//Constructor
	public Scenez_EVENT() {
		//Set up connection here
		s_con = new Scenez_Connection();
	}
	
	public Scenez_EVENT(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	//Methods
	//Get Methods for attributes, return as ArrayList
	
	// Get Ids
	public ArrayList<String> getIdAsList(){
		
		ArrayList<String> ids = new ArrayList<String>();
		try {
			smt = s_con.getConnection().createStatement();
			ResultSet res_ids = smt.executeQuery("SELECT id FROM project.event;");
			
			while(res_ids.next()) {
				String result = res_ids.getString("id");
				ids.add(result);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return ids;
	}
	
	
	//Get Event Name
	public ArrayList<String>getEventNamesAsList(String email){
		
		ArrayList<String> names = new ArrayList<String>();
		try {
			smt = s_con.getConnection().createStatement();
			String query = "SELECT name FROM project.event WHERE email=?;";
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			
			stmt.setString(1, email);
			ResultSet res_names = stmt.executeQuery();
			
			while(res_names.next()) {
				String result = res_names.getString("name");
				names.add(result);
			}
			return names;
		} catch (SQLException e) {
	
			e.printStackTrace();
		}
		
		return null;
	}
	
	//Get Event Name as Single
	public String getEventNameAsSingle(int primaryKey) {
		
		String result = "";
		try {
			PreparedStatement smt = s_con.getConnection().prepareStatement("SELECT name FROM project.event WHERE id=?;");
			smt.setInt(1, primaryKey);
			
			ResultSet resSet = smt.executeQuery();
			result = resSet.getString(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
		
	}
	
	public Scenez_EventBean getSingleEventBean(int eventID) {
		Scenez_EventBean eventBean = new Scenez_EventBean();
		
		String query = "Select * from project.event where id = ?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, eventID);
			
			ResultSet res = stmt.executeQuery();
			while(res.next()) {
				eventBean.setId(res.getInt(1));
				eventBean.setName(res.getString(2));
				eventBean.setStart_time(res.getString(3));
				eventBean.setDuration(res.getDouble(4));
				eventBean.setPrivacy(res.getString(5));
				eventBean.setCapacity(res.getInt(6));
				eventBean.setDescription(res.getString(7));
				eventBean.setEmail(res.getString(8));
				eventBean.setCat_name(res.getString(9));
				eventBean.setLocation_id(res.getInt(10));
				eventBean.setEvent_date(res.getString(11));
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return eventBean;
	}
	
	public ArrayList<String> getEventTagsAsList(int eventId){
		ArrayList<String> eventTags = new ArrayList<String>();
		
		String query = "select tag from project.event_tag where event_id = ?;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, eventId);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String result = rs.getString(1);
				eventTags.add(result);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("ERROR IN EVENT TAG SQL QUERY");
		}
		
		return eventTags;
	}
	
	public ArrayList<Scenez_EventBean> getAllEventBeansAsList()
	{
		String query = "Select * FROM project.event";
		ArrayList<Scenez_EventBean> events = new ArrayList<Scenez_EventBean>();
		
		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next())
			{
				Scenez_EventBean currentEvent = new Scenez_EventBean();
				currentEvent.setId(rs.getInt(1));
				currentEvent.setName(rs.getString(2));
				currentEvent.setStart_time(rs.getString(3));
				currentEvent.setDuration(rs.getDouble(4));
				currentEvent.setPrivacy(rs.getString(5));
				currentEvent.setCapacity(rs.getInt(6));
				currentEvent.setDescription(rs.getString(7));
				currentEvent.setEmail(rs.getString(8));
				currentEvent.setCat_name(rs.getString(9));
				currentEvent.setLocation_id(rs.getInt(10));
				currentEvent.setEvent_date(rs.getString(11));
				
				events.add(currentEvent);
			}
			return events;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static void main(String[] args) {
		
	}

}
