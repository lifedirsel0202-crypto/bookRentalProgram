<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.Format"%>
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
<a href ="bookList.jsp">도서조회</a>
<a href ="rentalForm.jsp">대여등록</a>
<a href ="rentalList.jsp">대여내역조회</a>
<a href ="rentalStats.jsp">분류별대여통계</a>
<a href ="index.jsp">홈으로</a>
</nav>
<section class="container">
<div class= "infoBox">
<h1>대여내역조회</h1>
<hr>
<p> 등록된 대여내역을 조회합니다.</p>
</div>

<table class= "tableBox">
<thead>
<tr>
<th>대여일자</th>
<th>대여번호</th>
<th>도서명</th>
<th>분류명</th>
<th>대여일수</th>
<th>1일 대여료</th>
<th>대여요금</th>
<th>대여자명</th>
</tr>
</thead>
<%
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	Statement stmt =null;
	ResultSet rs = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/HRD_20261110","root","admin");
		String sql = "select tr.rent_date 대여일자, tr.rent_no 대여번호, tb.book_name 도서명, tbc.cat_name 분류명, tr.rent_days 대여일수,"
				+" tb.daily_fee 1일대여료,sum(tr.rent_days*tb.daily_fee) 대여요금, tr.borrower_name 대여자명"
				+" from tbl_rental tr left outer join tbl_book tb on tr.book_code = tb.book_code"
				+" left outer join tbl_book_category tbc on tbc.cat_code = tb.cat_code"
				+" group by tr.rent_date,tr.rent_no";
		
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		DecimalFormat df = new DecimalFormat("￦#,###");
		
		SimpleDateFormat osdf = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat nsdf = new SimpleDateFormat("yyyy년MM월dd일");
		
		while(rs.next()){
			
			int f = rs.getInt("1일대여료");
			String fee = df.format(f);
			int tf = rs.getInt("대여요금");
			String totalFee = df.format(tf);
			
			String dd = rs.getString("대여일자");
			String date = nsdf.format(osdf.parse(dd));
				
	%>
	<tbody>
<tr>
       <td class= "c"><%= date%></td>
       <td class= "l"><%=rs.getString(2) %></td>
       <td class= "c"><%=rs.getString(3) %></td>
       <td class= "c"><%=rs.getString(4) %></td>
       <td class= "c"><%=rs.getInt(5) %></td>
       <td class= "c"><%=fee%></td>
       <td class= "c"><%=totalFee%></td>
       <td class= "c"><%=rs.getString(8) %></td>
</tr>
</tbody>
<%
			}
					} catch (Exception e) {e.printStackTrace();
					
							} finally {
								if (rs != null) {rs.close();}
								if (stmt != null) {stmt.close();}
								if (conn != null) {conn.close();}
									}
%>
</table>
</section>
<footer>
도서 대여관리 프로그램 · 실기 연습용 예시화면
</footer>

</body>
</html>