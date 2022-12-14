<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/WEB-INF/views/admin/header.jsp">
	<jsp:param name="title" value="헬로우 스프링" />
</jsp:include>

<!-- 폰트어썸 -->
<script src="https://kit.fontawesome.com/34c760bbb4.js" crossorigin="anonymous"></script>

<!-- datepicker -->
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">

<!-- 사용자 작성 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/header.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/product-list.css"/>
		<!-- admin content 시작 -->
		<div class="admin-content">
			<div id="admin-content" class="admin-sub-frame">
				<div>
					<div class="admin-sub-title">
						<div class="pull-left">
							<h2 class="title">상품 조회/수정</h2>
						</div>
					</div>
				</div>
				<div class="admin-sub-content">
					<!-- 결제 상태 등 표시 시작 -->
					<div class="form-section admin-status">
						<ul class="admin-status-list">
							<li>
								<span class="status-icon">
									<img src="${pageContext.request.contextPath}/resources/css/images/pills-solid.svg">
								</span>
								<div class="text">
									<p>전체</p>
									<strong>${fn:length(allList)}</strong>
									<em>건</em>
								</div>
							</li>
							<li>
								<span class="status-icon">
									<img src="${pageContext.request.contextPath}/resources/css/images/face-smile-regular.svg">
								</span>
								<div class="text">
									<p>판매중</p>
									<strong>${y}</strong>
									<em>건</em>
								</div>
							</li>
							<li>
								<span class="status-icon">
									<img src="${pageContext.request.contextPath}/resources/css/images/face-grin-squint-tears-regular.svg">
								</span>
								<div class="text">
									<p>품절</p>
									<strong>${s}</strong>
									<em>건</em>
								</div>
							</li>
							<li>
								<span class="status-icon">
									<img src="${pageContext.request.contextPath}/resources/css/images/circle-exclamation-solid.svg">
								</span>
								<div class="text">
									<p>판매종료</p>
									<strong>${n}</strong>
									<em>건</em>
								</div>
							</li>
						</ul>
					</div>
					<!-- /결제 상태 등 표시 끝 -->
					<!-- 상품 조회 폼 시작 -->
					<div class="panel panel-admin">
						<form action="${pageContext.request.contextPath}/admin/product/findByValues.do" name="adminSearchFrm">
							<!-- 조회폼 선택지 시작 -->
							<div class="panel-body">
								<div class="admin-search-section">
									<ul class="admin-list-border">
										<!-- 검색어로 검색 시작 -->
										<li>
											<div class="control-label">검색어</div>
											<div class="form-inline">
												<div class="form-group">
													<label>상품 번호</label>
													<input type="text" name="pcode" id="pcode"/>
												</div>
												<div class="form-group">
													<label>상품명</label>
													<input type="text" name="pname" id="pname"/>
												</div>
												<div class="form-group">
													<label>제조사명</label>
													<input type="text" name="manu" id="manu"/>
												</div>
											</div>
										</li>
										
										<!-- /검색어로 검색 끝 -->
										<!-- 판매 상태 검색 시작 -->
										<li>
											<div class="control-label">판매 상태</div>
											<div class="form-group checkbox-wrap">
											<input type="hidden" name="saleStatus" id="saleStatus" value=""/>
												<div>
													<input type="radio" name="saleStatuses" value="total" id="getTotal"/>
													<label for="getTotal">전체</label>
												</div>
												<div>
													<input type="radio" name="saleStatuses" value="Y" id="getY"/>
													<label for="getY">판매중</label>
												</div>
												<div>
													<input type="radio" name="saleStatuses" value="S" id="getSoldOut"/>
													<label for="getSoldOut">품절</label>
												</div>
												<div>
													<input type="radio" name="saleStatuses" value="N" id="getN"/>
													<label for="getN">판매 종료</label>
												</div>
											</div>
										</li>
										<!-- /판매 상태 검색 끝 -->
										<!-- 카테고리 검색 시작 -->
										<li>
											<div class="control-label">카테고리</div>
											<div class="form-group category-wrap">
												<select class="custom-select big-category">
													<option selected value="0">대분류</option>
													<option value="350001">성분</option>
													<option value="350002">성별</option>
													<option value="350003">신체</option>
													<option value="350004">정기구독</option>
												</select>
												<select class="custom-select small-category" name="categoryId">
													<option selected value="0">소분류</option>
												</select>
											</div>
										</li>
										<!-- /카테고리 검색 끝 -->
										<!-- 기간 검색 시작 -->
										<li>
											<div class="controll-label">기간</div>
											<div class="form-group">
												<select class="custom-select" name="enrollOrUpdate">
													<option selected value="createdAt">상품 등록일</option>
													<option value="updatedAt">최종 수정일</option>
												</select>
											</div>
											<div class="form-group">
												<div class="btn-group date-btns">
													<button type="button" class="date-btn" id="today-btn">오늘</button>
													<button type="button" class="date-btn" id="week-btn">1주일</button>
													<button type="button" class="date-btn" id="one-month-btn">1개월</button>
													<button type="button" class="date-btn" id="three-month-btn">3개월</button>
													<button type="button" class="date-btn" id="six-month-btn">6개월</button>
													<button type="button" class="date-btn" id="year-btn">1년</button>
													<button type="button" class="date-btn" id="total-btn">전체</button>
												</div>
											</div>
											<div class="form-group">
												<!-- datepicker 위젯 넣기 -->
												<div class="dates">
													<input type="text" class="datepicker" id="to" name="toDate" placeholder="시작일"/>
													<input type="text" class="datepicker" id="from" name="fromDate" placeholder="종료일"/>
												</div>
												
											</div>
										</li>
										<!-- 기간 검색 끝 -->
									</ul>
								</div>
							</div>
							<!-- /조회폼 선택지 끝 -->
							<!-- 검색 / 초기화 버튼 시작 -->
							<div class="panel-footer">
								<div class="admin-button-area">
									<button type="submit" class="btn btn-primary">검색</button>
									<button type="button" class="btn btn-default">초기화</button>
								</div>
							</div>
							<!-- /검색 / 초기화 버튼 끝 -->
						</form>
					</div>
					<!-- /상품 조회 폼 끝 -->
					<!-- 상품 리스트 시작 -->
					<div class="panel panel-admin">
						<div class="panel-heading">
							<div class="pull-left">
								<h3 class="panel-title">
									상품목록 (총
									<span class="text-primary">${fn:length(list)}</span>
									개)
								</h3>
							</div>
							<div class="pull-right">
								<select class="custom-select">
									<option selected>상품등록일순</option>
								</select>
								<select class="custom-select">
									<option selected>100개씩</option>
								</select>
							</div>
						</div>
						<div class="panel-body">
							<div class="admin-btn-group">
								<div class="admin-btn-left">
									<button type="button" class="btn btn-submit">선택 삭제</button>
								</div>
								<div class="admin-btn-right">
									<button type="button" class="btn btn-submit" onclick="updateProduct();">수정</button>
								</div>
							</div>
							<div class="admin-product-list">
								<table class="product-list-tbl" name="product-list-tbl">
									<thead>
										<tr>
											<td></td>
											<td>상품코드</td>
											<td>카테고리 코드</td>
											<td>품목제조관리번호</td>
											<td>상품명</td>
											<td>제조사</td>
											<td>가격</td>
											<td>내용량(수량)</td>
											<td>성분명</td>
											<td>효능</td>
											<td>주의사항</td>
											<td>용법</td>
											<td>유통기한</td>
											<td>구독상품</td>
											<td>판매상태</td>
											<td>상품 등록일</td>
											<td>최종 수정일</td>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty list}">
											<tr>
												<td colspan="18" class="text-center">조회된 상품이 없습니다.</td>
											</tr>
										</c:if>
										<c:if test="${not empty list}">
											<c:forEach items="${list}" var="product">
												<tr data-no="${product.pcode}">
													<td><input type="checkbox" name="checkbox" value="${product.pcode}"/></td>
													<td>${product.pcode}</td>
													<td>${product.categoryId}</td>
													<td>${product.sttenmtNo}</td>
													<td>${product.pname}</td>
													<td>${product.manu}</td>
													<td>${product.price}</td>
													<td>${product.amount}</td>
													<td>${product.ingreName}</td>
													<td>${product.mainFnctn}</td>
													<td>${product.intakeHint1}</td>
													<td>${product.srvUse}</td>
													<td>${product.distbPd}</td>
													<td>${product.subYn}</td>
													<td>${product.saleStatus}</td>
													<td>${product.createdAt}</td>
													<td>
														<c:if test="${empty product.updatedAt}">-</c:if>
													</td>
												</tr>
											</c:forEach>
										</c:if>
									</tbody>
								</table>
								<nav class="pagebar"></nav>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- /admin content 끝 -->
