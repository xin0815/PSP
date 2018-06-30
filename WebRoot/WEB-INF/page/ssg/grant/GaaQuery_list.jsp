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
		<title>申请学年度国家助学金汇总</title>
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
			        $("#ckxx_gaid").val($("input[name='_radio']:checked").val());
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
							window.location.href="<%=basePath%>gaaQuery/tijiao";
	 					});
					}
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>gaaQuery/ajaxCheckSubmit";
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
			申请学年度国家助学金汇总
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家助学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无审核通过的班级。</h4></div>
			</c:if>
			<form action="gaaQuery/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>国家助学金年度：${grantInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>国家助学金名称：
						${grantInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
					<th width="30">
					</th>
					<th>
						序号
					</th>
					<th>
						姓名
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
					<!-- <th>
						金额
					</th> -->
					<th>
						银行卡号
					</th>
					<th>
						学生申请等级
					</th>
					<th>
						班级认定等级
					</th>
					<th>
						学院审核等级
					</th>
				</tr>
				
				<c:forEach var="ga" items="${gaList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${ga.gaid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${ga.student.sname}
						</td>
						<td>
							${ga.bclass.academyInfo.aname}
						</td>
						<td>
							${ga.bclass.cmajor}
						</td>
						<td>
							${ga.student.sstudentCode}
						</td>
						<td>
							${ga.student.ssex}
						</td>
						<td>
							${ga.student.snation.name}
						</td>
						<!-- <td>
							${ga.gamoney}
						</td> -->
						<td>
							${ga.gacard}
						</td>
						<td>
							<c:if test="${ga.gasgrade eq 1}">一等</c:if>
							<c:if test="${ga.gasgrade eq 2}">二等</c:if>
							<c:if test="${ga.gasgrade eq 3}">三等</c:if>
						</td>
						<td>
							<c:if test="${ga.gatgrade eq 1}">一等</c:if>
							<c:if test="${ga.gatgrade eq 2}">二等</c:if>
							<c:if test="${ga.gatgrade eq 3}">三等</c:if>
						</td>
						<td>
							<c:if test="${ga.gaagrade eq 1}">一等</c:if>
							<c:if test="${ga.gaagrade eq 2}">二等</c:if>
							<c:if test="${ga.gaagrade eq 3}">三等</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			<center>
			<c:if test="${not empty gaList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详细</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			</c:if>
			</center>
			<form action="grantApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="gaid" id="ckxx_gaid"/>
			</form>
			<form action="gaaQuery/cancel" method="post" id="thForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
