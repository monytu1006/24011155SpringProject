<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md">
<h2>Member Modify Page</h2><br>

<form action="/member/modify" method="post">

<table class="table table-hover">
		<thead>
			<tr>
			<input type="hidden" name="id" value="${ses.id}">
				<th>ID</th>
				<td>${ses.id}</td>
			</tr>
			<tr>
				<th>Password</th>
				<td>
					<input type="password" name="pw" placeholder="변경할 password">
				</td>
			</tr>
			<tr>
				<th>Name</th>
				<td><input type="text" name="name" value="${ses.name}"></td>
			</tr>
			<tr>
				<th>email</th>
				<td><input type="email" name="email" value="${ses.email}"></td>
			</tr>
			<tr>
				<th>home</th>
				<td><input type="text" name="home" value="${ses.home}"></td>
			</tr>
			<tr>
				<th>Age</th>
				<td><input type="text" name="Age" value="${ses.age}"></td>
			</tr>
		</thead>
		<tbody>
		
		
		</tbody>
	</table>
	<button type="submit">modify</button>
	<!-- <a href="/member/modify"><button type="button">,pdify</button></a>
		버튼식이냐 서밋형식이냐 구분 확실히
	 --> 
	<a href="/member/delete"><button type="button">delete</button></a>
	
</form>
	
</div>



<jsp:include page="../layout/footer.jsp"></jsp:include>