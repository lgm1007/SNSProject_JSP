<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% if (session.getAttribute("id") != null) { %>
	<jsp:forward page="main_page.jsp"></jsp:forward>
<% } %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to SOL</title>
<style>
	* {
    padding:0;
    margin:0;
    font-size:100%;
    font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
}
li{list-style:none;}
a{text-decoration-line:none;}
img{max-width: 100%; height: auto;}

#container {
    padding:0;
    width:100%;
    height:100%;
    text-align:center;
}
.ul_cont { overflow:hidden; }
.ul_cont li { float:left; }
.background{
    width:659px;
    height:750px;
    box-sizing:border-box;
}
.log_in_cont{
    width:300px;
    height:750px;
    position:relative;
    box-sizing:border-box;
}
.log_in_box{
    width:90%;
    margin:auto 0;
    text-align:center;
    padding:3.3% 21.6%;
    top:20%;
    left:20%;
    z-index:2;
    border:1px solid #bebebe;
    border-radius:3px;
    position:absolute;
}
.log_in_box input[type=text] {
    color:#908d8d;
    width:83.3%;
    height:30px;
    font-size:11px;
    margin:0 auto;
    margin-top:20px;
}
.log_in_box input[type=password] {
    color:#908d8d;
    width:83.3%;
     height:30px;
    font-size:11px;
    margin:4px auto;
}

a {
    -webkit-transition: all 200ms;
    -moz-transition: all 200ms;
    -ms-transition: all 200ms;
    -o-transition: all 200ms;
    transition: all 200ms;
    display: block;
    margin: 20px auto;
    max-width: 180px;
    text-decoration: none;
    border-radius: 4px;
    padding: 5px 0px;
}

.btn_wrap .sign_btn {
    width: 80%;
}

input[type=submit] {
    border-style: none;
    width: 80%;
    cursor:pointer;
    -webkit-transition: all 200ms;
    -moz-transition: all 200ms;
    -ms-transition: all 200ms;
    -o-transition: all 200ms;
    transition: all 200ms;
    display: block;
    margin: 20px auto;
    max-width: 180px;
    text-decoration: none;
    border-radius: 4px;
    padding: 5px 0px;
}

.login_btn, .sign_btn {
    color:white;
    background-color: #3897f0;
    font-weight:bold;
}
.login_btn:hover, .sign_btn:hover{
    box-shadow: 0px 0px 0px 40px #163c60 inset;
}
</style>
</head>
<body>
	<div id="container">
        <ul class="ul_cont">
            <li>
                <div class="background">
                    <img src="img/background_page.png" style="max-width: 100%; height: 100%;"/>
                </div>
            </li>
            <li>
                <div class="log_in_cont">
                    <div class="log_in_box">
                        <img class="logo" src="img/sol_logo_128pix.png" alt="logo" /><br />
                        <form action="login_check.jsp" method="post" id="login_form">
                            <input type="text" name="id" placeholder="아이디" /><br />
                            <input type="password" name="pw" placeholder="비밀번호" /><br />
                            <input type="submit" class="login_btn" value="로그인" />
                        </form>
                        <div class="btn_wrap">
                            <a href="join_page.jsp" class="sign_btn">회원가입</a>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>