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
		<title>违纪学生处理信息查询</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/vendor/jquery-2.1.0.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
	<script language="javascript">
$(function(){

     $("#_query").click(function(){
     	$("#_acaCode").val($("#aacademyCode").val());
     	$("#_sstudentCode").val($("#sstudentCode").val());
     	$("#_Docde").val($("#Docde").val());
     	$("#_doccurDate").val($("#doccurDate").val());
     	$("#queryForm").submit();
     });
     
        //全选和全不选操作
     $("#selectAll").click(function(){
           var size = $("#selectAll:checked").size();
           if(size == 1)//全选
               {
                     $("input[name='checkbox']").each(function(i,o){
                          o.checked = true;   
                     });
               }
           if(size == 0)//全不选
               {
        	      $("input[name='checkbox']").each(function(i,o){
                       o.checked = false;   
                   });
               }
        });
})
</script>
	</head>
	<body>
		<legend>
			违纪学生信息查询
		</legend>
		<form action="disciplineStudent/list" method="post" class="form-inline" id="staffForm">
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
				<label for="">处理学生所在班级</label>
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
			<!-- <input type="button" class="btn btn-info" id="_export" value="信息导出" /> -->
		</div>
			<jsp:include page="../../common/Page.jsp" />
		</form>
				<table class="table table-striped table-bordered table-condensed">
          <tr>
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
            	<c:if test = "${list.disCancel == 3}">审核中	</c:if>
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
	 <form action="disciplineStudent/export" method="post" id="exportForm">
			<input type="hidden" id="_acaCode" name="acaCode" value="" >
			<input type="hidden" id="_sstudentCode" name="sstudentCode" value="">
			<input type="hidden" id="_Docde" name="Docde"  value="" />
			<input type="hidden" id="_doccurDate" name="doccurDate" value="" />
	</form>
</body>
	<script language="javascript">
	$(document).ready(function() {
		  $(".multiSelect").select2();
		});
</script>
</html>