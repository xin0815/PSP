<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>国家奖学金学院审核</title>
    	<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
			    	if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要查看的记录", "error");
			            return;
			       	}
		        	$("#ckxx_naid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要退回的记录", "error");
			            return;
			       	}
		        	swal({title: "温馨提示",text: "您确定要退回该申请吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#th_naid").val($("input[name='_radio']:checked").val());
						$("#thForm").submit();
		        	});
				});
				$("#tjrd").click(function(){
					if(ajaxCheckSubmit()){
						swal({title: "温馨提示",text: "学院所有申请信息将整体提交认定，您确定要提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#tjrdForm").submit();
			        	});
					}
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>naaCheck/ajaxCheckSubmit";
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
			国家奖学金学院审核
		</legend>
		<c:if test="${empty nationalInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty nationalInfo }">
			<form action="naaCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>学年：</label>${nationalInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>国家奖学金名称：</label>
						${nationalInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						<label>学院：</label>${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
				</div>
			</form>
			<table class="table table-bordered table-condensed ">
				<tr>
					<th width="30">
					</th>
					<th width="50">
						序号
					</th>
					<th>
						学生姓名
					</th>
					<th>
						公民身份证号码
					</th>
					<th>
						院系
					</th>
					<th>
						专业
					</th>
					<th>
						学号
					</th>
					<th>
						性别
					</th>
					<th>
						民族
					</th>
					<th>
						入学年月
					</th>
				</tr>
				
				<c:forEach var="na" items="${naList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${na.naid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${na.student.sname}
						</td>
						<td>
							${na.student.sidCard}
						</td>
						<td>
							${na.cclass.academyInfo.aname}
						</td>
						<td>
							${na.cclass.cmajor}
						</td>
						<td>
							${na.student.sstudentCode}
						</td>
						<td>
						    ${na.student.ssex}
						</td>
						<td>
							${na.student.snation.name}
						</td>
						<td>
						    ${na.cclass.cgrade}
						</td>
					</tr>
				</c:forEach>
			</table>
			<center>
			<c:if test="${not empty naList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${naaCheck eq 2 }">disabled="disabled"</c:if>>退回申请</button>
			<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${naaCheck eq 2 }">disabled="disabled"</c:if>>整院提交</button>
			</c:if>
			</center>
			<form action="nationalApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="naid" id="ckxx_naid"/>
			</form>
			<form action="naaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="naid" id="th_naid"/>
			</form>
			<form action="naaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="nid" value="${nationalInfo.nid}" />
				<input type="hidden" name="academyCode" value="${acaInfo.aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
