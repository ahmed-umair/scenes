package backend;

import java.sql.Connection;
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
	
	public Scenez_grp_invite(Connection con)
	{
		s_con = new Scenez_Connection(con);
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
	
	public ArrayList<Scenez_GroupBean> getGroupBean(String email){
		String query = "SELECT * FROM project.grp WHERE id in "
						+ "(SELECT group_id  FROM project.grp_invite WHERE inviter =? or (invitee =? AND status = 'Accepted'));";
		ArrayList<Scenez_GroupBean> grpEvents = new ArrayList<Scenez_GroupBean>();
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setString(1, email);
			stmt.setString(2, email);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				Scenez_GroupBean grpbean = new Scenez_GroupBean();
				grpbean.setGrp_id(res.getInt(1));
				grpbean.setName(res.getString(2));
				grpbean.setDescription(res.getString(3));
				
				grpEvents.add(grpbean);
			}
						
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return grpEvents;
	}
	
	public Scenez_GroupBean getSingleGroupBean(int groupID) {
		
		Scenez_GroupBean grpBean = new Scenez_GroupBean();
		String query = "Select * from project.grp where id = ?;";
		
		try {
			PreparedStatement  stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, groupID);
			
			ResultSet res = stmt.executeQuery();
			
			while(res.next()) {
				grpBean.setGrp_id(res.getInt(1));
				grpBean.setName(res.getString(2));
				grpBean.setDescription(res.getString(3));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return grpBean;
	}
	
	public ArrayList<Scenez_EventBean> getAllGroupEventsBean(int groupID){
		ArrayList<Scenez_EventBean> grpEventBeans = new ArrayList<Scenez_EventBean>();
		String query = "select * from project.event where id in (select event_id from project.grp_event where grp_id = ?)"
						+ " order by event_date desc;";
		
		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, groupID);
			
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()){
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
				
				grpEventBeans.add(currentEvent);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return grpEventBeans;
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
