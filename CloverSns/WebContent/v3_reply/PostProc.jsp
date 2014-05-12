<%@ page contentType="text/html; charset=EUC-KR"%>

<jsp:useBean id="dao" class="cloverbean.BoardDao" />
<jsp:useBean id="dto" class="cloverbean.BoardDto" />
<jsp:setProperty property="*" name="dto" />
<%
	request.setCharacterEncoding("euc-kr");
	
	// setter 메서드 12개를 호출하던가
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>