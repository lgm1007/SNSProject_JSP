<%@page import="db.DButil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<%!
	String sID;
	String sName;
	String cont;
	int bdKey;
%>
<body>
    <%
   		sID = (String)session.getAttribute("id");
		sName = (String)session.getAttribute("name");
		cont = request.getParameter("content");
		bdKey = Integer.parseInt(request.getParameter("postEditKey"));
		
		DButil dbupd = new DButil();
		String upSQL = "UPDATE board SET bd_cont = '"+ cont +"' WHERE bd_key = '"+bdKey+"'";
		int ui = dbupd.setSQL(upSQL);
		
		if(ui == 0) {
    %>
    <script type="text/javascript" charset="utf-8">
		alert("포스트 수정에 실패했습니다. (DB에러)");
		document.location.href="postEdit.jsp";
	</script>
    <%
    	} else {
	%>
	<script type="text/javascript" charset="utf-8">
		document.location.href="user_page.jsp";
	</script>
	<%  } %>
</body>
</html>