<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<jsp:include page="../layout/header.jsp"></jsp:include>


<h2>Board Detail Page</h2><br>
<!-- 게시글 상세정보란 시작 -->

<c:set value="${bdto.bvo}" var="bvo" />
   <div class="mb-3">
      <label for="bno" class="form-label">BNO</label>
      <input type="text" name="bno" class="form-control" id="bno" value="${bvo.bno }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="title" class="form-label">Title</label>
      <input type="text" name="title" class="form-control" id="title" value="${bvo.title }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="writer" class="form-label">Writer</label>
      <input type="text" name="writer" class="form-control" id="writer" value="${bvo.writer }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="reg_date" class="form-label">Reg_date</label>
   <span class="badge text-bg-primary">${bvo.readCount }</span>
      <input type="text" name="reg_date" class="form-control" id="reg_date" value="${bvo.regAt }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="content" class="form-label">Content</label>
      <textarea class="form-control" name="content" rows="3" id="content" readonly="readonly">${bvo.content }</textarea>
   </div>
   
   
   <!-- 파일 표시 라인 -->
<c:set value="${boardDTO.flist }" var="flist" />
   <div class="mb-3">
      <ul class="list-group list-group-flush">
      <!-- 파일의 개수만큼 li를 추가하여 파일을 표시, 타입이 1인경우만 표시 -->
      <!-- 
         li -> div => img 그림표시
               div => 파일이름, 작성일, span size
      -->
      <!-- 파일 리스트 중 하나만 가져와서 fvo로 저장 -->
         <c:forEach items="${flist }" var="fvo">
            <li class="list-group-item">
               <c:choose>
                  <c:when test="${fvo.file_type > 0 }">
                     <div>
                     <!-- /upload/save_dir/uuid_file_name -->
                        <img alt="" src="/upload/${fvo.save_dir }/${fvo.uuid}_th_${fvo.file_name}">
                     </div>
                  </c:when>
                  <c:otherwise>
                     <div>
                        <!-- 아이콘 같은 모양 하나 가져와서 넣기 -->
                     </div>
                  </c:otherwise>
               </c:choose>
               <div>
                  <!-- div => 파일이름, 작성일, span size -->
                  <div>${fvo.file_name }</div>
                  ${fvo.reg_date }
               </div>
               <span class="badge rounded-pull text-bg-warning">${fvo.file_size }Byte</span>
               
            </li>
         </c:forEach>
      </ul>
   </div>
   
   <!-- file line -->	
   <c:set value="${bdto.flist}" var="flist"></c:set>
   <div class="col-12">
	   <label for="f" class="form-label">File보여주기 공란</label>
	   <ul class="list-group list-group-flush">
	   	<c:forEach items="${flist}" var="fvo">
	   		<li class="list-group-item">
	   			<c:choose>
		   			<c:when test="${fvo.fileType==1}">
		   				<div>
		   					<img alt="" src="/upload/${fvo.saveDir}/${fvo.uuid}_th_${fvo.fileName}">
		   				</div>
		   			</c:when>
		   			<c:otherwise>
		   				<div>
		   					<!-- 일반 파일 표시할 아이콘 -->
		   					<!-- 이미지 파일이 아닌 다른 종료의 파일 다운받기 -->
		   					<a href="/upload/${fvo.saveDir}/${fvo.uuid}_${fvo.fileName}" download="${fvo.fileName}">>
			   					<!-- <i class="bi bi-journal-arrow-down"></i>
			   					<i class="bi bi-archive-fill"></i> -->
		   					</a>
		   				</div>
		   			</c:otherwise>
	   			</c:choose>
	   			<div class="ms-2 me-auto">
	   				<div class="fw-bold">${fvo.fileName}</div>
	   				<span class="badge rounded-pill text-bg-secondary">${fvo.fileSize}Byte</span>
	   			</div>
	   		</li>
	   	</c:forEach>
	   	</ul>
	</div>
   	
   
   
   
   
   <a href="/board/list"><button type="button" class="btn btn-primary">list</button></a>
   <a href="/board/modify?bno=${bvo.bno }" ><button type="button" class="btn btn-success">modify</button></a>
   <a href="/board/remove?bno=${bvo.bno }" ><button type="button" class="btn btn-danger">delete</button></a>
   
   <br> <hr> <br>
   <!-- 댓글등록라인 -->
<div class="input-group mb-3">
  <span class="input-group-text" id="cmtWriter" value="${bvo.writer }">${bvo.writer} </span>
  <input type="text" class="form-control" id="cmtText" aria-label="Amount (to the nearest dollar)">
  <button type="button" class="btn btn-success" id="cmtPostBtn">Post</button>
</div>
   <br>
   
   <!-- 댓글표시라인 -->
<ul class="list-group list-group-flush" id="cmtListArea">
  <li class="list-group-item">
     <div class="mb-3">
        <div class="fw-bold">Writer</div>
        Content
     </div>
     <span class="badge rounded-pill text-bg-warning">modAt</span>
  </li>
</ul>

   <!-- 댓글 더보기 버튼 -->
   <div>
      <button type="button" id="moreBtn" data-page="1" class="btn btn-outline-dark" style="visibility:hidden">More+</button>
   </div>

   <br>
   
   <!-- 모달창 -->
 <div class="modal" id="myModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Writer</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="input-group mb-3">
        <input type="Text" class="form-control" id="cmtTextMod">
        <button type="button" class="btn btn-primary" id="cmtModBtn">Post</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
   let bnoVal = `<c:out value="${bdto.bvo.bno}" />`;
   console.log(bnoVal);
</script>

<script src="/resources/js/boardComment.js" /></script>

<script type="text/javascript">
   spreadCommentList(bnoVal);
</script>

<!-- <script>
	const bnoVal = `<c:out value="${bvo.bno}"/>`;
</script>
<
<script src="/resources/js/boardComment.js"></script>
<script>
	getCommentList(bnoVal);
</script> -->

<jsp:include page="../layout/footer.jsp"></jsp:include>












