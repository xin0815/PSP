<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>励志奖学金-班主任审核</title>
    	<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
    
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
					if($("input[name='_checkbox']:checked").size() != 1){
			    		swal("错误提示", "请选择且只选择一条记录", "error");
			            return;
			       	}
			        $("#ckxx_laid").val($("input[name='_checkbox']:checked").val());
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
		                    $("#th_laids").val(checks.val());
		                }else{
		                    var str = "";
		                    checks.each(function(i,o){
		                    	str = str + $(o).val()+",";
		               	 	});
		                	$("#th_laids").val(str);
		          		 }
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					swal({title: "温馨提示",text: "班级所有申请信息将整体提交认定，您确定要提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#tjrdForm").submit();
		        	});
				});
			})   	
		</script>
	</head>
	<body>
		<legend>
			励志奖学金班主任审核
		</legend>
		<c:if test="${empty lizhiInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度励志奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty lizhiInfo }">
			<form action="latCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>励志奖学金年度：</label>${lizhiInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>励志奖学金名称：</label>
						${lizhiInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
				</div>
			</form>
			<table class="table table-bordered table-hover">
				<tr>
					<th width="30"></th>
					<th>
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
						年级
					</th>
					<th>
						银行卡号
					</th>
					<!-- <th>
						金额
					</th> -->
				</tr>
				<c:forEach var="la" items="${laList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="checkbox" " name="_checkbox" value="${la.laid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${la.student.sname}
						</td>
						<td>
							${la.student.sidCard}
						</td>
						<td>
							${la.bclass.academyInfo.aname}
						</td>
						<td>
							${la.bclass.cmajor}
						</td>
						<td>
							${la.student.sstudentCode}
						</td>
						<td>
							${la.student.ssex}
						</td>
						<td>
							${la.student.snation.name}
						</td>
						<td>
							${la.bclass.cgrade}
						</td>
						<td>
							${la.lacard}
						</td>
						<!-- <td>
							${la.lamoney}
						</td> -->
					</tr>
				</c:forEach>
			</table>
			<center>
			<c:if test="${not empty laList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${latCheck eq 2 }">disabled="disabled"</c:if>>退回申请</button>
			<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${latCheck eq 2 }">disabled="disabled"</c:if>>整班提交</button>
			</c:if>
			</center>
			<form action="lizhiApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="laid" id="ckxx_laid"/>
			</form>
			<form action="latCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="laids" id="th_laids"/>
				<input type="hidden" name="cid" value="${cclassId}"/>
			</form>
			<form action="latCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="lid" value="${lizhiInfo.lid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
