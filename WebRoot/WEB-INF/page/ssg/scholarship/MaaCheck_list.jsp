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
		<title>明德奖学金学院审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		 <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
					if($("input[name='_checkbox']:checked").size() != 1){
			    		swal("错误提示", "请选择且只选择一条记录", "error");
			            return;
			       	}
			        $("#ckxx_maid").val($("input[name='_checkbox']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					var checks = $("input[name='_checkbox']:checked");
					if(checks.size() < 1){
			    		swal("错误提示", "请先选择您要退回的记录", "error");
			            return;
			       	}
					swal({title: "温馨提示",text: "您确定要退回该申请吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						if(checks.size() == 1){
		                    $("#th_maids").val(checks.val());
		                }else{
		                    var str = "";
		                    checks.each(function(i,o){
		                    	str = str + $(o).val()+",";
		               	 	});
		                	$("#th_maids").val(str);
		          		 }
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					if(ajaxCheckSubmit()){
						swal({title: "温馨提示",text: "学院将整体提交认定，提交后不能修改，您确定要提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#tjrdForm").submit();
			        	});
					}
				});
			})   	
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>maaCheck/ajaxCheckSubmit";
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
		<c:if test="${empty mingdeInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度明德奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty mingdeInfo }">
			<form action="maaCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>明德奖学金年度：${mingdeInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>明德奖学金名称：
						${mingdeInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
				</div>
			</form>
			<table class="table table-bordered table-condensed ">
				<tr>
					<th width="50">
					</th>
					<th>
						序号
					</th>
					<th>
						姓名
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
						年级
					</th>
					<th>
						生源地
					</th>
					<th>
						手机号码
					</th>
				</tr>
				
				<c:forEach var="ma" items="${maList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="checkbox" " name="_checkbox" value="${ma.maid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${ma.student.sname}
						</td>
						<td>
							${ma.cclass.academyInfo.aname}
						</td>
						<td>
							${ma.cclass.cmajor}
						</td>
						<td>
							${ma.student.sstudentCode}
						</td>
						<td>
							${ma.student.ssex}
						</td>
						<td>
							${ma.student.snation.name}
						</td>
						<td>
							${ma.cclass.cgrade}
						</td>
						<td>
							${ma.student.soriginHome}
						</td>
						<td>
							${ma.student.sphoneNum}
						</td>
					</tr>
				</c:forEach>
			</table>
			<center>
				<c:if test="${not empty maList}">
				<button type="button" class="btn btn-primary" id="ckxx" >查看详情</button>
				<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>退回申请</button>
				<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整院提交</button>
				</c:if>
			</center>
			<form action="mingdeApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="maid" id="ckxx_maid"/>
			</form>
			<form action="maaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="maids" id="th_maids"/>
			</form>
			<form action="maaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="mid" value="${mingdeInfo.mid}" />
			</form>
		</c:if>
	</body>
</html>
