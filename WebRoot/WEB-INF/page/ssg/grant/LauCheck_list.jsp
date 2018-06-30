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
		<title>学校审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
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
					swal({title: "温馨提示",text: "该学院申请信息将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#shtg").click(function(){
					swal({title: "温馨提示",text: "您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#shtgForm").submit();
		        	});
				});
				$("#tx").click(function(){
	    			window.location.href="<%=basePath%>lauCheck/tq";
	    		});
			})   	
		</script>
	</head>
	<body>
		<legend>
			励志奖学金学校审核
		</legend>
		<c:if test="${empty lizhiInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度励志奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty lizhiInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="lauCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>励志奖学金年度：${lizhiInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>励志奖学金名称：
						${lizhiInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：</label>
						<select name="aacademyCode" class="form-control">
							<c:forEach var="aca" items="${acaList}">
								<option value="${aca.aacademyCode}" <c:if test="${aca.aacademyCode eq aacademyCode }">selected="selected"</c:if> >${aca.aname}</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<button type="button" class="btn btn-primary" id = "tx">特权模式</button>
				</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;申请人数：${bean.ldNumber}</label>
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
				
				<c:forEach var="la" items="${pager.data}" varStatus="st">
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
		</div>
		<center>
			<c:if test="${not empty pager.data}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="shtg">审核通过</button>
			</c:if>
		</center>
			<form action="lizhiApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="laid" id="ckxx_laid"/>
			</form>
			<form action="lauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="lid" value="${lizhiInfo.lid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="lauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="lid" value="${lizhiInfo.lid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
