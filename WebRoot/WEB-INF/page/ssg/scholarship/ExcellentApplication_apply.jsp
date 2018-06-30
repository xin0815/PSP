<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"%>
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
		<base href="<%=basePath%>">
		<title>校内奖学金申请</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<script language="javascript"
			src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript"
			src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<style>
	.xinghao{
		color: red;
		font-size: 20px;
		margin-right: 5px;
		vertical-align: top;
	}
</style>
		<script language="javascript">    
  			$(function(){
  				$("#tjBtn").click(function(){//提交
  					if(check()){
		  				swal({
						title : "警告",
						text : "提交后将不能修改，您确定提交吗？",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "ok",
						closeOnConfirm : false
						}, function() {
  					$("#isSubmit").val(true);
  					$("#applyForm").submit();
				});
				}
				});
  				$("#zcBtn").click(function(){//暂存
  					if(check()){
		  				swal({
						title : "警告",
						text : "您确定要暂存吗？",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : "#DD6B55",
						confirmButtonText : "ok",
						closeOnConfirm : false
						}, function() {
  					$("#isSubmit").val(false);
  					$("#applyForm").submit();
				});
				}
				});
				$("#dcBtn").click(function() {
				if(!$("#isSubmit").val()){
					alert("还没有提交，不能导出！")
				}else if($("#isSubmit").val()){
					if($("#eatcheck").val()==2){
						$("#exportForms").submit();
					}else{
						alert("未审核，不能导出！")
					}	
				  }	
				});
			});
			function check(){
			    trimAll();
  				 if($("#etype").val() == ""){
  					swal("错误提示", "请选择奖学金类别", "error");
  					$("#etype").focus();
  					return false;
  				}
  				if($("#personalSummary").val() == ""){
  					swal("错误提示", "请填写个人总结", "error");
  					$("#saoldReward").focus();
  					return false;
  				}
  				//if(!ajaxCheck()){
  					//return false;
  				//}
  				return true;
  			}
  			
  			function ajaxCheck(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>excellentApplication/ajaxCheck?etype="+$("#etype").val();
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
			};			
		</script>
	</head>
	<body>
		<legend>
			三优奖学金申请
		</legend>
		<c:if test="${empty excellentInfo }">
			<div class="alert alert-warning" role="alert">
				<h4>
					学校尚未发布当前年度三优奖学金指标，请发布后再申请。
				</h4>
			</div>
		</c:if>
		
		<c:if test="${not empty excellentInfo }">
			<div class="well form-search">
				<label>
					年度 ：<u>${excellentInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					名称 : <u>${excellentInfo.ename}</u>
				</label>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-info" id="dcBtn">导出word</button>
				
			</div>
			<div class="well form-search">
				<label>
					曾获奖项：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<c:forEach var="sa" items="${stuList}">
						<c:if test="${sa.saslevel eq 1}">一等奖学金</c:if>
						<c:if test="${sa.saslevel eq 2}">二等奖学金</c:if>
						<c:if test="${sa.saslevel eq 3}">三等奖学金</c:if>
						<c:if test="${sa.saslevel eq 4}">
							<c:if test="${sa.sassingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.sassingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.sassingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.sassingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.sassingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.sassingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.sassingleLevel eq 7}">文体技能奖</c:if>
						</c:if>
						<c:if test="${sa.saslevel eq 5}">优秀学生干部奖</c:if>
					</c:forEach>
					${naList}
				</label>
			</div>
			
			<fieldset <c:if test="${eaInfo.isSubmit eq true}">disabled="disabled"</c:if> >
				<form action="excellentApplication/apply" method="post" id="applyForm" class="form-horizontal">
					<input type="hidden" name="schoolYear.syid"
						value="${excellentInfo.schoolYear.syid}" />
					<input type="hidden" name="eaid" value="${eaInfo.eaid}" />
					<input type="hidden" name="student.sstudentCode"
						value="${stu.sstudentCode}" />
					<input type="hidden" name="excellentInfo.eid"
						value="${excellentInfo.eid}" />
					<input type="hidden" name="bclass.cid" value="${stu.cclass.cid}" />
					
					<input type="hidden" name="isSubmit" id="isSubmit"
						value="${eaInfo.isSubmit}" />
					<input type="hidden" name="eatcheck" id="eatcheck"
						value="${eaInfo.eatcheck}" />
						
					<table class="table table-bordered table-condensed table-striped">
						<tr>
							<th>
								学号
							</th>
							<th>
								姓名
							</th>
							<th>
								学院
							</th>
							<th>
								年级
							</th>
							<th>
								班级
							</th>
							<th>
								<span class="xinghao">*</span>奖学金类别
							</th>
						<tr>
							<td>
								${stu.sstudentCode}
							</td>
							<td>
								${stu.sname}
							</td>
							<td>
								${stu.cclass.academyInfo.aname}
							</td>
							<td>
								${stu.cclass.cgrade}
							</td>
							<td>
								${stu.cclass.cclassName}
							</td>
							<td>
								<select name="etype" id="etype" class="form-control">
									<option value="">
										--请选择--
									</option>
									<option value="1"
										<c:if test="${eaInfo.etype eq '1'}">selected="selected"</c:if>>
										三好学生
									</option>
									<option value="2"
										<c:if test="${eaInfo.etype eq '2'}">selected="selected"</c:if>>
										优秀学生干部
									</option>
									<option value="3"
										<c:if test="${eaInfo.etype eq '3'}">selected="selected"</c:if>>
										优秀毕业生
									</option>
								</select>
							</td>
						</tr>
						<tr>
							<th colspan="2">
								<span class="xinghao">*</span>个人总结
							</th>
							<th colspan="2">
								<span class="xinghao">*</span>主要先进事迹
							</th>
							<th colspan="2">
								<span class="xinghao">*</span>补充获得奖项
							</th>
							
						</tr>
						<tr>
							<td colspan="2" rowspan="5">
								<textarea class="form-control" id="personalSummary"
									name="personalSummary" rows="5" maxlength="512">${eaInfo.personalSummary}</textarea>
							</td>
							<td colspan="2" rowspan="5">
								<textarea class="form-control" id="personalSummarys"
									name="personalSummarys" rows="5" maxlength="512">${eaInfo.personalSummarys}</textarea>
							</td>
							<td colspan="2" rowspan="5">
								<textarea class="form-control" id="addAward"
									name="addAward" rows="5" maxlength="512">${eaInfo.addAward}</textarea>
							</td>
							
						</tr>
					</table>


					<div align="center">
						<button type="button" class="btn btn-info" id="zcBtn">
							暂存
						</button>
						<button type="button" class="btn btn-info" id="tjBtn">
							提交
						</button>
					</div>
					
				</form>
			</fieldset>
			<form action="excellentApplication/exportWord" method="post" id="exportForms">
					<input type="hidden" name="stucode" value="${stu.sstudentCode}" />
					<input type="hidden" name="etype" id="etype" value="${eaInfo.etype}"/>
					<input type="hidden" name="personalSummarysss" id="personalSummarysss" value="${eaInfo.personalSummary}"/>
					<input type="hidden" name="personalSummaryss" id="personalSummaryss" value="${eaInfo.personalSummarys}"/>
					<input type="hidden" name="addAward" id="addAward" value="${eaInfo.addAward}"/>
		    </form> 
			
		</c:if>
		
	  
	</body>
</html>
