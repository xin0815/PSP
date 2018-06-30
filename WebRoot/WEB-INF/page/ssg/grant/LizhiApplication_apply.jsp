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
	    <title>励志奖学金申请</title>    
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
  							$("#isSubmit").val(true);
  							$("#applyForm").submit();
  						});
  					}
				});
  				$("#zcBtn").click(function(){//暂存
  					if(check()){
  						swal({title: "温馨提示",text: "您确定要暂存吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
  							$("#isSubmit").val(false);
  							$("#applyForm").submit();
  						});
  					}
				});
			})
			function check(){
  				trimAll();
  				if($("#lahomeResidence").val() == ""){
  					swal("错误提示", "请选择家庭户口", "error");
  					$("#lahomeResidence").focus();
  					return false;
  				}else if($("#lahomePopulationTotal").val() == ""){
  					swal("错误提示", "请填写家庭人口总数", "error");
  					$("#lahomePopulationTotal").focus();
  					return false;
  				}else if($("#lahomeIncomePmtotal").val() == ""){
  					swal("错误提示", "请填写家庭月总收入", "error");
  					$("#lahomeIncomePmtotal").focus();
  					return false;
  				}else if($("#lahomeIncomePmpp").val() == ""){
  					swal("错误提示", "请填写人均月收入", "error");
  					$("#lahomeIncomePmpp").focus();
  					return false;
  				}else if($("#lahomeIncomeSource").val() == ""){
  					swal("错误提示", "请填写收入来源", "error");
  					$("#lahomeIncomeSource").focus();
  					return false;
  				}else if($("#gagrade").val() == ""){
  					swal("错误提示", "请选择申请等级", "error");
  					$("#lagrade").focus();
  					return false;
  				}else if($("#laoldReward").val() == ""){
  					swal("错误提示", "请填写曾获何种奖励", "error");
  					$("#laoldReward").focus();
  					return false;
  				}else if($("#lareason").val() == ""){
  					swal("错误提示", "请填写申请理由", "error");
  					$("#lareason").focus();
  					return false;
  				}else if(!ajaxCheck()){
  					return false;
  				}
  				return true;
  			}
  			
  			function ajaxCheck(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>lizhiApplication/ajaxCheck";
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
			励志奖学金申请
		</legend>
		<c:if test="${empty lizhiInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度励志奖学金指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty lizhiInfo }">
			<div class="well form-search">
				<label>励志奖学金年度：${lizhiInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;励志奖学金名称：${lizhiInfo.name}</label>
			</div>
			<fieldset <c:if test="${laInfo.isSubmit eq true}">disabled="disabled"</c:if>>
			<form action="lizhiApplication/apply" method="post" id="applyForm" class="form-horizontal">
				<input type="hidden" name="laid" value="${laInfo.laid}" />
				<input type="hidden" name="student.sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="lizhiInfo.lid" value="${lizhiInfo.lid}" />
				<input type="hidden" name="bclass.cid" value="${stu.cclass.cid}" />
				<input type="hidden" name="isSubmit" id="isSubmit" />
				<table class="table table-bordered table-condensed table-striped">
					<tr>
					    <th>学号</th>
					    <th>姓名</th>
					    <th>学院</th>
					    <th>年级</th>
					    <th>班级</th>
					    <th>贫困认定等级</th>
				    <tr>
					    <td>${stu.sstudentCode}</td>
					    <td>${stu.sname}</td>
						<td>${stu.cclass.academyInfo.aname}</td>
					    <td>${stu.cclass.cgrade}</td>
					    <td>${stu.cclass.cclassName}</td>
					    <td>
					    	<c:if test="${paInfo.pgrade eq '1'}">特别困难</c:if>
				    		<c:if test="${paInfo.pgrade eq '2'}">困难</c:if>
				    		<c:if test="${paInfo.pgrade eq '3'}">一般困难</c:if>
					    </td>
					</tr>
					<tr>
						<th>银行卡号</th>
				    	<th><span class="xinghao">*</span>选择家庭户口</th>
				    	<th><span class="xinghao">*</span>家庭人口总数</th>
				    	<th><span class="xinghao">*</span>家庭月总收入</th>
				    	<th><span class="xinghao">*</span>人均月收入</th>
				    	<th><span class="xinghao">*</span>收入来源</th>
					</tr>
					<tr>
						<td>
							<input type="hidden" name="lacard" value="${paInfo.pacard }" />
							${paInfo.pacard }
						</td>
						<td><select name="lahomeResidence" id="lahomeResidence" class="form-control">
							<option value="">--请选择--</option>
							<option value="1" <c:if test="${laInfo.lahomeResidence eq '1' }">selected="selected"</c:if>>城镇</option>
							<option value="2" <c:if test="${laInfo.lahomeResidence eq '2' }">selected="selected"</c:if>>农业</option>
						</select></td>
						<td><input type="text" name="lahomePopulationTotal" id="lahomePopulationTotal" value="${laInfo.lahomePopulationTotal}" onkeydown="checkInteger(this,2)" onkeypress="checkInteger(this,2)" onkeyup="checkInteger(this,2)" class="form-control"  placeholder="家庭人口总数" /></td>
						<td><input type="text" name="lahomeIncomePmtotal" id="lahomeIncomePmtotal" value="${laInfo.lahomeIncomePmtotal}" onkeydown="checkInteger(this,6)" onkeypress="checkInteger(this,6)" onkeyup="checkInteger(this,6)" class="form-control"  placeholder="家庭月收入" /></td>
						<td><input type="text" name="lahomeIncomePmpp" id="lahomeIncomePmpp" value="${laInfo.lahomeIncomePmpp}" onkeydown="checkInteger(this,6)" onkeypress="checkInteger(this,6)" onkeyup="checkInteger(this,6)" class="form-control"  placeholder="人均月收入" /></td>
						<td><input type="text" name="lahomeIncomeSource" id="lahomeIncomeSource" value="${laInfo.lahomeIncomeSource}" class="form-control" maxlength="32"  placeholder="收入来源" /></td>
					</tr>
					<tr>
				    	<th colspan="3"><span class="xinghao">*</span>曾获何种奖励</th>
				    	<th colspan="6"><span class="xinghao">*</span>申请理由</th>
					</tr>
					<tr>
					    <td colspan="3" rowspan="5"><textarea class="form-control" name="laoldReward" id="laoldReward" maxlength="512" rows="5">${laInfo.laoldReward}</textarea></td>
					    <td colspan="3" rowspan="5"><textarea class="form-control" name="lareason" maxlength="512" id="lareason" rows="5">${laInfo.lareason}</textarea></td>
					</tr>
					<tr>
				    	
					</tr>
					<tr>
					    
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
