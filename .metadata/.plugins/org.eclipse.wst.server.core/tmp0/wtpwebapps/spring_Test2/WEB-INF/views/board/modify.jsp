<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<jsp:include page="../layout/header.jsp"></jsp:include>

<div class="container-md">
<h1>Board Modify Page</h1>
<br>
<c:set value="${bdto.bvo}" var="bvo" />
<form action="/board/modify" method="post" enctype="multipart/form-data">
   <div class="mb-3">
      <label for="bno" class="form-label">BNO</label>
      <input type="text" name="bno" class="form-control" id="bno" value="${bvo.bno }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="title" class="form-label">Title</label>
      <input type="text" name="title" class="form-control" id="title" value="${bvo.title }">
   </div>
   <div class="mb-3">
      <label for="writer" class="form-label">Writer</label>
      <input type="text" name="writer" class="form-control" id="writer" value="${bvo.writer }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="reg_date" class="form-label">Reg_date</label>
      <input type="text" name="reg_date" class="form-control" id="reg_date" value="${bvo.regAt }" readonly="readonly">
   </div>
   <div class="mb-3">
      <label for="content" class="form-label">Content</label>
      <textarea class="form-control" name="content" rows="3" id="content">${bvo.content }</textarea>
   </div>
<c:set value="${bdto.flist }" var="flist" />
   <div class="col-12">
      <label for="f" class="form-label"></label>
      <ul class="list-group list-group-flush">
         <c:forEach items="${flist }" var="fvo">
              <li class="list-group-item">
                 <c:choose>
                    <c:when test="${fvo.fileType == 1 }">
                       <div>
                          <img alt="" src="/upload/${fvo.saveDir }/${fvo.uuid}_th_${fvo.fileName}">
                       </div>
                    </c:when>
                    <c:otherwise>
                       <div>
                          <!-- 일반 파일 표시할 아이콘 -->
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-journal-arrow-down" viewBox="0 0 16 16">
  <path fill-rule="evenodd" d="M8 5a.5.5 0 0 1 .5.5v3.793l1.146-1.147a.5.5 0 0 1 .708.708l-2 2a.5.5 0 0 1-.708 0l-2-2a.5.5 0 1 1 .708-.708L7.5 9.293V5.5A.5.5 0 0 1 8 5z"/>
  <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2z"/>
  <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1H1z"/>
</svg>
                       </div>
                    </c:otherwise>
                 </c:choose>
                 <div class="ms-2 me-auto">
                    <div class="fw-bold">${fvo.fileName }</div>
                    <span class="badge rounded-pill text-bg-secondary">${fvo.fileSize }Byte</span>
                    <button type="button" data-uuid="${fvo.uuid }" class="btn btn-sm btn-outline-danger file-x">x</button>
                 </div>
              </li>
         </c:forEach>
        </ul>
   </div>
   
   <!-- 파일 등록 라인 -->
   <div class="mb-3">
      <input type="file" name="files" class="form-control" id="files" multiple style="display: none"> <br>
      <button type="button" class="btn btn-primary" id="trigger">FileUpload</button>
   </div> 
   <!-- 파일 목록 표시라인 -->
    <div class="mb-3" id="fileZone"></div> 
   
    <button type="submit" class="btn btn-success" id="regBtn">modify</button>
   <a href="/board/list"><button type="button" class="btn btn-primary">list</button></a>
</form>
</div>

<script src="/resources/js/boardRegister.js"></script>
<script src="/resources/js/boardModify.js"></script>

<jsp:include page="../layout/footer.jsp"></jsp:include>


