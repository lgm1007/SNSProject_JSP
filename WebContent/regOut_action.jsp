<%@page import="db.DButil"%>
<%@page import="daodto.Member"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daodto.dbDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%
	String sID;
	String re_pw;
	String re_pwchk;
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
	re_pw = request.getParameter("re_pw");
	re_pwchk = request.getParameter("re_pwchk");
	
	DButil ddu = new DButil();
	String selpwSQL = "SELECT * FROM member WHERE id = '"+sID+"'";
	dbDAO dao = new dbDAO();
	ArrayList<Member> memList = dao.SelectMember(selpwSQL);
	Member thisMember = memList.get(0);
	if(!(re_pw.equals(re_pwchk))) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("비밀번호가 일치하지 않습니다");
		document.location.href="regOut_page.jsp";
	</script>
<%
	} else {
		if(!(re_pw.equals(thisMember.getPw()))) {
%>
		<script type="text/javascript" charset="utf-8">
			alert("비밀번호가 틀렸습니다");
			document.location.href="regOut_page.jsp";
		</script>
<%			
		} else {
			String delSQL = "delete from member where id='"+sID+"'";
			int di = ddu.setSQL(delSQL);
			if(di != 0) {
				session.invalidate();
%>
			<script type="text/javascript" charset="utf-8">
				alert("회원탈퇴가 완료되었습니다");
				document.location.href="login.jsp";
			</script>
<%
			} else {
%>
			<script type="text/javascript" charset="utf-8">
				alert("회원탈퇴를 실패했습니다. (DB에러)");
				document.location.href="regOut_page.jsp";
			</script>
<%
			}
			ddu.closeConnect();
		}
	}
	
%>
</body>
</html>