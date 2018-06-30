<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>班级认定</title>
    	<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
    
		<script type="text/javascript">
			$(function(){
				$("#pkrdck").click(function(){
			    	if($("input[name='_checkbox']:checked").size() != 1){
			    		swal("错误提示", "请选择且只选择一条记录", "error");
			            return;
			       	}
		        	$("#pkrdck_paid").val($("input[name='_checkbox']:checked").val());
					$("#pkrdckForm").submit();
				}); 
				$("#th").click(function(){
					var checks = $("input[name='_checkbox']:checked");
					if(checks.size() < 1){
			    		swal("错误提示", "请先选择您要退回的记录", "error");
			            return;
			       	}
		        	swal({title: "温馨提示",text: "您确定要退回该申请吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
		        		if(checks.size() == 1){
		                    $("#th_paids").val(checks.val());
		                }else{
		                    var str = "";
		                    checks.each(function(i,o){
		                    	str = str + $(o).val()+",";
		               	 	});
		                	$("#th_paids").val(str);
		          		 }
						$("#thForm").submit();
		        	});
				});
				$("#tjrd").click(function(){
					if(checkPgrade()){
			        	swal({title: "温馨提示",text: "班级所有申请信息将整体提交认定，您确定要提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#tjrdForm").submit();
			        	});
					}
				});
				$("#bcdj").click(function(){
					if(checkPgrade()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="pgrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#pkrdck").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#tjrd").attr("disabled",true);
	    		}); 
			})
			function checkPgrade(){
				var flag = true;
				$('*[name="pgrade"]').each(function(){
					if($(this).val() == ""){
			       		$(this).focus();
						swal("错误提示", "请选择贫困等级", "error");
			       		flag = false;
			       		return false;
					}
			    });
				return flag;
			}
		</script>
	</head>
	<body>
		<legend>
			贫困认定—班级认定
		</legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度贫困认定指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<form action="patCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>贫困认定年度：</label>${poorInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>贫困认定名称：</label>
						${poorInfo.pname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						<label>学院：</label>${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>班级：</label>
						<select name="cclassId" class="form-control">
							<c:forEach var="cc" items="${classList}">
								<option value="${cc.cid }" <c:if test="${cclassId eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<c:if test="${not empty paList}">
					<button type="button" class="btn btn-primary" id="xgdj" <c:if test="${patCheck eq 2 }">disabled="disabled"</c:if>>修改等级</button>
					</c:if>
				</div>
			</form>
			
			<table class="table table-bordered table-hover">
				<tr>
					<th width="50"></th>
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
				<form action="patCheck/savePgrade" method="post" id="bcdjForm">
				<input type="hidden" name="classId" value="${cclassId}" />
				<c:forEach var="pa" items="${paList}" varStatus="st">
					<input type="hidden" name="paid" value="${pa.paid}" />
					<tr>
						<td width="30px">
							<input type="checkbox" name="_checkbox" value="${pa.paid}" />
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
							<select name="pgrade" class="form-control" disabled="disabled">
								<option value="">——请选择——</option>
								<option value="1" <c:if test="${pa.pgrade eq '1'}">selected="selected"</c:if>>特别困难</option>
								<option value="2" <c:if test="${pa.pgrade eq '2'}">selected="selected"</c:if>>困难</option>
								<option value="3" <c:if test="${pa.pgrade eq '3'}">selected="selected"</c:if>>一般困难</option>
							</select>
						</td>
					</tr>
				</c:forEach>
				</form>
			</table>
			<center>
			<c:if test="${not empty paList}">
			<button type="button" class="btn btn-primary" id="pkrdck">查看详细</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${patCheck eq 2 }">disabled="disabled"</c:if>>退回申请</button>
			<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${patCheck eq 2 }">disabled="disabled"</c:if>>整班提交</button>
			</c:if>
			</center>
			<form action="poorApplication/info" method="post" id="pkrdckForm">
				<input type="hidden" name="paid" id="pkrdck_paid"/>
			</form>
			<form action="patCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="paids" id="th_paids"/>
				<input type="hidden" name="cid" value="${cclassId}"/>
			</form>
			<form action="patCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="pid" value="${poorInfo.pid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
