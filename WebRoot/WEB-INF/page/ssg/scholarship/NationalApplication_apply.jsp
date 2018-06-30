<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
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
	    <base href="<%=basePath%>">    
	    <title>国家奖学金申请</title>    
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
	    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
	    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
	<style>
	.xinghao{
		color: red;
		font-size: 20px;
		margin-right: 5px;
		vertical-align: top;
	}
</style>
  		<script>    
  			$(function(){
  				$("#tjBtn").click(function(){//提交
  					if(check()){
  						swal({title: "温馨提示",text: "提交后将不能修改，您确定要提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
  							$("#isStuSubmit").val(true);
  	  						$("#applyForm").submit();
  						});
  					}
				});
  				$("#zcBtn").click(function(){//暂存
  					if(check()){
  						swal({title: "温馨提示",text: "您确定要暂存吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
  							$("#isStuSubmit").val(false);
  							$("#applyForm").submit();
  						});
  					}
				});
			})   
			function check(){
  				trimAll();
  				if($("#nareason").val() == ""){
  					swal("错误提示", "请填写申请理由", "error");
  					$("#nareason").focus();
  					return false;
  				}
  				if(!ajaxCheck()){
  					return false;
  				}
  				return true;
  			}
  			function ajaxCheck(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>nationalApplication/ajaxCheck";
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
			国家奖学金申请
		</legend>
		<c:if test="${empty nationalInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家奖学金指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty nationalInfo }">
			<div class="well form-search">
				学年：<u>${nationalInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国家奖学金名称：<u>${nationalInfo.name}</u>
			</div>
			<fieldset <c:if test="${naInfo.isStuSubmit eq true}">disabled="disabled"</c:if>>
			<form action="nationalApplication/apply" method="post" id="applyForm" class="form-horizontal">
				<input type="hidden" name="naid" value="${naInfo.naid}" />
				<input type="hidden" name="student.sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="nationalInfo.nid" value="${nationalInfo.nid}" />
				<input type="hidden" name="cclass.cid" value="${stu.cclass.cid}" />
				<input type="hidden" name="isStuSubmit" id="isStuSubmit" />
				<table class="table table-bordered table-condensed table-striped">
					<tr>
						<th rowspan="4">
							基本情况
						</th>
					    <th>姓名</th>
					    <td>${stu.sname}</td>
					    <th>性别</th>
					    <td>${stu.ssex}</td>
					    <th>出生年月</th>
					    <td>${stu.sbirthDate}</td>
					</tr>
					<tr>
						<th>政治面貌</th>
					    <td>${stu.spolitical}</td>
					    <th>民族</th>
					    <td>${stu.snation.name}</td>
					    <th>年级</th>
					    <td>${stu.cclass.cgrade}</td>
					</tr>
					<tr>
						<th>专业</th>
						<td>${stu.cclass.cmajor}</td>
						<th>联系电话</th>
						<td>${stu.sphoneNum}</td>
					    <th>班级</th>
					    <td>${stu.cclass.cclassName}</td>
				    </tr>
				    <tr>
				    	<th>身份证号码</th>
						<td>${stu.sidCard}</td>
				    </tr>
					<tr>
				    	<th rowspan="5"><span class="xinghao">*</span>申请理由</th>
					</tr>
					<tr>
					    <td colspan="6"><textarea class="form-control" id="nareason" name="nareason" rows="5" maxlength="256">${naInfo.nareason}</textarea></td>
					</tr>
				</table>
				<div align="center">
					<button type="button" class="btn btn-primary" id="zcBtn">暂存</button>
					<button type="button" class="btn btn-primary" id="tjBtn">提交</button>
				</div>
			</form>
			</fieldset>
		</c:if>
	</body>
</html>
