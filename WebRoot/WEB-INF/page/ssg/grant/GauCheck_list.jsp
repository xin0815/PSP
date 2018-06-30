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
			        $("#ckxx_gaid").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该学院申请信息将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#shtg").click(function(){
					if(checkGaugrade()){
						swal({title: "温馨提示",text: "您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#shtgForm").submit();
			        	});
					}
				});
				$("#bcdj").click(function(){
					if(checkGaugrade()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="gaugrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#shtg").attr("disabled",true);
	    		}); 
	    		$("#tx").click(function(){
	    			window.location.href="<%=basePath%>gauCheck/tq";
	    		});
			})
			function checkGaugrade(){
				var flag = true;
				$('*[name="gaugrade"]').each(function(){
					if($(this).val() == ""){
			       		$(this).focus();
						swal("错误提示", "请选择学校审批等级", "error");
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
			国家助学金学校审核
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家助学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="gauCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>国家助学金年度：${grantInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>国家助学金名称：
						${grantInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
					<c:if test="${not empty pager.data}">
					<button type="button" class="btn btn-primary" id="xgdj">修改等级</button>
					</c:if>
				</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;申请人数：${bean.gdnumber}&nbsp;&nbsp;&nbsp;&nbsp;申请金额：${bean.gdmoney}</label>
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
					<th>
						学校审批等级
					</th>
				</tr>
				<form action="gauCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
				<c:forEach var="ga" items="${pager.data}" varStatus="st">
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
							<c:if test="${ga.gaagrade eq 1}">一等</c:if>
							<c:if test="${ga.gaagrade eq 2}">二等</c:if>
							<c:if test="${ga.gaagrade eq 3}">三等</c:if>
						</td>
						<td>
							<select name="gaugrade" class="form-control" disabled="disabled">
								<option value="">——请选择——</option>
								<option value="1" <c:if test="${ga.gaugrade eq 1}">selected="selected"</c:if>>一等</option>
								<option value="2" <c:if test="${ga.gaugrade eq 2}">selected="selected"</c:if>>二等</option>
								<option value="3" <c:if test="${ga.gaugrade eq 3}">selected="selected"</c:if>>三等</option>
							</select>
						</td>
					</tr>
				</c:forEach>
				</form>
			</table>
		</div>
			<center>
			<c:if test="${not empty pager.data}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="shtg">整院通过</button>
			</c:if>
			</center>
			<form action="grantApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="gaid" id="ckxx_gaid"/>
			</form>
			<form action="gauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="gauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
