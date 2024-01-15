<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/">Navbar</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="/">Home</a>
        </li>
               
        <li class="nav-item">
          <a class="nav-link" href="/board/list">게시판 보기</a>
        </li>
        
 
        <!-- 현재 인증한 사용자의 정보를 가져와서 해당 권한이 있는지 확인 -->
        <!-- 로그인 인증한 후 사용가능한 것들 -->
        <!-- 현재 사용자의 정보는 pricipal -->
        <!-- anyMatch() : stream 매칭 매서드(최소한 1개의 요소가 주어진 조건에 맞는지 조사) -->
        <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.mvo.email" var="authEmail"/>
        <sec:authentication property="principal.mvo.nickName" var="authNick"/>
        <sec:authentication property="principal.mvo.authList" var="auths"/>
        
        <!-- 어드민 계정일 떄문 뜨는 -->
        <c:choose>
        	<c:when test="${auths.stream().anyMatch(authVO -> authVO.auth.equals('ROLE_ADMIN')).get()}">
        		<li class="nav-item">
	         		 <a class="nav-link" href="/member/list">회원리스트  ${authNick }(${authEmail }/ADMIN)</a>
	       		</li>
	       		
	       		<li class="nav-item">
		          <a class="nav-link" href="/member/modify">회원정보 수정  ${authNick }(${authEmail })</a>
		        </li>
		        
        	</c:when>
        	<c:otherwise>
	        	<li class="nav-item">
		          <a class="nav-link" href="/member/modify">회원정보 수정  ${authNick }(${authEmail })</a>
		        </li>		
        	</c:otherwise>
        </c:choose>
        
	        <li class="nav-item">
	          <a class="nav-link" href="/board/register">게시판 글쓰기</a>
	        </li>
		    <li class="nav-item">
		       <a class="nav-link" href="" id="logoutLink">로그아웃</a>
		    </li>

			<form action="/member/logout" method="post" id="logoutForm">
			<!-- 인증된 (로그인한 계정의) 이메일 -->
				<input type="hidden" name="email" value="authEmail">
			</form>
        </sec:authorize>

		<sec:authorize access="isAnonymous()">
		     <li class="nav-item">
		       <a class="nav-link" href="/member/register">회원가입</a>
		     </li>
		
			 <li class="nav-item">
			   <a class="nav-link" href="/member/login">로그인</a>
		 	 </li>
		</sec:authorize>
		
		<%--
		  <c:if test="${ses.id ne null }">
	        <li class="nav-item">
	          <a class="nav-link" href="/member/modify">${ses.id }( ${ses.email } ) welcom!!</a>
	        </li>
	        </c:if> --%>
		
      </ul>
    </div>
  </div>
</nav>
</body>

<script type="text/javascript">
	document.getElementById('logoutLink').addEventListener('click', (e) => {
	    e.preventDefault();	//JavaScript에서 이벤트의 기본 동작을 막는 역할
	    document.getElementById('logoutForm').submit();
	});
</script>

</html>