package backend;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Scenez_Connection {
	
	//attributes
	Connection dbConnection;
	String url;
	String username;
	String password;
	
	//constructors
	public Scenez_Connection()
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");         //obtain jdbc driver class
		} catch (ClassNotFoundException e1) {

			e1.printStackTrace();
		}
		
		//SET NEW DATABASE CREDENTIALS HERE
		dbConnection = null;
		url = "jdbc:mysql://139.179.211.216:3306/project";
		username = "masna";
		password = "lifeisenjoy1";
		
		try {
			dbConnection = DriverManager.getConnection(url, username, password);    //obtain connection using given url, username and password
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//methods
	public Connection getConnection()
	{
		return this.dbConnection;
	}
	
	public void setConnection(String url, String user, String password)
	{
		try {
			Class.forName("com.mysql.jdbc.Driver");         //obtain jdbc driver class
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		dbConnection = null;
		try {
			dbConnection = DriverManager.getConnection(url, user, password);    //obtain connection using given url, username and password
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}