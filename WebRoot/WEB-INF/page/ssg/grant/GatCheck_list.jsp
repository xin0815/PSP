<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>班级认定</title>
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
			        $("#ckxx_gaid").val($("input[name='_checkbox']:checked").val());
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
		                    $("#th_gaids").val(checks.val());
		                }else{
		                    var str = "";
		                    checks.each(function(i,o){
		                    	str = str + $(o).val()+",";
		               	 	});
		                	$("#th_gaids").val(str);
		          		 }
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					if(checkGatgrade()){
						swal({title: "温馨提示",text: "班级所有申请信息将整体提交，您确定要提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
							$("#tjrdForm").submit();
			        	});
					}
				});
				$("#bcdj").click(function(){
					if(checkGatgrade()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="gatgrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#tjrd").attr("disabled",true);
	    		}); 
			})
			function checkGatgrade(){
				var flag = true;
				$('*[name="gatgrade"]').each(function(){
					if($(this).val() == ""){
			       		$(this).focus();
						swal("错误提示", "请选择班级认定等级", "error");
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
			国家助学金班主任审核
		</legend>
		<c:if test="${empty grantInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度国家助学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty grantInfo }">
			<form action="gatCheck/list" method="post" class="form-inline">
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
					<button type="button" class="btn btn-primary" id="xgdj" <c:if test="${gatCheck eq 2 }">disabled="disabled"</c:if>>修改等级</button>
					</c:if>
				</div>
			</form>
			<table class="table table-bordered table-condensed table-hover">
				<tr>
					<th width="30"></th>
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
				</tr>
				<form action="gatCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="classId" value="${cclassId}" />
				<c:forEach var="ga" items="${gaList}" varStatus="st">
					<input type="hidden" name="gaid" value="${ga.gaid}" />
					<tr>
						<td width="30px">
							<input type="checkbox" " name="_checkbox" value="${ga.gaid}" />
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
							<select name="gatgrade" class="form-control" disabled="disabled">
								<option value="">——请选择——</option>
								<option value="1" <c:if test="${ga.gatgrade eq 1}">selected="selected"</c:if>>一等</option>
								<option value="2" <c:if test="${ga.gatgrade eq 2}">selected="selected"</c:if>>二等</option>
								<option value="3" <c:if test="${ga.gatgrade eq 3}">selected="selected"</c:if>>三等</option>
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
			<button type="button" class="btn btn-warning" id="th" <c:if test="${gatCheck eq 2 }">disabled="disabled"</c:if>>退回申请</button>
			<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${gatCheck eq 2 }">disabled="disabled"</c:if>>整班提交</button>
			</c:if>
			</center>
			<form action="grantApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="gaid" id="ckxx_gaid"/>
			</form>
			<form action="gatCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="gaids" id="th_gaids"/>
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="gatCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="gid" value="${grantInfo.gid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
