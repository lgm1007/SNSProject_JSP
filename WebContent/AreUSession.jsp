<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <% request.setCharacterEncoding("utf-8"); %>
 <%!
 	String sID;
 	String sName;
 	String chkID;
 	String chkName;
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
	sName = (String)session.getAttribute("name");
	chkID = request.getParameter("otherUserID");
	chkName = request.getParameter("otherUserName");
%>
	<form action="OtherUser_Page.jsp" name="other_frm" method="post">
    	<input type="hidden" name="otherUserID" value="<%=chkID%>" />
    	<input type="hidden" name="otherUserName" value="<%=chkName%>" />
    </form>
<%	
	if(sID.equals(chkID)) {
%>
	<script type="text/javascript">
		document.location.href="user_page.jsp";
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		document.other_frm.submit();
	</script>
<%} %>
</body>
</html>