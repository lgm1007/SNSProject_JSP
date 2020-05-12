<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="db.DButil" %>
<%! 
	String cid;
	String cpw;
	String cname;
	String sql;
	ResultSet rs;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>
<%
	DButil Dbs = new DButil();
	cid = request.getParameter("id");
	cpw = request.getParameter("pw");
	sql = "SELECT * FROM member WHERE id = '"+ cid +"'";
	
	rs = Dbs.selectSQL(sql);
	boolean b = rs.next();
	if(b == false) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("해당 아이디는 가입하지 않은 아이디입니다.");
		document.location.href="login.jsp";
	</script>
<%		
	}

	try { if (!(cpw.equals(rs.getString("pw")))) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("아이디 또는 비밀번호가 다릅니다.");
		document.location.href="login.jsp";
	</script>
<% 		
	} else {
		cname = rs.getString("name");
		session.setAttribute("id", cid);
		session.setAttribute("name", cname);
		
		response.sendRedirect("main_page.jsp");
		Dbs.closeConnect();
		}
	} catch(Exception e){
			e.printStackTrace();
		} 
	
%>
</body>
</html>