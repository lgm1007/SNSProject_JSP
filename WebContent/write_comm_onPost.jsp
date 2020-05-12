<%@page import="java.sql.ResultSet"%>
<%@page import="db.DButil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%!
	int bdKey;
	String writtenID;
	String comm_text;
	String memID;
	String memName;
	int comm_key;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>
<%
	bdKey = Integer.parseInt(request.getParameter("bdKey"));
	writtenID = request.getParameter("sessionID");
	comm_text = request.getParameter("comm_text");
	memID = request.getParameter("memID");
	memName = request.getParameter("memName");
	
	String selCom_key = "SELECT comment_key FROM comm order by comment_key DESC";
	DButil Dbsc = new DButil();
	ResultSet rs = Dbsc.selectSQL(selCom_key);
	boolean br = rs.next();
	if(br == false) {
		comm_key = 1;
	} else {
		int recentCommKey = rs.getInt("comment_key");
		comm_key = recentCommKey + 1;
	}
	Dbsc.closeConnect();
	
	String inCommSQL = "insert into comm values('"+comm_key+"','"+bdKey+"','"+writtenID+"','"+comm_text+"')";
	DButil Dbic = new DButil();
	int ri = 0;
	ri = Dbic.setSQL(inCommSQL);
%>
	<form action="postedBoard.jsp" method="get" name="gotoBd_frm">
		<input type="hidden" name="bdKey" value="<%=bdKey%>"  />
		<input type="hidden" name="memID" value="<%=memID%>" />
		<input type="hidden" name="memName" value="<%=memName%>" />
	</form>
<%
	if(ri != 0) {
%>
	<script type="text/javascript">
		document.gotoBd_frm.submit();
	</script>
<%
	} else {
%>
	<script type="text/javascript" charset="utf-8">
		alert("댓글 입력에 실패했습니다.(DB에러)");
		history.back();
	</script>
<%} Dbic.closeConnect(); %>
</body>
</html>