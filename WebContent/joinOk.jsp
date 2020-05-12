<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="db.DButil" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <% request.setCharacterEncoding("utf-8"); %>
 <%!
 	Connection con;
	ResultSet rs;
	Statement stmt;
 	String ConfId;
 	
 	String driver = "com.mysql.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/jspdb?characterEncoding=UTF-8";
	String uid = "root";
	String upw = "1234";
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
	ConfId = request.getParameter("id");
	String sql = "select id from member where id='"+ConfId+"'";
	rs = Dbs.selectSQL(sql);
	
	
	// rset.next() 가  true하면 이미 같은 아이디가 DB에 존재함
	if(rs.next()) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("이미 존재하는 아이디입니다.");
		document.location.href="join_page.jsp";
	</script>
<% 
	}
	//SELECT 문으로 열었던 Connect 닫기
	Dbs.closeConnect();
	
	DButil DBi = new DButil();
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");
	String insSql = "insert into member values('"+ id +"','"+ pw +"','"+ name +"','"+ tel1 +"','"+ tel2 +"','"+ tel3 +"')";
	int ri = 0;
	ri = DBi.setSQL(insSql);
	if (ri == 1) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("회원가입이 완료되었습니다!");
		document.location.href="login.jsp";
	</script>
<%
	DBi.closeConnect();
	}else {
%>
	<script type="text/javascript" charset="utf-8">
		alert("회원가입에 실패하였습니다. (DB에러)");
		document.location.href="join_page.jsp";
	</script>
<% 
	}
%>
</body>
</html>