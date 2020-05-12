<%@page import="daodto.Images"%>
<%@page import="daodto.Board"%>
<%@page import="daodto.Follow"%>
<%@page import="daodto.dbDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@ page import="db.DButil"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%!String sID;
	String sName;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>SOL</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="style_main.css" />
<style>
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

.fl_table_modal {
	margin-bottom: 10px;
}

.modal_fl_frm {
	width: 350px;
}

.fl_id_submit {
	border-style: none;
	background: none;
	color: black;
	font-weight: bold;
	font-size: 1.1em;
	margin-left: 27px;
}

.modal_frm_realname {
	font-size: 1.1em;
	color: #999999;
	margin-left: 33px;
}

.fl_ufl_btn_wrap {
	margin-left: 55px;
}

.modal_ufl_btn, .modal_fl_btn {
	color: white;
	border-style: none;
	background: none;
	font-weight: bold;
	-webkit-transition: all 200ms;
	-moz-transition: all 200ms;
	-ms-transition: all 200ms;
	-o-transition: all 200ms;
	transition: all 200ms;
	display: inline-block;
	background-color: #3897f0;
	border-radius: 4px;
	padding: 5px 0;
	width: 70px;
	cursor: pointer;
}

.modal_ufl_btn:hover, .modal_fl_btn:hover {
	box-shadow: 0px 0px 0px 40px #163c60 inset;
}

