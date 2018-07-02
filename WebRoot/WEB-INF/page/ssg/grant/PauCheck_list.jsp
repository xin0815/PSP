<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>学校审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script type="text/javascript">
			$(function(){
				$("#pkrdck").click(function(){
					if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要查看的记录", "error");
			            return;
			       	}
			        $("#pkrdck_paid").val($("input[name='_radio']:checked").val());
					$("#pkrdckForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该学院申请信息将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					swal({title: "温馨提示",text: "您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#tjrdForm").submit();
		        	});
				});
				$("#tx").click(function(){
	    			window.location.href="<%=basePath%>pauCheck/tq";
	    		});
			})   	
		</script>
	</head>
	<body>
		<legend>
			贫困认定学校审核
		</legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度贫困认定指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="pauCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>贫困认定年度：</label>${poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>贫困认定名称：</label>
						${poorInfo.pname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						<label>学院：</label>
						<select name="aacademyCode" class="form-control">
							<c:forEach var="aca" items="${acaList}">
								<option value="${aca.aacademyCode}" <c:if test="${aca.aacademyCode eq aacademyCode }">selected="selected"</c:if> >${aca.aname}</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<button type="button" class="btn btn-primary" id = "tx">特权模式</button>
				</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;特别困难：${bean.pdspecialDifficultyN}&nbsp;&nbsp;&nbsp;&nbsp;
			困难：${bean.pddifficultyN }&nbsp;&nbsp;&nbsp;&nbsp;一般困难：${bean.pdgeneralDiffcultyN }&nbsp;&nbsp;&nbsp;&nbsp;不困难：${bean.unDiffcultyN }</label>
			<table class="table table-bordered table-hover ">
				<tr>
					<th width="50">
					</th>
					<th>
						序号
					</th>
					<th>
						院系
					</th>
					<th>
						专业
					</th>
					<th>
						年级
					</th>
					<th>
						班级名称
					</th>
					<th>
						学号
					</th>
					<th>
						姓名
					</th>
					<th>
						性别
					</th>
					<th>
						等级
					</th>
				</tr>
				
				<c:forEach var="pa" items="${pager.data}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${pa.paid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${pa.student.cclass.academyInfo.aname}
						</td>
						<td>
							${pa.student.cclass.cmajor}
						</td>
						<td>
							${pa.student.cclass.cgrade}
						</td>
						<td>
							${pa.student.cclass.cclassName}
						</td>
						<td>
							${pa.student.sstudentCode}
						</td>
						<td>
							${pa.student.sname}
						</td>
						<td>
						    ${pa.student.ssex}
						</td>
						<td>
						    <c:if test="${pa.pgrade eq '1'}">特别困难</c:if>
							<c:if test="${pa.pgrade eq '2'}">困难</c:if>
							<c:if test="${pa.pgrade eq '3'}">一般困难</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
			<center>
			<c:if test="${not empty pager.data}">
			<button type="button" class="btn btn-primary" id="pkrdck">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="tjrd">审核通过</button>
			</c:if>
			</center>
			<form action="poorApplication/info" method="post" id="pkrdckForm">
				<input type="hidden" name="paid" id="pkrdck_paid"/>
			</form>
			<form action="pauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="pauCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>