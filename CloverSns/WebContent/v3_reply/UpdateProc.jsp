<%@page import="cloverbean.BoardDao"%>
<%@page import="cloverbean.BoardDto"%>
<%@ page contentType="text/html; charset=EUC-KR"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	String pass1 = request.getParameter("pass");
	BoardDao dao = new BoardDao();
	BoardDto dto = dao.getBoard(num);
	
	if(pass1.equals(dto.getPass())){
		BoardDto dto2 = new BoardDto();
		dto2.setName(request.getParameter("name"));
		dto2.setEmail(request.getParameter("email"));
		dto2.setSubject(request.getParameter("subject"));
		dto2.setContent(request.getParameter("content"));
		dto2.setNum(num);
		
		dao.updateBoard(dto2);
		response.sendRedirect("List.jsp");
	}
	else{
%>
	<script>
		alert("패스워드가 맞지 않습니다.");
		history.back();
	</script>
<%
	}
%>