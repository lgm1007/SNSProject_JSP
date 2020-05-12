package db;
import java.sql.*;
public class DButil {
	private Connection connection;
	private Statement stmt;
	ResultSet rs;
	
	private String driver = "com.mysql.jdbc.Driver";
 	private String url = "jdbc:mysql://localhost:3306/jspdb?characterEncoding=UTF-8";
	private String uid = "root";
	private String upw = "1234";
	int ri = 0;
	
	public int setSQL(String sql) {
		try {
			Class.forName(driver);
			this.connection = DriverManager.getConnection(url, uid, upw);
			this.stmt = this.connection.createStatement();
			ri = this.stmt.executeUpdate(sql);
			return ri;
		} catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public ResultSet selectSQL(String sql) {
		try {
			Class.forName(driver);
			this.connection = DriverManager.getConnection(url, uid, upw);
			this.stmt = this.connection.createStatement();
			ResultSet resultset = this.stmt.executeQuery(sql);
			return resultset;
		}catch(Exception e) {
			e.printStackTrace();
			return rs;
		}
	}
	
	public void closeConnect() {
		try{
			if(stmt != null) stmt.close();
			if(connection != null) connection.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}

