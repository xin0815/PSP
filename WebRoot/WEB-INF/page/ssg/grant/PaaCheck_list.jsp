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
		<title>贫困认定学院审核</title>
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
					swal({title: "温馨提示",text: "该班级申请将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
		        	swal({title: "温馨提示",text: "该班级申请将整体审核通过，您确定审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#tjrdForm").submit();
		        	});
				});
			})   	
		</script>
	</head>
	<body>
		<legend>
			贫困认定—学院审核
		</legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度贫困认定指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核班级。</h4></div>
			</c:if>
			<form action="paaCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>贫困认定年度：</label>${poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>贫困认定名称：</label>
						${poorInfo.pname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						<label>学院：</label>${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>班级：</label>
						<select name="cclassId" class="form-control">
							<c:forEach var="cc" items="${classList}">
								<option value="${cc.cid }" <c:if test="${cclassId eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
				</div>
			</form>
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
				
				<c:forEach var="pa" items="${paList}" varStatus="st">
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
			<c:if test="${not empty paList}">
			<button type="button" class="btn btn-primary" id="pkrdck">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整班退回</button>
			<button type="button" class="btn btn-warning" id="tjrd">整班通过</button>
			</c:if>
		</center>
			<form action="poorApplication/info" method="post" id="pkrdckForm">
				<input type="hidden" name="paid" id="pkrdck_paid"/>
			</form>
			<form action="paaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="paaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
