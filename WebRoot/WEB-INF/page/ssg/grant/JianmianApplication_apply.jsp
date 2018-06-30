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
	    <title>减免学费申请</title>    
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
  		<script language="javascript">    
  			$(function(){
  				$("#tjBtn").click(function(){//提交
  					if(check()){
		  				swal({
						title : "警告",
						text : "提交后将不能修改，您确定提交吗？",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "ok",
						closeOnConfirm : false
						}, function() {
  					$("#isSubmit").val(true);
  					$("#applyForm").submit();
				});
				}
				});
  				$("#zcBtn").click(function(){//暂存
  					if(check()){
		  				swal({
						title : "警告",
						text : "您确定要暂存吗？",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "ok",
						closeOnConfirm : false
						}, function() {
  					$("#isSubmit").val(false);
  					$("#applyForm").submit();
				});
				}
				});
			}) 
			function check(){
			    trimAll();
  				 if($("#jasgrade").val() == ""){
  					swal("错误提示", "请选择减免学费等级", "error");
  					$("#jasgrade").focus();
  					return false;
  				}
  				if($("#jareason").val() == ""){
  					swal("错误提示", "请填写学生申请理由", "error");
  					$("#jareason").focus();
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
				var src = "<%=basePath%>jianmianApplication/ajaxCheck?jasgrade="+$("#jasgrade").val();
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
			减免学费申请
		</legend>
		<c:if test="${empty jianmianInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度减免学费指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty jianmianInfo }">
			<div class="well form-search">
				<label>减免学费年度：<u>${jianmianInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;减免学费名称：<u>${jianmianInfo.name}</u></label>
			</div>
			<fieldset <c:if test="${jaInfo.isSubmit eq true}">disabled="disabled"</c:if>>
			<form action="jianmianApplication/apply" method="post" id="applyForm" class="form-horizontal">
				<input type="hidden" name="schoolYear.syid" value="${jianmianInfo.schoolYear.syid}" />
				<input type="hidden" name="jaid" value="${jaInfo.jaid}" />
				<input type="hidden" name="student.sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="jianmianInfo.jid" value="${jianmianInfo.jid}" />
				<input type="hidden" name="bclass.cid" value="${stu.cclass.cid}" />
				<input type="hidden" name="isSubmit" id="isSubmit" />
				<table class="table table-bordered table-condensed table-striped">
					<tr>
					    <th>学号</th>
					    <th>姓名</th>
					    <th>学院</th>
					    <th>年级</th>
					    <th>班级</th>
					    <th><span class="xinghao">*</span>减免学费等级</th>
				    <tr>
					    <td>${stu.sstudentCode}</td>
					    <td>${stu.sname}</td>
						<td>${stu.cclass.academyInfo.aname}</td>
					    <td>${stu.cclass.cgrade}</td>
					    <td>${stu.cclass.cclassName}</td>
					    <td>
					    	<select name="jasgrade" id="jasgrade" class="form-control">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${jaInfo.jasgrade eq '1'}">selected="selected"</c:if>>一等</option>
					    		<option value="2" <c:if test="${jaInfo.jasgrade eq '2'}">selected="selected"</c:if>>二等</option>
					    		<option value="3" <c:if test="${jaInfo.jasgrade eq '3'}">selected="selected"</c:if>>三等</option>
					    	</select>
					    </td>
					</tr>
					<tr>
				    	<th colspan="7"><span class="xinghao">*</span>申请理由</th>
					</tr>
					<tr>
					    <td colspan="7" rowspan="5"><textarea class="form-control" id="jareason" name="jareason" rows="5" maxlength="256">${jaInfo.jareason}</textarea></td>
					</tr>
				</table>
				<div align="center">
					<button type="button" class="btn btn-info" id="zcBtn">暂存</button>
					<button type="button" class="btn btn-info" id="tjBtn">提交</button>
				</div>
			</form>
			</fieldset>
		</c:if>
	</body>
</html>
