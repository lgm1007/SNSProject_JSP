package like;
import java.sql.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import db.DButil;

@WebServlet("/LikeServlet")
public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String mem_id = request.getParameter("mem_id");
		int bd_key = Integer.parseInt(request.getParameter("bd_key"));
		
		//결과값 반환 메소드
		response.getWriter().write(registerLike(bd_key, mem_id) + "");
	}
	
	public int registerLike(int bd_key, String mem_id) {
		String insertLikeSQL = "insert into blike values('"+ bd_key +"','"+ mem_id +"', '1')";
		int li = 0;
		DButil dbi = new DButil();
		try {
			li = dbi.setSQL(insertLikeSQL);
			dbi.closeConnect();
			return li;
		}catch(Exception e) {
			dbi.closeConnect();
			return 0;
		}
	}
}
