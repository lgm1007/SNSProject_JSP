<%@page import="db.DButil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<%!
	int bdKey;
%>
<body>
<%
	bdKey = Integer.parseInt(request.getParameter("postDelKey"));

	DButil dbd = new DButil();
	String delSQL = "DELETE FROM board where bd_key='"+bdKey+"'";
	int di = dbd.setSQL(delSQL);
	
	if(di == 0) {
%>
<script type="text/javascript" charset="utf-8">
	alert("포스트 삭제에 실패했습니다. (DB에러)");
	document.location.href="postEdit.jsp";
</script>
<%} else { %>
<script type="text/javascript" charset="utf-8">
	alert("포스트를 삭제했습니다");
	document.location.href="main_page.jsp";
</script>
<% } %>
</body>
</html>