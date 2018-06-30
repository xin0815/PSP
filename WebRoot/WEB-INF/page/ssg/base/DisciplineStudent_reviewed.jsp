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
		<title>违纪撤销审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	<script language="javascript">
		/*获取选中的checkbox的当前行的所有信息*/
$(function(){
	
     //审核通过
    $("#reviewed_success").click(function(o){
	   var check = false;
		var obj = document.getElementsByTagName("input");
		for(var i=0; i<obj.length; i ++){
		    if(obj[i].checked){
		    	$("#_did").val(obj[i].value);
		        $("#_disCancel").val(1);
		        check = true;
		    }
		}
		if(check){
			swal({title: "温馨提示",text: "您确定审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
				$("#reviewed_form").submit();
			});
		}else{
			swal("错误提示", "请选择一条违纪记录", "error");
		}
   });
   
   $("#reviewed_fail").click(function(o){ 
	   var check = false;
		var obj = document.getElementsByTagName("input");
		for(var i=0; i<obj.length; i ++){
		    if(obj[i].checked){
		    	$("#_did").val(obj[i].value);
		        $("#_disCancel").val(0);
		        check = true;
		    }
		}
		if(check){
			swal({title: "温馨提示",text: "您确定退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
				$("#reviewed_form").submit();
			});
		}else{
			swal("错误提示", "请选择一条违纪记录", "error");
		}
   });
 });
</script>
	</head>
	<body>
		<legend>
			违纪撤销审核
		</legend>
		<form action="disciplineStudent/reviewed" method="post" class="form-inline" id="staffForm">
			<div class="well form-search">
			<div class="form-group">
				<label for="">处理学生所在学院</label>
				<select id="aacademyCode" name="student.cclass.academyInfo.aacademyCode" style="width: 120px;" class="multiSelect ">
					<c:if test="${teacher.isSchoolTeacher == true}">
					<option value="">——全部——</option>
					</c:if>
					<c:forEach var="acade" items="${acadeLsit}">
						<option value="${acade.aacademyCode}" <c:if test="${acade.aacademyCode eq ds.student.cclass.academyInfo.aacademyCode}">selected='selected'</c:if>>${acade.aname}</option>
					</c:forEach>
				</select>
			</div>
			<c:if test="${not empty classList}">
			<div class="form-group">
				<label for="">班级</label>
				<select id="cid" name="student.cclass.cid" style="width: 120px;"  class="multiSelect ">
					<option value="">——全部——</option>
					<c:forEach var="cc" items="${classList}">
					<option value="${cc.cid}" <c:if test="${cc.cid eq ds.student.cclass.cid}">selected='selected'</c:if>>${cc.cclassName}</option>
					</c:forEach>
				</select>
			</div>
			</c:if>
			<div class="form-group">
				<label for="">处理学生学号</label>
				<input type="text" id="sstudentCode" name="student.sstudentCode" style="width: 120px;" class="form-control" value="${ds.student.sstudentCode }" />
			</div>	
			<div class="form-group">
				<label for="">处理文号</label>
				<input type="text" id="dcode" name="dcode" style="width: 120px;" class="form-control" value="${ds.dcode }" />
			</div>
			<div class="form-group">
				<label for="">处理日期</label>
				<input type="text" id="doccurDate" name="doccurDate" style="width: 120px;" class="form-control" value="${ds.doccurDate }" />
			</div>
			<input type="submit" class="btn btn-primary" id = "_query" value="查询 " />
			</div>
			<jsp:include page="../../common/Page.jsp" />
		</form>
				<table class="table table-striped table-bordered table-condensed">
          <tr>
       		<th>
       			
       		</th>
            <th style = "white-space:nowrap;">
              学号
            </th>
            <th style = "white-space:nowrap;">
              姓名
            </th>
            <th style = "white-space:nowrap;">
              性别
            </th>
            <th style = "white-space:nowrap;">
              学院
            </th>
            <th style = "white-space:nowrap;">
              专业
            </th>
            <th style = "white-space:nowrap;">
              班级
            </th>
            <th style = "white-space:nowrap;">
              违纪日期
            </th>
            <th style = "white-space:nowrap;">
              处分原因
            </th>
            <th style = "white-space:nowrap;">
              处分级别
            </th>
            <th style = "white-space:nowrap;">
              处分日期
            </th>
            <th style = "white-space:nowrap;">
              处分文号
            </th>
            <th style = "white-space:nowrap;">
              处分是否撤销
            </th>
            <th style = "white-space:nowrap;">
              撤销日期
            </th>
             <th style = "white-space:nowrap;">
              撤销理由
            </th>
          </tr>
               <tr>
      <c:forEach var="list" items="${pager.data}">
      		<td>
      			<input name="Fruit" type="radio" value="${list.did }" />
      		</td>
            <td style = "white-space:nowrap;">
              ${list.student.sstudentCode}
            </td>
            <td style = "white-space:nowrap;">
              	${list.student.sname}
            </td>
            <td style = "white-space:nowrap;">
              	${list.student.ssex}
            </td>
            <td style = "white-space:nowrap;">
            	${list.student.cclass.academyInfo.aname}
            </td>
            <td style = "white-space:nowrap;">
          		${list.student.cclass.cmajor}
            </td>
            <td style = "white-space:nowrap;">
           		${list.student.cclass.cclassName}
            </td >
            <td style = "white-space:nowrap;">
              	${list.ddisDate}
            </td >
            <td>
              	${list.dreason}
            </td>
            <td style = "white-space:nowrap;">
              	${list.dlevel}
            </td>
            <td style = "white-space:nowrap;">
              	${list.doccurDate}
            </td>
            <td style = "white-space:nowrap;">
            	${list.dcode}
            </td>
            <td style = "white-space:nowrap;">
          		<c:if test = "${list.disCancel == 1}">是</c:if>
            	<c:if test = "${list.disCancel == 0}">否</c:if>
            	<c:if test = "${list.disCancel == 3}">待审核</c:if>
            </td>
            <td style = "white-space:nowrap;">
              	${list.dcancelDate}
            </td>
             <td style = "white-space:nowrap;"> 
              	${list.dcancelReason}
            </td>
          </tr>
     </c:forEach>
    </table>
	</div>
	<center><button type="button" class="btn btn-warning" id = "reviewed_success">审核通过</button>
			<button type="button" class="btn btn-warning" id = "reviewed_fail">退回</button>
	</center>
		<form action="disciplineStudent/reviewedSuccess" method="post" id="reviewed_form">
				<input type="hidden" id="_did" name="did" value="" >
				<input type="hidden" id="_disCancel" name="disCancel"  value="" />
		</form>
</body>
	<script language="javascript">
	$(document).ready(function() {
		  $(".multiSelect").select2();
		});
</script>
</html>
