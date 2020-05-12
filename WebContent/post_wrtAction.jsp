<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="db.DButil" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title></title>
</head>
<body>
<%!
	String sID;
	int bd_key;
%>
<%
	DButil dbsi = new DButil();
	/*path:파일 저장될 실제 경로, maxSize: 최대크기 (10MB)*/
	String path = "C:/Workspace/upload/";
	int maxSize = 1024 * 1024 * 10;

	MultipartRequest multipartRequest = new MultipartRequest(request, path, maxSize, "utf-8", new DefaultFileRenamePolicy());
	

	//board테이블의 키값 구하는 부분
	String getBoardSQL = "select bd_key from board ORDER BY bd_key DESC";
	ResultSet brs = dbsi.selectSQL(getBoardSQL);
	boolean b1 = brs.next();
	// b1==false 라면 아직 글이 작성되지 않은 상태
	if(b1 == false){
		bd_key = 1;
	} else {
		bd_key = brs.getInt("bd_key") + 1;
	}
	
	// board테이블에 데이터 입력하는 부분
	//sID:현재 로그인한 유저 = 글쓴이, content: 내용
	sID = (String)session.getAttribute("id");
	String content = multipartRequest.getParameter("content");
	String insertBoardSQL = "insert into board values('"+ bd_key +"','"+ sID +"','"+ content +"')";
	
	int bi = dbsi.setSQL(insertBoardSQL);
	if(bi == 0) {
%>
		<script type="text/javascript" charset="utf-8">
			alert("글 포스팅에 실패했습니다. (DB에러)");
			document.location.href="main_page.jsp";
		</script>
<% }

// 파일 입력 받는 부분
	Enumeration fileNames = multipartRequest.getFileNames();
	while(fileNames.hasMoreElements()) {
		/*fileName:사용자가 업로드한 파일이름, fileRealName: 실제로 서버에 업로드된 파일이름*/
		String fileLists = (String)fileNames.nextElement();
		String fileName = multipartRequest.getOriginalFileName(fileLists);
		String fileRealName = multipartRequest.getFilesystemName(fileLists);
		
		if(fileName == null) continue;
		
		String fileInsertSQL = "insert into images values('"+ bd_key +"','"+ fileName +"','"+ fileRealName +"')";
		int fi = dbsi.setSQL(fileInsertSQL);
		if(fi == 0) {
%>
			<script type="text/javascript" charset="utf-8">
				alert("파일 업로드에 실패했습니다. (DB에러)");
				document.location.href="main_page.jsp";
			</script>
<% 	
		} 
	}
	/* 사진을 업로드하지 않을 경우 처리부분 */
	String imgChkSQL = "SELECT * from images where bd_key='"+ bd_key +"'";
	ResultSet imgChkRS = dbsi.selectSQL(imgChkSQL);
	boolean imgb = imgChkRS.next();
	if(imgb == false) {
%>
		<script type="text/javascript" charset="utf-8">
			alert("사진을 업로드하지 않았습니다");
			document.location.href="main_page.jsp";
		</script>
<%		
		String delBoard = "delete from board where bd_key='"+ bd_key +"'";
		dbsi.setSQL(delBoard);
	} else {
%>
		<script type="text/javascript" charset="utf-8">
			alert("Posting!");
			document.location.href="main_page.jsp";
		</script>

<% 
	}
	dbsi.closeConnect();
%>
</body>
</html>