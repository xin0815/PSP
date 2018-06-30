<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>新增学工</title>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
    <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
    <link href="<%=basePath%>css/jquery-ui-1.9.2.custom.css" rel="stylesheet" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery-ui-1.9.2.custom.js"></script>
	<script language="javascript" src="<%=basePath%>js/jquery/jquery-ui-timepicker-addon.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
	<style>
		.xinghao{
			color: red;
			font-size: 20px;
			margin-right: 5px;
			vertical-align: top;
		}
	</style>
 	<script type="text/javascript">
   $(function(){
		$("#bc").click(function(){
			if(check()){
				swal({title: "温馨提示",text: "您确定要保存吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#form1").submit();
				});
			}
        	
		});
		$("#qx").click(function(){
        	window.location.href='<%=basePath%>leader/list';
		});
	});
	function check(){
		trimAll();
		if($("#tname").val() == ""){
			swal("错误提示", "请填写姓名", "error");
			$("#tname").focus();
			return false;
		}else if($("#bteacherId").val() == ""){
			swal("错误提示", "请填写教工号", "error");
			$("#bteacherId").focus();
			return false;
		}else if(!ajaxCommonCheck("<%=basePath%>leader/isUniqueTeacherId?tid="+$("#tid").val()+"&bteacherId="+$("#bteacherId").val())){
			swal("错误提示", "该教工号已存在", "error");
			$("#bteacherId").focus();
			return false;
		}else if($("#tphone").val() == ""){
			swal("错误提示", "请填写联系电话", "error");
			$("#tphone").focus();
			return false;
		}else if($("#tduty").val() == ""){
			swal("错误提示", "请填写行政职务", "error");
			$("#tduty").focus();
			return false;
		}else if($("#tproTitle").val() == ""){
			swal("错误提示", "请填写职称", "error");
			$("#tproTitle").focus();
			return false;
		}else if($("#teduBackground").val() == ""){
			swal("错误提示", "请填写学历", "error");
			$("#teduBackground").focus();
			return false;
		}else if($("#temail").val() == ""){
			swal("错误提示", "请填写电子邮箱", "error");
			$("#temail").focus();
			return false;
		}else if($("#tbirthDay").val() == ""){
			swal("错误提示", "请填写出生年月", "error");
			$("#tbirthDay").focus();
			return false;
		}else if($("#aacademyCode").val() == ""){
			swal("错误提示", "请选择所在学院", "error");
			$("#aacademyCode").focus();
			return false;
		}
		return true;
	}
	
	$(document).ready(function() { 
		$('#tbirthDay').datepicker({
			dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
			dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
			dateFormat: 'yy-mm',
           	prevText:'前一月',
           	nextText:'后一月',
           	currentText:' ',
           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
           	closeText:'确定',
           	changeMonth: true,
           	changeYear: true,
           	showMonthAfterYear: true,
           	yearRange:"1950:2016"
		});
		
		$("#aacademyCode").select2();
	});
</script>
</head>
  
<body>
	<legend>学工领导及干部管理</legend>
	<div class="container">
		<form action="leader/save" method="post" id="form1" class="form-horizontal">
			<input type="hidden" name="tid" id="tid" value="${bt.tid}" />
			<input type="hidden" name="sysUserId" id="sysUserId" value="${bt.sysUserId}" />
			<input type="hidden" name="isActive" id="isActive" value="${bt.isActive}" />
			<fieldset>
				<div class="form-group row">
					<div class="col-sm-4">
						<label for="tname"><span class="xinghao">*</span>姓名</label>
						<input class="form-control" id="tname" type="text" value="${bt.tname}" maxlength="32" name="tname"/>
					</div>
		            <div class="col-sm-4">
		            	<label for="bteacherId"><span class="xinghao">*</span>教工号</label>
		                 <input class="form-control" id="bteacherId" type="text" value="${bt.bteacherId}" name="bteacherId" maxlength="9" onkeydown="checkInteger(this,9)" onkeypress="checkInteger(this,9)" onkeyup="checkInteger(this,9)"/>
		            </div>
		            <div class="col-sm-4">
           				<label for="tphone"><span class="xinghao">*</span>联系电话</label>
                 		<input class="form-control" id="tphone" type="tel" value="${bt.tphone}" maxlength="20" name="tphone" />
					</div>
				</div>
			   	<div class="form-group row">
			   		<div class="col-sm-4">
		            	<label for="tduty"><span class="xinghao">*</span>行政职务</label>
		                <input class="form-control" id="tduty" type="text" value="${bt.tduty}" maxlength="20" name="tduty"/>
		            </div>
		            <div class="col-sm-4">
		            	<label for="tproTitle" ><span class="xinghao">*</span>职称</label>
		                 <input class="form-control" id="tproTitle" type="text" value="${bt.tproTitle}" maxlength="20" name="tproTitle"/>
		            </div>
		            <div class="col-sm-4">
						<label for="teduBackground"><span class="xinghao">*</span>学历</label>
						<input class="form-control" id="teduBackground" type="text" value="${bt.teduBackground}" maxlength="10" name="teduBackground"/>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-4">
						<label for="temail"><span class="xinghao">*</span>电子邮箱</label>
						<input class="form-control" id="temail" type="text" value="${bt.temail}" maxlength="32" name="temail"/>
					</div>
					<div class="col-sm-4">
						<label for="tbirthDay"><span class="xinghao">*</span>出生年月</label>
						<input class="form-control" id="tbirthDay" type="text" value="${bt.tbirthDay}" readonly="readonly" name="tbirthDay"/>
					</div>
		            <div class="col-sm-4">
		            	<label for="aacademyCode"><span class="xinghao">*</span>所在学院</label>
		            	<select class="form-control" name="aacademy.aacademyCode" id="aacademyCode">
		            		<c:if test="${teacher.isSchoolTeacher eq true}">
		            			<option value="">——请选择——</option>
		            			<c:forEach var="acc" items="${aacademyList}">
		            				<option value="${acc.aacademyCode}" <c:if test="${acc.aacademyCode eq bt.aacademy.aacademyCode}">selected="selected"</c:if>>${acc.aname}</option>
		            			</c:forEach>
		            		</c:if>
		            		<c:if test="${teacher.isAcademyTeacher eq true}">
		            			<option value="${aacademy.aacademyCode}">${aacademy.aname}</option>
		            		</c:if>
		            	</select>
		            </div>
     			</div>
				<div class="checkbox">
					<c:if test="${teacher.isSchoolTeacher eq true}">
						<label>
					  		<input type="checkbox" name="isSchoolTeacher" <c:if test="${bt.isSchoolTeacher eq true}">checked="checked"</c:if> />
							是否学校学工
						</label>
				   </c:if>
				   <label>
				  		<input type="checkbox" name="isAcademyTeacher" <c:if test="${bt.isAcademyTeacher eq true}">checked="checked"</c:if>/>
						是否学院学工
					</label>
					<label>
				  		<input type="checkbox" name="isClassTeacher" <c:if test="${bt.isClassTeacher eq true}">checked="checked"</c:if>/>
						是否班主任
					</label>
				</div>
				<div class="form-group row text-center">
					<button type="button" class="btn btn-info" id="bc">保存</button>
					<button type="button" class="btn btn-info" id="qx">取消</button>
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>
