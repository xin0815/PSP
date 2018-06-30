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
	    <title>校内奖学金申请</title>    
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
  				 if($("#saslevel").val() == ""){
  					swal("错误提示", "请选择奖学金等级", "error");
  					$("#saslevel").focus();
  					return false;
  				}
  				if($("#saslevel").val() == "4"){//单项奖
  					if($("#sassingleLevel").val() == ""){
  	  					swal("错误提示", "请选择单项奖类型", "error");
  	  					$("#sassinglelevel").focus();
  	  					return false;
  	  				}
  					
  				}
  				if($("#saoldReward").val() == ""){
  					swal("错误提示", "请填写学生曾获得奖励", "error");
  					$("#saoldReward").focus();
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
				var src = "<%=basePath%>scholarshipApplication/ajaxCheck?saslevel="+$("#saslevel").val()+"&sassingleLevel="+$("#sassingleLevel").val();
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
  			function showSingleLevel(value){
  				if(value == '4'){
  					$("#sassingleLevel").show();
  				}else{
  					$("#sassingleLevel").hide();
  					$("#sassingleLevel").val("");
  				}
  			}
		</script>      
	</head>
	<body>
		<legend>
			校内奖学金申请
		</legend>
		<c:if test="${empty scholarshipInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度校内奖学金指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty scholarshipInfo }">
			<div class="well form-search">
				<label>校内奖学金年度：<u>${scholarshipInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;校内奖学金名称：<u>${scholarshipInfo.sname}</u></label>
			</div>
			<fieldset <c:if test="${ssInfo.isSubmit eq true}">disabled="disabled"</c:if>>
			<form action="scholarshipApplication/apply" method="post" id="applyForm" class="form-horizontal">
				<input type="hidden" name="schoolYear.syid" value="${scholarshipInfo.schoolYear.syid}" />
				<input type="hidden" name="said" value="${ssInfo.said}" />
				<input type="hidden" name="student.sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="scholarshipInfo.sid" value="${scholarshipInfo.sid}" />
				<input type="hidden" name="bclass.cid" value="${stu.cclass.cid}" />
				<input type="hidden" name="isSubmit" id="isSubmit" />
				<table class="table table-bordered table-condensed table-striped">
					<tr>
					    <th>学号</th>
					    <th>姓名</th>
					    <th>学院</th>
					    <th>年级</th>
					    <th>班级</th>
					    <th><span class="xinghao">*</span>奖学金认定等级</th>
					    <th>
					    	单项奖类型
					    </th>
				    <tr>
					    <td>${stu.sstudentCode}</td>
					    <td>${stu.sname}</td>
						<td>${stu.cclass.academyInfo.aname}</td>
					    <td>${stu.cclass.cgrade}</td>
					    <td>${stu.cclass.cclassName}</td>
					    <td>
					    	<select name="saslevel" id="saslevel" class="form-control" onchange="showSingleLevel(this.value)">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${ssInfo.saslevel eq '1'}">selected="selected"</c:if>>一等奖学金</option>
					    		<option value="2" <c:if test="${ssInfo.saslevel eq '2'}">selected="selected"</c:if>>二等奖学金</option>
					    		<option value="3" <c:if test="${ssInfo.saslevel eq '3'}">selected="selected"</c:if>>三等奖学金</option>
					    		<option value="4" <c:if test="${ssInfo.saslevel eq '4'}">selected="selected"</c:if>>单项奖</option>
					    		<option value="5" <c:if test="${ssInfo.saslevel eq '5'}">selected="selected"</c:if>>优秀学生干部奖</option>
					    	</select>
					    </td>
					    <td>
					    	<select name="sassingleLevel" id="sassingleLevel" class="form-control" <c:if test="${ssInfo.saslevel ne '4'}">style="display:none"</c:if>>
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${ssInfo.sassingleLevel eq 1}">selected="selected"</c:if>>道德风尚奖</option>
					    		<option value="2" <c:if test="${ssInfo.sassingleLevel eq 2}">selected="selected"</c:if>>科技创新奖</option>
					    		<option value="3" <c:if test="${ssInfo.sassingleLevel eq 3}">selected="selected"</c:if>>民族团结奖</option>
					    		<option value="4" <c:if test="${ssInfo.sassingleLevel eq 4}">selected="selected"</c:if>>社会公益活动奖</option>
					    		<option value="5" <c:if test="${ssInfo.sassingleLevel eq 5}">selected="selected"</c:if>>鼓励进步奖</option>
					    		<option value="6" <c:if test="${ssInfo.sassingleLevel eq 6}">selected="selected"</c:if>>学习优秀奖</option>
					    		<option value="7" <c:if test="${ssInfo.sassingleLevel eq 7}">selected="selected"</c:if>>文体技能奖</option>
					    	</select>
					    </td>
					</tr>
					<tr>
				    	<th colspan="7"><span class="xinghao">*</span>曾获何种奖励</th>
					</tr>
					<tr>
					    <td colspan="7" rowspan="5"><textarea class="form-control" id="saoldReward" name="saoldReward" rows="5" maxlength="512">${ssInfo.saoldReward}</textarea></td>
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
