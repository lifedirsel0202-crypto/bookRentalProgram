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
<h1>분류별대여통계</h1>
<hr>
<p> 항목별 건수와 합계를 조회합니다.</p>
</div>

<table class= "tableBox">
<thead>
<tr>
<th>분류코드</th>
<th>분류명</th>
<th>대여건수</th>
<th>총대여일수</th>
<th>총대여금액</th>
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
		String sql = "select tbc.cat_code 분류코드, tbc.cat_name 분류명, count(tr.rent_days)대여건수, sum(tr.rent_days)총대여일수,"
					+" sum(tr.rent_days*tb.daily_fee) 총대여금액"
					+" from tbl_book_category tbc left outer join tbl_book tb on tbc.cat_code = tb.cat_code"
					+" left outer join tbl_rental tr on tb.book_code = tr.book_code"
					+" group by tbc.cat_code,tbc.cat_name with rollup";
		
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
		
			DecimalFormat df = new DecimalFormat("￦#,###");
		
		
		
		while(rs.next()){
			
			int f = rs.getInt("총대여금액");
			String fee = df.format(f);
			
			 if(rs.getString("분류코드")== null && rs.getString("분류명")== null){
			 %>
	<tfoot>
<tr>
       <td class= "c">총합</td>
       <td class= ""></td>
       <td class= "c"><%=rs.getInt(3) %></td>
       <td class= "c"><%=rs.getInt(4) %></td>
       <td class= "r"><%=fee%></td>
</tr>
</tfoot>
<%
			}else if(rs.getString("분류코드")!= null && rs.getString("분류명") != null){
				%>
				<tbody>
				<tr>
			<td class= "c"><%=rs.getString(1) %></td>
			<td class= "l"><%=rs.getString(2) %></td>
			<td class= "c"><%=rs.getInt(3) %></td>
			<td class= "c"><%=rs.getInt(3) %></td>
			<td class= "r"><%=fee %></td>
			</tr>
				<%
			}
					} 
		}catch (Exception e) {e.printStackTrace();
					
							} finally {
								if (rs != null) {rs.close();}
								if (stmt != null) {stmt.close();}
								if (conn != null) {conn.close();}
									}
%>
			</tbody>
</table>
</section>
<footer>
도서 대여관리 프로그램 · 실기 연습용 예시화면
</footer>

</body>
</html>