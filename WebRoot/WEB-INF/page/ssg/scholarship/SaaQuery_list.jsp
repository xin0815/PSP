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
		<title>申请年度校内奖学金汇总</title>
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
			        $("#ckxx_said").val($("input[name='_radio']:checked").val());
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
							window.location.href="<%=basePath%>saaQuery/tijiao";
	 					});
					}
				});
				$("#_exprot").click(function() {
        			window.location.href='<%=basePath%>saaQuery/exportExcel?aacademyCode='+ $("#aacademyCode").val();
				});
			})
			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>saaQuery/ajaxCheckSubmit";
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
		<c:if test="${empty scholarshipInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度减免学费指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty scholarshipInfo }">
			<c:if test="${empty classList}">
				<div class="alert alert-warning" role="alert"><h4>暂无审核通过的班级。</h4></div>
			</c:if>
			<form action="saaQuery/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>校内奖学金年度：${scholarshipInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>校内奖学金名称：
						${scholarshipInfo.sname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
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
						学生申请等级
					</th>
					<th>
						学生申请单项奖类型
					</th>
					<th>
						班级认定等级
					</th>
					<th>
						班级认定单项奖类型
					</th>
					<th>
						学院审核等级
					</th>
					<th>
						学院审核单项奖类型
					</th>
				</tr>
				
				<c:forEach var="sa" items="${saList}" varStatus="st">
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${sa.said}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${sa.student.sname}
						</td>
						<td>
							${sa.student.sidCard}
						</td>
						<td>
							${sa.bclass.academyInfo.aname}
						</td>
						<td>
							${sa.bclass.cmajor}
						</td>
						<td>
							${sa.student.sstudentCode}
						</td>
						<td>
							${sa.student.ssex}
						</td>
						<td>
							${sa.student.snation.name}
						</td>
						<td>
							${sa.bclass.cgrade}
						</td>
						<td>
							<c:if test="${sa.saslevel eq 1}">一等</c:if>
							<c:if test="${sa.saslevel eq 2}">二等</c:if>
							<c:if test="${sa.saslevel eq 3}">三等</c:if>
							<c:if test="${sa.saslevel eq 4}">单项奖</c:if>
							<c:if test="${sa.saslevel eq 5}">优秀学生干部奖</c:if>
						</td>
						<td>
							<c:if test="${sa.sassingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.sassingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.sassingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.sassingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.sassingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.sassingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.sassingleLevel eq 7}">文体技能奖</c:if>
					    </td>
					    <td>
							<c:if test="${sa.satlevel eq 1}">一等</c:if>
							<c:if test="${sa.satlevel eq 2}">二等</c:if>
							<c:if test="${sa.satlevel eq 3}">三等</c:if>
							<c:if test="${sa.satlevel eq 4}">单项奖</c:if>
							<c:if test="${sa.satlevel eq 5}">优秀学生干部奖</c:if>
						</td>
						<td>
							<c:if test="${sa.satsingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.satsingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.satsingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.satsingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.satsingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.satsingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.satsingleLevel eq 7}">文体技能奖</c:if>
					    </td>
					     <td>
							<c:if test="${sa.saalevel eq 1}">一等</c:if>
							<c:if test="${sa.saalevel eq 2}">二等</c:if>
							<c:if test="${sa.saalevel eq 3}">三等</c:if>
							<c:if test="${sa.saalevel eq 4}">单项奖</c:if>
							<c:if test="${sa.saalevel eq 5}">优秀学生干部奖</c:if>
						</td>
						<td>
							<c:if test="${sa.saasingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.saasingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.saasingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.saasingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.saasingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.saasingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.saasingleLevel eq 7}">文体技能奖</c:if>
					    </td>
					</tr>
				</c:forEach>
			</table>
			<center>
			<c:if test="${not empty saList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${isSubmit eq true}">disabled="disabled"</c:if>>整班退回</button>
			</c:if>
			</center>
			<form action="scholarshipApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="said" id="ckxx_said"/>
			</form>
			<form action="saaQuery/cancel" method="post" id="thForm">
				<input type="hidden" name="sid" value="${scholarshipInfo.sid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
