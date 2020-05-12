<%@page import="daodto.Member"%>
<%@page import="daodto.dbDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="db.DButil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<%
	request.setCharacterEncoding("utf-8");
%>
<%!Connection con;
	ResultSet rs;
	Statement stmt;
	String Searching;%>
<html>
<head>
<meta charset="utf-8">
<title>Searching</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<style>
body {
	padding: 0;
	margin: 0;
	font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
	background-color: #fafafa;
}

li {
	list-style: none;
}

a {
	text-decoration: none;
}

a:link {
	text-decoration: none;
	color: initial;
}

a:visited {
	text-decoration: none;
	color: initial;
}

a:hover {
	text-decoration: none;
	color: initial;
}
/* 헤더 */
#header {
	width: 100%;
	border: 0.5px solid #e8e8e8;
	position: fixed;
	text-align: center;
	background-color: white;
	z-index: 9;
}

.headbar_div {
	width: 80%;
	overflow: hidden;
	height: 80px;
	margin: 0 auto;
}

.headbar li {
	float: left;
}

.headbar .head_logo {
	margin: 20px auto 20px auto;
}

.headbar_div .head_input {
	margin-top: 20px;
}

#keyword {
	top: 40%;
	left: 43%;
	padding: 0.5% 5%;
	border-radius: 4px;
}

.headbar .head_icon {
	float: right;
	margin: 20px auto 20px auto;
}

.head_icon, .head_logo {
	margin-bottom: 10px;
}

.icon_like, .icon_me, .icon_pic {
	margin-left: 15px;
}
/* 유저 검색창 */
#div_wrap {
	width: 100%;
	background-color: #fafafa;
}

#div_wrap .sch_div {
	width: 50%;
	height: 1500px;
	margin: 0 auto 0 auto;
	overflow-y: auto;
	display: block;
	background-color: white;
	padding-top: 7%;
	border-left: 0.5px solid #e8e8e8;
	border-right: 0.5px solid #e8e8e8;
}

.sch_usercont {
	margin-bottom: 8px;
	border-bottom: 0.5px solid #e8e8e8;
	position: relative;
}

.text_wrap {
	float: left;
	margin-left: 2%;
}

.mem_table {
	margin-bottom: 10px;
}

.srh_user_frm {
	width: 350px;
}

.sch_user_id {
	font-weight: bold;
	font-size: 1.1em;
	color: #000;
	border-style: none;
	background: none;
	margin-left: 80px;
}

.sch_user_name {
	font-size: 1.1em;
	color: #999999;
	margin-left: 86px;
}

.btn_wrap {
	margin-left: 100px;
}

.fl_btn {
	border-style: none;
	cursor: pointer;
	-webkit-transition: all 200ms;
	-moz-transition: all 200ms;
	-ms-transition: all 200ms;
	-o-transition: all 200ms;
	transition: all 200ms;
	display: inline-block;
	margin: 20px auto;
	text-decoration: none;
	border-radius: 4px;
	padding: 5px 0;
	width: 100px;
	color: white;
	font-weight: bold;
	background-color: #3897f0;
}

.fl_btn:hover {
	box-shadow: 0px 0px 0px 40px #163c60 inset;
}
</style>

</head>
<body>
	<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script src="Search.js" type="text/javascript"></script>

	<%
		Searching = request.getParameter("srch");
		String srhSQL = "SELECT * FROM member where id like ('%" + Searching + "%') or name like ('%" + Searching + "%')";
		dbDAO dao = new dbDAO();
		ArrayList<Member> listMem = dao.SelectMember(srhSQL);
	%>
	<div id="header">
		<div class="headbar_div">
			<ul class="headbar">
				<li class="head_logo"><a href="main_page.jsp"><img src="img/sol_logo_40px.png" alt="logo" /></a></li>
				<li class="head_icon"><a href="Like_page.jsp" class="icon_like"><img src="img/like.png" alt="like" /></a> 
				<a href="user_page.jsp" class="icon_me"><img src="img/me.PNG" alt="me" /></a> 
				<a href="post_writePage.jsp" class="icon_pic"><img src="img/pic.PNG" alt="pic" /></a></li>
			</ul>
			<div class="head_input">
				<form action="Search_Page.jsp" name="hd_frm" method="get">
					<input type="search" id="keyword" name="srch" placeholder="검색"
						onkeypress="if (event.keyCode == 13) { goSearch();}"
						style="text-align: center; font-size: 13px; color: #cacaca; border: 0.7px solid #cacaca;" />
				</form>
			</div>
		</div>
	</div>
	<!-- 아이디 (userid) ()에 검색해서 나온 유저 아이디를 넣음, 반복으로 sch_usercont클래스 생성,-->

	<div id="div_wrap">
		<div class="sch_div">
			<div class="sch_usercont" id="userid">
				<%
					String sID = (String) session.getAttribute("id");
					String sName = (String) session.getAttribute("name");
					int mi = 0;
					for (mi = 0; mi < listMem.size(); mi++) {
						Member obj_mem = listMem.get(mi);
						String srhedID = obj_mem.getId();
						String srhedName = obj_mem.getName();
						if (!(sID.equals(srhedID) && !(sName.equals(srhedName)))) {
							//ArrayList에 검색해서 나온 아이디값들을 차례대로 add
							String srhedMemID = srhedID;
							String srhedMemName = srhedName;
				%>

				<table class="mem_table">
					<tr>
						<td>
							<form action="AreUSession.jsp" method="post"
								class="srh_user_frm">
								<input type="hidden" value="<%=srhedMemID%>" name="otherUserID" />
								<input type="hidden" value="<%=srhedMemName%>" name="otherUserName" /> 
								<input type="submit" class="sch_user_id" value="<%=srhedMemID%>" />
							</form>
							<p class="sch_user_name"><%=srhedMemName%></p>
						</td>
						<td>
							<div class="btn_wrap">
								<form action="AreUSession.jsp" method="post">
									<input type="hidden" value="<%=srhedMemID%>" name="otherUserID" />
									<input type="hidden" value="<%=srhedMemName%>" name="otherUserName" /> 
									<input type="submit" class="fl_btn" value="방문"></input>
								</form>

							</div>
						</td>
					</tr>
				</table>

				<%
					} else {
							continue;
						}
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>