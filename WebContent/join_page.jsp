<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" charset="utf-8">
<title>회원가입</title>
<style>
	* {
            padding: 0;
            margin: 0;
            font-size: 100%;
            font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
        }

        li { list-style: none; }
        a { text-decoration-line: none; }
        #container {
            padding: 0;
            width: 1500px;
            height: 100%;
            text-align: center;
        }
        .ul_cont { overflow:hidden; }
        .ul_cont li { float:left; }
        .background {
            width: 659px;
            height: 750px;
            box-sizing: border-box;
        }
        .create_cont {
            width: 300px;
            height: 750px;
            position: relative;
            box-sizing: border-box;
        }
        .create_box {
            width: 270px;
            margin: auto 0;
            text-align: center;
            padding: 10px 65px;
            top: 20%;
            left: 20%;
            z-index: 2;
            border: 1px solid #bebebe;
            border-radius: 3px;
            position: absolute;
        }
        .create_box input[type=text] {
            color: #908d8d;
            width: 250px;
            height: 30px;
            font-size: 11px;
            margin: 4px 10px;
            margin-top: 20px;
        }
        .create_box input[type=password] {
            color: #908d8d;
            width: 250px;
            height: 30px;
            font-size: 11px;
            margin: 4px 10px;
        }
        .create_box input[name=name] {
            margin-top:0px;
        }
        .create_box input[type=tel] {
            color: #908d8d;
            width:75px;
            height: 30px;
            font-size: 11px;
            margin: 4px 0px;
        }

        .create_box select {
            color: #908d8d;
            width:75px;
            height: 30px;
            font-size: 11px;
            margin: 4px 0px;
        }
        input[type=submit]{
            outline-style:none;
            border-style:none;
        }
        .join_btn {
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
            padding: 5px 45px;
        }
        .join_btn {
            color: white;
            background-color: #3897f0;
            font-weight: bold;
            cursor:pointer;
        }
        .join_btn:hover{
              box-shadow: 0px 0px 0px 40px #163c60 inset;
        }
</style>
<script type="text/javascript" src="memjs.js" charset="utf-8"></script>
</head>
<body>
	    <div id="container">
        <ul class="ul_cont">
            <li>
                <div class="background">
                    <img src="img/background_page.png" style="width:659px; height:750px " />
                </div>
            </li>
            <li>
                <div class="create_cont">
                    <div class="create_box">
                        <img class="logo" src="img/sol_logo_128pix.png" alt="logo" /><br />
                        
                        <form action="joinOk.jsp" method="post" name="reg_frm" >
                         <input type="text" name="id" placeholder="아이디" /><br />
                         <input type="password" name="pw" placeholder="비밀번호" /><br />
                         <input type="password" name="pw_chk" placeholder="비밀번호확인" /><br />
                         <input type="text" name="name" placeholder="이름" /><br />
                         <select name="tel1">
                             <option value="010" selected>010</option>
                             <option value="011">011</option>
                             <option value="016">016</option>
                             <option value="017">017</option>
                             <option value="019">019</option>
                         </select> 
                            - <input type="tel" name="tel2" placeholder="전화번호2" /> - <input type="tel" name="tel3" placeholder="전화번호3" /><br/>
                         <input type="button" onclick="infoConfirm()" class="join_btn" value="가입하기" />
                        </form>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</body>
</html>