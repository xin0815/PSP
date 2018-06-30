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
			        $("#ckxx_eaid").val($("input[name='_radio']:checked").val());
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
	    			window.location.href="<%=basePath%>eauCheck/tq";
	    		});
			})
			
		</script>
	</head>
	<body>
		<legend>
			三优奖学金学校审核
		</legend>
		<c:if test="${empty excellentInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度三优奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty excellentInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="eauCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>年度：${excellentInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>名称：
						${excellentInfo.ename}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：</label>
						<select id = "acade" name="aacademyCode" class="form-control">
							<c:forEach var="aca" items="${acaList}">
								<option value="${aca.aacademyCode}" <c:if test="${aca.aacademyCode eq aacademyCode }">selected="selected"</c:if> >${aca.aname}</option>
							</c:forEach>
						</select>
					</div>	
					<div class="form-group">
					<label for="">奖学金等级：</label> <select id="saaLevel" name="saaLevel"
						class="form-control" >
						<option value="" <c:if test="${empty etype }">selected="selected"</c:if>>全部</option>
						<option value="1" <c:if test="${etype eq 1 }">selected="selected"</c:if>>三好学生</option>
						<option value="2" <c:if test="${etype eq 2 }">selected="selected"</c:if>>优秀班干部</option>
						<option value="3" <c:if test="${etype eq 3 }">selected="selected"</c:if>>优秀毕业生</option>
					</select>
					</div>
					<input type="submit" class="btn btn-primary" value="查询" />
					<button type="button" class="btn btn-primary" id="tx">特权模式</button>
			</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<table class="table table-bordered table-hover">
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
				<c:forEach var="ea" items="${pager.data}" varStatus="st">
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
				</form>
			</table>
		</div>
		<center>
			<c:if test="${not empty pager.data}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="shtg">整院通过</button>
			</c:if>
		</center>
			<form action="excellentApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="eaid" id="ckxx_eaid"/>
			</form>
			<form action="eauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="eid" value="${excellentInfo.eid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="eauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="eid" value="${excellentInfo.eid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
