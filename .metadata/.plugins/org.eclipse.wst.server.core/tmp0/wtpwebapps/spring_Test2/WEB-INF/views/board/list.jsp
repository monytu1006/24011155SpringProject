<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous">

<jsp:include page="../layout/header.jsp"></jsp:include>
<jsp:include page="../layout/nav.jsp"></jsp:include>

<div class="container-md">
	<br>
	<h2>Board List Page</h2>
	<br>

	<!-- 검색라인 -->
	<div>
		<form action="/board/list" method="get">
		<div class="input-group mb-3">
			<select name="type" class="form-select" id="inputGroupSelect02">
				<option ${ph.pgvo.type==null ? 'selected' : ''}>Choose...</option>
					<option value="t" ${ph.pgvo.type eq 't' ? 'selected' : ''} >Title</option>
					<option value="w" ${ph.pgvo.type eq 'w' ? 'selected' : ''}>Writer</option>
					<option value="c" ${ph.pgvo.type eq 'c' ? 'selected' : ''}>Content</option>
					<option value="tc" ${ph.pgvo.type eq 'tc' ? 'selected' : ''}>Title&Content</option>
					<option value="tw" ${ph.pgvo.type eq 'tw' ? 'selected' : ''}>Title&Writer</option>
					<option value="wc" ${ph.pgvo.type eq 'wc' ? 'selected' : ''}>Writer&Content</option>
					<option value="twc" ${ph.pgvo.type eq 'twc' ? 'selected' : ''}>All</option>
				<!-- 원래 selected는 하나만 쓰수 있으나 -->
			</select>
			
			<input type="text" class="form-control" name="keyword" value="${ph.pgvo.keyword }" placeholder="Search...">
			<input type="hidden" name="pageNo" value="1">
			<input type="hidden" name="qty" value="${ph.pgvo.qty}">

			<button type="submit" class="btn btn-primary position-relative">Search
			    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
				    ${ph.totalCount}
			    <span class="visually-hidden"></span>
			  </span>
			</button>
		</div>
		</form>
	</div>
	
				
	
	<table class="table table-hover">
		<thead>
			<tr>
<!-- 			<tr>
				<th scope="col">#</th>
				<th scope="col">title</th>
				<th scope="col">writer</th>
				<th scope="col">reg_date</th>
				<th scope="col">read_count</th>
			</tr>
  -->

			<tr>
				<th scope="col">#</th>
				<th scope="col">title</th>
				<th scope="col">writer</th>
				<th scope="col">Read_Count</th>
				<th scope="col">comment_qty</th>
				<th scope="col">file_qty</th>
				<th scope="col">Mod_At</th>
			</tr>

		</thead>
		<tbody>
			<c:forEach items="${list }" var="bvo">
			<%-- 
				<tr>
					<th scope="row">${bvo.bno }</th>
					<td><a href="/board/detail?bno=${bvo.bno}">${bvo.title }</a>
					<td>${bvo.writer }</td>
					<td>${bvo.regAt }</td>
					<td>${bvo.readCount }</td>
				</tr>
				 --%> 
				<tr>
					<th scope="row">${bvo.bno }</th>
					<td><a href="/board/detail?bno=${bvo.bno}">${bvo.title }</a>
					<td>${bvo.writer }</td>
					<td>${bvo.readCount }</td>
					<td>${bvo.cmtQty }</td>
					<td>${bvo.hasFile }</td>
					<td>${bvo.modAt }</td>
				</tr>

			</c:forEach>
		</tbody>
	</table>
</div>


<!-- 페이지 네이션 -->

<nav aria-label="Page navigation example">
  <ul class="pagination justify-content-center">
 
  <!-- 이전 -->
  <c:if test="${ph.prev }">
    <li class="page-item">
      <a class="page-link" href="/board/list?pageNo=${ph.startPage-1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Previous">
        <span aria-hidden="true">&laquo;</span>
      </a>
    </li>
  </c:if>
  
	<!-- 페이지 번호 -->    
	<c:forEach begin="${ph.startPage }" end="${ph.endPage }" var="i">
    <li class="page-item">
    	<a class="page-link" href="/board/list?pageNo=${i}&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}">${i}</a>
    </li>
	
	</c:forEach>

	<!-- 다음 -->
	<c:if test="${ph.next }">
	    <li class="page-item">
	      <a class="page-link" href="/board/list?pageNo=${ph.endPage+1 }&qty=${ph.pgvo.qty}&type=${ph.pgvo.type}&keyword=${ph.pgvo.keyword}" aria-label="Next">
	        <span aria-hidden="true">&raquo;</span>
	      </a>
	    </li>
	</c:if>

 	<li class="page-item"><a class="page-link" href="/board/list">전체보기</a>
	<!-- <li class="page-item"><a href="/board/list"><button>전체보기</button></a> -->


  </ul>
</nav>




<%-- 
<script>
	const isDel = `<c:out value ="${isDel }"/>`;
	if (isDel ==1) {
		alert("게시글이 삭제 되었습니다")
	}
</script>

<jsp:include page="../layout/footer.jsp"></jsp:include>
 --%>









