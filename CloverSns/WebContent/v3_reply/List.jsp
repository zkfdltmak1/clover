<%@page import="java.math.RoundingMode"%>
<%@page import="cloverbean.BoardDto"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html;charset=euc-kr" %>
<HTML>
<link href="style.css" rel="stylesheet" type="text/css">
<script>
	function check(){
		if(document.search.keyWord.value == ""){
			alert("검색어를 입력하세요.");
			document.search.keyWord.focus();
			return;
		}
		document.search.submit();
	}


	function list(){
		document.list.action="List.jsp";
		document.list.submit();
	}
	
	function read(param){
		document.read.num.value=param;
		document.read.submit();
	}
</script>
<BODY>
<center><br>
<h2>문의 게시판</h2>
<jsp:useBean id="dao" class="cloverbean.BoardDao" />
<%!
	public String getParam(HttpServletRequest req, String pName){
		if(req.getParameter("keyWord") != null){
			return req.getParameter("keyWord");
		}
		else
			return "";
	}

	// paging에 필요한 변수
	int totalRecord = 0; // 전체 글의 갯수
	int numPerPage = 5; // 한 페이지당 보여질 글의 갯수
	int pagePerBlock = 3; // 한 블럭당 페이지 수
	int totalPage = 0; // 전체 페이지 수
	int totalBlock = 0; // 전체 블럭 수
	int nowPage = 0; // 현재 페이지 번호
	int nowBlock = 0; // 현재 블럭 번호
	int beginPerPage = 0; // 페이지당 시작 번호
%>
<%
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");

	if(keyField == null)
		keyField = "name";
	
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){
			keyWord = "";
		}
	}


	Vector list = dao.getBoardList(keyField, keyWord);
	
	totalRecord = list.size();
	totalPage = (int)(Math.ceil((double)totalRecord/numPerPage));
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	if(request.getParameter("nowBlock") != null){
		nowBlock = Integer.parseInt(request.getParameter("nowBlock"));
	}
	beginPerPage = nowPage * numPerPage;
	totalBlock = (int)(Math.ceil((double)totalPage/pagePerBlock));
%>
<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  <%=list.size()%> Articles(
		<font color=red>  <%= nowPage+1 %> / <%= totalPage %> Pages </font>)
	</td>
</tr>
</table>


<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td><input type="checkbox" name="chk1" /></td>
				<td width="10%"> 번호 </td>
				<td widht="40%"> 제목 </td>
				<td width="20%"> 이름 </td>
				<td width="20%"> 날짜 </td>
				<td width="10%"> 조회수 </td>
			</tr>		
			<% if(list.isEmpty()){ %>
					<b>등록된 글이 없습니다.</b>
			<%
				}
				else{
					for(int i=beginPerPage; i<beginPerPage+numPerPage; i++){
						if(i == totalRecord){
							break;
						}
						BoardDto dto = (BoardDto)list.get(i);
			%>
			<tr align="left">
				<td><center><input type="checkbox" name="chk2"/></center></td>
				<td><%=dto.getNum()%></td>
				<td><%=dao.useDepth(dto.getDepth())%>
				<% if(dto.getDepth() > 0){ %>
						<img alt="" src="../image/re.gif">
				<% } %><a href="javascript:read('<%= dto.getNum() %>')"><%= dto.getSubject() %></td>
				<td><a href="mailto:<%= dto.getEmail() %>"><%= dto.getName() %></td>
				<td><%=dto.getRegdate()%></td>
				<td><%=dto.getCount()%></td>
			</tr>
			<%
					}
				}
			%>
		</table>
	</td>
</tr>
<tr><td></td></tr>
<tr>
	<td align="center">go to page
			<%
				if(nowBlock != 0){
			%>
					<a href="List.jsp?nowBlock=<%= nowBlock-1 %>&nowPage=<%= pagePerBlock*(nowBlock-1) %>">이전</a>
			<%
				}
		 		for(int i=0; i<pagePerBlock; i++){
			%>
					<a href="List.jsp?nowBlock=<%= nowBlock %>&nowPage=<%= (nowBlock*pagePerBlock) + i %>">
					<%= (nowBlock*pagePerBlock) + i + 1 %>&nbsp;
					</a>
			<%
				}
				if(totalBlock > nowBlock+1){
			%>
					<a href="List.jsp?nowBlock=<%= nowBlock+1 %>&nowPage=<%= pagePerBlock*(nowBlock+1) %>">다음</td>
			<%
				}
			%>
	<td align=right>
		<a href="Post.jsp">[글쓰기]</a>
		<a href="javascript:list()">[처음으로]</a>
	</td>
</tr>
</table>
<BR>
<form action="List.jsp" name="search" method="post">
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="name" /> 이름
				<option value="subject" /> 제목
				<option value="content" /> 내용
			</select>


			<input type="text" size="16" name="keyWord" value='<%= getParam(request, "keyWord") %>' />
			<input type="button" value="찾기" onClick="check()" />
			<input type="hidden" name="page" value= "0" />
		</td>
	</tr>
	</table>
</form>
<form name="list" method="post">
	<input type="hidden" name="reload" value="true" />
</form>

<form name="read" method="post" action="Read.jsp">
	 <input type="hidden" name="num" />
	 <input type="hidden" name="keyField" value="<%= keyField %>" />
	 <input type="hidden" name="keyWord" value="<%= keyWord %>" />
</form>

</center>	
</BODY>
</HTML>
