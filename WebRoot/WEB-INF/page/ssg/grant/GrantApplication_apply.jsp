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
	    <title>国家助学金申请</title>    
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
  				if($("#gahomeResidence").val() == ""){
  					swal("错误提示", "请选择家庭户口", "error");
  					$("#gahomeResidence").focus();
  					return false;
  				}else if($("#gahomePopulationTotal").val() == ""){
  					swal("错误提示", "请填写家庭人口总数", "error");
  					$("#gahomePopulationTotal").focus();
  					return false;
  				}else if($("#gahomeIncomePmtotal").val() == ""){
  					swal("错误提示", "请填写家庭月总收入", "error");
  					$("#gahomeIncomePmtotal").focus();
  					return false;
  				}else if($("#gahomeIncomePmpp").val() == ""){
  					swal("错误提示", "请填写人均月收入", "error");
  					$("#gahomeIncomePmpp").focus();
  					return false;
  				}else if($("#gahomeIncomeSource").val() == ""){
  					swal("错误提示", "请填写收入来源", "error");
  					$("#gahomeIncomeSource").focus();
  					return false;
  				}else if($("#gasgrade").val() == ""){
  					swal("错误提示", "请选择申请等级", "error");
  					$("#gasgrade").focus();
  					return false;
  				}else if($("#gareason").val() == ""){
  					swal("错误提示", "请填写申请理由", "error");
  					$("#gareason").focus();
  					return false;
  				}else if(!ajaxCheck()){
  					return false;
  				}
  				return true;
  			}
  			function ajaxCheck(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>grantApplication/ajaxCheck";
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
			国家助学金申请
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家助学金指标，请发布后再申请。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<div class="well form-search">
				<label>国家助学金年度：${grantInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;国家助学金名称：${grantInfo.name}</label>
			</div>
			<fieldset <c:if test="${gaInfo.isSubmit eq true}">disabled="disabled"</c:if>>
			<form action="grantApplication/apply" method="post" id="applyForm" class="form-horizontal">
				<input type="hidden" name="gaid" value="${gaInfo.gaid}" />
				<input type="hidden" name="student.sstudentCode" value="${stu.sstudentCode}" />
				<input type="hidden" name="grantInfo.gid" value="${grantInfo.gid}" />
				<input type="hidden" name="bclass.cid" value="${stu.cclass.cid}" />
				<input type="hidden" name="isSubmit" id="isSubmit" />
				<table class="table table-bordered table-condensed">
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
					<div class="form-group">
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
							<input type="hidden" name="gacard" value="${paInfo.pacard }" />
							${paInfo.pacard }
						</td>
						<td><select name="gahomeResidence" id="gahomeResidence" class="form-control">
							<option value="">--请选择--</option>
							<option value="1" <c:if test="${gaInfo.gahomeResidence eq '1' }">selected="selected"</c:if>>城镇</option>
							<option value="2" <c:if test="${gaInfo.gahomeResidence eq '2' }">selected="selected"</c:if>>农业</option>
						</select></td>
						<td><input type="text" name="gahomePopulationTotal" id="gahomePopulationTotal"  onkeydown="checkInteger(this,2)" onkeypress="checkInteger(this,2)" onkeyup="checkInteger(this,2)" maxlength="2" value="${gaInfo.gahomePopulationTotal}" class="form-control"  placeholder="家庭人口总数" /></td>
						<td><input type="text" name="gahomeIncomePmtotal" id="gahomeIncomePmtotal" onkeydown="checkInteger(this,6)" onkeypress="checkInteger(this,6)" onkeyup="checkInteger(this,6)" maxlength="6" value="${gaInfo.gahomeIncomePmtotal}" class="form-control"  placeholder="家庭月收入" /></td>
						<td><input type="text" name="gahomeIncomePmpp" id="gahomeIncomePmpp" onkeydown="checkInteger(this,6)" onkeypress="checkInteger(this,6)" onkeyup="checkInteger(this,6)" maxlength="6" value="${gaInfo.gahomeIncomePmpp}" class="form-control"  placeholder="人均月收入" /></td>
						<td><input type="text" name="gahomeIncomeSource" id="gahomeIncomeSource" value="${gaInfo.gahomeIncomeSource}" maxlength="64" class="form-control"  placeholder="收入来源" /></td>
					</tr>
					<tr>
						<th><span class="xinghao">*</span>申请等级</th>
				    	<th colspan="5"><span class="xinghao">*</span>申请理由</th>
					</tr>
					<tr>
						<td>
					    	<select name="gasgrade" id="gasgrade" class="form-control">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${gaInfo.gasgrade eq 1}">selected="selected"</c:if>>一等助学金</option>
					    		<option value="2" <c:if test="${gaInfo.gasgrade eq 2}">selected="selected"</c:if>>二等助学金</option>
					    		<option value="3" <c:if test="${gaInfo.gasgrade eq 3}">selected="selected"</c:if>>三等助学金</option>
					    	</select>	
					    </td>
					    <td colspan="5" rowspan="5"><textarea class="form-control" id="gareason" name="gareason" maxlength="512" rows="5">${gaInfo.gareason}</textarea></td>
					</tr>
					</div>
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
