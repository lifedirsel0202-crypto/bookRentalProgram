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
<form action="sucess.jsp" method="post" onsubmit="return checkSubmit()">
<h1>대여등록</h1>
<hr>
<p>아래 항목을 입력한 후 등록 버튼을 클릭하십시오.</p>
<table class= "tableBox">
<tbody>
<tr>
<th class= "l">대여번호</th>
<td><input type="text" name = "rentalNo" id ="rentalNo" placeholder="예:R0009"></td>
</tr>
<tr>
<th class= "l">대여일자</th>
<td><input type="text" name = "rentalDate" id ="rentalDate" placeholder="20261026"></td>
</tr>
<tr>
<th class= "l">도서코드</th>
<td><select name= "bookCode" id="bookCode">
<option value="">--선택하세요--</option>
<option value="B1001">B1001-바람의정원</option>
<option value="B1002">B1002-별빛 서점</option>
<option value="B2001">B2001-작은 습관의 힘</option>
<option value="B2002">B2002-생각 정리 노트</option>
<option value="B3001">B3001-자바 웹 기초</option>
</select></td>
</tr>
<tr>
<th class= "l">대여일수</th>
<td><input type="text" name = "rentalDays" id ="rentalDays" placeholder="1~14일 사이의 정소를 입력하세요."></td>
</tr>
<tr>
<th class= "l">대여자명</th>
<td><input type="text" name = "borrowerName" id ="borrowerName" placeholder="이름을 입력하세요."></td>
</tr>
</tbody>
</table>
<div class="groupBtn">
<button type= "submit" class="subBtn">대여등록</button>
<button type= "reset" class="reBtn" onclick="resetBtn()">다시쓰기</button>
</div>
</form>
</section>
<footer>
도서 대여관리 프로그램·실기 연습용 예시 화면
</footer>
<script>
	function checkSubmit(){
		let rentalNo = document.querySelector("#rentalNo").value;
		let rentalDate = document.querySelector("#rentalDate").value;
		let bookCode = document.querySelector("#bookCode").value;
		let rentalDays = document.querySelector("#rentalDays").value;
		let borrowerName = document.querySelector("#borrowerName").value;
	
		
		
		if (rentalNo ==""){
			alert("대여번호가 입력되지 않았습니다.");
			document.querySelector("#rentalNo").focus();
			return false;
		}
		
		if (rentalDate ==""){
			alert("대여일자가 입력되지 않았습니다.");
			document.querySelector("#rentalDate").focus();
			return false;
		} else if(rentalDate.length !=8 || isNaN(rentalDate)){
			alert("대여일자를 YYYYDDMM 형식으로 입력하세요!");
			document.querySelector("#rentalDate").focus();
			return false;
		}
		if (bookCode ==""){
			alert("도서코드를 선택해주세요.");
			document.querySelector("#bookCode").focus();
			return false;
		}
		if (rentalDays ==""){
			alert("대여일수가 입력되지 않았습니다.");
			document.querySelector("#rentalDays").focus();
			return false;
		}else if (rentalDays < 1 || rentalDays > 14 || !Number.isInteger(Number(rentalDays))){
			alert("대여일수는 1~14 사이의 정수여야합니다.");
			document.querySelector("#rentalDays").focus();
			return false;
			
		}
		if (borrowerName ==""){
			alert("대여자명이 입력되지 않았습니다.");
			document.querySelector("#borrowerName").focus();
			return false;
		}
	}

	function resetBtn(){
		alert(" 입력 내용을 초기화합니다.");
		document.querySelector("#rentalNo").focus();
	}

</script>
</body>
</html>