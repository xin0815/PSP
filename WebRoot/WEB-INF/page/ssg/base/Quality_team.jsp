<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>素质评价小组</title>
    <base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<style>.form-group{margin: 10px 10px;margin—left:10px;}</style>
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
  </head>
<script language="javascript">
		var index =0;
		window.onload=function(){
			var listsize = $("#listsize").val();
			if(listsize != ""){
				index= listsize;
			}
		}
$(function(){
		$("#tj").click(function(){ //提交操作
  		trimAll();
  		var flag = true;
  		if(!checkInputText()){
  			flag = false;
  		}else if(!checkStudentCode()){
  			flag = false;
  		}
        if(flag){
        	if(confirm('提交后，将无法修改。您确定要提交吗？')) {
	        	document.getElementById("checkStatus").value = 1;
	        	$("#updateForm").submit();
        	}
        }
      });
      
      $("#zc").click(function(){ //暂存操作
  		trimAll();
  		var flag = true;
  		if(!checkInputText()){
  			flag = false;
  		}else if(!checkStudentCode()){
  			flag = false;
  		}
        if(flag){
        	document.getElementById("checkStatus").value = 0;
        	$("#updateForm").submit();
        }
      });

		//增加一行
	   $("#zj").click(function(){
	    	var _table = $("#_table");
	    	index++;
	    	var html = "<tr><td><input type='checkbox' name='cbox' id='cbox_"+ index +"'/></td>";
			html+= "<td><input type='text' name='sstudentCode' id = 'sstudentCode_"+ index +"'onchange='ajaxGetStuInfo(this)' class='form-control' placeholder='请输入学生学号' /></td>";
			html+= "<td><input type='text' name='sname' id = 'sname_"+ index +"' class='form-control' readonly='readonly'/></td>";
			html+= "<td><input type='text' name='qtduty' id = 'qtduty_"+ index +"' class='form-control' placeholder='请输入职务'/></td>";
			html+= "<td><input type='text' name='qtisDiscip' id = 'qtisDiscip_"+ index +"' class='form-control' readonly='readonly'/></td>";
			html+= "<td><select type='text' name='qtisRstudy' id = 'qtisRstudy_"+ index +"' class='form-control'><option value=''>--请选择--</option><option value='1'>是</option><option value='0'>否</option></select></td>";
			html+= "<td><input type='text' name='sdormNum'  id = 'sdormNum_"+ index +"' class='form-control' readonly='readonly'/></td>";
			html+= "<td><input type='text' name='sphoneNum'  id = 'sphoneNum_"+ index +"' class='form-control' readonly='readonly'/></td></tr>";
			_table.append(html);	
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

//验证学号不能重复
function checkStudentCode(){
	var flag = true;
    var sstudentCodes = $("input[name=sstudentCode]");
    sstudentCodes.each(function(){
    	var sstudentCode = $(this).val();
    	var i = 0;
    	sstudentCodes.each(function(){
    		if($(this).val() == sstudentCode){
    			i++;
    		}
    	});
    	if(i>1){
    		alert("学号为"+sstudentCode+"的人员重复录入");
    		flag = false;
       		return false;
    	}
    });
    return flag;
}

function ajaxGetStuInfo(obj){
	var flag = true;
	initAjaxXmlHttpRequest();
	var src = "<%=basePath%>qualityteam/ajaxGetStuInfo?sstudentCode="+obj.value+"&cclassId="+$("#cclassId").val();
    // 指定要打开的页面
    xmlhttp.open("POST", src, false);
    // 指定页面打开完之后要进行的操作.
    xmlhttp.onreadystatechange =function(){
		// 请求已完成
		if (xmlhttp.readyState == 4) {
			var message = xmlhttp.responseText;
			if(message!=""){
				var stuInfo = message.split(",");
				if(stuInfo.length == 1){//返回信息为错误信息
					swal("错误提示", message, "error");
				}else{
					var idarray = obj.id.split("_");
					document.getElementById("sname_"+idarray[1]).value=stuInfo[1];
					document.getElementById("qtisDiscip_"+idarray[1]).value=stuInfo[2];
					document.getElementById("sdormNum_"+idarray[1]).value=stuInfo[3];
					document.getElementById("sphoneNum_"+idarray[1]).value=stuInfo[4];
				}
			}
		}
	};
    xmlhttp.send();
    return flag;
}
	
function checkInputText(){
	var flag = true;
	$('*[name="qtisRstudy"]').each(function(){
		if($(this).val() == ""){
       		$(this).focus();
			swal("错误提示", "请选择有无补考或重修", "error");
       		flag = false;
       		return false;
		}
    });
	$('*[name="qtduty"]').each(function(){
		if($(this).val() == ""){
       		$(this).focus();
			swal("错误提示", "职务不能为空", "error");
       		flag = false;
       		return false;
		}
    });
	$('*[name="sstudentCode"]').each(function(){
		if($(this).val() == ""){
       		$(this).focus();
			swal("错误提示", "学号不能为空", "error");
       		flag = false;
       		return false;
		}
    });
    return flag;
}
</script>
  
  
  <body>
  <legend>
		素质评价小组
  </legend>
  <input type="hidden" id="listsize" value="${listsize}" />
    <form action="qualityteam/list"  method="post" id="QualityTeamForm" class="form-inline" style="aligen:center;">
    	  <div class="well form-search">
			 <div class="form-group">
	      		<label for="disabledTextInput">素质评价年度</label>
	     		<input class="form-control" type="text" value="${semester.bname}" readonly >
    		 </div>

			  <div class="form-group" style="margin-left:10px;" >
			    <label for="exampleInputEmail2">学院</label>
			    	<input class="form-control" type="text" value = "${aname}"  readonly>
			  </div>
			  
			  <div class="form-group" style="margin-left:10px;" >
			    <label for="classTeacher">班主任</label>
			  <input class="form-control" type="text" value = "${tname}"  readonly>
			  </div>
			  
			  <div class="form-group" style="margin-left:10px;" >
			    <label for="">班級</label>
				   <select id="cclassId" name="cclassId" class="form-control">
					   <option value="">——请选择——</option>
					   <c:forEach var="bc" items="${classList}">
						   <option value="${bc.cid}" <c:if test="${bc.cid eq cclassId}">selected='selected'</c:if>>
						   	${bc.cclassName}
						   </option>
					   </c:forEach>			   
				  </select>
			  </div>
			  <input style="margin-left:20px;" type="submit" class="btn btn-primary" value="查询 " />
		</div>
	</form>
	<fieldset <c:if test="${empty cclassId or checkStatus eq 1}">disabled</c:if>>
	<form action="qualityteam/update"  method="post" id="updateForm" class="form-inline" style="aligen:center;">
		<input type="hidden" name="checkStatus" id="checkStatus" />
		<input type="hidden" name="cclassId" value="${cclassId }">
		<table id="_table" style="margin:20 3px;"class="table table-bordered table-hover">
	    <thead>
	    <tr>
	    <th style="text-align:center"  colspan=9>素质考评小组名单</th>
	     </tr>
	     <tr style="text-align:center">
	     	<th nowrap="nowrap">选择</th>
	        <th>学号</th>
	        <th>姓名</th>
	        <th>担任职务</th>
	        <th>是否受处分</th>
	        <th>有无补考或重修 </th>
	        <th>宿舍号</th>
	        <th>电话号码</th>
	      </tr>
	    </thead>
	    
	    <tbody>
	    <c:forEach var="qt" items="${teamList}" varStatus="status">
		  <tr>
			<td><input type="checkbox" name="cbox" id="cbox_${status.index}"/></td>
	        <td><input type="text" name="sstudentCode"  id="sstudentCode_${status.index + 1}" onchange="ajaxGetStuInfo(this)" value="${qt.student.sstudentCode} "class="form-control" /></td>
	        <td><input type="text" name="sname" id="sname_${status.index + 1}" readonly="readonly" value="${qt.student.sname}" class="form-control" /></td>
	        <td><input type="text" name="qtduty" id="qtduty_${status.index + 1}" value="${qt.qtduty}" class="form-control" /></td>
	        <td><input type="text" name="qtisDiscip" id="qtisDiscip_${status.index + 1}" readonly="readonly" <c:if test="${qt.qtisDiscip eq true}">value="是"</c:if><c:if test="${qt.qtisDiscip eq false}">value="否"</c:if> class="form-control" /></td>
			<td>
				<select type="text" name="qtisRstudy" id = "qtisRstudy_${status.index + 1}" class="form-control">
					<option value="">--请选择--</option>
					<option value="1" <c:if test="${qt.qtisRstudy eq true}">selected="selected"</c:if>>是</option>
					<option value="0" <c:if test="${qt.qtisRstudy eq false}">selected="selected"</c:if>>否</option>
				</select>
	        <td><input type="text" name="sdormNum" id="sdormNum_${status.index + 1}" readonly="readonly"value="${qt.student.sdormNum}" class="form-control" /></td>
	        <td><input type="text" name="sphoneNum" id="sphoneNum_${status.index + 1}" readonly="readonly"value="${qt.student.sphoneNum}" class="form-control" /></td>
	       </tr>
	       </c:forEach>
	      </tbody>
	 	</table>
   	</form>
  	<div align="center">
	   <button type="button" class="btn btn-primary" id="zj" name="zj">
			增加一行
		</button>
	   <button type="button" class="btn btn btn-warning" id="_del" name="_del">
			删除行
	   </button>
	   <button type="button" class="btn btn-info" id="zc" name="zc">
			 暂存
	   </button>
	   <button type="button" class="btn btn-success" id="tj" name="tj">
			 提交
	   </button>
	</div>
	</fieldset>
		
  </body>
</html>
