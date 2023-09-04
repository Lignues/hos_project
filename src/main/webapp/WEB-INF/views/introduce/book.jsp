<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<br><br>
<div class="container">
	<input type="hidden" class="year" value="${bookCalendar.thisYear}">
	<h1 class="month text-center">20${bookCalendar.thisYear}년 ${bookCalendar.thisMonth}월</h1>
	<br>
	<div class="float-right mb-3">
		<button type="button" class="beforeBtn btn btn-info">◀</button>
		<button type="button" class="nextBtn btn btn-info">▶</button>
	</div>
	<table class="table text-center">
		<tr>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th class="text-danger">토</th>
			<th class="text-danger">일</th>
		</tr>
		<tr><!-- 첫주 -->
			<c:forEach begin="1" end="${bookCalendar.firstDOW-1}" var="days"><!-- 월 첫날 시작 전(요일-1) -->
				<td></td>
			</c:forEach>
			<c:forEach begin="1" end="${bookCalendar.firstDOW < 6 ? 8-2-bookCalendar.firstDOW : 0}" var="days"><!-- 첫주 평일 -->
				<td data-days="${days}">${days}</td>
			</c:forEach>
			<c:forEach begin="${bookCalendar.firstDOW != 7 ? 8-1-bookCalendar.firstDOW : 1}" end="${8-bookCalendar.firstDOW}" var="days"><!-- 첫주의 주말 -->
				<td class="text-danger">${days}</td>
			</c:forEach>
		</tr>
		<c:forEach begin="1" end="${((bookCalendar.lastDay - bookCalendar.lastDOW + 1 - 1) - (8-bookCalendar.firstDOW))/7}" var="dou"><!-- 둘째주~마지막 전주 -->
			<tr>
				<c:forEach begin="${dou*7+1+1-bookCalendar.firstDOW}" end="${dou*7+8-2-bookCalendar.firstDOW}" var="days"><!-- 주중 평일 -->
					<td data-days="${days}">${days}</td>
				</c:forEach>
				<c:forEach begin="${dou*7+8-1-bookCalendar.firstDOW}" end="${dou*7+8-bookCalendar.firstDOW}" var="days"><!-- 주중 주말 -->
					<td class="text-danger">${days}</td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr><!-- 마지막주 -->
			<c:forEach begin="${bookCalendar.lastDay - bookCalendar.lastDOW + 1}" 
						end="${bookCalendar.lastDOW < 6 ? bookCalendar.lastDay : bookCalendar.lastDay - (bookCalendar.lastDOW - 5)}" var="days"><!-- 마지막주 평일 -->
				<td data-days="${days}">${days}</td>
			</c:forEach>
			<c:forEach begin="${bookCalendar.lastDOW < 6 ? bookCalendar.lastDay : bookCalendar.lastDay - (bookCalendar.lastDOW - 6)}" 
						end="${bookCalendar.lastDOW >= 6 ? bookCalendar.lastDay : 0}" var="days"><!-- 마지막주 주말 -->
				<td class="text-danger">${days}</td>
			</c:forEach>
			<c:forEach begin="1" end="${7-bookCalendar.lastDOW}"><!-- 달의 마지막 일 후에 남은 일수 -->
				<td></td>
			</c:forEach>
		</tr>
	</table>
	<br><br>
</div>

<!-- The Modal -->
<form action="${ctxPath}/introduce/booking" class="thisForm" method="post">
  <div class="modal" id="bookModal">
    <div class="modal-dialog">
      <div class="modal-content">
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">예약안내</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        <!-- Modal body -->
        <div class="modalDate modal-body">
        </div>
        <div class="bookableTimes modal-body">
		    <div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="10">10:00
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="11">11:00
			  </label>
			</div>
			<div class="form-check-inline disabled">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="12">12:00
			  </label>
			</div>
		    <div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="14">14:00
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="15">15:00
			  </label>
			</div>
			<div class="form-check-inline disabled">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="bookTime" value="16">16:00
			  </label>
			</div>
        </div>
        <div class="bookReason modal-body">
          <input type="text" class="form-control" name="bookReason" placeholder="원하시는 상담 내역을 적어주세요">
        </div>
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="bookSubmit btn btn-primary" data-dismiss="modal">예약하기</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
        </div>
      </div>
    </div>
  </div>
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  <input type="hidden" name="MemberId" value="${authInfo.memberId}">
  <input type="hidden" name="bookDate" value="">
