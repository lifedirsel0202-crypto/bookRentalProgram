<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<header>
도서 대여관리 프로그램
</header>
<nav>
<a href="bookList.jsp">도서조회</a>
<a href="retalForm.jsp">대여등록</a>
<a href="rentalList.jsp">대여내역조회</a>
<a href="categoryStats.jsp">분류별대여통계</a>
<a href="index.jsp">홈으로</a>
</nav>
<section class="container">

<h1>도서 대여관리 프로그램</h1>
<hr>
<p>등록된 자료를 조회합니다.</p>
<table class= "tableBox">
<thead>
<tr>
<th>도서코드</th>
<th>도서명</th>
<th>분류명</th>
<th>1일대여료</th>
</tr>
</thead>
<tbody>
<%
	request.setCharacterEncoding("utf-8");
	Connection conn= null;
	Statement stmt = null;
	ResultSet rs= null;
	
	try{
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HRD_20261109","root","admin");
	String sql = "select tb.book_code 도서코드, tb.book_name 도서명, tbc.cat_name 분류명, tb.daily_ree"
			+" from tbl_book tb left outer join tbl_book_category tbc on tb.cat_code= tbc.cat_code";
	stmt= conn.createStatement();
			
	rs= stmt.executeQuery(sql);
	DecimalFormat df = new DecimalFormat("￦#,###");
	
	while(rs.next()){
		
		int dFee=rs.getInt("daily_ree");
		String dailyFee = df.format(dFee);
		
	%>
	<tr>
	<td class= "c"><%=rs.getString(1) %></td>
	<td class= "l"><%=rs.getString(2) %></td>
	<td class= "c"><%=rs.getString(3) %></td>
	<td class= "r"><%=dailyFee %></td>
	</tr>
<%	}
	}catch(Exception e){
	
	}
	%>
</tbody>

</table>

</section>
<footer>
도서 대여관리 프로그램·실기 연습용 예시 화면
</footer>
</body>
</html>