<script>
document.adminSearchFrm.addEventListener('submit', (e) => {
	const frm = e.target;
	e.preventDefault();
	
	const status = document.querySelector('[name=saleStatuses]:checked') == null ? null : document.querySelector('[name=saleStatuses]:checked').value;
	document.querySelector('#saleStatus').value = status;
	
	if(document.querySelector('[name=pcode]').value == ''){
		document.querySelector('[name=pcode]').value = 0;
	}
	frm.submit();
});

const updateProduct = () => {
	let arr = [];
	$("input:checkbox[name='checkbox']:checked").each(function(){
	    arr.push($(this).val());
	    console.log(arr);
	});
	
	if(arr.length == 0)
		alert("수정할 상품을 선택해주세요.");
	
	if(arr.length > 1)
		alert("하나의 상품만 선택해주세요.");
	
	if(arr.length == 1){
		location.href = "${pageContext.request.contextPath}/admin/product/productUpdate.do?pcode=" + arr[0];
	}
}

// 상품명 자동 완성
$('#pname').autocomplete({
	source(request, response){
		console.log(request);
		const {term} = request;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/product/autocompletePname.do",
			method : "GET",
			data : {term},
			success(pnames){
				console.log(pnames);
				const arr = pnames.map((pname) => ({
					label : pname,
					value : pname
				}));
				console.log(arr);
				response(arr);
			},
			error(jqxhr, statusText, err){
                   console.log(jqxhr, statusText, err);
               }
		});
	},
	focus(e, selected){return false;}
});

