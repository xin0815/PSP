<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<head>
	<title>班级信息修改</title>
	<base href="<%=basePath%>" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>bootstrap/js/bootstrap.min.js"></script>
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
	<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
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
			$("#update").click(function(){//更新操作
				trimAll();
				var flag = true;
				if(checkInputText() == false){
					flag = false;
				}
				if(flag){
					$("#form1").submit();
				}
			});
			$("#zc").click(function(){
				if($("input[name='_radio']:checked").size() != 1){
		    		swal("错误提示", "请先选择需要转出的学生", "error");
		            return;
		       	}
	        	swal({title: "温馨提示",text: "您确定把该学生从班级转出吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					window.location.href='<%=basePath%>classStudent/delStuFromClass?studentCode='+$("input[name='_radio']:checked").val() +"&classId="+$("#cid").val();
	        	});
			});
			$("#zr").click(function(){
				if($("input[name='_radio']:checked").size() != 1){
		    		swal("错误提示", "请先选择需要转入的学生", "error");
		            return;
		       	}
	        	swal({title: "温馨提示",text: "您确定把该学生转入该班级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					window.location.href='<%=basePath%>classStudent/inClass?studentCode='+$("input[name='_radio']:checked").val() +"&classId="+$("#cid").val();
	        	});
			});
		})
		$(document).ready(function() {
			$(".multiSelect").select2();
		});
		function checkInputText(){
			//验证所有输入框内容均不能为空
			var flag = true;
			$("input[type='text']").each(function(){
		       if($(this).prop("name") != "" && $(this).val() == ""){//sweetalert弹出会创建name为空的text框，因此加$(this).prop("name") != ""判断
		       	$(this).focus();
					swal("错误提示", "内容不能为空，请正确填写", "error");
		       	flag = false;
		       	return false;
		       }
		    });
		  //验证所有选择框内容均不能为空
			$('*[name="teacherNum"]').each(function(){
		       if($(this).val() == ""){
		       	$(this).focus();
					swal("错误提示", "请选择班主任", "error");
		       	flag = false;
		       	return false;
		       }
		    });
		    return flag;
		}
		
	</script>
</head>
<body>
	<container>
		<form action="classStudent/update" method="post" id="form1">
			<input type="hidden" name="academy" value="${academy.aacademyCode}">
			<h6>学院：${academy.aname}&nbsp;&nbsp;&nbsp;&nbsp;学年学期：${semester.bname}</h6>
			<table class="table table-bordered table-condensed table-hover">
				<tr>
	        		<th nowrap="nowrap"><span class="xinghao">*</span>班级名称</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>班级编号</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>班主任教工号</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>年级</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>专业</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>授课语种</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>培养层次</th>
					<th nowrap="nowrap"><span class="xinghao">*</span>是否师范</th>
				</tr>
				<tr>
					<td>
						<input class="form-control" type="hidden" name="cid" id="cid" value="${cp.cid}">
						<input class="form-control" type="text" name="cclassName" value="${cp.cclassName}">
					</td>
					<td>
						<input class="form-control" type="text" name="cclassCode" value ="${cp.cclassCode}">
					</td>
					<td>
						<select id="tCode" name="bteacherId" class="multiSelect" >
							<option value="">——全部——</option>
							<c:forEach var="tea" items="${tlist}">
								<option value="${tea.bteacherId}" <c:if test="${cp.currTeacher.bteacherId eq tea.bteacherId}">selected="selected"</c:if>>${tea.bteacherId}[${tea.tname}]</option>
							</c:forEach>
						</select>
					</td>
					<td>
	        			<input class="form-control" name="cgrade" type="text" value="${cp.cgrade}">
		          	</td>
	        		<td>
	        			<input class="form-control" type="text" name="cmajor" value="${cp.cmajor}">
	         		</td>
	        		<td>
	        			<input class="form-control" type="text" name="clanguage" value="${cp.clanguage }">
			         </td>
					<td>
						<input class="form-control" type="text" name="clevel" value="${cp.clevel }">
					</td>
					<td>
		        		<select id="cisTeacher" name="cisTeacher" class="form-control" >
							<c:if test="${cp.cisTeacher == true }">
								<option value="true">是</option>
								<option value="false">否</option>
							</c:if>
			        		<c:if test="${cp.cisTeacher == false }">
								<option value="false">否</option>
								<option value="true">是</option>
							</c:if>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
		<!-- Standard button -->
		<button type="submit" class="btn btn-info" id="update"name="update">保存修改</button>
		<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">
	   		返回
	   	</button>
	</div>
	</container>
	<ul id="myTab" class="nav nav-tabs">
		<li class="active">
			<a href="#home" data-toggle="tab">班内学生</a>
		</li>
		<li>
			<a href="#ios" data-toggle="tab">未分班学生</a>
		</li>
	</ul>
	<div id="myTabContent" class="tab-content">
		<div class="tab-pane fade in active" id="home">
			<table id="_table" class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>
						</th>
						<th>
							序号
						</th>
						<th>
							学号
						</th>
						<th>
							姓名
						</th>
						<th>
							出生年月
						</th>
						<th>
							性别
						</th>
						<th>
							民族
						</th>
						<th>
							政治面貌
						</th>
						<th>
							宿舍号
						</th>
						<th>
							本人联系方式
						</th>
					</tr>
					<c:forEach var="stu" items="${stuList}" varStatus="vs">
						<tr>
							<td width="30px">
								<input type="radio" " name="_radio" value="${stu.sstudentCode}" />
							</td>
							<td>
								${vs.index + 1 }
							</td>
							<td>
								${stu.sstudentCode}
							</td>
							<td>
								${stu.sname}
							</td>
							<td>
								${stu.sbirthDate }
							</td>
							<td>
								${stu.ssex }
							</td>
							<td>
								${stu.snation.name }
							</td>
							<td>
								${stu.spolitical }
							</td>
							<td>
								${stu.sdormNum }
							</td>
							<td>
								${stu.sphoneNum }
							</td>
						</tr>
					</c:forEach>
				</thead>
			</table>
			<div align="center">
				<button type="button" class="btn btn-info" id="zc" name="zc">转出</button>
			</div>
		</div>
		<div class="tab-pane fade" id="ios">
			<table id="_table" class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
						<th>
						</th>
						<th>
							序号
						</th>
						<th>
							学号
						</th>
						<th>
							姓名
						</th>
						<th>
							出生年月
						</th>
						<th>
							性别
						</th>
						<th>
							民族
						</th>
						<th>
							政治面貌
						</th>
						<th>
							宿舍号
						</th>
						<th>
							本人联系方式
						</th>
					</tr>
					<c:forEach var="stu" items="${unStuList}" varStatus="vs">
						<tr>
							<td width="30px">
								<input type="radio" " name="_radio" value="${stu.sstudentCode}" />
							</td>
							<td>
								${vs.index + 1 }
							</td>
							<td>
								${stu.sstudentCode}
							</td>
							<td>
								${stu.sname}
							</td>
							<td>
								${stu.sbirthDate }
							</td>
							<td>
								${stu.ssex }
							</td>
							<td>
								${stu.snation.name }
							</td>
							<td>
								${stu.spolitical }
							</td>
							<td>
								${stu.sdormNum }
							</td>
							<td>
								${stu.sphoneNum }
							</td>
						</tr>
					</c:forEach>
				</thead>
			</table>
			<div align="center">
				<button type="button" class="btn btn-info" id="zr" name="zr">转入</button>
			</div>
		</div>
	</div>
</body>
</html>