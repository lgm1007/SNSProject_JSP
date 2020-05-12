<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Regi-Out</title>
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
            height: 450px;
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
        
        input[type=text] {
            color: #908d8d;
            font-size: 11px;
        }
        input[type=password] {
            color: #908d8d;
            font-size:11px;
            width:300px;
            height:30px;
            text-align:center;
            margin-top:10px;
            margin-left:auto;
            margin-right:auto;
        }
       
        input[type=submit], input[type=reset] {
            margin-top: 20px;
            margin-left:auto;
            margin-right:auto;
            background-color: #fafafa;
            font-size: 16px;
            font-weight: bold;
            border-style: none;
            border-radius: 4px;
            border: 0.5px solid #e8e8e8;
            padding: 4px 10px 4px 10px;
            cursor: pointer;
        }
        
        input[type=submit]:hover, input[type=reset]:hover, .go_out:hover {
            border:0.5px solid #000000;
        }
</style>
</head>
<body>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="js/bootstrap.js"></script>
    <script src="Search.js" type="text/javascript"></script>
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
    
        <div id="div_wrap">
        <div id="form_wrap">
            <form class="formtag" action="regOut_action.jsp" method="post" name="formtag">
                <h4><b>회원탈퇴를 위해 비밀번호를 확인합니다.</b></h4>
                <input type="password" placeholder="비밀번호를 입력하세요" name="re_pw" /><br/>
                <input type="password" placeholder="비밀번호를 재입력하세요" name="re_pwchk" /><br/>
                <input type="submit" value="입력" /> <input type="reset" value="취소" /> 
            </form>
        </div>
    </div>
</body>
</html>