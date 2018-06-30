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
		<title>明德奖学金学校审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		 <link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
    <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
	<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
					if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要查看的记录", "error");
			            return;
			       	}
			        $("#ckxx_maid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该学院申请信息将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#shtg").click(function(){
					swal({title: "温馨提示",text: "您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#shtgForm").submit();
		        	});
				});
			})   	
		</script>
	</head>
	<body>
		 <legend>
			明德奖学金学校审核
	     </legend>
		<c:if test="${empty mingdeInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度明德奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty mingdeInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="mauCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						明德奖学金年度：${mingdeInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>	
					<div class="form-group">
						明德奖学金名称：
						${mingdeInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
					<div class="form-group">
						学院：
						<select name="aacademyCode" class="form-control">
							<c:forEach var="aca" items="${acaList}">
								<option value="${aca.aacademyCode}" <c:if test="${aca.aacademyCode eq aacademyCode }">selected="selected"</c:if> >${aca.aname}</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
				</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;明德奖学金人数：${bean.mdnumber}&nbsp;&nbsp;&nbsp;&nbsp;</label>
			<table class="table table-bordered table-condensed ">
				<tr>
					<th width="50">
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
					<th>
						年级
					</th>
					<th>
						生源地
					</th>
					<th>
						手机号码
					</th>
					<th>
						是否退回
					</th>
				</tr>
				
				<c:forEach var="ma" items="${pager.data}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${ma.maid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${ma.student.sname}
						</td>
						<td>
							${ma.student.cclass.academyInfo.aname}
						</td>
						<td>
							${ma.student.cclass.cmajor}
						</td>
						<td>
							${ma.student.sstudentCode}
						</td>
						<td>
							${ma.student.ssex}
						</td>
						<td>
							${ma.student.snation.name}
						</td>
						<td>
							${ma.student.cclass.cgrade}
						</td>
						<td>
							${ma.student.soriginHome}
						</td>
						<td>
							${ma.student.sphoneNum}
						</td>
						<td>
							<a class="btn btn-default" href="mauCheck/cancelStu?stuCode=${ ma.student.sstudentCode}&acadCode=${ma.student.cclass.academyInfo.aacademyCode}" role="button">&nbsp;是&nbsp;</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
			<c:if test="${not empty pager.data}">
			<center>
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="shtg">整院通过</button>
			</center>
			</c:if>
			<form action="mingdeApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="maid" id="ckxx_maid"/>
			</form>
			<form action="mauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="mid" value="${mingdeInfo.mid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="mauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="mid" value="${mingdeInfo.mid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
