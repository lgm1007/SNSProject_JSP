<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%!
	String sID;
	String sName;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 작성</title>
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
        .inf_pic_wrap {
            width:200px;
        }
        .inf_pic {
            margin-bottom: 20px;
        }
        .inf_content {
            margin-bottom:-3%;
        }
        
        .add_btn, .del_btn {
            cursor:pointer;
            border-style:none;
            background:none;
            width:80px;
            font-size:13px;
            font-weight:bold;
            padding:4px 10px;
            border:0.5px solid #e8e8e8;
            border-radius:4px;
            margin-bottom: 20px;
            margin-left: 7px;
            margin-right: 7px;
        }
        .add_btn:hover , .del_btn:hover {
            border:0.5px solid #000000;
        }
        #fileArea { margin-bottom:7px; }
        .upfile {
            margin-left: 5px;
        }
        .upfile::-webkit-file-upload-button {
            background-color:#fafafa;
            font-size:1.1em;
            font-weight:bold;
            border-style:none;
            border-radius:4px;
            border:0.5px solid #e8e8e8;
            padding:4px 10px 4px 10px;
            cursor: pointer;   
        }
        .upfile::-webkit-file-upload-button:hover {
            border:0.5px solid #000000;
        }
        .upfile_info {
            margin-top:5px;
            margin-bottom:5%;
            font-size:12px;
            color:#808080;
        }
        .textarea {
            margin-left:10%;
            border:1px solid #e8e8e8;
            color:#808080;
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
        input[type=submit]:hover, input[type=reset]:hover {
            border:0.5px solid #000000;
        }
</style>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="js/bootstrap.js"></script>
    <script type="text/javascript" src="Search.js" charset="utf-8"></script>
    <script type="text/javascript">
        var count = 2;

        function addFileInput() {
            if(count <= 3) {
                var element = document.createElement("input");
                element.type = "file";
                element.name = "upfile" + count;
                element.accept = "image/jpeg, image/png, image/gif";
                element.className = "upfile";
                count++;
            
                document.getElementById("fileArea").appendChild(document.createElement("br"));
                document.getElementById("fileArea").appendChild(element);
            } else {
                alert("파일은 3개까지 추가할 수 있습니다");
            }
        }

        function deleteFileInput() {
            if (count > 2) {
                count--;
                var input = document.getElementById("fileArea").getElementsByTagName('input');
                var brArr = document.getElementById("fileArea").getElementsByTagName('br');

                document.getElementById("fileArea").removeChild(input[input.length - 1]);
                document.getElementById("fileArea").removeChild(brArr[brArr.length - 1]);
            } else {
                alert("최소 1개 이상의 파일은 업로드해야 합니다");
            }
        }
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
 	sID = (String)session.getAttribute("id");
	sName = (String)session.getAttribute("name");
 %>
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
            <form class="formtag" action="post_wrtAction.jsp" method="post" enctype="multipart/form-data">
                <table>
                    <tr>
                        <td class="inf_pic_wrap" ><p class="inf_pic">사진</p></td>
                        <td><button type="button" id="add_btn" class="add_btn" onclick="addFileInput()">파일추가</button><button type="button" id="del_btn" class="del_btn" onclick="deleteFileInput()">파일제거</button></td>
                    </tr>
                </table>
                <div id="fileArea">
                    <input type="file" class="upfile" name="upfile1" accept="image/jpeg, image/png, image/gif" />
                </div>
                <p class="upfile_info">< 10MB이상 크기의 사진은 올릴 수 없습니다. 파일은 3개까지 올릴 수 있습니다. ></p>
                <p class="inf_content">내용</p>   
                <textarea cols="50" rows="4" class="textarea" placeholder="최대 200자까지 입력할 수 있습니다" name="content"></textarea>
                <br />
                <br />
                <input type="submit" value="글쓰기" /> <input type="reset" value="취소" />
            </form>
        </div>
    </div>
</body>
</html>