</form>

<input type="hidden" name="highlight" value="book">
<input type="hidden" name="thisDays" value="${bookCalendar.thisDays}">
<input type="hidden" name="thisMonth" value="${bookCalendar.thisMonth}">
<input type="hidden" name="bookableDate" value="${bookCalendar.bookableDate}">
<form action="${ctxPath}/introduce/book" class="monthForm">
	<input type="hidden" name="changeMonth" value="0">
</form>

<%@ include file="../includes/footer.jsp"%>
<script>
$(function(){
	let year = $('.year').val().slice(2);
	let month = $('[name="thisMonth"]').val();
	if(month.length==1){
		month = '0'+ month;
	}
	let thisDays = $('[name="thisDays"]').val();
	let bookableDate = $('[name="bookableDate"]').val();
	let changeMonth = $('[name="changeMonth"]').val();
	let countList = [];
	let bookableList = [];
	
	// 예약버튼 누르면 예약 가능 시간 출력
	$('.table').on('click', '.modalBtn', function(){
		let clickedDate = $(this).attr('name');
		$('.modalDate').text(year + '년 ' + $('[name="thisMonth"]').val() + '월 ' + clickedDate + '일 예약가능 시간');
		let checkDate = year + '/' + month + '/' + clickedDate;
		$('[name="bookDate"]').val(checkDate);
		console.log($(''[name="bookDate"]).val());
		$.ajax({
			data : {checkDate : checkDate},
			url : '${ctxPath}/introduce/bookableTime',
			type : 'get',
			success : function(result){
				$('[name="bookTime"]').prop('disabled', false).prop('checked', false); // 기존입력내역 지우기
				$('[name="bookReason"]').val('');
				
				bookableList = result;
				$.each(bookableList, function(i,e){
					$('.bookableTimes').find('[value=' + e + ']').prop('disabled', true); // 예약된 시간 이용불가처리
				});
			}
		});
	});
	
	// 예약하기 
	$('.bookSubmit').click(function(e){
		e.preventDefault();
		$('.thisForm').submit();
	});
	
	// 오늘날짜에 색칠하기 메서드
	function todayColor(){
		$('[data-days="' + thisDays + '"]').attr('class', 'text-danger font-weight-bold');
	};
	
	// 예약가능시 버튼 추가
	function bookableDays(changeMonth){
		$.ajax({
			data : {changeMonth : changeMonth},
			url: '${ctxPath}/introduce/bookableList',
			type : 'get',
			success : function(result){
				countList = result;
				let intThisDays = parseInt(thisDays);
				for(var j = intThisDays; j <= bookableDate; j++){
					let canBook = true; // 예약 가능할지 여부
					$.each(countList, function(i,e){
						let jNumber = j;
						if(j < 10){ // 1자릿수일때 포멧 바꾸기
							jNumber = '0' + j;
						}
						let checkDate = year + '/' + month + '/' + jNumber;
						if (e.bookDate == checkDate && e.bookCount > 5) { // 예약 5 이상일시 예약불가
							canBook = false;
						}
					});
					if (!canBook) {
					    $('[data-days="' + j + '"]').attr('class', 'text-primary font-weight-bold')
					        .append($('<br>'))
					        .append($('<button>').text('예약불가').attr('class', 'btn btn-danger btn-sm'));
					}else{
					    $('[data-days="' + j + '"]').attr('class', 'text-primary font-weight-bold')
					        .append($('<br>'))
					        .append($('<button>', {type: 'button', name: j}).text('예약가능')
					        		.attr('class', 'modalBtn btn btn-primary btn-sm')
					        		.attr('data-toggle', 'modal')
					        		.attr('data-target', '#bookModal')
					        		.attr('data-agree', 'data'));
					}
				}
			}
		});
	};
	
	$('.nextBtn').click(function(){
		$('input[name="changeMonth"]').val('1');
		$('.monthForm').submit();
	});
	
	bookableDays(changeMonth);
	todayColor();
});
</script>