.modal_ufl_btn {
	display: none;
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
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript" src="Search.js" charset="utf-8"></script>

	<script type="text/javascript">
        function view_follower() {
            document.getElementById("modal_follow_lists").style.display = "none";
            document.getElementById("modal_follower_lists").style.display = "block";    
        }
        function view_follow() {
            document.getElementById("modal_follower_lists").style.display = "none";
            document.getElementById("modal_follow_lists").style.display = "block";
        }
        /*팔로워목록 버튼누르자마자 팔로워먼저 보여주기 -> 팔로워목록 버튼에 onclick이벤트 view_follower()*/
    </script>
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
	<!-- Modal -->
	<div id="all_tag_wrap">
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">팔로우 목록</h4>
					</div>
					<div class="modal-body">
						<div class="modal_btnlist_wrap">
							<ul class="modal_btn_ul">
								<li><button type="button" class="btn_follower"
										onclick="view_follower()">팔로워</button></li>
								<li><button type="button" class="btn_follow"
										onclick="view_follow()">팔로우</button></li>
							</ul>
						</div>
						<div id="modal_follower_lists">
							<!--팔로워(나를 팔로우한 사람) 1명 값-->
							<table class="fl_table_modal">
								<%
									dbDAO dao = new dbDAO();
									//해당 유저의 팔로워(해당유저를 팔로우한 사람)
									String chkFlerSql = "select * from bfollow where follow='" + sID + "'";
									ArrayList<Follow> listOfFollower = dao.SelectFollow(chkFlerSql);
									int follower_i = 0;
									ArrayList<String> erList = new ArrayList<>();

									//while문 수행 : 1명이라도 팔로워가 있다면
									for (follower_i = 0; follower_i < listOfFollower.size(); follower_i++) {
										DButil Dbui = new DButil();
										Follow obj_follower = listOfFollower.get(follower_i);
										erList.add(follower_i, obj_follower.getFollower());

										ResultSet rsForName = Dbui.selectSQL("select * from member where id='" + erList.get(follower_i) + "'");
										boolean b1 = rsForName.next();
								%>
								<!-- 팔로우/언팔로우버튼 ajax Script 1 -->
								<script type="text/javascript" charset="utf-8">
                            	var Followrequest = new XMLHttpRequest();
                            	var Unfollowrequest = new XMLHttpRequest();
                            	
                            	function insertFollow<%=follower_i%>() {
                        			Followrequest.open("Post","./FollowRegisterServlet?follow="+ encodeURIComponent(document.getElementById("followID<%=follower_i%>").value) +
                        								 "&follower="+ encodeURIComponent(document.getElementById("followerID<%=follower_i%>").value), true);
                        			
                        			Followrequest.onreadystatechange = FollowProcess<%=follower_i%>;
                        			Followrequest.send(null);
                        		}
                            	function FollowProcess<%=follower_i%>() {
                            		if(Followrequest.readyState == 4 && Followrequest.status == 200) {
                        				var getWrite = Followrequest.responseText;
                        				if(getWrite == 0) {
                        					alert("팔로우를 실패하였습니다! (DB에러)");
                        				} 
                        				else {
                        					document.getElementById("fl_btn<%=follower_i%>").style.display = "none";
                        	  				document.getElementById("ufl_btn<%=follower_i%>").style.display = "block";
                        				}
                        			}
                            	}
                            	
                            	function doUnFollow<%=follower_i%>() {
                        			Unfollowrequest.open("Post","./UnfollowServlet?follow="+ encodeURIComponent(document.getElementById("unfollowID<%=follower_i%>").value) +
                        					 "&follower="+ encodeURIComponent(document.getElementById("unfollowerID<%=follower_i%>").value), true);
                        			Unfollowrequest.onreadystatechange = UnfollowProcess<%=follower_i%>;
                        			Unfollowrequest.send(null);
                        		}
                            	function UnfollowProcess<%=follower_i%>() {
                            		if(Unfollowrequest.readyState == 4 && Unfollowrequest.status == 200) {
                        				var getWrite = Unfollowrequest.responseText;
                        				if(getWrite == 0) {
                        					alert("팔로우를 실패하였습니다! (DB에러)");
                        				}
                        				else {
                        					document.getElementById("ufl_btn<%=follower_i%>").style.display = "none";
                        	 				document.getElementById("fl_btn<%=follower_i%>").style.display = "block";
                        				}
                        			}
                            	}
                            </script>
								<tr>
									<td>
										<form action="OtherUser_Page.jsp" method="post"
											class="modal_fl_frm">
											<input type="hidden" value="<%=erList.get(follower_i)%>" name="otherUserID" /> 
											<input type="hidden" value="<%=rsForName.getString("name")%>" name="otherUserName" />
											<input name="otherUser" class="fl_id_submit" type="submit" value="<%=erList.get(follower_i)%>" />
										</form>
										<p class="modal_frm_realname"><%=rsForName.getString("name")%></p>
									</td>
									<td>
										<div class="fl_ufl_btn_wrap">
											<input type="hidden" id="followerID<%=follower_i%>" value="<%=sID%>" name="unfollower_session" /> 
											<input type="hidden" id="followID<%=follower_i%>" value="<%=erList.get(follower_i)%>" name="unfollow_mem" />
											<button type="button" class="modal_fl_btn" id="fl_btn<%=follower_i%>" onclick="insertFollow<%=follower_i%>()">팔로우</button>

											<input type="hidden" id="unfollowerID<%=follower_i%>" value="<%=sID%>" name="unfollower_session" /> 
											<input type="hidden" id="unfollowID<%=follower_i%>" value="<%=erList.get(follower_i)%>" name="unfollow_mem" />
											<button type="button" class="modal_ufl_btn"
												id="ufl_btn<%=follower_i%>"
												onclick="doUnFollow<%=follower_i%>()">언팔로우</button>

											<%
												String isFollowerSQL = "select * from bfollow where follow='" + erList.get(follower_i)
															+ "' and follower='" + sID + "'";
													ResultSet isFollowerRS = Dbui.selectSQL(isFollowerSQL);
													boolean b = isFollowerRS.next();
											%>
											<script type="text/javascript">
    										/* 팔로우 되어있지 않으면 팔로우 버튼이 보이게 */
    										if(<%=b%>==false) {
           		 								document.getElementById("ufl_btn<%=follower_i%>").style.display = "none";
           		 								document.getElementById("fl_btn<%=follower_i%>").style.display = "block";
    										}
    										/* 팔로우 되어있으면 언팔로우 버튼이 보이게 */
    										else {
          		  								document.getElementById("fl_btn<%=follower_i%>").style.display = "none";
         		  								document.getElementById("ufl_btn<%=follower_i%>").style.display = "block";
    										}
   		 									</script>

										</div>
									</td>
								</tr>
								<%
									//folow_i 가 0이라면 팔로워가 없을때 
									}
									if (follower_i == 0) {
								%>
								<tr>
									<h3>팔로워가 없습니다. ㅠㅠ</h3>
								</tr>
								<%
									}
								%>
							</table>
						</div>

						<div id="modal_follow_lists">
							<!--팔로우(내가 팔로우한 사람) 1명 값-->
							<table class="fl_table_modal">
								<%
									//해당 유저의 팔로우(해당유저가 팔로우한 사람)
									String chkFlowSql = "select * from bfollow where follower='" + sID + "'";
									ArrayList<Follow> listOfFollow = dao.SelectFollow(chkFlowSql);

									int follow_i = 0;
									ArrayList<String> owList = new ArrayList<>();
									//while문 수행 : 1명이라도 팔로워가 있다면
									for (follow_i = 0; follow_i < listOfFollow.size(); follow_i++) {
										DButil Dbui = new DButil();
										Follow obj_follow = listOfFollow.get(follow_i);
										owList.add(follow_i, obj_follow.getFollow());

										ResultSet rsForName = Dbui.selectSQL("select * from member where id='" + owList.get(follow_i) + "'");
										boolean b2 = rsForName.next();
								%>
								<!-- 팔로우/언팔로우버튼 ajax Script 2 -->
								<script type="text/javascript" charset="utf-8">
                            	var Followrequest2 = new XMLHttpRequest();
                            	var Unfollowrequest2 = new XMLHttpRequest();
                            	
                            	function insertFollow2<%=follow_i%>() {
                        			Followrequest2.open("Post","./FollowRegisterServlet?follow="+ encodeURIComponent(document.getElementById("followID2<%=follow_i%>").value) +
                        								 "&follower="+ encodeURIComponent(document.getElementById("followerID2<%=follow_i%>").value), true);
                        			
                        			Followrequest2.onreadystatechange = FollowProcesss<%=follow_i%>;
                        			Followrequest2.send(null);
                        		}
                            	function FollowProcesss<%=follow_i%>() {
                            		if(Followrequest2.readyState == 4 && Followrequest2.status == 200) {
                        				var getWrite = Followrequest2.responseText;
                        				if(getWrite == 0) {
                        					alert("팔로우를 실패하였습니다! (DB에러)");
                        				} 
                        				else {
                        					document.getElementById("fl_btn2<%=follow_i%>").style.display = "none";
                        	  				document.getElementById("ufl_btn2<%=follow_i%>").style.display = "block";
                        				}
                        			}
                            	}
                            	
                            	function doUnFollow2<%=follow_i%>() {
                        			Unfollowrequest2.open("Post","./UnfollowServlet?follow="+ encodeURIComponent(document.getElementById("unfollowID2<%=follow_i%>").value) +
                        					 "&follower="+ encodeURIComponent(document.getElementById("unfollowerID2<%=follow_i%>").value), true);
                        			Unfollowrequest2.onreadystatechange = UnfollowProcesss<%=follow_i%>;
                        			Unfollowrequest2.send(null);
                        		}
                            	function UnfollowProcesss<%=follow_i%>() {
                            		if(Unfollowrequest2.readyState == 4 && Unfollowrequest2.status == 200) {
                        				var getWrite = Unfollowrequest2.responseText;
                        				if(getWrite == 0) {
                        					alert("팔로우를 실패하였습니다! (DB에러)");
                        				}
                        				else {
                        					document.getElementById("ufl_btn2<%=follow_i%>").style.display = "none";
                        	 				document.getElementById("fl_btn2<%=follow_i%>").style.display = "block";
                        				}
                        			}
                            	}
                            </script>
								<tr>
									<td>
										<form action="OtherUser_Page.jsp" method="post"
											class="modal_fl_frm">
											<input type="hidden" value="<%=owList.get(follow_i)%>" name="otherUserID" /> 
											<input type="hidden" value="<%=rsForName.getString("name")%>" name="otherUserName" /> 
											<input name="otherUser" class="fl_id_submit" type="submit" value="<%=owList.get(follow_i)%>" />
										</form>
										<p class="modal_frm_realname"><%=rsForName.getString("name")%></p>
									</td>
									<td>
										<div class="fl_ufl_btn_wrap">

											<input type="hidden" id="followerID2<%=follow_i%>" value="<%=sID%>" name="unfollower_session" /> 
											<input type="hidden" id="followID2<%=follow_i%>" value="<%=owList.get(follow_i)%>" name="unfollow_mem" />
											<button type="button" class="modal_fl_btn" id="fl_btn2<%=follow_i%>" onclick="insertFollow2<%=follow_i%>()">팔로우</button>

											<input type="hidden" id="unfollowerID2<%=follow_i%>" value="<%=sID%>" name="unfollower_session" /> 
											<input type="hidden" id="unfollowID2<%=follow_i%>" value="<%=owList.get(follow_i)%>" name="unfollow_mem" />
											<button type="button" class="modal_ufl_btn" id="ufl_btn2<%=follow_i%>" onclick="doUnFollow2<%=follow_i%>()">언팔로우</button>

											<%
												String isFollowSQL = "select * from bfollow where follow='" + owList.get(follow_i) + "' and follower='"
															+ sID + "'";
													ResultSet isFollowRS = Dbui.selectSQL(isFollowSQL);
													boolean bb = isFollowRS.next();
											%>
											<script type="text/javascript">
    									/* 팔로우 되어있지 않으면 팔로우 버튼이 보이게 */
    									if(<%=bb%>==false) {
           		 							document.getElementById("ufl_btn2<%=follow_i%>").style.display = "none";
           		 							document.getElementById("fl_btn2<%=follow_i%>").style.display = "block";
    									}
    									/* 팔로우 되어있으면 언팔로우 버튼이 보이게 */
    									else {
          		  							document.getElementById("fl_btn2<%=follow_i%>").style.display = "none";
         		  							document.getElementById("ufl_btn2<%=follow_i%>").style.display = "block";
    									}
   		 								</script>
										</div>
									</td>
								</tr>
								<%
									}
									if (follow_i == 0) {
								%>
								<tr>
									<h3>팔로우가 없습니다. 팔로우를 찾아보세요!</h3>
								</tr>
								<% }%>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
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

		<!-- 타임라인 -->
		<div id="container">
			<div class="cont_wrap">
				<%
					// 현재 로그인한 유저의 글이나 현재 유저가 팔로우한 사람의 글을 조회한다.
					String selectBoard = "SELECT * FROM board where mem_id = '" + sID
							+ "' or mem_id in (select follow from bfollow where follower='" + sID + "') order by bd_key DESC";
					ArrayList<Board> listOfBoard = dao.SelectBoard(selectBoard);

					ResultSet rsImg;
					ResultSet rssidLk;
					ResultSet rsCntLK;
					int ci = 0;
					// 조회할 포스트 상자 반복 생성
					for (ci = 0; ci < listOfBoard.size(); ci++) {
						Board obj_bd = listOfBoard.get(ci);
						String memID = obj_bd.getMem_id();
						int bdKey = obj_bd.getBd_key();

						DButil dbsl = new DButil();
						DButil dbsc = new DButil();
						DButil dbsn = new DButil();
						//현재 로그인한 유저가 해당 글을 좋아하는지 알기 위한 SQL
						String selectLkSQL = "SELECT * FROM blike where bd_key = '" + bdKey + "' and mem_id = '" + sID + "'";
						//현재 글의 좋아요 수를 알기 위한 SQL
						String selectthisLK = "SELECT * FROM blike where bd_key = '" + bdKey + "'";

						rssidLk = dbsl.selectSQL(selectLkSQL);
						rsCntLK = dbsc.selectSQL(selectthisLK);
						//현재 글쓴 유저의 이름을 구하기 위한 SQL
						String selNameSQL = "SELECT name FROM member where id = '" + memID + "'";
						ResultSet rs_nm = dbsn.selectSQL(selNameSQL);
						boolean bn = rs_nm.next();
						String memName = rs_nm.getString("name");
				%>

				<div class="content">
					<table class="content_head">
						<tr>
							<td class="post_head_name">
							<form action="AreUSession.jsp" method="post">
								<input type="hidden" name="otherUserID" value="<%=memID%>" /> 
								<input type="hidden" name="otherUserName" value="<%=memName%>" />
								<input type="submit" class="content_nick" value="<%=memID%>" style="padding-top: 11px;" />
							</form></td>
							<td>
							<form action="postEdit.jsp" method="post">
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
						<!-- 좋아요 테이블에 넣을 정보 (bdKey:글번호, sID:현재 좋아요를 한 사람=로그인한 사람) -->
						<input type="hidden" id="bd_key<%=bdKey%>" value="<%=String.valueOf(bdKey)%>" /> 
						<input type="hidden" id="sessionID" value="<%=sID%>" />
					</table>
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
								<%
									}
								%>
								<a class="prev" onclick="plusSlides<%=bdKey%>(-1)">❮</a> 
								<a class="next" onclick="plusSlides<%=bdKey%>(1)">❯</a>
								<div class="dot_wrap">
									<%
										for (ii = 0; ii < imgCount; ii++) {
									%>
									<span class="dot<%=bdKey%> dot" onclick="currentSlide<%=bdKey%>(<%=ii + 1%>)"></span>
									<%
										}
									%>
								</div>
							</div>
						</div>
						<%
							int cntLk = 0;
								while (rsCntLK.next()) {
									cntLk++;
								}
								dbsc.closeConnect();
						%>
						<div class="pic_wrap" id="pic<%=bdKey%>">
							<img src="http://localhost:8181/upload/<%=imagernames.get(0)%>" />
						</div>
					</div>
					<div class="content_cont">
						<p class="cont_in"><%=obj_bd.getBd_cont()%></p>
					</div>
					<div class="content_lnc">
						<table>
							<tr>
								<!-- 해당 bd_key에 대한blike 테이블 열이 있으면 좋아요한 상태, 없으면 안함 -->
								<td><button type="button" id="btnlike_empty<%=bdKey%>" class="content_like" onclick="insertLike<%=bdKey%>()">
										<img src="img/like.png" />
									</button>
									<button type="button" id="btnlike_full<%=bdKey%>" class="content_like" onclick="deleteLike<%=bdKey%>()" style="display: none;">
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
						boolean bIslk = rssidLk.next();
					%>
					<script type="text/javascript" charset="utf-8">
                //좋아요 되어있지 않으면(false) 빈하트, 되어있으면(true) 하트
                	if(<%=bIslk%> == false) {
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
					<%
						dbsl.closeConnect();
					%>
					<!--댓글 입력하기 (!!text input, button의 아이디:뒤에 %=bdKey%로 넣기)-->
					<div class="comment_form">
						<table>
							<tr>
								<td><input type="text" id="comm<%=bdKey%>"
									class="comm_text" /></td>
								<td>
									<button type="button" class="comm_post_btn"
										onclick="insertComm<%=bdKey%>()">게시</button>
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
						포스팅한 글이 없습니다.<br />마음에 드는 사람을 팔로우 해보세요!
					</h3>
				</div>
				<%
					}
				%>
				<div class="side_fixed">
					<div class="side_name_div">
						<p class="p_nicname"><%=sID%></p>
						<p class="p_realname"><%=sName%></p>
					</div>
					<button type="button" class="btn btn-primary btn-lg"
						data-toggle="modal" data-target="#myModal"
						onclick="view_follower()">팔로우 목록</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>