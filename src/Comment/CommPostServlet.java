package Comment;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import db.DButil;

@WebServlet("/CommPostServlet")
public class CommPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String mem_id = request.getParameter("mem_id");
		int bd_key = Integer.parseInt(request.getParameter("bd_key"));
		String comment_cont = request.getParameter("comment_cont");
		int comment_key = 1;
		
		DButil Dbs = new DButil();
		ResultSet rs;
		String selSQL = "SELECT * FROM comm";
		rs = Dbs.selectSQL(selSQL);
		try {
			while(rs.next()) {
				if (comment_key == rs.getInt("comment_key"))
					comment_key++;
				else
					break;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		response.getWriter().write(registerComm(mem_id, bd_key, comment_cont, comment_key) + "");
		Dbs.closeConnect();
	}
	public int registerComm(String memID, int bdKey, String commCont, int commKey) {
		DButil Dbi = new DButil();
		String sql = "INSERT INTO comm values('"+commKey+"','"+bdKey+"', '"+memID+"','"+commCont+"')";
		int ri;
		try {
			ri = Dbi.setSQL(sql);
			Dbi.closeConnect();
			return ri;
		} catch(Exception e) {
			Dbi.closeConnect();
			return 0;
		}
	}

}
