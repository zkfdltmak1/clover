<%@ page contentType="text/html; charset=EUC-KR"%>

<jsp:useBean id="dao" class="cloverbean.BoardDao" />
<jsp:useBean id="dto" class="cloverbean.BoardDto" />
<jsp:setProperty property="*" name="dto" />
<%
	request.setCharacterEncoding("euc-kr");
	
	// setter �޼��� 12���� ȣ���ϴ���
	dao.insertBoard(dto);
	response.sendRedirect("List.jsp");
%>