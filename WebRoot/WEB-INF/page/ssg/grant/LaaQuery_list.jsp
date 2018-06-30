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
		<title>申请年度励志奖学金汇总</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
					if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要查看的记录", "error");
			            return;
			       	}
			        $("#ckxx_laid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				});
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该班级申请将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#tj").click(function(){
					if(ajaxCheckSubmit()){
						swal({title: "温馨提示",text: "把学院所有班级的申请整体提交学校审核，您确定提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							window.location.href="<%=basePath%>laaQuery/tijiao";
	 					});
					}
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>laaQuery/ajaxCheckSubmit";
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
			申请年度励志奖学金汇总
		</legend>
		<c:if test="${empty lizhiInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度励志奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty lizhiInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无审核通过的班级。</h4></div>
			</c:if>
			<form action="laaQuery/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>励志奖学金年度：${lizhiInfo.schoolYear.syname}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						<label>励志奖学金名称：${lizhiInfo.name}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						<label>学院：${acaInfo.aname}</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
					<button type="button" class="btn btn-warning" id="tj" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>学院整体提交</button>
				</div>
			</form>
			<table class="table table-bordered table-hover ">
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
							<input type="radio" " name="_radio" value="${la.laid}" />
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
			<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			</c:if>
			</center>
			<form action="lizhiApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="laid" id="ckxx_laid"/>
			</form>
			<form action="laaQuery/cancel" method="post" id="thForm">
				<input type="hidden" name="lid" value="${lizhiInfo.lid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
