<%@page import="db.DButil"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%!
	String sName;
	String sID;
	String opw;
	String otel2;
	String otel3;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>프로필 편집</title>
<link rel="stylesheet" href="css/bootstrap.css" />
<style type="text/css">
	    body {
            padding: 0;
            margin: 0;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
            background-color:#fafafa;
        }

        li {  list-style: none; }

        a {  text-decoration: none; }

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
        /* 글쓰기 폼 */
        #div_wrap {
            width:100%;
            height:1000px;
            background-color:#fafafa;
            
        }
        #form_wrap {
            position:relative;
            margin-left:auto;
            margin-right:auto;
            width:50%;
            height: 500px;
            top:10%;
            border:0.5px solid #e8e8e8;
            background-color:white;
        }
        .formtag {
            position:relative;
            top:10%;
            left:20%;
            font-size:1.2em;
        }
        .modify_inf {
            font-size:1.5em;
            font-weight:bold;
            margin-bottom:8%;
            margin-left:15%;
        }
        input[type=text] {
            color: #908d8d;
            font-size: 11px;
            text-align:center;
        }
        input[type=password] {
            color: #908d8d;
            font-size:11px;
            width:200px;
            height:30px;
            text-align:center;
        }
        input[name=update_pw] {
            margin-left: 6%;
        }
        input[name=update_pw_chk] {
            margin-left: 2%;
        }
        .update_name {
            margin-left: 10%;
            width: 200px;
            height: 30px;
        }
        .tel {
            color: #908d8d;
            font-size: 11px;
            height:30px;
            
        }
        input[type=submit], input[type=reset] {
            margin-top: 5%;
            background-color: #fafafa;
            font-size: 16px;
            font-weight: bold;
            border-style: none;
            border-radius: 4px;
            border: 0.5px solid #e8e8e8;
            padding: 4px 10px 4px 10px;
            cursor: pointer;
        }
        .go_out {
            margin-top: 2%;
            background-color: #fafafa;
            font-size: 16px;
            font-weight: bold;
            border: 0.5px solid #e8e8e8;
            border-radius: 4px;
            padding: 5px 10px;
            cursor: pointer;
        }
        input[type=submit]:hover, input[type=reset]:hover, .go_out:hover {
            border:0.5px solid #000000;
        }
</style>
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" ></script>
    <script src="js/bootstrap.js"></script>
    <script src="Search.js" type="text/javascript"></script>
    <script type="text/javascript" src="useredit.js" charset="utf-8"></script>
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
    
    <div id="div_wrap">
        <div id="form_wrap">
            <form action="user_edit_action.jsp" class="formtag" method="post" name="formtag">
                <!-- 텍스트창이 비어있으면 원래의 값으로 Update-->
                <h4 class="modify_inf">회원정보 변경</h4>
                이름: <input type="text" class="update_name" name="update_name" placeholder="변경된 이름을 입력해주세요" /><br /><br />
                비밀번호: <input type="password" name="update_pw" placeholder="변경할 비밀번호를 입력해주세요" /><br/><br/>
                비밀번호확인: <input type="password" name="update_pw_chk" placeholder="변경할 비밀번호 확인" /><br /><br />
                휴대폰 번호:
                <select name="tel1" class="tel">
                    <option value="010" selected>010</option>
                    <option value="011">011</option>
                    <option value="016">016</option>
                    <option value="017">017</option>
                    <option value="019">019</option>
                </select>
                 - <input type="text" class="tel" name="tel2" placeholder="휴대폰번호 2"/> - <input type="text" class="tel" name="tel3" placeholder="휴대폰번호 3"/>
                <br />
                <input type="submit" value="수정" /> <input type="reset" value="취소" /> <br/><br />
                <a href="regOut_page.jsp" class="go_out">탈퇴하기</a>
            </form>
        </div>
    </div>

</body>
</html>