<%@page import="cloverbean.BoardDto"%>
<%@page import="cloverbean.BoardDao"%>
<%@ page contentType="text/html; charset=EUC-KR" %>
<%
	request.setCharacterEncoding("euc-kr");
%>
<jsp:useBean id="dao" class="cloverbean.BoardDao" />
<jsp:useBean id="dto" class="cloverbean.BoardDto" />
<jsp:setProperty property="*" name="dto" />

<%
	int num = Integer.parseInt(request.getParameter("num"));

	BoardDto parent = dao.getBoard(num);
	dao.replyUpdatePos(parent);
	
	dto.setPos(parent.getPos());
	dto.setDepth(parent.getDepth());
	dao.replyBoard(dto);
	
	
	response.sendRedirect("List.jsp");
%>