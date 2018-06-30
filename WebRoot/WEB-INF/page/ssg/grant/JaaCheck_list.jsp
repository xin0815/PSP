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
		<title>减免学费学院审核</title>
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
			        $("#ckxx_jaid").val($("input[name='_radio']:checked").val());
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
				$("#bcdj").click(function(){
					if(checkJaalevel()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="jaagrade"]').each(function(){
						$(this).attr("disabled",false);
				    });
				    $('*[name="jamoney"]').each(function(){
						$(this).attr("disabled",false);				    
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#tjrd").attr("disabled",true);
	    		}); 
	    		$("#_export").click(function() {
        			window.location.href='<%=basePath%>jaaCheck/exportExcel?classID='+ $("#cclassId").val();
				});
			})
			function checkJaalevel(){
				var studentCode = $('*[name="studentCode"]');
				var jaalevel = $('*[name="jaagrade"]');
				for(var i=0;i<jaalevel.length;i++){
					if(jaalevel[i].value == ""){
						swal("错误提示", "请选择学院审核等级", "error");
			       		return false;
					}else if(!ajaxCheck(studentCode[i].value,jaalevel[i].value)){
	  					return false;
	  				}
				}
				return true;
			}
			
			function ajaxCheck(studentCode,jaagrade){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>jaaCheck/ajaxCheck?studentCode="+studentCode+"&jaagrade="+jaagrade;
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
			减免学费学院审核
		</legend>
		<c:if test="${empty jianmianInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度减免学费指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty jianmianInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核班级。</h4></div>
			</c:if>
			<form action="jaaCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>减免学费年度：${jianmianInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>减免学费名称：
						${jianmianInfo.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
					<c:if test="${not empty jaList}">
					<button type="button" class="btn btn-primary" id="xgdj">修改等级</button>
					</c:if>
					<input type="button" class="btn btn-info" id="_export" value="信息导出" />
				</div>
			</form>
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
				</tr>
				<form action="jaaCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="classId" value="${cclassId}" />
				<c:forEach var="ja" items="${jaList}" varStatus="st">
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
							${ja.bclass.academyInfo.aname}
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
					    	<select name="jaagrade" id="jaagrade" class="form-control" disabled="disabled">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${ja.jaagrade eq '1'}">selected="selected"</c:if>>一等</option>
					    		<option value="2" <c:if test="${ja.jaagrade eq '2'}">selected="selected"</c:if>>二等</option>
					    		<option value="3" <c:if test="${ja.jaagrade eq '3'}">selected="selected"</c:if>>三等</option>
					    		<option value="4" <c:if test="${ja.jaagrade eq '4'}">selected="selected"</c:if>>不通过</option>
					    	</select>
					    </td>
					</tr>
				</c:forEach>
				</form>
			</table>
		</div>
		<center>
			<c:if test="${not empty jaList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th">整班退回</button>
			<button type="button" class="btn btn-warning" id="tjrd">整班通过</button>
			</c:if>
		</center>
			<form action="jianmianApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="jaid" id="ckxx_jaid"/>
			</form>
			<form action="jaaCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="jid" value="${jianmianInfo.jid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="jaaCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="jid" value="${jianmianInfo.jid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
