<%@page import="daodto.Comm"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DButil"%>
<%@page import="daodto.Board"%>
<%@page import="daodto.Images"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daodto.dbDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%!
	String sID;
	String memID;
	String memName;
	int bdKey;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Posting</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<style>
body {
	padding: 0;
	margin: 0;
	font-family: Verdana, sans-serif;
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

#all_tag_wrap {
	width: 100%;
	background-color: #fafafa;
	height: auto;
}

/* Slideshow container */
.slideshow-container {
	width: 650px;
	height: 500px;
	position: relative;
	margin: auto;
	overflow: hidden;
	text-align: center;
	border-left: 0.5px solid #e8e8e8;
	border-right: 0.5px solid #e8e8e8;
}
/* 이미지태그 */
.slideshow-container .main_slideImg {
	width: 649px;
	height: 498px;
	object-fit: contain;
}

/* Next & previous buttons */
.prev, .next {
	position: absolute;
	cursor: pointer;
	text-align: center;
	width: 3%;
	top: 0;
	top: 50%;
	padding: 16px;
	color: #cecece;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	border-radius: 0 3px 3px 0;
	z-index: 100;
}
/* Position the "next button" to the right */
.prev {
	left: 0%;
}

.next {
	right: 0%;
	border-radius: 3px 0 0 3px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

/* Caption text */
.text {
	color: #f2f2f2;
	font-size: 15px;
	padding: 8px 12px;
	position: absolute;
	bottom: 8px;
	width: 100%;
	text-align: center;
}

/* Number text (1/3 etc) */
.numbertext {
	color: #f2f2f2;
	font-size: 12px;
	padding: 8px 12px;
	position: absolute;
	top: 0;
}

/* The dots/bullets/indicators */
.dot_wrap {
	width: auto;
	height: auto;
	position: absolute;
	text-align: center;
	bottom: 2%;
}

.dot {
	cursor: pointer;
	height: 9px;
	width: 9px;
	margin: 0 2px;
	background-color: #bbb;
	border-radius: 50%;
	display: inline-block;
	transition: background-color 0.6s ease;
	z-index: 10;
}

.active, .dot:hover {
	background-color: #717171;
}

/* Fading animation */
.fade2 {
	-webkit-animation-name: fade;
	-webkit-animation-duration: 0.5s;
	animation-name: fade;
	animation-duration: 5s;
}

@
-webkit-keyframes fade2 {
	from {opacity: .4
}

to {
	opacity: 1
}

}
@
keyframes fade2 {
	from {opacity: .4
}

to {
	opacity: 1
}

}

/* On smaller screens, decrease text size */
@media
only
screen
and
(max-width:
300px)
{
.slprev, .slnext, .text {
	font-size: 11px
}

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
   width:80%;
   overflow: hidden;
   height: 80px;
   margin: 0 auto;
}
.headbar li {
   float: left;
}
.headbar .head_logo {
   margin: 7px auto 20px auto;
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

/* 본문 */
body {
	background-color: #fafafa;
}

#container {
	width: 100%;
	text-align: center;
}

.cont_wrap {
	height: auto;
	margin: 0 auto 0 auto;
	position: relative;
	top: 130px;
}
/* edit: 왼쪽 margin */
.content {
	width: 650px;
	height: 680px;
	border: 0.5px solid #e8e8e8;
	border-radius: 3px;
	background-color: white;
	margin-bottom: 15px;
	margin-left: 30px;
}

.content_head {
	width: 100%;
	height: 7%;
	text-align: left;
}

.content_nick {
    cursor: pointer;
    font-family: sans-serif;
    border-style: none;
    background: none;
    font-weight: bold;
    color: black;
    font-size: 12px;
    padding-top:11px;
    margin-left: 1%;
}

.content_realname {
	font-weight: lighter;
	font-size: 12px;
	color: #999999;
	margin-left: 3%;
}

.content_pic {
	width: 100%;
	height: auto;
	border-top: 0.5px solid #e8e8e8;
	border-bottom: 0.5px solid #e8e8e8;
}

.pic_wrap {
	width: 650px;
	height: 500px;
	border-left: 0.5px solid #e8e8e8;
	border-right: 0.5px solid #e8e8e8;
}

.pic_wrap img {
	width: 649px;
	height: 498px;
	object-fit: contain;
}

.content_lnc {
	width: 100%;
	height: 4%;
	margin: 2% 0px 0px 0px;
	float: left;
	text-align: left;
}

.content_lnc button {
	cursor: pointer;
	margin-left: 1%;
	border-style: none;
	background: none;
}

.content_cont {
	width: 100%;
	height: 40px;
	text-align: left;
}

.content_cont .cont_in {
	font-size: 13px;
	font-weight: normal;
	color: black;
	margin-left: 7px;
	margin-right: 7px;
}

.comm_text {
	width: 599px;
	height: 30px;
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 0.5px solid #a9a9a9;
	margin-top: 9px;
	margin-left: 2px;
}

.comm_post_btn {
	border-style: none;
	background: none;
	font-size: 1.05em;
	font-weight: bold;
	color: #266ede;
	margin-top: 9px;
	-webkit-transition: all 200ms;
	-moz-transition: all 200ms;
	-ms-transition: all 200ms;
	-o-transition: all 200ms;
	transition: all 200ms;
	cursor:pointer;
}

.comm_post_btn:hover {
	color: #103672;
}

.cont_wrap .side_fixed {
	position: fixed;
	top: 17%;
	right: 13%;
	text-align: left;
}

.side_fixed .side_name_div {
	margin-left: 7%;
}

.side_name_div .p_nicname {
	color: black;
	font-size: 12px;
	font-weight: bold;
	margin-bottom: 5px;
}

.side_name_div .p_realname {
	font-weight: lighter;
	font-size: 11px;
	color: #999999;
}

.side_myFollow {
	background-color: white;
	border: 0.5px solid #e8e8e8;
	border-radius: 3px;
	width: 300px;
	height: 200px;
	padding: 9px;
}

.p_info_follow {
	color: #999999;
	margin-left: 3%;
	margin-bottom: 10px;
}

.p_follow {
	cursor: pointer;
	color: black;
	border-style: none;
	background: none;
	font-size: 12px;
	font-weight: bold;
	margin-left: 1%;
	margin-bottom: 7px;
}
/*5.29 추가 - 왼쪽:글, 오른쪽:댓글창*/
.comm_table {
	width: 1000px;
	height: auto;
}

.left_post, .right_post {
	width: 50%;
}

.comm_wrapTag {
	position: relative;
	top: 130px;
}

.comm_container {
	width: 650px;
	height: 680px;
	background-color: white;
	border: 0.5px solid #e8e8e8;
	border-radius: 4px;
	margin-bottom: 15px;
	margin-left: 40px;
	overflow: scroll;
}
.comm_small_container {
	margin-top: 10px;
}
.comt {
	margin: 4px 0;
}
button {
	border-style: none;
	background: none;
}
.comm_post_btn {
	border-style:none;
    background:none;
    font-size:1.05em;
    font-weight:bold;
    color:#266ede;
    margin-top:9px;
    -webkit-transition: all 200ms;
    -moz-transition: all 200ms;
    -ms-transition: all 200ms;
    -o-transition: all 200ms;
    transition: all 200ms;
}
.btn, .btn-primary, .btn-lg {
	border: 0.5px solid #e8e8e8;
	background-color: #fafafa;
	color: black;
	font-weight: bold;
	font-size: 1.15em;
	padding: 5px 25px 5px 25px;
}

.btn:hover, .btn-primary:hover, .btn-lg:hover {
	border: 0.5px solid #000;
	background-color: #fafafa;
	color: black;
	font-weight: bold;
	font-size: 1.15em;
}

.btn:focus, .btn-primary:focus, .btn-lg:focus {
	border: 0.5px solid #000;
	background-color: #fafafa;
	color: black;
	font-weight: bold;
	font-size: 1.15em;
}
.comm_delete {
	cursor: pointer;
	margin-left: 20px;
	border-style: none;
	background: none;
	font-size:10px;
	color: black;
}
.comm_delete:hover{
	color: red;
}
.post_head_name {
	width:600px;
}
.btn-pencil{
   border-style:none;
   background:none;
   width:auto;
   height:auto;
   padding:5px 5px;
}
.btn-pencil:hover {
   background:none;
}
</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"crossorigin="anonymous"></script>
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
		memID = request.getParameter("memID");
		memName = request.getParameter("memName");
		bdKey = Integer.parseInt(request.getParameter("bdKey"));
	%>
	<!-- 포스트 글 -->
	<table class="comm_table">
        <tr>
            <td class="left_post">
                <div id="container">
                    <div class="cont_wrap">
                        <div class="content">
                            <table class="content_head">
                            	<tr>
                                <td class="post_head_name"><form action="AreUSession.jsp" method="post">
									<input type="hidden" name="otherUserID" value="<%=memID%>" /> 
									<input type="hidden" name="otherUserName" value="<%=memName%>" />
									<input type="submit" class="content_nick" value="<%=memID%>" style="padding-top: 11px;" />
								</form></td>
								<td><form action="postEdit.jsp" method="post">
									<input type="hidden" name="bdEditKey" value="<%=bdKey%>" />
									<button type="submit" id="edit_btn<%=bdKey%>" class="btn btn-default btn-lg btn-pencil" style="display:none;">
                               			<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                            		</button>
                            		</form></td>
								</tr>
								
								<%
									if(sID.equals(memID)) {
								 %>
								<script type="text/javascript">
									document.getElementById("edit_btn<%=bdKey%>").style.display = "block";
								</script>
								<% } %>
								
								<!-- 좋아요 테이블에 넣을 값들 -->
								<input type="hidden" id="bd_key" value="<%=String.valueOf(bdKey)%>" /> 
								<input type="hidden" id="sessionID" value="<%=sID%>" />
                            </table>
                            <%
                            	dbDAO dao = new dbDAO();
                            	String bdSql = "select * from board where bd_key = '"+ bdKey +"'";
                            	ArrayList<Board> bdList = dao.SelectBoard(bdSql);
                            	Board obj_bd = bdList.get(0);
                            	
                            	String imgsSQL = "select * from images where bd_key ='" + bdKey + "'";
                            	ArrayList<Images> imgList = dao.SelectImages(imgsSQL);
                            	int picCount = 0;
                            	// 사진이 1장이면 Count:1, 여러 장이면 Count > 1
                            	ArrayList<String> imgNameList = new ArrayList<>();
                            
                            	for(picCount = 0; picCount < imgList.size(); picCount++) {
                            		Images obj_img = imgList.get(picCount);
                            		imgNameList.add(picCount, obj_img.getFileRealName());
                            	}
                            %>
                            <div class="content_pic">
                                <!--사진 1장이면 그냥표기, 여러장이면 슬라이드-->
                                <div class="slide" id="slide<%=bdKey%>" style="display: none;">
                                    <div class="slideshow-container">
                                    <%
                                    	int ii;
                                    	for(ii = 0; ii < picCount; ii++) {
                                    %>
                                        <div class="mySlides fade2">
                                            <img class="main_slideImg" src="http://localhost:8181/upload/<%=imgNameList.get(ii)%>" />
                                        </div>
                                     <%
                                    	}
                                     %>
                                        <a class="prev" onclick="plusSlides(-1)">❮</a>
                                        <a class="next" onclick="plusSlides(1)">❯</a>
                                        <div class="dot_wrap">
                                        <% for (ii = 0; ii < picCount; ii++) { %>
                                            <span class="dot" onclick="currentSlide(<%=ii + 1%>)"></span>
                                        <% } %>
                                        </div>
                                    </div>
                                </div>
                                <!--사진 1장-->
                                <div class="pic_wrap" id="pic<%=bdKey%>">
                                    <img src="http://localhost:8181/upload/<%=imgNameList.get(0)%>" />
                                </div>
                            </div>
                            <div class="content_cont">
                                <p class="cont_in"><%=obj_bd.getBd_cont() %></p>
                            </div>
                     <script type="text/javascript">
						//슬라이드 스크립
					var slideIndex = 1;
					showSlides<%=bdKey%>(slideIndex);
						
					function plusSlides(n) {
	    				showSlides<%=bdKey%>(slideIndex += n);
					}

					function currentSlide(n) {
	    				showSlides<%=bdKey%>(slideIndex = n);
					}

					function showSlides<%=bdKey%>(n) {
	    				var i;
	    				var slides = document.getElementsByClassName("mySlides");
	    				var dots = document.getElementsByClassName("dot");

	    				if (n > slides.length) {slideIndex = 1}
	    				if (n < 1) {slideIndex = slides.length}

	    				for (i = 0; i < slides.length; i++) {
	        				slides[i].style.display = "none";
	    				}

	    				for (i = 0; i < dots.length; i++) {
	        				dots[i].className = dots[i].className.replace(" active", "");
	    				}
	    				slides[slideIndex-1].style.display = "block";
	    				dots[slideIndex-1].className += " active";
					}
					
					if(<%=picCount%> > 1) {
                		document.getElementById("pic<%=bdKey%>").style.display = "none";
                		document.getElementById("slide<%=bdKey%>").style.display = "block";
                	}
                	else {
                		document.getElementById("slide<%=bdKey%>").style.display = "none";
                		document.getElementById("pic<%=bdKey%>").style.display = "block";
                	}
				</script>
                            <%
                            	DButil DbchkLike = new DButil();
                            	DButil Dbln = new DButil();
                            	String likeChk = "SELECT * FROM blike WHERE bd_key = '" + bdKey + "' and mem_id = '" + sID + "'";
                            	String countLike = "SELECT * FROM blike WHERE bd_key = '" + bdKey + "'";
                            	
                            	ResultSet rsChkLike = DbchkLike.selectSQL(likeChk);
                            	ResultSet rsCountLike = Dbln.selectSQL(countLike);
                            	
                            	int lk_count = 0;
                            	while(rsCountLike.next()){
                            		lk_count++;
                            	}
                            	Dbln.closeConnect();
                            %>
                            <div class="content_lnc">
                            	<table>
                            		<tr>
                                		<td><button type="button" id="btnlike_empty<%=bdKey%>" class="content_like" onclick="insertLike<%=bdKey%>()"><img src="img/like.png" /></button>
                                		<button type="button" id="btnlike_full<%=bdKey%>" class="content_like" onclick="deleteLike<%=bdKey%>()" style="display:none;"><img src="img/like_full.png" /></button></td>
                                		<td><b><b id="cnt_Lk"><%=lk_count%></b> 명이 이 글을 좋아합니다.</b></td>
                                	</tr>
                            	</table>
                            </div>
                            <% 
                            	boolean bIsLike = rsChkLike.next(); 
                            	DbchkLike.closeConnect();
                            %>
                            <script type="text/javascript" charset="utf-8">
                            	var cntArray = new Array();
                            	if (<%=bIsLike%> == false){
                            		document.getElementById("btnlike_full<%=bdKey%>").style.display = "none";
                					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "block";
                            	}
                            	else {
                            		document.getElementById("btnlike_empty<%=bdKey%>").style.display = "none";
                	 				document.getElementById("btnlike_full<%=bdKey%>").style.display = "block";
                            	}
                            	//좋아요 ajax
                            	var likerequest = new XMLHttpRequest();
                            	var Unlikerequest = new XMLHttpRequest();
                            	cntArray[<%=bdKey%>] = <%=lk_count%>;
                            	
                            	function insertLike<%=bdKey%>() {
                            		likerequest.open("Post","./LikeServlet?mem_id="+ encodeURIComponent(document.getElementById("sessionID").value) + 
    										"&bd_key="+ encodeURIComponent(document.getElementById("bd_key").value), true);
    								likerequest.onreadystatechange = LikeProcess<%=bdKey%>;
    								likerequest.send(null);
                            	}
                            	function LikeProcess<%=bdKey%>() {
                        			if(likerequest.readyState == 4 && likerequest.status == 200) {
                        				var getWrite = likerequest.responseText;
                        				if(getWrite == 0) {
                        					alert("좋아요를 실패했습니다. (DB에러)");
                        				} else {
                        					var c = cntArray[<%=bdKey%>] + 1;
                        					cntArray[<%=bdKey%>] = c;
                        					document.getElementById("cnt_Lk").innerHTML = c;
                        					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "none";
                        	 				document.getElementById("btnlike_full<%=bdKey%>").style.display = "block";
                        				}
                        			}
                        		}
                            	
                            	function deleteLike<%=bdKey%>() {
                        			Unlikerequest.open("Post","./UnlikeServlet?mem_id="+ encodeURIComponent(document.getElementById("sessionID").value) + 
                        									"&bd_key="+ encodeURIComponent(document.getElementById("bd_key").value), true);
                        			Unlikerequest.onreadystatechange = UnlikeProcess<%=bdKey%>;
                        			Unlikerequest.send(null);
                        		}
                            	function UnlikeProcess<%=bdKey%>() {
                        			if(Unlikerequest.readyState == 4 && Unlikerequest.status == 200) {
                        				var getWrite = Unlikerequest.responseText;
                        				if(getWrite == 0) {
                        					alert("좋아요 취소를 실패했습니다. (DB에러)");
                        				} else {
                        					var c = cntArray[<%=bdKey%>] - 1;
                        					cntArray[<%=bdKey%>] = c;
                        					document.getElementById("cnt_Lk").innerHTML = c;
                        					document.getElementById("btnlike_full<%=bdKey%>").style.display = "none";
                        					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "block";
                        				}
                        			}
                        		}
                            </script>
                            
                            <!--댓글 입력하기 (text input, button의 아이디:%%로 넣기)-->
                            <div class="comment_form">
                                <table>
                                    <tr>
                                    <form action="write_comm_onPost.jsp" method="post" name="write_comm_frm">
                                        <td>
                                        	<input type="hidden" name="bdKey" value="<%=bdKey%>" />
                                        	<input type="hidden" name="sessionID" value="<%=sID%>" />
                                        	<input type="hidden" name="memID" value="<%=memID%>" />
											<input type="hidden" name="memName" value="<%=memName%>" />
                                            <input type="text" name="comm_text" class="comm_text" />
                                        </td>
                                        <td>
                                            <input type="submit" class="comm_post_btn" value="게시"></input>
                                        </td>
                                        </form>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </td>
            <!--댓글창-->
            <%
            	String selectComm = "SELECT * FROM comm where bd_key = '"+ bdKey +"' ORDER BY comment_key ASC";
            	ArrayList<Comm> CommList = dao.SelectComm(selectComm);
            	int Commi = 0;
            %>
            <td class="right_post">
                <div class="comm_wrapTag">
                    <div class="comm_container">
                        <div class="comm_small_container">
                            <ul>
                            <%
                            	for(Commi = 0; Commi < CommList.size(); Commi++) {
                            		Comm obj_com = CommList.get(Commi);
                            		int comment_key = obj_com.getComment_key();
                            		String comWriteID = obj_com.getMem_id();
                            %>
                                <li class="comt"><b><%=comWriteID %></b> <%=obj_com.getComment_cont() %>
                                	<form action="del_comm_onPost.jsp" method="post" style="display:inline;">
                                		<input type="hidden" name="bdKey" value="<%=bdKey%>" />
                                    	<input type="hidden" name="sessionID" value="<%=sID%>" />
                                    	<input type="hidden" name="comm_key" value="<%=comment_key%>" />
                                    	<input type="hidden" name="memID" value="<%=memID%>" />
										<input type="hidden" name="memName" value="<%=memName%>" />
                                		<button type="submit" id="comm_del<%=comment_key%>" class="comm_delete" style="display:none;">&#10006;</button>
                               		</form>
                                </li>
                            	<script type="text/javascript">
                            		if(<%=sID.equals(comWriteID)%>) {
                            			document.getElementById("comm_del<%=comment_key%>").style.display = "inline";
                            		}
                            	</script>
                            <%
                            	}
                            %>
                            </ul>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
       </table>
</body>
</html>