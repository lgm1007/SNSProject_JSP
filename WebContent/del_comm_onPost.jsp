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
	int bdKey;
	String writtenID;
	String memID;
	String memName;
	int comm_key;
%>
<body>
<%
	bdKey = Integer.parseInt(request.getParameter("bdKey"));
	writtenID = request.getParameter("sessionID");
	comm_key = Integer.parseInt(request.getParameter("comm_key"));
	memID = request.getParameter("memID");
	memName = request.getParameter("memName");
	
	String comDelSQL = "DELETE FROM comm WHERE comment_key = '"+comm_key+"' and mem_id = '"+writtenID+"' and bd_key = '"+bdKey+"'";
	DButil Ddb = new DButil();
	int di = Ddb.setSQL(comDelSQL);
%>
	<form action="postedBoard.jsp" method="get" name="gotoBd_frm">
		<input type="hidden" name="bdKey" value="<%=bdKey%>"  />
		<input type="hidden" name="memID" value="<%=memID%>" />
		<input type="hidden" name="memName" value="<%=memName%>" />
	</form>
<%	
	if(di==0) {
%>
	<script type="text/javascript" charset="utf-8">
	alert("댓글 입력에 실패했습니다.(DB에러)");
	history.back();
	</script>
<%
	} else {
%>
	<script type="text/javascript">
	document.gotoBd_frm.submit();
	</script>
<%		
	}
%>
</body>
</html>