<%@page import="daodto.Images"%>
<%@page import="daodto.Board"%>
<%@page import="daodto.dbDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="db.DButil" %>
 <% request.setCharacterEncoding("utf-8"); %>
 <%!
 	String sID;
 	String sName;
 %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.css" />
<style type="text/css">
		body {
            padding: 0;
            margin: 0;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }
        li { list-style: none; }
        a { text-decoration: none; }
        a:link { text-decoration: none;  color: initial; }
        a:visited { text-decoration: none;  color: initial; }
        a:hover { text-decoration: none; color: initial; }
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
            width:80%;
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
            padding: 0.5% 5% ;
            border-radius: 4px;
        }
        .headbar .head_icon {
            float: right;
            margin: 20px auto 20px auto;
        }
        .icon_like, .icon_me, .icon_pic {
            margin-left: 15px;
        }
        /* 프로필 DIV */
        #profile {
            width:100%;
            background-color:#fafafa;
            text-align:center;
            border: 0.5px solid #e8e8e8;
        }
        #profile_wrap {
            width:1000px;
            margin:0 auto 0 auto;
            height:350px;
        }
        #profile_wrap .profilePicture {
            float:left;
            position:relative;
            top:37%;
            margin-left:8%;
        }
        .profileComment { 
            position:relative;
            top:40%;
        }
        .profileComment_top {
            float:left;
            position:relative;
            margin-left:12%;
        }
        .profileComment_top .profile_id {
            font-size:1.3em;
            float:left;
            margin-bottom:15px;
            
        }
        .profileComment_top .profile_set {
            float:right;
            margin-left:20px;
        }
        .logout_btn {
            font-size: 1.2em;
            font-weight: bold;
            border: 0.5px solid #e8e8e8;
            border-radius: 4px;
            margin-left: 20px;
            margin-right: 10px;
            padding: 5px 10px 5px 10px;
            transition: all 200ms;
        }
        .logout_btn:hover {
            border:0.5px solid #000000;
        }
        .wrap_pro_list {
            position: relative;
            left: -25%;
        }
        
        .list_of_fol li { 
            float:left;
            padding:5px;
            margin-bottom:10px;
            margin-top:5px;
        }
        .btn_follower, .btn_follow {
            border-style:none;
            background:none;
            font-weight:bold;
            
        }
        .numberFollow, .numberFollower {
            margin-right: 7%;
        }
        .profile_name {
            font-weight:bold;
            float:left;
            padding-left:10px;
            padding-right:15px;
            padding-top:4px;
            margin-left:120px;
            font-size:14px;
        }
        /*프로필 아래 포스팅 글*/
        #userPostContainer{
            width:100%;
            text-align:center;
        }
        #userPost {
            width:900px;
            margin:0 auto 0 auto;
            overflow:hidden;
            margin-top:5px;
            margin-bottom:5px;
        }
        .mypost {
            border-style:none;
            background:none;
            width:250px;
            height:250px;
            margin:10px;
            float:left;
            cursor:pointer;
        }
        .mypost img {
            width:250px;
            height:250px;
            
        }
</style>
<meta charset="utf-8">
<title>SOL User Page</title>
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
	<%}%>
      <!-- 헤더 -->
	<div id="header">
        <div class="headbar_div">
            <ul class="headbar">
                <li class="head_logo"><a href="main_page.jsp"><img src="img/sol_logo_40px.png" alt="logo" /></a></li>
                <li class="head_icon">
                    <a href="Like_page.jsp" class="icon_like"><img src="img/like.png" alt="like" /></a>
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
    
    <%
    	sID = (String)session.getAttribute("id");
    	sName = (String)session.getAttribute("name");
    %>
    <!-- 프로필 부분 -->
   	<div id="profile">
        <div id="profile_wrap">
            <div class="profilePicture"><img src="img/prof.png" alt="profile" /></div>
            <div class="profileComment">
                <div class="profileComment_top">
                    <div class="profile_id"><%=sID%></div>
                    <a href="userEdit_page.jsp" class="profile_set"><img src="img/profset.png" alt="profset" /></a>
                    <a href="logout.jsp" class="logout_btn">로그아웃</a>
                </div><br />
            <%
            	DButil Dbnum_fer = new DButil();
            	DButil Dbnum_fow = new DButil();
            	String getFerSql = "select count(*) as num from bfollow where follow='"+ sID +"'";
         		String getFowSql = "select count(*) as num from bfollow where follower='"+ sID +"'";
         		//현재 로그인한 유저의 팔로워 수
         		ResultSet rs_followerNum = Dbnum_fer.selectSQL(getFerSql);
         		//현재 로그인한 유저의 팔로우 수
         		ResultSet rs_followNum = Dbnum_fow.selectSQL(getFowSql);
         		rs_followerNum.next();
         		rs_followNum.next();
         		String numOfFollower = rs_followerNum.getString("num");
         		String numOfFollow = rs_followNum.getString("num");
         		
         		Dbnum_fer.closeConnect();
         		Dbnum_fow.closeConnect();
            %>
                <div class="wrap_pro_list">
                    <ul class="list_of_fol">
                        <li><button type="button" class="btn_follower">팔로워</button></li>
                        <li class="numberFollower"><p><%=numOfFollower %></p></li>
                        <li><button type="button" class="btn_follow">팔로우</button></li>
                        <li class="numberFollow"><p><%=numOfFollow %></p></li>
                    </ul>
                </div>
                <br/>
                <div class="profile_name"><%=sName%></div>
            </div>
        </div>
    </div>
    
    <%
    	dbDAO dao = new dbDAO();
    	String selectSQL = "select * from board where mem_id = '"+sID+"' order by bd_key DESC" ;
    	ArrayList<Board> boardList = dao.SelectBoard(selectSQL);
    	int bi;
    %>
    <!-- 유저가 쓴 글 -->
    <div id="userPostContainer">
        <ul id="userPost">
        <%	for(bi = 0; bi < boardList.size(); bi++) {
        		Board obj_bd = boardList.get(bi);
    			int bdKey = obj_bd.getBd_key();
    			//해당 bdKey에 저장된 사진들을 검색하는 sql
    			String sqlImg = "select * from images where bd_key='"+ bdKey +"'";
    			ArrayList<Images> imgList = dao.SelectImages(sqlImg);
    			Images users_bd_img = imgList.get(0);
    			String fileRelnm = users_bd_img.getFileRealName();
    	%>
            <li>
            <form action="postedBoard.jsp" method="get">
                <input type="hidden" name="bdKey" value="<%=bdKey%>"/>
                <input type="hidden" name="memID" value="<%=sID%>" />
				<input type="hidden" name="memName" value="<%=sName%>" />
                <button type="submit" class="mypost"><img src="http://localhost:8181/upload/<%=fileRelnm%>" alt="postpic"></button>
            </form>
            </li>
        <%} %>
         </ul>
    </div>
</body>
</html>