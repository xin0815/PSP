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
		<title>三优奖学金学院审核</title>
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
			        $("#ckxx_eaid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该班级申请将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					swal({title: "温馨提示",text: "该班级申请将整体审核通过，您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#tjrdForm").submit();
		        	});
				});
	    		$("#_exprot").click(function() {
        			window.location.href='<%=basePath%>eaaCheck/exportExcel?classID='+ $("#cclassId").val();
				});
			})
			
			function ajaxCheck(studentCode,etype){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>eaaCheck/ajaxCheck?studentCode="+studentCode+"&etype="+etype;
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
			三优奖学金学院审核
		</legend>
		<c:if test="${empty excellentInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度三优奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty excellentInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核班级。</h4></div>
			</c:if>
			<form action="eaaCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>年度：${excellentInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>奖学金名称：
						${excellent.sname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>班级：</label>
						<select name="cclassId" class="form-control" id="cclassId">
							<c:forEach var="cc" items="${classList}">
								<option value="${cc.cid }" <c:if test="${cclassId eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<input type="button" class="btn btn-info" id="_exprot" value="信息导出" />
				</div>
			</form>
			<table class="table table-bordered table-hover ">
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
					<th>
						是否退回
					</th>
				</tr>
				<c:forEach var="ea" items="${eaList}" varStatus="st">
					<input type="hidden" name="eaid" value="${ea.eaid}" />
					<input type="hidden" name="studentCode" value="${ea.student.sstudentCode}" />
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
						<td>
							<a class="btn btn-default" href="eatCheck/back?sstuCode=${ea.student.sstudentCode}&cid=${ea.bclass.cid}&eid=${excellentInfo.eid}" role="button">&nbsp;是&nbsp;</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
		<center>
			<c:if test="${not empty eaList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整班退回</button>
			<button type="button" class="btn btn-warning" id="tjrd">整班通过</button>
			</c:if>
		</center>
			<form action="excellentApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="eaid" id="ckxx_eaid"/>
			</form>
			<form action="eaaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="eid" value="${excellentInfo.eid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="eaaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="eid" value="${excellentInfo.eid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
