package following;

import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.DButil;


@WebServlet("/UnfollowServlet")
public class UnfollowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String follow = request.getParameter("follow");
		String follower = request.getParameter("follower");
		
		response.getWriter().write(deleteFollow(follow, follower) + "");
	}
	public int deleteFollow(String follow, String follower) {
		DButil dbd = new DButil();
		String sql = "delete from bfollow where follow='"+ follow +"' and follower='"+ follower +"'";
		int ri;
		try {
			ri = dbd.setSQL(sql);
			dbd.closeConnect();
			return ri;
		}catch(Exception e) {
			dbd.closeConnect();
			return 0;
		}
	}

}
