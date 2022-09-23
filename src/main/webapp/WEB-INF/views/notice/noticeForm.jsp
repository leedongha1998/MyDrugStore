<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="글작성" name="title" />
</jsp:include>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/notice.css" />
<div id="container">
	<h2>공지사항 작성📝</h2>
	<hr>
	<br>
	<form action="${pageContext.request.contextPath}/notice/noticeEnroll.do" method="post" id="noticeEnrollFrm">
		<div class="form-group">
			<label for="title">제목</label> <input type="text" class="form-control"
				id="title" placeholder="제목 입력" name="title" required">
		</div><br /><br />

		<div class="form-group">
			<label for="writer">작성자&nbsp;&nbsp;&nbsp;<sec:authentication property="principal.memberId"/></label> 
		</div><br /><br />

		<div class="form-group">
			<label for="content">내용</label>
			<input type="hidden" name="content" id="enroll_summernote"/>
		</div>
		<button type="submit" class="btn-add">등록</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
</div>

<script>
//게시판 에디터 생성
$("#enroll_summernote").summernote({
  height: 300,
  width: 700,
  focus: true,
  disableResizeEditor: true,
 });

//submit 처리
$("#noticeEnrollFrm").submit(function(){
		$("[name=content]").val($("#enroll_summernote").summernote('code'));
		var $title = $("[name=title]").val();
		var $content = $("[name=content]").val();
		
		//제목 유효성 검사
		if(/^.{1,}$/.test($title)==false){
			alert("제목을 입력하세요");
			$("[name=title]").focus();
			return false;
		}
		//내용 유효성 검사
		if($content.length==0 || $content=="<p><br></p>"){
			alert("내용을 입력하세요");
			$("#enroll_summernote").summernote("focus");
			return false;
		}
		
	if(confirm("게시글을 등록 하시겠습니까?")){
		return true;
	}else{
		return false;
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>