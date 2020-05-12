package daodto;
import java.sql.*;
import java.util.ArrayList;

public class dbDAO {
	private String driver = "com.mysql.jdbc.Driver";
 	private String url = "jdbc:mysql://localhost:3306/jspdb?characterEncoding=UTF-8";
	private String uid = "root";
	private String upw = "1234";
	
	public dbDAO() {
		try {
			Class.forName(driver);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Member> SelectMember(String sql) {
		ArrayList<Member> dtos = new ArrayList<Member>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(url, uid, upw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String name = rs.getString("name");
				String tel1 = rs.getString("tel1");
				String tel2 = rs.getString("tel2");
				String tel3 = rs.getString("tel3");
				
				Member dto = new Member(id, pw, name, tel1, tel2, tel3);
				dtos.add(dto);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return dtos;
	}
	
	public ArrayList<Board> SelectBoard(String sql) {
		ArrayList<Board> dtos = new ArrayList<Board>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(url, uid, upw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int bd_key = rs.getInt("bd_key");
				String mem_id = rs.getString("mem_id");
				String bd_cont = rs.getString("bd_cont");
				
				Board dto = new Board(bd_key, mem_id, bd_cont);
				dtos.add(dto);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return dtos;
	}
	
	public ArrayList<Follow> SelectFollow(String sql) {
		ArrayList<Follow> dtos = new ArrayList<Follow>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(url, uid, upw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int fl_key = rs.getInt("fl_key");
				String follow = rs.getString("follow");
				String follower = rs.getString("follower");
				
				Follow dto = new Follow(fl_key, follow, follower);
				dtos.add(dto);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return dtos;
	}
	
	public ArrayList<Comm> SelectComm(String sql) {
		ArrayList<Comm> dtos = new ArrayList<Comm>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(url, uid, upw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int comment_key = rs.getInt("comment_key");
				int bd_key = rs.getInt("bd_key");
				String mem_id = rs.getString("mem_id");
				String comment_cont = rs.getString("comment_cont");
				
				Comm dto = new Comm(comment_key, bd_key, mem_id, comment_cont);
				dtos.add(dto);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return dtos;
	}
	
	public ArrayList<Images> SelectImages(String sql) {
		ArrayList<Images> dtos = new ArrayList<Images>();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		try {
			conn = DriverManager.getConnection(url, uid, upw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				int bd_key = rs.getInt("bd_key");
				String fileName = rs.getString("fileName");
				String fileRealName = rs.getString("fileRealName");
				
				Images dto = new Images(bd_key, fileName, fileRealName);
				dtos.add(dto);
			}
		} catch(Exception e) {
				e.printStackTrace();
			} finally {
				try {
					if(rs != null) rs.close();
					if(stmt != null) stmt.close();
					if(conn != null) conn.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		return dtos;
	}	
	
}

