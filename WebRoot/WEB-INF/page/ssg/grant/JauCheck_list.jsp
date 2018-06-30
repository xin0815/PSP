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
			        $("#ckxx_jaid").val($("input[name='_radio']:checked").val());
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
				$("#bcdj").click(function(){
					if(checkJaugrade()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="jaugrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
				     $('*[name="jamoney"]').each(function(){
						$(this).attr("disabled",false);				    
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#shtg").attr("disabled",true);
	    		}); 
	    		$("#tq").click(function(){
	    			window.location.href="<%=basePath%>jauCheck/tq";
	    		});
			})
			function checkJaugrade(){
				var studentCode = $('*[name="studentCode"]');
				var jaugrade = $('*[name="jaugrade"]');
				for(var i=0;i<jaugrade.length;i++){
					if(jaugrade[i].value == ""){
						swal("错误提示", "请选择学校审批等级", "error");
			       		return false;
					}
				}
				return true;
			}
		</script>
	</head>
	<body>
		<legend>
			减免学费学校审核
		</legend>
		<c:if test="${empty jianmianInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度减免学费指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty jianmianInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="jauCheck/queryByJaaLevel" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>减免学费年度：${scholarshipInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>减免学费名称：
						${jianmianInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
					<label for="">减免学费等级：</label> <select id="jaaGrade" name="jaaGrade"
						class="form-control" >
						<option value="0"<c:if test="${jaaGrade eq 0 }">selected="selected"</c:if>>全部</option>
						<option value="1"<c:if test="${jaaGrade eq 1 }">selected="selected"</c:if>>一等</option>
						<option value="2"<c:if test="${jaaGrade eq 2 }">selected="selected"</c:if>>二等</option>
						<option value="3"<c:if test="${jaaGrade eq 3 }">selected="selected"</c:if>>三等</option>
					</select>
					</div>
					<input type="submit" class="btn btn-primary" value="查询" />
					<c:if test="${not empty pager.data}">
					<button type="button" class="btn btn-primary" id="xgdj">修改等级</button>
					</c:if>
					<button type="button" class="btn btn-primary" id="tq">特权模式</button>
			</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;一等：${bean.jdleve1}&nbsp;&nbsp;&nbsp;&nbsp;二等：${bean.jdleve2}&nbsp;&nbsp;&nbsp;&nbsp;三等：${bean.jdleve3}&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
						减免金额
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
				<form action="jauCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
				<c:forEach var="ja" items="${pager.data}" varStatus="st">
				<input type="hidden" name="jaid" value="${ja.jaid}" />
				<input type="hidden" name="studentCode" value="${ja.student.sstudentCode}" />
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${ja.jaid}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${ja.student.sname}
						</td>
						<td>
							${ja.student.sidCard}
						</td>
						<td>
							${ja.bclass.cmajor}
						</td>
						<td>
							${ja.student.sstudentCode}
						</td>
						<td>
							${ja.student.ssex}
						</td>
						<td>
							${ja.student.snation.name}
						</td>
						<td>
							${ja.bclass.cgrade}
						</td>
						<td>
							<input name = "jamoney" value = "${ja.jamoney}" disabled="disabled"/>
						</td>
						<td>
							<c:if test="${ja.jasgrade eq 1}">一等</c:if>
							<c:if test="${ja.jasgrade eq 2}">二等</c:if>
							<c:if test="${ja.jasgrade eq 3}">三等</c:if>
						</td>
					    <td>
							<c:if test="${ja.jatgrade eq 1}">一等</c:if>
							<c:if test="${ja.jatgrade eq 2}">二等</c:if>
							<c:if test="${ja.jatgrade eq 3}">三等</c:if>
							<c:if test="${ja.jatgrade eq 4}">不通过</c:if>
						</td>
					    <td>
							<c:if test="${ja.jaagrade eq 1}">一等</c:if>
							<c:if test="${ja.jaagrade eq 2}">二等</c:if>
							<c:if test="${ja.jaagrade eq 3}">三等</c:if>
							<c:if test="${ja.jaagrade eq 4}">不通过</c:if>
						</td>
					    <td>
					    	<select name="jaugrade" id="jaugrade" class="form-control" disabled="disabled">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${ja.jaugrade eq '1'}">selected="selected"</c:if>>一等</option>
					    		<option value="2" <c:if test="${ja.jaugrade eq '2'}">selected="selected"</c:if>>二等</option>
					    		<option value="3" <c:if test="${ja.jaugrade eq '3'}">selected="selected"</c:if>>三等</option>
					    		<option value="3" <c:if test="${ja.jaugrade eq '4'}">selected="selected"</c:if>>不通过</option>
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
			<form action="jianmianApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="jaid" id="ckxx_jaid"/>
			</form>
			<form action="jauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="jid" value="${jianmianInfo.jid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="jauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="jid" value="${jianmianInfo.jid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
