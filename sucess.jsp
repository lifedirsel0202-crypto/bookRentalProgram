<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement checkRentalDate = null;
	ResultSet rs =null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/HRD_20261109","root","admin");
		String checkSql= "select count(*) from tbl_rental where rent_no = ?";
		checkRentalDate = conn.prepareStatement(checkSql);	
		checkRentalDate.setString(1, request.getParameter("rentalNo"));
		rs= checkRentalDate.executeQuery();
		
		rs.next();
		
		int count= rs.getInt(1);
		
		if(count>0){
			out.println("<script>alert('이미 등록된 대여번호입니다.'); history.back(); </script>");
		}else{
			String sql= "insert into tbl_rental values(?,?,?,?,?)";
			pstmt= conn.prepareStatement(sql);
			
			pstmt.setString(1,request.getParameter("rentalNo"));
			pstmt.setString(2,request.getParameter("rentalDate"));
			pstmt.setString(3,request.getParameter("bookCode"));
			pstmt.setInt(4, Integer.parseInt(request.getParameter("rentalDays")));
			pstmt.setString(5,request.getParameter("borrowerName"));
			pstmt.executeUpdate();
			
			response.sendRedirect("index.jsp");
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if (rs != null){
			rs.close();
		}
		if (checkRentalDate != null){
			checkRentalDate.close();
		}
		if (pstmt != null){
			pstmt.close();
		}
		if (conn != null){
			conn.close();
		}
		
		
	}

%>
</body>
</html>