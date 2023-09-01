<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<h1>${bookCalendar.thisMonth}월</h1>

<div class="container">
	<table class="table text-center">
		<tr>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
			<th>일</th>
		</tr>
		<tr><!-- 첫주 -->
			<c:forEach begin="1" end="${bookCalendar.firstDOW-1}" var="days">
				<td class="${days}"></td>
			</c:forEach>
			<c:forEach begin="1" end="${8-bookCalendar.firstDOW}" var="days">
				<td class="${days}">${days}</td>
			</c:forEach>
		</tr>
		<c:forEach begin="1" end="${((bookCalendar.lastDay - bookCalendar.lastDOW + 1 - 1) - (8-bookCalendar.firstDOW))/7}" var="dou">
			<tr>
				<c:forEach begin="${dou*7+1+1-bookCalendar.firstDOW}" end="${dou*7+7+1-bookCalendar.firstDOW}" var="days">
					<td class="${days}">${days}</td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr><!-- 마지막주 -->
			<c:forEach begin="${bookCalendar.lastDay - bookCalendar.lastDOW + 1}" end="${bookCalendar.lastDay}" var="days">
				<td class="${days}">${days}</td>
			</c:forEach>
			<c:forEach begin="1" end="${7-1-bookCalendar.firstDOW}">
				<td></td>
			</c:forEach>
		</tr>
	</table>
</div>
<input type="hidden" name="highlight" value="book">
<input type="hidden" name="thisDays" value="${bookCalendar.thisDays}">
<input type="hidden" name="bookableDate" value="${bookCalendar.bookableDate}">


<%@ include file="../includes/footer.jsp"%>
<script>
$(function(){
	let thisDays = $('[name="thisDays"]').val();
	let bookableDate = $('[name="bookableDate"]').val();
	
	todayColor();
	bookableDays();
	
	// 오늘날자에 색칠하기 메서드
	function todayColor(){
		$('[class="' + thisDays + '"]').attr('class', thisDays+' text-danger font-weight-bold');
	};
	
	// 예약가능 색칠(차후 예약하기 기능 추가할것)
	function bookableDays(){
		for(i=thisDays; i<=bookableDate; i++){
			$('[class="' + i + '"]').attr('class', i + ' text-primary font-weight-bold');
		}
	}
	
});
</script>