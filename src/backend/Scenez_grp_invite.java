package backend;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Scenez_grp_invite {
	
	Scenez_Connection s_con;
	static String USER_PENDING = "User_Pending";
	static String ADMIN_PENDING = "Admin_Pending";
	static String ACCEPTED = "Accepted";
	static String REJECTED = "Rejected";
	
	public Scenez_grp_invite()
	{
		s_con = new Scenez_Connection();
	}
	
	//Invitee will be the current user
	public void addInvite(String inviter, String invitee, int grp_id)
	{
		String query = "INSERT INTO project.grp_invite values (?, ?, ?, ?)";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, inviter);
			st.setString(2, invitee);
			st.setInt(3, grp_id);
			st.setString(4, USER_PENDING);
			//System.out.println(st.toString());
			st.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void updateStatus(String inviter, String invitee, int grp_id, String newStatus)
	{
		String query = "UPDATE project.grp_invite "
				+ "SET status = ? "
				+ "WHERE inviter = ? AND invitee = ? AND group_id = ?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, newStatus);
			st.setString(2, inviter);
			st.setString(3, invitee);
			st.setInt(4, grp_id);
			st.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<String> getGroupNamesAsLinkedList(String user_email)
	{
		String query = "SELECT name "
				+ "FROM project.grp "
				+ "WHERE id in (SELECT group_id  "
							+ "FROM project.grp_invite "
							+ "WHERE invitee = ? AND status = 'Accepted')";
		try 
		{
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, user_email);
			ResultSet rs = st.executeQuery();
			ArrayList<String> group_names = new ArrayList<String>();
			while (rs.next())
			{
				group_names.add(rs.getString(1));
			}
			return group_names;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
}
