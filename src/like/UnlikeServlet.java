package like;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import db.DButil;

@WebServlet("/UnlikeServlet")
public class UnlikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String mem_id = request.getParameter("mem_id");
		int bd_key = Integer.parseInt(request.getParameter("bd_key"));
		
		response.getWriter().write(registerUnlike(bd_key, mem_id) + "");
	}
	public int registerUnlike(int bd_key, String mem_id) {
		String delLkSQL = "delete from blike where bd_key='"+bd_key+"' and mem_id='"+mem_id+"'";
		int di;
		DButil dbd = new DButil();
		try {
			di = dbd.setSQL(delLkSQL);
			dbd.closeConnect();
			return di;
		}catch(Exception e) {
			dbd.closeConnect();
			return 0;
		}
	}

}
