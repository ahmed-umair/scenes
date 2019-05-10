package backend;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
}