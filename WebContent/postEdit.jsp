<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>postEdit</title>
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
            top:25%;
            left:10%;
            font-size:1.2em;
        }
       
        .inf_content {
            margin-bottom:-3%;
        }
        .textarea {
            margin-left:10%;
            border:1px solid #e8e8e8;
            color:#808080;
        }
        .btns {
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
        .btns:hover {
            border:0.5px solid #000000;
        }
        .btn_delete {
            margin-top:125px;
            margin-left:70px;
        }
</style>
</head>
<%!
	String sID;
	String sName;
	int bdKey;
%>
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
		bdKey = Integer.parseInt(request.getParameter("bdEditKey"));
    %>
    <script type="text/javascript" charset="utf-8">
    	var ok;
    	function selectDel() {
    		ok = confirm("포스트를 삭제하겠습니까?");
    		if (ok) {
    			document.post_del_frm.submit();
    		}
    	}
    </script>
    
    <div id="div_wrap">
        <div id="form_wrap">
            <form class="formtag" action="post_editAction.jsp" method="post" name="formtag">
                <table>
                    <tr>
                        <td><h3>포스트 수정 / 삭제</h3></td>
                    </tr>
                </table>
                <input type="hidden" name="postEditKey" value="<%=bdKey%>" />
                <p class="inf_content">내용</p> <textarea cols="50" rows="4" class="textarea" name="content" placeholder="최대 200자까지 입력할 수 있습니다" ></textarea>
                <br />
                <br />
                <input type="submit" class="btns" value="수정" /> <input type="reset" class="btns" value="취소" />
            </form>
            <br/>
            <button type="button" class="btns btn_delete" onclick="selectDel()">글 삭제</button>
            <form action="postDelete.jsp" method="post" name="post_del_frm">
            	<input type="hidden" name="postDelKey" value="<%=bdKey%>" />
            </form>
        </div>
    </div>
    
</body>
</html>