// 제조사명 자동 완성
$('#manu').autocomplete({
	source(request, response){
		console.log(request);
		const {term} = request;
		
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/autocompleteManu.do",
			method : "GET",
			data : {term},
			success(manus){
				console.log(manus);
				const arr = manus.map((manu) => ({
					label : manu,
					value : manu
				}));
				console.log(arr);
				response(arr);
			},
			error(jqxhr, statusText, err){
                   console.log(jqxhr, statusText, err);
               }
		});
	},
	focus(e, selected){return false;}
});

document.querySelector(".big-category").addEventListener('change', (e) => {
	const smallCategory = document.querySelector('.small-category');
	smallCategory.options[0].selected = true;
	$.ajax({
		url : "${pageContext.request.contextPath}/admin/product/category.do",
		method : "GET",
		data : {
			categoryId : e.target.value
		},
		success(data){
			console.log(data);
			
			data.forEach(({categoryDetailName, categoryId}) => {
				console.log(categoryDetailName, categoryId);
				$(smallCategory).append("<option id='small-category' value='" + categoryId + "'>" + categoryDetailName + "</option>");
			});
		},
		error : console.log
	});
});

const to = document.querySelector('#to');
const from = document.querySelector('#from');
const today = new Date();
const dateFormat = (date) => {
	let year = date.getFullYear();
	let month = (date.getMonth() + 1) >= 10 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1);
	let _date = date.getDate() >= 10 ? date.getDate() : '0' + date.getDate(); 
	
	
	return year + '-' + month + '-' + _date;
};
$.datepicker.setDefaults({
	dateFormat:'yy-mm-dd',
	prevText: '이전 달',
	nextText: '다음 달',
    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	showMonthAfterYear: true,
	yearSuffix: '년'
});
$(function(){
	$('.datepicker').datepicker();
});

// 오늘 버튼 클릭시
$('#today-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	to.value = dateFormat(today);
	from.value = dateFormat(today);
});
// 1주일 버튼 클릭시
$('#week-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	to.value = dateFormat(new Date(today.getFullYear(),today.getMonth(), today.getDate() - 6));
	from.value = dateFormat(today);
});
// 1개월 버튼 클릭시
$('#one-month-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	let _month = today.getMonth() - 1 <= 0 ? today.getMonth() - 1 + 12 : today.getMonth() - 1;
	let _year = today.getMonth() - 3 <= 0 ? today.getFullYear() - 1 : today.getFullYear();
	to.value = dateFormat(new Date(today.getFullYear(), today.getMonth() - 1, today.getDate() + 1));
	from.value = dateFormat(today);
});
// 3개월 버튼 클릭시
$('#three-month-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	let _month = today.getMonth() - 3 <= 0 ? today.getMonth() - 3 + 12 : today.getMonth() - 3;
	let _year = today.getMonth() - 3 <= 0 ? today.getFullYear() - 1 : today.getFullYear();
	to.value = dateFormat(new Date(_year, _month, today.getDate() + 1));
	from.value = dateFormat(today);
});
// 6개월 버튼 클릭시
$('#six-month-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	let _month = today.getMonth() - 6 <= 0 ? today.getMonth() - 6 + 12 : today.getMonth() - 6;
	let _year = today.getMonth() - 6 <= 0 ? today.getFullYear() - 1 : today.getFullYear();
	to.value = dateFormat(new Date(_year, _month, today.getDate() + 1));
	from.value = dateFormat(today);
});
// 1년 버튼 클릭시
$('#year-btn').on('click', (e) => {
	$('.datepicker').datepicker('option', 'disabled', false);
	to.value = dateFormat(new Date(today.getFullYear() - 1, today.getMonth(), today.getDate() + 1));
	from.value = dateFormat(today);
});
// 전체 버튼 클릭시
$('#total-btn').on('click', (e) => {
	to.value='';
	from.value='';
	$('.datepicker').datepicker('option', 'disabled', true); // input 박스 비활성화
});
// 시작일
$('#to').datepicker({
	showOn: "both", // 달력을 표시할 타이밍 (both: focus or button)
	buttonImage: "${pageContext.request.contextPath}/resources/images/calendar.png", // 버튼 이미지
	onClose: function( selectedDate ) {    
	// 시작일(to) datepicker가 닫힐때
	// 종료일(from)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
		$("#from").datepicker( "option", "minDate", selectedDate );
	}                
});

//종료일
$('#from').datepicker({
    showOn: "both", 
    buttonImage: "${pageContext.request.contextPath}/resources/images/calendar.png", // 버튼 이미지
    onClose: function( selectedDate ) {
        // 종료일(from) datepicker가 닫힐때
        // 시작일(to)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
        $("#to").datepicker( "option", "maxDate", selectedDate );
    }                
});
</script>
	</div>
</div>


</body>
</html>