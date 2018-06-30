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
		<title>申请学年度贫困认定汇总</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
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
				$("#tj").click(function(){
					if(ajaxCheckSubmit()){
						swal({title: "温馨提示",text: "把学院所有班级的贫困认定申请整体提交学校审核，您确定提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							window.location.href="<%=basePath%>paaQuery/tijiao";
	 					});
					}
				});
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该班级申请将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>paaQuery/ajaxCheckSubmit";
			    // 指定要打开的页面
			    xmlhttp.open("POST", src, false);
			    // 指定页面打开完之后要进行的操作.
			    xmlhttp.onreadystatechange =function(){
					// 请求已完成
					if (xmlhttp.readyState == 4) {
						var message =xmlhttp.responseText;
						if(message !="success"){
				    		swal("错误提示", message, "error");
							flag = false;
						}
					}
				};
			    // 开始发起浏览请求, Mozilla 必须加 null
			    xmlhttp.send();
			    return flag;
			}
		</script>
	</head>
	<body>
		<legend>
			申请年度贫困认定汇总
		</legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度贫困认定指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无审核通过的班级。</h4></div>
			</c:if>
			<form action="paaQuery/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						贫困认定年度：${poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						贫困认定名称：
						${poorInfo.pname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						学院：${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						班级：
						<select name="cclassId" class="form-control">
							<c:forEach var="cc" items="${classList}">
								<option value="${cc.cid }" <c:if test="${cclassId eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<button type="button" class="btn btn-warning" id="tj" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>学院整体提交</button>
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
			<center>
			<c:if test="${not empty paList}">
				<button type="button" class="btn btn-primary" id="pkrdck">查看详情</button>
				<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			</c:if>
			</center>
			<form action="poorApplication/info" method="post" id="pkrdckForm">
				<input type="hidden" name="paid" id="pkrdck_paid"/>
			</form>
			<form action="paaQuery/cancel" method="post" id="thForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
