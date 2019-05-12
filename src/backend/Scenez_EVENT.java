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
	
	//Methods
	//Get Methods for attributes, return as ArrayList
	
	// Get Ids
	public ArrayList<String>getIdAsList(){
		
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
	
	
	
	public static void main(String[] args) {
		
	}

}
