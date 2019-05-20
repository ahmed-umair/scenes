package backend;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 * grp
 */
public class Scenez_GRP {

    public String getNameAsSingle(int grp_id){
        String returnString = "";
        Connection s_con = new Scenez_Connection().getConnection();
        ResultSet rs;

        try {
            PreparedStatement statement = s_con.prepareStatement("SELECT * FROM project.grp WHERE project.grp.id = ?");
            statement.setInt(1,grp_id);
            rs = statement.executeQuery();
            rs.next();
            returnString = rs.getString(0);
        } catch (Exception e) {
            System.out.println("ERROR: Problem encountered while trying to establish connection to database!");
        }

        return returnString;
    }

    public ArrayList<String> getIdAsList() {
        ArrayList<String> returnArr = new ArrayList<String>();
        Connection s_con = new Scenez_Connection().getConnection();
        
        try {
            Statement statement = s_con.createStatement();   
            String sql = "SELECT id FROM project.grp";
            statement.execute(sql);

            ResultSet rs = statement.getResultSet();

            while(rs.next()){
                returnArr.add(rs.getString(0));
            }
        } catch (Exception e) {
            System.out.println("ERROR: Problem encountered while trying to establish connection to database!");
        }
        return returnArr;
    }

    public ArrayList<String> getNameAsList() {
        ArrayList<String> returnArr = new ArrayList<String>();
        Connection s_con = new Scenez_Connection().getConnection();
        
        try {
            Statement statement = s_con.createStatement();   
            String sql = "SELECT name FROM project.grp";
            statement.execute(sql);

            ResultSet rs = statement.getResultSet();

            while(rs.next()){
                returnArr.add(rs.getString(0));
            }
        } catch (Exception e) {
            System.out.println("ERROR: Problem encountered while trying to establish connection to database!");
        }
        return returnArr;
    }
    
    public boolean addNewGroup(String grp_name, String grp_desc, String email) {
    	boolean result = false;
    	Connection s_con = new Scenez_Connection().getConnection();
    	
    	try {
			s_con.setAutoCommit(false);
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
    	
      	try {
    		int grp_id = 1;
    		Statement statement_getMax = s_con.createStatement();
    		String getMaxGrpID_sql = "SELECT max(id) FROM project.grp";
    		statement_getMax.executeQuery(getMaxGrpID_sql);
    		
    		ResultSet rs = statement_getMax.getResultSet();
    		
    		if (rs.first()){
    			grp_id = rs.getInt(1);
    		}
    		

    		String addGrp_sql = "INSERT into project.grp values (?,?,?)";
    		PreparedStatement statement_addGrp = s_con.prepareStatement(addGrp_sql);
    		grp_id++;
    		statement_addGrp.setInt(1, grp_id);
    		statement_addGrp.setString(2, grp_name);
    		statement_addGrp.setString(3, grp_desc);
    		int count = statement_addGrp.executeUpdate();
    		
    		String addGrpOwner_sql = "INSERT into grp_invite values (?,?,?,?)";
    		PreparedStatement statement_addGrpOwner = s_con.prepareStatement(addGrpOwner_sql);
    		statement_addGrpOwner.setString(1, email);
    		statement_addGrpOwner.setString(2, email);
    		statement_addGrpOwner.setInt(3, grp_id);
    		statement_addGrpOwner.setString(4, "Accepted");
    		count = statement_addGrpOwner.executeUpdate();
    		System.out.println("LOL CHECKPOINT 1");
    		System.out.println(count);
    		
    		s_con.commit();
    		result = true;
    		System.out.println("Successfully added group?");
    	}
    	catch(Exception e) {
    		System.out.println("Connection nahi ban raha yaaar");
    		try {
				s_con.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				System.out.println("There's a fucking error with the rollback");
				e1.printStackTrace();
			}
    	}
    	finally {
    		try {
				s_con.setAutoCommit(true);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("There's a fucking error with setAutoCommit");
				e.printStackTrace();
			}
    	}
    	return result;
    }
    
    public boolean checkUniqueGrpName(String name, String email) {
		Connection s_con = new Scenez_Connection().getConnection();
    	String query = "SELECT count(id) FROM project.grp, project.grp_invite WHERE name = ? AND inviter = ? AND inviter=invitee";
		boolean isUnique = false;
		
		try {
			PreparedStatement stmt = s_con.prepareStatement(query);
			stmt.setString(1, name);
			stmt.setString(2, email);
			
			ResultSet set = stmt.executeQuery();
			
			if (set.next()) {
			    int count = set.getInt(1);
			    
			    if(count < 1) {
			    	isUnique = true;
			    }
			} 
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isUnique;
	}
}

