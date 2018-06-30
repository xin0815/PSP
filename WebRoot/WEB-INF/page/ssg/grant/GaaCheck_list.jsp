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
		<title>国家助学金学院审核</title>
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
			        $("#ckxx_gaid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该班级申请将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					if(checkGaagrade()){
						swal({title: "温馨提示",text: "该班级申请将整体审核通过，您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#tjrdForm").submit();
			        	});
					}
				});
				$("#bcdj").click(function(){
					if(checkGaagrade()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="gaagrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#tjrd").attr("disabled",true);
	    		}); 
			})
			function checkGaagrade(){
				var flag = true;
				$('*[name="gaagrade"]').each(function(){
					if($(this).val() == ""){
			       		$(this).focus();
						swal("错误提示", "请选择学院审核等级", "error");
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
			国家助学金学院审核
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家助学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核班级。</h4></div>
			</c:if>
			<form action="gaaCheck/list" method="post" class="form-inline">
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
					<c:if test="${not empty gaList}">
					<button type="button" class="btn btn-primary" id="xgdj">修改等级</button>
					</c:if>
				</div>
			</form>
			<table class="table table-bordered table-condensed ">
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
					<th>
						金额
					</th>
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
				<form action="gaaCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="classId" value="${cclassId}" />
				<c:forEach var="ga" items="${gaList}" varStatus="st">
				<input type="hidden" name="gaid" value="${ga.gaid}" />
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
						<td>
							${ga.gamoney}
						</td>
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
							<select name="gaagrade" class="form-control" disabled="disabled">
								<option value="">——请选择——</option>
								<option value="1" <c:if test="${ga.gaagrade eq 1}">selected="selected"</c:if>>一等</option>
								<option value="2" <c:if test="${ga.gaagrade eq 2}">selected="selected"</c:if>>二等</option>
								<option value="3" <c:if test="${ga.gaagrade eq 3}">selected="selected"</c:if>>三等</option>
							</select>
						</td>
					</tr>
				</c:forEach>
				</form>
			</table>
			<center>
			<c:if test="${not empty gaList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th">整班退回</button>
			<button type="button" class="btn btn-warning" id="tjrd">整班通过</button>
			</c:if>
			</center>
			<form action="grantApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="gaid" id="ckxx_gaid"/>
			</form>
			<form action="gaaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="gaaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
