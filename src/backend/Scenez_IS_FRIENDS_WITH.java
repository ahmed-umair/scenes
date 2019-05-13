package backend;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Scenez_IS_FRIENDS_WITH {
	
	private Scenez_Connection s_con;
	
	public Scenez_IS_FRIENDS_WITH()
	{
		s_con = new Scenez_Connection();
	}
	
	public ArrayList<Friend_Pair> getAllFriendsAsList(String email)
	{
		String query = "SELECT user1, user2 " + 
				"FROM project.is_friends_with " + 
				"WHERE user1 = ? OR user2 = ? and status='Accepted'";
		ArrayList<Friend_Pair> friend_pairs = new ArrayList<>();
		try {
			PreparedStatement st = s_con.getConnection().prepareStatement(query);
			st.setString(1, email);
			st.setString(2, email);
			ResultSet rs = st.executeQuery();
			while (rs.next())
			{
				Friend_Pair p = new Friend_Pair();
				p.setRequester(rs.getString(1));
				p.setRequested(rs.getString(2));
				friend_pairs.add(p);
			}
			return friend_pairs;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getFriendsCountByEmail(String email)
	{
		return 0;
	}

}
