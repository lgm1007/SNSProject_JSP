<%@page import="daodto.Images"%>
<%@page import="db.DButil"%>
<%@page import="daodto.Board"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="daodto.dbDAO"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="style_main.css" />
<title>Liking Page</title>
<style type="text/css">
* {
	box-sizing: border-box
}
body {
	font-family: Verdana, sans-serif;
	margin: 0
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
@media only screen and (max-width: 300px) {
	.slprev, .slnext, .text {
		font-size: 11px
	}
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
/*Modal Body 내용 추가*/
.modal_btnlist_wrap {
	width: 100%;
	height: 35px;
}

.modal_btn_ul li {
	float: left;
}

.btn_follow, .btn_follower {
	border-style: none;
	background: none;
	font-weight: bold;
	color: black;
	font-size: 1.2em;
}

.btn_follow:hover, .btn_follower:hover {
	text-decoration-line: underline;
}

.btn_follow:focus, .btn_follower:focus {
	text-decoration-line: underline;
}

.btn_follow {
	margin-left: 330px;
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

<script type="text/javascript">
	var cntArray = new Array();
</script>

<%!
	String sID;
	String sName;
	ResultSet rsImg;
	ResultSet rssidLk;
	ResultSet rsCntL;
%>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="Search.js" charset="utf-8"></script>
		<%
		if (session.getAttribute("id") == null) {
	%>
	<script type="text/javascript" charset="utf-8">
		alert("유효한 세선이 없습니다.");
		document.location.href="login.jsp";
	</script>
	<%
		}
		sID = (String) session.getAttribute("id");
		sName = (String) session.getAttribute("name");
	%>
	
	<!-- 헤더 -->
	<div id="header">
		<div class="headbar_div">
			<ul class="headbar">
				<li class="head_logo"><a href="main_page.jsp">
					<img src="img/sol_logo_40px.png" alt="logo" />
				</a></li>
				<li class="head_icon">
					<a href="Like_page.jsp" class="icon_like"><img src="img/like.png" alt="like" /></a> 
					<a href="user_page.jsp" class="icon_me"><img src="img/me.PNG" alt="me" /></a> 
					<a href="post_writePage.jsp" class="icon_pic"><img src="img/pic.PNG" alt="pic" /></a>
				</li>
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
	
	<div id="container">
		<div class="cont_wrap">
		<%
			String joinSQL = "SELECT bd.bd_key, bd.mem_id, bd.bd_cont FROM board as bd JOIN blike as lk WHERE bd.bd_key = lk.bd_key and lk.mem_id = '"+ sID +"' ORDER BY bd_key DESC";
			dbDAO dao = new dbDAO();
			ArrayList<Board> listOfBoard = dao.SelectBoard(joinSQL);
			
			int ci = 0;
			//for문으로 포스트 출력
			for(ci = 0; ci < listOfBoard.size(); ci++) {
				Board obj_bd = listOfBoard.get(ci);
				String memID = obj_bd.getMem_id();
				int bdKey = obj_bd.getBd_key();
				//현재 포스트의 유저(글쓴이)의 이름을 구하기 위한 SQL
				String selNameSQL = "SELECT name FROM member where id = '" + memID + "'";
				DButil dbsn = new DButil();
				ResultSet rs_nm = dbsn.selectSQL(selNameSQL);
				boolean bn = rs_nm.next();
				String memName = rs_nm.getString("name");
		%>
			<div class="content">
				<div class="content_head">
						<form action="AreUSession.jsp" method="post">
							<input type="hidden" name="otherUserID" value="<%=memID%>" /> 
							<input type="hidden" name="otherUserName" value="<%=memName%>" />
							<input type="submit" class="content_nick" value="<%=memID%>" style="padding-top: 11px;" />
						</form>
						<!-- 좋아요 테이블에 넣을 정보 (bdKey:글번호, sID:현재 좋아요를 한 사람=로그인한 사람) -->
						<input type="hidden" id="bd_key<%=bdKey%>" value="<%=String.valueOf(bdKey)%>" /> 
						<input type="hidden" id="sessionID" value="<%=sID%>" />
					</div>
			<%
				dbsn.closeConnect();
				String imgsSQL = "select * from images where bd_key ='" + bdKey + "'";
				ArrayList<Images> listOfImages = dao.SelectImages(imgsSQL);

				int imgCount = 0;
				ArrayList<String> imagernames = new ArrayList<>();
				// 사진이 1장이면 Count:1, 여러 장이면 Count > 1
				for (imgCount = 0; imgCount < listOfImages.size(); imgCount++) {
					Images obj_img = listOfImages.get(imgCount);
					imagernames.add(imgCount, obj_img.getFileRealName());
				}
			%>
			<div class="content_pic">
				<!--사진 1장이면 그냥표기, 여러장이면 슬라이드-->
				<div class="slide" id="slide<%=bdKey%>" style="display: none;">
					<div class="slideshow-container">
						<%
							int ii;
							for (ii = 0; ii < imgCount; ii++) {
						%>
						<div class="mySlides<%=bdKey%> fade2">
							<img class="main_slideImg" src="http://localhost:8181/upload/<%=imagernames.get(ii)%>" />
						</div>
						<% } %>
						<a class="prev" onclick="plusSlides<%=bdKey%>(-1)">❮</a> 
						<a class="next" onclick="plusSlides<%=bdKey%>(1)">❯</a>
						<div class="dot_wrap">
							<%
								for (ii = 0; ii < imgCount; ii++) {
							%>
							<span class="dot<%=bdKey%> dot" onclick="currentSlide<%=bdKey%>(<%=ii + 1%>)"></span>
							<% } %>
						</div>
					</div>
				</div>
				
				<div class="pic_wrap" id="pic<%=bdKey%>">
					<img src="http://localhost:8181/upload/<%=imagernames.get(0)%>" />
				</div>
			</div>
			
			<div class="content_cont">
				<p class="cont_in"><%=obj_bd.getBd_cont()%></p>
			</div>
			<%
				DButil dbcu = new DButil();
				String selectthisLK = "SELECT * FROM blike where bd_key = '" + bdKey + "'";
				rsCntL = dbcu.selectSQL(selectthisLK);
				int cntLk = 0;
				while(rsCntL.next()) {
					cntLk++;
				}
				dbcu.closeConnect();
			%>
			
			<div class="content_lnc">
				<table>
					<tr>
						<!-- 해당 bd_key에 대한blike 테이블 열이 있으면 좋아요한 상태, 없으면 안함 -->
						<td><button type="button" id="btnlike_empty<%=bdKey%>" class="content_like" onclick="insertLike<%=bdKey%>()" style="display: none;">
							<img src="img/like.png" />
						</button>
						<button type="button" id="btnlike_full<%=bdKey%>" class="content_like" onclick="deleteLike<%=bdKey%>()">
							<img src="img/like_full.png" />
						</button></td>
						<td><b><b id="cnt_Lk<%=bdKey%>"><%=cntLk%></b> 명이 이 글을 좋아합니다.</b></td>
						<td>
						<form action="postedBoard.jsp" name="comm_btn_form" method="get">
							<input type="hidden" name="bdKey" value="<%=bdKey%>"  />
							<input type="hidden" name="memID" value="<%=memID%>" />
							<input type="hidden" name="memName" value="<%=memName%>" />
							<button type="submit" class="content_comm"><img src="img/comm.png" /></button>
						</form>
						</td>
					</tr>
				</table>
			</div>
			<%
				//좋아요 여부 알아보는 SQL
				DButil dbslk = new DButil();
				String selectLkSQL = "SELECT * FROM blike where bd_key = '" + bdKey + "' and mem_id = '" + sID + "'";
				rssidLk = dbslk.selectSQL(selectLkSQL);
				boolean bisLk = rssidLk.next();
			%>
			<script type="text/javascript" charset="utf-8">
                //좋아요 되어있지 않으면(false) 빈하트, 되어있으면(true) 하트
                	if(<%=bisLk%> == false) {
                		document.getElementById("btnlike_full<%=bdKey%>").style.display = "none";
    					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "block";
                	}
                	else {
                		document.getElementById("btnlike_empty<%=bdKey%>").style.display = "none";
    	 				document.getElementById("btnlike_full<%=bdKey%>").style.display = "block";
                	}
                //좋아요 ajax 구문
                	var likerequest = new XMLHttpRequest();
            		var Unlikerequest = new XMLHttpRequest();
            		
            		cntArray[<%=bdKey%>] = <%=cntLk%>;
            		
            		function insertLike<%=bdKey%>() {
            			likerequest.open("Post","./LikeServlet?mem_id="+ encodeURIComponent(document.getElementById("sessionID").value) + 
            										"&bd_key="+ encodeURIComponent(document.getElementById("bd_key<%=bdKey%>").value), true);
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
            					document.getElementById("cnt_Lk<%=bdKey%>").innerHTML = c;
            					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "none";
            	 				document.getElementById("btnlike_full<%=bdKey%>").style.display = "block";
            				}
            			}
            		}
            		
            		function deleteLike<%=bdKey%>() {
            			Unlikerequest.open("Post","./UnlikeServlet?mem_id="+ encodeURIComponent(document.getElementById("sessionID").value) + 
            									"&bd_key="+ encodeURIComponent(document.getElementById("bd_key<%=bdKey%>").value), true);
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
            					document.getElementById("cnt_Lk<%=bdKey%>").innerHTML = c;
            					document.getElementById("btnlike_full<%=bdKey%>").style.display = "none";
            					document.getElementById("btnlike_empty<%=bdKey%>").style.display = "block";
            				}
            			}
            		}
                </script>
             <% dbslk.closeConnect(); %>
             <!--댓글 입력하기 (!!text input, button의 아이디:뒤에 %=bdKey%로 넣기)-->
				<div class="comment_form">
					<table>
						<tr>
							<td><input type="text" id="comm<%=bdKey%>"
								class="comm_text" /></td>
							<td>
								<button type="button" class="comm_post_btn" onclick="insertComm<%=bdKey%>()">게시</button>
							</td>
						</tr>
					</table>
				</div>
		    </div>
		    <!-- 댓글 작성 ajax -->
		    <script type="text/javascript" charset="utf-8">
            	var registComm = new XMLHttpRequest();
            	function insertComm<%=bdKey%>() {
            		registComm.open("Post","./CommPostServlet?mem_id="+ encodeURIComponent(document.getElementById("sessionID").value) + 
							"&bd_key="+ encodeURIComponent(document.getElementById("bd_key<%=bdKey%>").value) + 
							"&comment_cont=" + encodeURIComponent(document.getElementById("comm<%=bdKey%>").value), true);
            		registComm.onreadystatechange = CommProcess<%=bdKey%>;
            		registComm.send(null);
            	}
            	function CommProcess<%=bdKey%>() {
            		if(registComm.readyState == 4 && registComm.status == 200) {
            			var getWrite = registComm.responseText;
            			if(getWrite == 0) {
            				alert("댓글 작성에 실패하였습니다. (DB에러)");
            			} else {
            				document.getElementById("comm<%=bdKey%>").value = "";
            			}
            		}
            	}
            </script>
            <script type="text/javascript">
          //슬라이드 스크립
			var slideIndex = 1;
			showSlides<%=bdKey%>(slideIndex);
				
			function plusSlides<%=bdKey%>(n) {
				showSlides<%=bdKey%>(slideIndex += n);
			}

			function currentSlide<%=bdKey%>(n) {
				showSlides<%=bdKey%>(slideIndex = n);
			}

			function showSlides<%=bdKey%>(n) {
				var i;
				var slides = document.getElementsByClassName("mySlides<%=bdKey%>");
				var dots = document.getElementsByClassName("dot<%=bdKey%>");

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
            </script>
            <script type="text/javascript">
                	if(<%=imgCount%> > 1) {
                		document.getElementById("pic<%=bdKey%>").style.display = "none";
                		document.getElementById("slide<%=bdKey%>").style.display = "block";
                	}
                	else {
                		document.getElementById("slide<%=bdKey%>").style.display = "none";
                		document.getElementById("pic<%=bdKey%>").style.display = "block";
                	}
           </script>
           <%
			    }
				if (ci == 0) {
			%>
			<div class="content">
				<h3 style="line-height: 150px">
					좋아요한 글이 없습니다.<br />마음에 드는 포스트를 좋아요 해보세요!
				</h3>
			</div>
			<% } %>
			<div class="side_fixed">
				<div class="side_name_div">
					<p class="p_nicname"><%=sID%></p>
					<p class="p_realname"><%=sName%></p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>