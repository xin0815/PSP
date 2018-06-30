<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<script type='text/javascript'>

	function forwardpage() {
		if (parseInt(document.getElementsByName('currentPage')[0].value) < document
				.getElementsByName('totalPage')[0].value) {
			document.getElementsByName('currentPage')[0].value = parseInt(document
					.getElementsByName('currentPage')[0].value) + 1;
		} else {
			document.getElementsByName('currentPage')[0].value = document
					.getElementsByName('totalPage')[0].value;
		}
		document.forms[0].submit();
	}
	function backpage() {
		if (parseInt(document.getElementsByName('currentPage')[0].value) > 1) {
			document.getElementsByName('currentPage')[0].value = parseInt(document
					.getElementsByName('currentPage')[0].value) - 1;
		} else {
			document.getElementsByName('currentPage')[0].value = 1;
		}
		document.forms[0].submit();
	}
	function gopage(num) {
		document.getElementsByName('currentPage')[0].value = num;
		document.forms[0].submit();
	}
</script>
<c:if test="${not empty pager}">
	<input type="hidden" name="currentPage" value="${pager.currentPage}" />
	<input type="hidden" name="totalPage" value="${pager.totalPage}" />
	<div align="right" style="margin-right: 10px;">
		<nav>
			<ul class="pagination" >
				<li <c:if test="${pager.currentPage eq 1}">class="disabled"</c:if>><a onclick="backpage()" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
				<li <c:if test="${pager.currentPage eq 1}">class="active"</c:if>><a <c:if test="${pager.currentPage > 3}">onclick="gopage(${pager.currentPage - 2})"</c:if><c:if test="${pager.currentPage <= 3}">onclick="gopage(1)"</c:if>><c:if test="${pager.currentPage > 3}">${pager.currentPage - 2}</c:if><c:if test="${pager.currentPage <= 3}">1</c:if></a></li>
				<li <c:if test="${pager.currentPage eq 2}">class="active"</c:if>><a <c:if test="${pager.currentPage > 3}">onclick="gopage(${pager.currentPage - 1})"</c:if><c:if test="${pager.currentPage <= 3}">onclick="gopage(2)"</c:if>><c:if test="${pager.currentPage > 3}">${pager.currentPage - 1}</c:if><c:if test="${pager.currentPage <= 3}">2</c:if></a></li>
				<li <c:if test="${pager.currentPage >= 3}">class="active"</c:if>><a <c:if test="${pager.currentPage > 3}">onclick="gopage(${pager.currentPage})"</c:if><c:if test="${pager.currentPage <= 3}">onclick="gopage(3)"</c:if>><c:if test="${pager.currentPage > 3}">${pager.currentPage}</c:if><c:if test="${pager.currentPage <= 3}">3</c:if></a></li>
				<li><a <c:if test="${pager.currentPage > 3}">onclick="gopage(${pager.currentPage + 1})"</c:if><c:if test="${pager.currentPage <= 3}">onclick="gopage(4)"</c:if>><c:if test="${pager.currentPage > 3}">${pager.currentPage + 1}</c:if><c:if test="${pager.currentPage <= 3}">4</c:if></a></li>
				<li><a <c:if test="${pager.currentPage > 3}">onclick="gopage(${pager.currentPage + 2})"</c:if><c:if test="${pager.currentPage <= 3}">onclick="gopage(5)"</c:if>><c:if test="${pager.currentPage > 3}">${pager.currentPage + 2}</c:if><c:if test="${pager.currentPage <= 3}">5</c:if></a></li>
				<li <c:if test="${pager.currentPage eq pager.totalPage}">class="disabled"</c:if>><a onclick="forwardpage()" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
				<li><a>共<span style="color:red;">${pager.totalPage}</span>页</a></li>
			</ul>
		</nav>
	</div>
</c:if>



