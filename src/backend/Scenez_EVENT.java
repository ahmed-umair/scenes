package backend;

import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

public class Scenez_EVENT {

	// Properties
	Scenez_Connection s_con;
	Statement smt = null;

	// Constructor
	public Scenez_EVENT() {
		// Set up connection here
		s_con = new Scenez_Connection();
	}

	public Scenez_EVENT(Connection con) {
		s_con = new Scenez_Connection(con);
	}

	// Methods
	// Get Methods for attributes, return as ArrayList

	// Get Ids
	public ArrayList<String> getIdAsList() {

		ArrayList<String> ids = new ArrayList<String>();
		try {
			smt = s_con.getConnection().createStatement();
			ResultSet res_ids = smt.executeQuery("SELECT id FROM project.event;");

			while (res_ids.next()) {
				String result = res_ids.getString("id");
				ids.add(result);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return ids;
	}

public ArrayList<Scenez_EventBean>getEventNamesAsList(String email){
		
		ArrayList<Scenez_EventBean> names = new ArrayList<Scenez_EventBean>();
		try {
			smt = s_con.getConnection().createStatement();
			
			String query = "Select * from project.event where (email = ? or id " + 
			"in (select distinct event_id  from project.event_invite where inviter = ? or (invitee = ? and status = \"Accepted\"))) " + 
			"and event_date > curdate() order by event_date asc;";
			
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			
			stmt.setString(1, email);
			stmt.setString(2, email);
			stmt.setString(3, email);
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
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
				
				names.add(currentEvent);
			}
			return names;
		} catch (SQLException e) {
	
			e.printStackTrace();
		}
		
		return null;
	}

	// Get Event Name as Single
	public String getEventNameAsSingle(int primaryKey) {

		String result = "";
		try {
			PreparedStatement smt = s_con.getConnection()
					.prepareStatement("SELECT name FROM project.event WHERE id=?;");
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
			while (res.next()) {
				eventBean.setId(res.getInt(1));
				eventBean.setName(res.getString(2));
				eventBean.setStart_time(res.getString(3));
				eventBean.setDuration(res.getDouble(4));
				eventBean.setPrivacy(res.getString(5));
				eventBean.setCapacity(res.getInt(6));
				eventBean.setDescription(res.getString(7));
				eventBean.setEmail(res.getString(8));
				eventBean.setCat_name(res.getString(9));
				eventBean.setLocation(res.getString("location"));
				eventBean.setEvent_date(res.getString("event_date"));
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return eventBean;
	}

	public ArrayList<String> getEventTagsAsList(int eventId) {
		ArrayList<String> eventTags = new ArrayList<String>();

		String query = "select tag from project.event_tag where event_id = ?;";

		try {
			PreparedStatement stmt = s_con.getConnection().prepareStatement(query);
			stmt.setInt(1, eventId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
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

	public ArrayList<Scenez_EventBean> getAllEventBeansAsList() {
		String query = "Select * FROM project.event";
		ArrayList<Scenez_EventBean> events = new ArrayList<Scenez_EventBean>();

		try {
			Statement st = s_con.getConnection().createStatement();
			ResultSet rs = st.executeQuery(query);
			while (rs.next()) {
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

	public int getEventHostedCount(String email) {
		String query = "SELECT count(*) " + "FROM project.event " + "WHERE email = ?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int getEventAttendedCount(String email) {
		String query = "SELECT count(distinct event_id) " + "FROM project.event_invite "
				+ "WHERE event_id in (select id from project.event where event_date < curdate()) "
				+ "AND ((inviter = ?) OR (invitee = ? AND status = 'Accepted'))";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			st.setString(2, email);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Inviter_Invitee_Info> getAttendedEventsAsList(String email) {
		String query = "SELECT inviter, invitee, event_id " + "FROM project.event_invite "
				+ "WHERE event_id in (select id from project.event where event_date < curdate()) "
				+ "AND event_id not in (select id from project.event where email = ?) "
				+ "AND (invitee = ? AND status = 'Accepted')";
		ArrayList<Inviter_Invitee_Info> attended_events = new ArrayList<>();

		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			st.setString(2, email);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				Inviter_Invitee_Info curr_event_info = new Inviter_Invitee_Info();
				curr_event_info.setInviter(rs.getString(1));
				curr_event_info.setInvitee(rs.getString(2));
				curr_event_info.setEvent_id(rs.getInt(3));
				attended_events.add(curr_event_info);
			}
			return attended_events;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return null;
	}

	public String getHostEmailByID(int id) {
		String query = "SELECT email " + "FROM project.event " + "WHERE id=?";
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setInt(1, id);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public ArrayList<String> separateByComma(String input){
		ArrayList<String> separated = new ArrayList<> (Arrays.asList(input.split(",")));
		return separated;
	}

	public boolean addNewEvent(String name, String location, Date date, String time, String tags, String desc,
			int capacity, double duration, String email, String category, String privacy) {
		boolean result = false;
		Connection s_con = new Scenez_Connection().getConnection();

		try {
			s_con.setAutoCommit(false);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}

		try {
			int event_id = 1;
			Statement statement_getMax = s_con.createStatement();
			String getMaxEventID_sql = "SELECT max(id) FROM project.event";
			statement_getMax.executeQuery(getMaxEventID_sql);

			ResultSet rs = statement_getMax.getResultSet();

			if (rs.first()) {
				event_id = rs.getInt(1);
			}

			String addGrp_sql = "INSERT into project.event values (?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement statement_addGrp = s_con.prepareStatement(addGrp_sql);
			event_id++;
			statement_addGrp.setInt(1, event_id);
			statement_addGrp.setString(2, name);
			statement_addGrp.setString(3, time);
			statement_addGrp.setDouble(4, duration);
			statement_addGrp.setString(5, privacy);
			statement_addGrp.setInt(6, capacity);
			statement_addGrp.setString(7, desc);
			statement_addGrp.setString(8, email);
			statement_addGrp.setString(9, category);
			statement_addGrp.setInt(10, 11);
			statement_addGrp.setString(11, location);
			statement_addGrp.setDate(12, date);
			int res = statement_addGrp.executeUpdate();
			s_con.commit();
			
			ArrayList<String> tagsList = separateByComma(tags);
			
			
			for(int count1 = 0; count1 < tagsList.size(); count1++) {
				String checkTag_sql = "SELECT * FROM project.tag where tagText=?";
				PreparedStatement statement_checkTag = s_con.prepareStatement(checkTag_sql);
				statement_checkTag.setString(1, tagsList.get(count1));
				ResultSet rset = statement_checkTag.executeQuery();
				
				if(!rset.first()) {
					String addTag_sql = "INSERT into tag values(?)";
					PreparedStatement statement_addTag = s_con.prepareStatement(addTag_sql);
					statement_addTag.setString(1, tagsList.get(count1));
					int added = statement_addTag.executeUpdate();
					System.out.println(added);
				}
				
				String addTagEvent_sql = "INSERT into event_tag values (?,?)";
				PreparedStatement statement_addTagEvent = s_con.prepareStatement(addTagEvent_sql);
				statement_addTagEvent.setInt(1, event_id);
				statement_addTagEvent.setString(2, tagsList.get(count1));
				res = statement_addTagEvent.executeUpdate();
				System.out.println(count1);
			}
			
			System.out.println("LOL CHECKPOINT 1");

			s_con.commit();
			result = true;
			System.out.println("Successfully added group?");
		} catch (Exception e) {
			System.out.println("Connection nahi ban raha yaaar");
			try {
				s_con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				System.out.println("There's a duckingerror with the rollback");
				e1.printStackTrace();
			}
		} finally {
			try {
				s_con.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("There's a duckingerror with setAutoCommit");
				e.printStackTrace();
			}
		}
		return result;

	}
}
