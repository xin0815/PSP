<%@ page language="java"  contentType="text/html; charset=UTF-8" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
    	<title>班级新增</title>
 		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/vendor/jquery-2.1.0.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>select2-4.0.2/dist/css/select2.min.css" />
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/select2.min.js"></script>
		<script language="javascript" src="<%=basePath%>select2-4.0.2/dist/js/i18n/zh-CN.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
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
				$("#baocun").click(function(){
					trimAll();
					var flag = true;
					if(checkInputText() == false){
						flag = false;
					}
					if(flag){
						$("#form1").submit();
						$('#fieldset').attr("disabled",true);
					}
				});
				      //增加一行
			   $("#zj").click(function(){
			    	var _table = $("#_table");
			    	var html = "<tr><input type='hidden' name='class.cid' />";
			    	html += "<td><input type='checkbox' name='cbox' id='cbox'/></td>";
					html+= "<td><input type='text' name='cclassName' class='form-control' /></td>";
					html+= "<td><input type='text' name='cclassCode' class='form-control' /></td>";
					html+= "<td> <select id='tCode' name='teacherNum' class='multiSelect' ><option value=''>——全部——</option><c:forEach var='tlist' items='${tlist}'><option value='${tlist.bteacherId}'>${tlist.bteacherId}[${tlist.tname}]</option></c:forEach></select></td>";
					html+= "<td><input type='text' name='cgrade' class='form-control' /></td>";
					html+= "<td><input type='text' name='cmajor' class='form-control' /></td>";
					html+= "<td><input type='text' name='clanguage' class='form-control' /></td>";
					html+= "<td><input type='text' name='clevel' class='form-control' /></td>";
					html+= "<td> <select id='cisTeacher' name='cisTeacher' class='form-control' ><option value='true'>是</option><option value='false'>否</option></select></td>";
					_table.append(html);
					$(".multiSelect").select2();
				});
		
		
				//删除行
				$("#_del").click(function(){
			 		//获取选中的复选框，然后循环遍历删除
			    	var ckbs=$("input[name=cbox]:checked");
			     	if(ckbs.size()==0){
			     		swal("错误提示", "请选择要删除的行", "error");
			        	return;
			     	}
			           ckbs.each(function(){
			              $(this).parent().parent().remove();
			           });
				});
	
			})		
			function checkInputText(){
				//验证所有输入框内容均不能为空
				var flag = true;
				$("input[type='text']").each(function(){
			       if($(this).prop("name") != "" && $(this).val() == ""){//sweetalert弹出会创建name为空的text框，因此加$(this).prop("name") != ""判断
			       	$(this).focus();
  					swal("错误提示", "内容不能为空，请正确填写", "error");
			       	flag = false;
			       	return false;
			       }
			    });
			  //验证所有选择框内容均不能为空
				$('*[name="teacherNum"]').each(function(){
			       if($(this).val() == ""){
			       	$(this).focus();
  					swal("错误提示", "请选择班主任", "error");
			       	flag = false;
			       	return false;
			       }
			    });
			    return flag;
			}
		</script>
	</head>
	<body>
		<fieldset id="fieldset">
		<form action="classStudent/add" method="post" id="form1">
			<input type="hidden" name="aacademyCode" value="${academy.aacademyCode}" />
			<h6>学院：${academy.aname}&nbsp;&nbsp;&nbsp;&nbsp;学年学期：${semester.bname}</h6>
			<table id="_table" class="table table-bordered table-condensed table-hover">
				<thead>
					<tr>
				     	<th nowrap="nowrap">选择</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>班级名称</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>班级编号</th>  
				        <th nowrap="nowrap"><span class="xinghao">*</span>班主任</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>年级 </th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>专业</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>授课语种</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>培养层次</th>
				        <th nowrap="nowrap"><span class="xinghao">*</span>是否师范生</th>
	      			</tr>
	    		</thead>
	    		<tbody>
		  			<tr>
					  	<input type="hidden" name="class.cid"  id="class.cid"  />
						<td><input type="checkbox" name="cbox" id="cbox"/></td>
				        <td><input type="text" name="cclassName"  id="cclassName"class="form-control" maxlength="32"/></td>
				        <td><input type="text" name="cclassCode" id="cclassCode" class="form-control" maxlength="20" /></td>
				        <td>
				        	<select id="tCode" name="teacherNum" class="multiSelect">
				        		<option value="">——请选择——</option>
				        		<c:forEach var="tlist" items="${tlist}">
				       				<option value="${tlist.bteacherId}">${tlist.bteacherId}[${tlist.tname}]</option>
				        		</c:forEach>
				        	</select>
				        </td>
				        <td><input type="text" name="cgrade" id="cgrade" class="form-control" maxlength="4" onkeydown="checkInteger(this,4)" onkeypress="checkInteger(this,4)" onkeyup="checkInteger(this,4)" /></td>
				        <td><input type="text" name="cmajor" id="cmajor" class="form-control" maxlength="32"/></td>
				        <td><input type="text" name="clanguage" id="clanguage" class="form-control" maxlength="10" /></td>
				        <td><input type="text" name="clevel" id="clevel" class="form-control" maxlength="10" /></td>
				        <td>
							<select id="cisTeacher" name="cisTeacher" class="form-control" >
			       		 		<option value="true">是</option>
			       		 		<option value="false">否</option>
			      		  	</select>
				      	</td>
					</tr>
				</tbody>
			</table>
			<div align="center">
				<button type="button"class="btn btn-primary" id="zj" name="zj">
					增加一行
				</button>
				<button type="button"class="btn btn btn-warning" id="_del" name="_del">
					删除行
				</button>
	   			<button type="button" class="btn btn-success" id="baocun" name="baocun">
					保存
	   			</button>
	   			<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">
	   				返回
	   			</button>
     		</div>
      	</form>
      	</fieldset>
	</body>
	<script language="javascript">
		$(document).ready(function() {
			  $(".multiSelect").select2();
			});
	</script>
</html>
