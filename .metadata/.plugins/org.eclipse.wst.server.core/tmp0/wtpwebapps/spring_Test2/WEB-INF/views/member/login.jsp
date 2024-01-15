<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>

<div class="container-md">
	<h2>Member Login Page</h2><br>
	<form action="/member/login" method="post">
		<div class="mb-3">
	      <label for="email" class="form-label">Email</label>
	      <input type="text" name="email" class="form-control" id="email" placeholder="Email..">
	   </div>
	   <div class="mb-3">
	      <label for="pwd" class="form-label">PW</label>
	      <input type="password" name="pwd" class="form-control" id="pwd" placeholder="PassWord..">
	   </div>
   		<button type="submit" class="btn btn-primary">Login</button>
	</form>
	
	<c:if test="${not empty param.errMsg }">
		<div class="mb-3 text-danger">
			<c:choose>
				<c:when test="${param.errMsg eq 'Bad credentials' }">
					<c:set value="이메일 & 비밀번호가 일치하지 않습니다!" var="errText"></c:set>
				</c:when>
				<c:otherwise>
					<c:set value="관리자에게 문의해주세요" var="errText"></c:set>
				</c:otherwise>
			</c:choose>
			${errText}
		</div>
	</c:if>
</div>


<jsp:include page="../layout/footer.jsp"></jsp:include>