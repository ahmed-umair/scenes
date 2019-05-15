package backend;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Scenez_LOCATION {
	
	private Scenez_Connection s_con;
	
	public Scenez_LOCATION()
	{
		s_con = new Scenez_Connection();
	}
	
	public Scenez_LOCATION(Connection con)
	{
		s_con = new Scenez_Connection(con);
	}
	
	public String getLocationSpecificsByID(int id)
	{
		String query = "SELECT specifics FROM project.location WHERE id=" + id;
		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next())
			{
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
