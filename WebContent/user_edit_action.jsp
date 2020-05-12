<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DButil" %>
<% request.setCharacterEncoding("utf-8"); %>
<%!
	String sID;
	String eName;
	String epw_chk;
	String epw;
	String etel1;
	String etel2;
	String etel3;
	
	String oName;
	String opw;
	String otel2;
	String otel3;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>
<%
	sID = (String)session.getAttribute("id");
	eName = request.getParameter("update_name");
	epw = request.getParameter("update_pw");
	epw_chk = request.getParameter("update_pw_chk");
	etel1 = request.getParameter("tel1");
	etel2 = request.getParameter("tel2");
	etel3 = request.getParameter("tel3");
	if(!epw.equals(epw_chk)) {
%>
	<script type="text/javascript" charset="utf-8">
	 	alert("비밀번호가 다릅니다.");
	 	document.location.href="userEdit_page.jsp";
	</script>
<%
	} else {
	
	DButil dbu = new DButil();
	String selSQL = "SELECT * FROM member WHERE id = '"+sID+"'";
	ResultSet rs = dbu.selectSQL(selSQL);
	boolean bs = rs.next();
	
	oName = rs.getString("name");
	opw = rs.getString("pw");
	otel2 = rs.getString("tel2");
	otel3 = rs.getString("tel3");
	
	if(eName.equals(null) || eName.equals("")){ eName = oName; }
	if(epw.equals(null) || epw.equals("")){ epw = opw; }
	if(etel2.equals(null) || etel2.equals("")){ etel2 = otel2; }
	if(etel3.equals(null) || etel3.equals("")){ etel3 = otel3; }
	
	String updSQL = "UPDATE member SET pw = '"+epw+"', name = '"+eName+"', tel1 = '"+etel1+"', tel2 = '"+etel2+"', tel3 = '"+etel3+"' WHERE id = '"+sID+"'";
	int ri = dbu.setSQL(updSQL);
	if(ri == 0) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("프로필 변경에 실패했습니다. (DB에러)");
		document.location.href="userEdit_page.jsp";
	</script>
<%
	} 	else {
			session.removeAttribute("name");
			session.setAttribute("name", eName);
			response.sendRedirect("user_page.jsp");
		}
		dbu.closeConnect();
	}
	
%>
</body>
</html>