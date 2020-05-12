package following;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.DButil;

@WebServlet("/FollowRegisterServlet")
public class FollowRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String follow = request.getParameter("follow");
		String follower = request.getParameter("follower");
		ResultSet rs;
		DButil dbs = new DButil();
		rs = dbs.selectSQL("select fl_key from bfollow ORDER BY fl_key ASC");
		
		int fl_key = 1 ;
		//중복되지 않는 fl_key값 넣기
		try {
			while(rs.next()) {
				if(fl_key == rs.getInt("fl_key")){
					fl_key++;
				} else { break;	}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//결과값 반환하는 메소드
		response.getWriter().write(registerFollow(follow, follower, fl_key) + "");
		dbs.closeConnect();
	}
	public int registerFollow(String follow, String follower, int fl_key) {
		DButil dbfi = new DButil();
		String sql = "insert into bfollow values('"+ fl_key +"','"+ follow +"','"+ follower +"')";
		int ri;
		try {
			ri = dbfi.setSQL(sql);
			dbfi.closeConnect();
			return ri;
		}catch(Exception e) {
			dbfi.closeConnect();
			return 0;
		}
	}

}
