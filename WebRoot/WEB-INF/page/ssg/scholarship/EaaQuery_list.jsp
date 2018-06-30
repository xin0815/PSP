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
		<title>申请年度三优奖学金汇总</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		 <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
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
			        $("#ckxx_eaid").val($("input[name='_radio']:checked").val());
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
							window.location.href="<%=basePath%>eaaQuery/tijiao";
	 					});
					}
				});
				$("#_exprot").click(function() {
        			window.location.href='<%=basePath%>eaaQuery/exportExcel?aacademyCode='+ $("#aacademyCode").val();
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>eaaQuery/ajaxCheckSubmit";
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
			申请学年奖学金汇总
		</legend>
		<c:if test="${empty excellentInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度减免学费指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty excellentInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无审核通过的班级。</h4></div>
			</c:if>
			<form action="eaaQuery/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>年度：${excellentInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>名称：
						${excellentInfo.ename}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
					<input type="button" class="btn btn-info" id="_exprot" value="信息导出" />
				</div>
			</form>
			<table class="table table-bordered table-condensed ">
				<tr>
					<th width="30"></th>
					<th>
						序号
					</th>
					<th>
						姓名
					</th>
					<th>
						性别
					</th>
					<th>
						民族
					</th>
					<th>
						院系
					</th>
					<th>
						年级及专业
					</th>
					<th>
						评选项目
					</th>
				</tr>
				
				<c:forEach var="ea" items="${eaList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${ea.eaid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${ea.student.sname}
						</td>
						<td>
							${ea.student.ssex}
						</td>
						<td>
							${ea.student.snation.name}
						</td>
						<td>
							${ea.bclass.academyInfo.aname}
						</td>
						<td>
							${ea.bclass.cgrade}级${sa.bclass.cmajor}
						</td>
						<td>
							<c:if test="${ea.etype eq 1}">三好学生</c:if>
							<c:if test="${ea.etype eq 2}">优秀班干部</c:if>
							<c:if test="${ea.etype eq 3}">优秀毕业生</c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			<center>
			<c:if test="${not empty eaList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			</c:if>
			</center>
			<form action="excellentApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="eaid" id="ckxx_eaid"/>
			</form>
			<form action="eaaQuery/cancel" method="post" id="thForm">
				<input type="hidden" name="eid" value="${excellentInfo.eid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
