<%@page import="daodto.Images"%>
<%@page import="daodto.Board"%>
<%@page import="daodto.dbDAO"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DButil" %>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%	request.setCharacterEncoding("utf-8"); %>
<%
	ResultSet rs_followNum;
	ResultSet rs_followerNum;
	ResultSet isFollowRS;
	String sID;
	String thisUserID;
	String thisUserName;
	String isFollowSQL;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="Otheruser_PageStyle.css" />
<title>SOL UserPage</title>
<style type="text/css">
	#userPost .mypost {
            border-style:none;
            background:none;
            width:250px;
            height:250px;
            margin:10px;
            float:left;
            cursor:pointer;
        }
</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="js/bootstrap.js"></script>
    <script src="Search.js" type="text/javascript"></script>
    
<%
	if (session.getAttribute("id") == null) {
%>
	<script type="text/javascript" charset="utf-8">
		alert("유효한 세선이 없습니다.");
		document.location.href="login.jsp";
	</script>
<%
	}
	sID = (String)session.getAttribute("id");
	thisUserID = request.getParameter("otherUserID");
	thisUserName = request.getParameter("otherUserName");
%>

		<div id="header">
        <div class="headbar_div">
            <ul class="headbar">
                <li class="head_logo"><a href="main_page.jsp"><img src="img/sol_logo_40px.png" alt="logo" /></a></li>
                <li class="head_icon">
                    <a href="#" class="icon_like"><img src="img/like.png" alt="like" /></a>
                    <a href="user_page.jsp" class="icon_me"><img src="img/me.PNG" alt="me" /></a>
                    <a href="post_writePage.jsp" class="icon_pic"><img src="img/pic.PNG" alt="pic" /></a>
                </li>
            </ul>
            <div class="head_input">
                <form action="Search_Page.jsp" name="hd_frm" method="get">
                    <input type="search" id="keyword" name="srch" placeholder="검색" onkeypress="if (event.keyCode == 13) { goSearch();}"  style="text-align :center; font-size:13px; color:#cacaca; border:0.7px solid #cacaca;" />
                </form>
            </div>
        </div>
    </div>

	<!-- ajax 비동기식 데이터처리, 버튼누르면 팔로우, 언팔로우하기 -->
	<script type="text/javascript" charset="utf-8">
		var Followrequest = new XMLHttpRequest();
		var Unfollowrequest = new XMLHttpRequest();
		function insertFollow() {
			Followrequest.open("Post","./FollowRegisterServlet?follow="+ encodeURIComponent(document.getElementById("followID").value) +
								 "&follower="+ encodeURIComponent(document.getElementById("followerID").value), true);
			//위 코드가 성공적으로 수행하면 동작
			Followrequest.onreadystatechange = FollowProcess;
			Followrequest.send(null);
		}
		function FollowProcess() {
			if(Followrequest.readyState == 4 && Followrequest.status == 200) {
				var getWrite = Followrequest.responseText;
				if(getWrite == 0) {
					alert("팔로우를 실패하였습니다! (DB에러)");
				} 
				else {
					document.getElementById("fl_btn").style.display = "none";
	  				document.getElementById("ufl_btn").style.display = "block";
				}
			}
		}
		
		function doUnFollow() {
			Unfollowrequest.open("Post","./UnfollowServlet?follow="+ encodeURIComponent(document.getElementById("unfollowID").value) +
					 "&follower="+ encodeURIComponent(document.getElementById("unfollowerID").value), true);
			Unfollowrequest.onreadystatechange = UnfollowProcess;
			Unfollowrequest.send(null);
		}
		function UnfollowProcess() {
			if(Unfollowrequest.readyState == 4 && Unfollowrequest.status == 200) {
				var getWrite = Unfollowrequest.responseText;
				if(getWrite == 0) {
					alert("팔로우를 실패하였습니다! (DB에러)");
				}
				else {
					document.getElementById("ufl_btn").style.display = "none";
	 				document.getElementById("fl_btn").style.display = "block";
				}
			}
		}
	</script>
	    <div id="profile">
        <div id="profile_wrap">
            <div class="profilePicture"><img src="img/prof.png" alt="profile" /></div>
            <div class="profileComment">
                <div class="profileComment_top">
                    <div class="profile_id"><%=thisUserID%></div>
                    <div class="btn_wrap">
               		   <input type="hidden" id="unfollowerID" value="<%=sID%>" name="unfollower_session" />
                	   <input type="hidden" id="unfollowID" value="<%=thisUserID%>" name="unfollow_mem" />
                	   <button type="button" id="ufl_btn" onclick="doUnFollow()" >언팔로우</button>
                	  
                 		<input type="hidden" id="followerID" value="<%=sID%>" name="follower_session" />
                 	    <input type="hidden" id="followID" value="<%=thisUserID%>" name="follow_mem" />
                    	<button type="button" id="fl_btn" onclick="insertFollow()" >팔로우</button>
                    	<%
							isFollowSQL = "select * from bfollow where follow='"+ thisUserID +"' and follower='"+ sID +"'";
							DButil Dbsf = new DButil();
                    		isFollowRS = Dbsf.selectSQL(isFollowSQL);
							boolean b = isFollowRS.next();
						%>	
                    			<script type="text/javascript">
    								/* 팔로우 되어있지 않으면 팔로우 버튼이 보이게 */
    								if(<%=b%>==false) {
           		 						document.getElementById("ufl_btn").style.display = "none";
           		 						document.getElementById("fl_btn").style.display = "block";
    								}
    								/* 팔로우 되어있으면 언팔로우 버튼이 보이게 */
    								else {
          		  						document.getElementById("fl_btn").style.display = "none";
         		  						document.getElementById("ufl_btn").style.display = "block";
    								}
   		 							</script>
   		 				<% Dbsf.closeConnect(); %>
   		 			</div>
                </div><br />
 <%
 // 팔로워, 팔로우 수 구하는 SQL문
 	String getFerSql = "select count(*) as num from bfollow where follow='"+ thisUserID +"'";
 	String getFowSql = "select count(*) as num from bfollow where follower='"+ thisUserID +"'"; 	
 	DButil Dbs_fer = new DButil();
 	DButil Dbs_fow = new DButil();
 	
 	rs_followerNum = Dbs_fer.selectSQL(getFerSql);
 	rs_followNum = Dbs_fow.selectSQL(getFowSql);
 	
	rs_followerNum.next();
	rs_followNum.next();
	String numOfFollower = rs_followerNum.getString("num");
	String numOfFollow = rs_followNum.getString("num");
	
	Dbs_fer.closeConnect();
	Dbs_fow.closeConnect();
 %>
                <div class="wrap_pro_list">
                    <ul class="list_of_fol">
                        <li><button type="button" class="btn_follower">팔로워</button></li>
                        <li class="numberFollower"><p><%=numOfFollower%></p></li>
                        <li><button type="button" class="btn_follow">팔로우</button></li>
                        <li class="numberFollow"><p><%=numOfFollow%></p></li>
                    </ul>
                </div>
                <div class="profile_name"><%=thisUserName%></div>
            </div>
        </div>
    </div>
    <%
    	dbDAO dao = new dbDAO();
    	String selectBoard = "SELECT * FROM board WHERE mem_id = '"+thisUserID+"' order by bd_key DESC";
  		ArrayList<Board> boardList = dao.SelectBoard(selectBoard);
  		int bi = 0;
    %>
    <!--유저가 쓴 글, input=hidden value값: board key-->
    <div id="userPostContainer">
        <ul id="userPost">
        <%
        	for(bi = 0; bi < boardList.size(); bi++) {
        		Board obj_bd = boardList.get(bi);
        		int bdKey = obj_bd.getBd_key();
        		
        		String imgsql = "SELECT * FROM images where bd_key='"+ bdKey +"'";
        		ArrayList<Images> imgList = dao.SelectImages(imgsql);
        		Images users_bd_img = imgList.get(0);
        		String fileRelnm = users_bd_img.getFileRealName();
        %>
            <li>
            <form action="postedBoard.jsp" method="get">
                <input type="hidden" name="bdKey" value="<%=bdKey%>"/>
                <input type="hidden" name="memID" value="<%=thisUserID%>" />
				<input type="hidden" name="memName" value="<%=thisUserName%>" />
                <button type="submit" class="mypost"><img src="http://localhost:8181/upload/<%=fileRelnm%>" alt="postpic"></button>
            </form>
            </li>
        <%} %>
        </ul>
    </div>
</body>
</html>