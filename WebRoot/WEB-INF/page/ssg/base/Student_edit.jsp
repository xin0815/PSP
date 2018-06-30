<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
	    <base href="<%=basePath%>">
	    <title>学生基本信息修改</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">    
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<script language="javascript" src="<%=basePath %>js/system/all.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link href="<%=basePath%>css/jquery-ui-1.9.2.custom.css" rel="stylesheet" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery/jquery-ui-1.9.2.custom.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery/jquery-ui-timepicker-addon.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript">
			UpLoadFileCheck=function()
			 { 
			  this.AllowExt=".jpg,.png";
			  //允许上传的文件类型 0为无限制
			  //每个扩展名后边要加一个"," 小写字母表示 
			  this.AllowImgFileSize=50;
			  //允许上传文件的大小 0为无限制 单位：KB 
			  this.AllowImgWidth=150;
			  //允许上传的图片的宽度 0为无限制　单位：px(像素) 
			  this.AllowImgHeight=200;
			  //允许上传的图片的高度 0为无限制　单位：px(像素) 
			  this.ImgObj=new Image();
			  this.ImgFileSize=0;
			  this.ImgWidth=0;
			  this.ImgHeight=0;
			  this.FileExt="";
			  this.ErrMsg="";
			  this.IsImg=false;//全局变量
			 }
			 
			  UpLoadFileCheck.prototype.CheckExt=function(obj)
			 {
			 this.ErrMsg=""; 
			 this.ImgObj.src=obj.value; 
			 //this.HasChecked=false; 
			 if(obj.value=="")
			 {
			  this.ErrMsg="\n请选择一个文件";  
			 }
			 else
			 {  
			  this.FileExt=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase(); 
			  if(this.AllowExt!=0&&this.AllowExt.indexOf(this.FileExt)==-1)
			  //判断文件类型是否允许上传 
			  { 
			  this.ErrMsg="\n该文件类型不允许上传。请上传 "+this.AllowExt+" 类型的文件，当前文件类型为"+this.FileExt;  
			  }
			 } 
			 if(this.ErrMsg!="") 
			 {
			  this.ShowMsg(this.ErrMsg,false); 
			  return false;
			 }
			 else 
			  return this.CheckProperty(obj);  
			 }
			 UpLoadFileCheck.prototype.CheckProperty=function(obj)
			 {
			 if(this.ImgObj.readyState!="complete")//
			  { 
			  sleep(1000);//一秒使用图能完全加载  
			  }  
			 if(this.IsImg==true)
			 {
			  this.ImgWidth=this.ImgObj.width;
			  //取得图片的宽度 
			  this.ImgHeight=this.ImgObj.height;
			  //取得图片的高度
			  if(this.AllowImgWidth!=0&&this.AllowImgWidth<this.ImgWidth) 
			  this.ErrMsg=this.ErrMsg+"\n图片宽度超过限制。请上传宽度小于"+this.AllowImgWidth+"px的文件，当前图片宽度为"+this.ImgWidth+"px"; 
			  if(this.AllowImgHeight!=0&&this.AllowImgHeight<this.ImgHeight) 
			  this.ErrMsg=this.ErrMsg+"\n图片高度超过限制。请上传高度小于"+this.AllowImgHeight+"px的文件，当前图片高度为"+this.ImgHeight+"px"; 
			 }
			 this.ImgFileSize=Math.round(this.ImgObj.fileSize/1024*100)/100;
			 //取得图片文件的大小 
			 if(this.AllowImgFileSize!=0&&this.AllowImgFileSize<this.ImgFileSize) 
			  this.ErrMsg=this.ErrMsg+"\n文件大小超过限制。请上传小于"+this.AllowImgFileSize+"KB的文件，当前文件大小为"+this.ImgFileSize+"KB"; 
			 if(this.ErrMsg!="") 
			 {
			  this.ShowMsg(this.ErrMsg,false); 
			  return false;
			 }
			 else
			  return true; 
			 } 
			 
			 UpLoadFileCheck.prototype.ShowMsg=function(msg,tf)
			 //显示提示信息 tf=false 显示错误信息 msg-信息内容 
			 { 
			 /*msg=msg.replace("\n","<li>"); 
			 msg=msg.replace(/\n/gi,"<li>"); 
			  */
			 alert(msg);
			 }
			 function sleep(num) 
			 { 
			  var tempDate=new Date(); 
			  var tempStr=""; 
			  var theXmlHttp = new ActiveXObject( "Microsoft.XMLHTTP" ); 
			  while((new Date()-tempDate)<num ) 
			  { 
			  tempStr+="\n"+(new Date()-tempDate); 
			  try{ 
			  theXmlHttp .open( "get", "about:blank?JK="+Math.random(), false ); 
			  theXmlHttp .send(); 
			  } 
			  catch(e){;} 
			  } 
			  //containerDiv.innerText=tempStr; 
			 return; 
			 } 
			 
			 
			function c(obj){
				var d=new UpLoadFileCheck();
				d.IsImg=true;
				 d.AllowImgFileSize=100;
				 d.CheckExt(obj)
			}
			$(function(){
				$("#fhBtn").click(function(){//返回
					window.location.href="<%=basePath%>student/info?stuCode="+$("#sstudentCode").val();
				});
				$("#tjBtn").click(function(){//提交
					trimAll();//去掉所有空格
					if(!check()){
						return false;
					}else{
						$("#updateForm").submit();
					}
				});			     
			})
			function check(){
				//出生年月
				if($('#sbirthDate').val() == ""){
  					swal("错误提示", "请填写出生年月", "error");
					$('#sbirthDate').focus();
					return false;
				}
				//民族
				if($('#snation').val() == ""){
  					swal("错误提示", "请选择民族", "error");
					$('#snation').focus();
					return false;
				}
				//政治面貌
				if($('#spolitical').val() == ""){
  					swal("错误提示", "请填写政治面貌", "error");
					$('#spolitical').focus();
					return false;
				}
				//宿舍号
				if($('#sdormNum').val() == ""){
  					swal("错误提示", "请填写宿舍号", "error");
					$('#sdormNum').focus();
					return false;
				}
				//本人联系方式
				if($('#sphoneNum').val() == ""){
  					swal("错误提示", "请填写本人联系方式", "error");
					$('#sphoneNum').focus();
					return false;
				}
				//联系人1
				if($('#srelation1').val() == ""){
  					swal("错误提示", "请填写联系人1", "error");
					$('#srelation1').focus();
					return false;
				}
				//与本人关系
				if($('#srelationship1').val() == ""){
  					swal("错误提示", "请填写与本人关系", "error");
					$('#srelationship1').focus();
					return false;
				}
				//联系人1电话
				if($('#srelationPhone1').val() == ""){
  					swal("错误提示", "请填写联系人1电话", "error");
					$('#srelationPhone1').focus();
					return false;
				}
				
				//联系人2
				if($('#srelation2').val() == ""){
  					swal("错误提示", "请填写联系人2", "error");
					$('#srelation2').focus();
					return false;
				}
				//与本人关系
				if($('#srelationship2').val() == ""){
  					swal("错误提示", "请填写与本人关系", "error");
					$('#srelationship2').focus();
					return false;
				}
				//联系人2电话
				if($('#srelationPhone2').val() == ""){
  					swal("错误提示", "请填写联系人2电话", "error");
					$('#srelationPhone2').focus();
					return false;
				}
				//身份证号码
				if($('#sidCard').val() == ""){
  					swal("错误提示", "请填写身份证号码", "error");
					$('#sidCard').focus();
					return false;
				} else if ($('#sidCard').val().length != 18) {
					$('#sidCard').focus();
					swal("错误提示", "无效的身份证号码", "error");
					return false;
				}
				if($('#sname').val() ==""){
					swal("错误提示", "请填写姓名", "error");
					$('#srelationPhone2').focus();
					return false;
				}
				if($('#joinDate').val()==""){
					swal("错误提示", "请填写加入时间", "error");
					$('#joinDate').focus();
					return false;
				}
				if($('#spostcode').val()==""){
					swal("错误提示", "请填写邮编", "error");
					$('#spostcode').focus();
					return false;
				}
				if($('#sorigin').val()==""){
					swal("错误提示", "请填写籍贯", "error");
					$('#sorigin').focus();
					return false;
				}
				if($('#shomeAdd').val()==""){
					swal("错误提示", "请填写家庭详细地址", "error");
					$('#shomeAdd').focus();
					return false;
				}
				if($('#soldSchool').val()==""){
					swal("错误提示", "请填写入学前所在学校", "error");
					$('#soldSchool').focus();
					return false;
				}
			    if($('#sfamilyRel1').val()==""){
			    	swal("错误提示", "请填写家庭成员称呼", "error");
					$('#sfamilyRel1').focus();
					return false;
			    }
			    if($('#sfamilyName1').val()==""){
			    	swal("错误提示", "请填写家庭成员姓名", "error");
					$('#sfamilyName1').focus();
					return false;
			    }
			    if($('#sfamilyAge1').val()==""){
			    	swal("错误提示", "请填写家庭成员年龄", "error");
					$('#sfamilyAge1').focus();
					return false;
			    }
			    if($('#sfamilyPolitical1').val()==""){
			    	swal("错误提示", "请填写家庭成员政治面貌", "error");
					$('#sfamilyPolitical1').focus();
					return false;
			    }
			    if($('#sfamilyWork1').val()==""){
			    	swal("错误提示", "请填写家庭成员所在单位", "error");
					$('#sfamilyWork1').focus();
					return false;
			    }
			    if($('#sfamilyWorkDuty1').val()==""){
			    	swal("错误提示", "请填写家庭成员职务", "error");
					$('#sfamilyWorkDuty1').focus();
					return false;
			    }
			    if($('#sresumeDate1').val()==""){
			    	swal("错误提示", "请填写毕业时间", "error");
					$('#sresumeDate1').focus();
					return false;
			    }
			    if($('#soldSchool1').val()==""){
			    	swal("错误提示", "请填写毕业学校", "error");
					$('#soldSchool1').focus();
					return false;
			    }
			    if($('#sresCertifier1').val()==""){
			    	swal("错误提示", "请填写毕业证明人", "error");
					$('#sresCertifier1').focus();
					return false;
			    }
				return true;
			}
			$(document).ready(function() { 
				$('#sbirthDate').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1980:2016"
				});
				$('#joinDate').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1980:2030"
				});
				$('#sresumeDate1').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1990:2030"
				});
				$('#sresumeDate2').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1990:2030"
				});
				$('#sresumeDate3').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1990:2030"
				});
				$('#sresumeDate4').datepicker({
					dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
					dayNamesMin  : ['日', '一', '二', '三', '四', '五', '六'],
					dateFormat: 'yy-mm-dd',
		           	prevText:'前一月',
		           	nextText:'后一月',
		           	currentText:' ',
		           	monthNames: ['一月','二月','三月','四月','五月','六月', '七月','八月','九月','十月','十一月','十二月'],
		           	monthNamesShort: ['1','2','3','4','5','6', '7','8','9','10','11','12'],
		           	closeText:'确定',
		           	changeMonth: true,
		           	changeYear: true,
		           	showMonthAfterYear: true,
		           	yearRange:"1990:2030"
				});
			});
		</script>
		<style>
			.xinghao{
				color: red;
				font-size: 16px;
				margin-right: 5px;
			}
		</style>
	</head>
	<body>
		<legend>学生基本信息</legend>
		<form action="student/update" method="post" id="updateForm" class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" class="form-control" id="sstudentCode" name="sstudentCode" value="${stu.sstudentCode}" />
			<input type="hidden" class="form-control" name="sname" value="${stu.sname}" />
			<table class="table table-bordered table-condensed table-striped">
				<tr>
				    <th>学号</th>
				    <th><span class="xinghao">*</span>姓名</th>
				    <th>曾用名</th>
				    <th><span class="xinghao">*</span>出生年月</th>
				    <th><span class="xinghao">*</span>性别</th>
				    <th><span class="xinghao">*</span>民族</th>
				    <th><span class="xinghao">*</span>政治面貌</th>
				    <th rowspan="4" style="width: 150px;"><img alt="一寸相" src="<%=basePath %>stuPicture/${stu.pictureUrl}" width="148" height="148"/><input type="file" id="pictureUrl" name="pictureUrl" class="form-control" onkeydown="return false;" onchange="c(this)" /></th>
			    </tr>
			    <tr>
				    <td>${stu.sstudentCode}</td>
				    <td><input type="text" id="sname" name="sname" value="${stu.sname}" class="form-control" placeholder="姓名" maxlength="32" /></td>
				    <td><input type="text" id="soldName" name="soldName" value="${stu.soldName}" class="form-control" placeholder="曾用名" maxlength="32" /></td>
				    <td><input type="text" id="sbirthDate" name="sbirthDate" value="${stu.sbirthDate}" class="form-control" placeholder="出生年月" readonly="readonly"/></td>
			        <td>
					<select type="text" name="ssex" id="ssex" class="form-control">
						<option value="男" <c:if test="${stu.ssex eq '男' }">selected="selected"</c:if>>男</option>
						<option value="女" <c:if test="${stu.ssex eq '女' }">selected="selected"</c:if>>女</option>
					</select>
				    </td>
				    <td>
				    <select name="snation" id="snation" class="form-control">
						<option value="">请选择</option>
						<c:forEach var="nation" items="${nationList}">
							<option value="${nation.nid}" <c:if test="${nation.nid eq stu.snation.nid}">selected="selected"</c:if>>${nation.name}</option>
						</c:forEach>
					</select>
				    </td>
				    <td>
						<input type="text" id="spolitical" name="spolitical" value="${stu.spolitical}" class="form-control" placeholder="政治面貌" maxlength="10" />
				    </td>
				</tr>
				<tr>
					<th><span class="xinghao">*</span>加入时间</th>
				    <th><span class="xinghao">*</span>宿舍号</th>
				    <th><span class="xinghao">*</span>本人联系方式</th>
				    <th><span class="xinghao">*</span>邮编</th>
				    <th colspan="2"><span class="xinghao">*</span>籍贯</th>
				    <th><span class="xinghao">*</span>是否孤儿</th>
			    </tr>
			    <tr>
			    	<td><input type="text" id="joinDate" name="joinDate" value="${stu.joinDate}" class="form-control" readonly="readonly"/></td>
				    <td><input type="text" id="sdormNum" name="sdormNum" value="${stu.sdormNum}" class="form-control" placeholder="宿舍号" maxlength="20"/></td>
				    <td><input type="text" id="sphoneNum" name="sphoneNum" value="${stu.sphoneNum}" class="form-control" placeholder="本人联系方式" maxlength="20"/></td>
				    <td><input type="text" id="spostcode" name="spostcode" value="${stu.spostcode}" class="form-control" placeholder="邮编" maxlength="10"/></td>
				    
				    <td colspan="2">
						<input type="text" id="sorigin" name="sorigin" value="${stu.sorigin}" class="form-control" placeholder="籍贯" maxlength="64"/>
				    </td>
				    <td>
						<select name="sisOrphan" id="sisOrphan" class="form-control">
							<option value="false" <c:if test="${stu.sisOrphan eq 'false' }">selected="selected"</c:if>>否</option>
							<option value="true" <c:if test="${stu.sisOrphan eq 'true' }">selected="selected"</c:if>>是</option>
						</select>
				    </td>
				<tr>
					<th><span class="xinghao">*</span>是否残疾</th>
					<th>残疾等级</th>
				    <th><span class="xinghao">*</span>联系人1</th>
				    <th><span class="xinghao">*</span>与本人关系</th>
				    <th><span class="xinghao">*</span>联系人1电话</th>
				    <th><span class="xinghao">*</span>联系人2</th>
				    <th><span class="xinghao">*</span>与本人关系</th>
				    <th><span class="xinghao">*</span>联系人2电话</th>
			    </tr>
			    <tr>
			    	<td>
					<select type="text" name="sisDisable" id="sisDisable" class="form-control">
						<option value="false" <c:if test="${stu.sisDisable eq 'false' }">selected="selected"</c:if>>否</option>
						<option value="true" <c:if test="${stu.sisDisable eq 'true' }">selected="selected"</c:if>>是</option>
					</select>
				    </td>
				    
				    <td>
				    	<input type="text" id="sdisableLevel" name="sdisableLevel" value="${stu.sdisableLevel}" class="form-control" maxlength="32" placeholder="残疾等级" />
				    </td>
				    <td><input type="text" id="srelation1" name="srelation1" value="${stu.srelation1}" class="form-control"  placeholder="联系人1" maxlength="20" /></td>
				    <td><input type="text" id="srelationship1" name="srelationship1" value="${stu.srelationship1}" class="form-control"  maxlength="10" placeholder="与本人关系" /></td>
				    <td><input type="text" id="srelationPhone1" name="srelationPhone1" value="${stu.srelationPhone1}" class="form-control"  maxlength="20" placeholder="联系人1电话" /></td>
				    <td><input type="text" id="srelation2" name="srelation2" value="${stu.srelation2}" class="form-control"  maxlength="20" placeholder="联系人2" /></td>
				    <td><input type="text" id="srelationship2" name="srelationship2" value="${stu.srelationship2}" class="form-control"  maxlength="10" placeholder="与本人关系" /></td>
				    <td><input type="text" id="srelationPhone2" name="srelationPhone2" value="${stu.srelationPhone2}" class="form-control"  maxlength="20" placeholder="联系人2电话" /></td>
				</tr>
				<tr>
					<th colspan="1"><span class="xinghao">*</span>身份证号</th>
					<th colspan="1"><span class="xinghao">*</span>校发农业银行卡卡号</th>
					<th colspan="2"><span class="xinghao">*</span>家庭详细地址</th>
					<th colspan="2"><span class="xinghao">*</span>入学前所在学校</th>
				    <th colspan="2">生源地</th>
				</tr>
				<tr>
					<td colspan="1"><input type="text" id="sidCard" name="sidCard" value="${stu.sidCard}" class="form-control" maxlength="18" placeholder="身份证号" /></td>
					<td colspan="1"><input type="text" id="sCard" name="sCard" value="${stu.sCard}" class="form-control" maxlength="30" placeholder="校发农业银行卡卡号" /></td>
					
					<td colspan="2"><input type="text" id="shomeAdd" name="shomeAdd" value="${stu.shomeAdd}" class="form-control" maxlength="64" placeholder="家庭详细地址" /></td>
					<td colspan="2"><input type="text" id="soldSchool" name="soldSchool" value="${stu.soldSchool}" class="form-control"  maxlength="64" placeholder="入学前所在学校" /></td>
				    <td colspan="2"><input type="text" name="soriginHome" value="${stu.soriginHome}" class="form-control"  maxlength="32" placeholder="生源地" /></td>
				</tr>
			</table>
			<table class="table table-bordered table-condensed table-striped">
				<tr>
					<th rowspan="4" style="width: 30px;vertical-align: middle;">家</br>庭</br>成</br>员</th>
				    <th><span class="xinghao">*</span>称呼</th>
				    <th><span class="xinghao">*</span>姓名</th>
				    <th><span class="xinghao">*</span>年龄</th>
				    <th><span class="xinghao">*</span>政治面貌</th>
				    <th><span class="xinghao">*</span>所在单位</th>
				    <th><span class="xinghao">*</span>职务</th>
				</tr>
				<tr>
			    	<td><input type="text" id="sfamilyRel1" name="sfamilyRel1" value="${stu.sfamilyRel1}" class="form-control" maxlength="10"  placeholder="称呼" /></td>
			    	<td><input type="text" id="sfamilyName1" name="sfamilyName1" value="${stu.sfamilyName1}" class="form-control" maxlength="32" placeholder="姓名" /></td>
			    	<td><input type="text" id="sfamilyAge1" name="sfamilyAge1" value="${stu.sfamilyAge1}" class="form-control" maxlength="2" placeholder="年龄" /></td>
			    	<td><input type="text" id="sfamilyPolitical1" name="sfamilyPolitical1" value="${stu.sfamilyPolitical1}" maxlength="10" class="form-control"  placeholder="政治面貌" /></td>
			    	<td><input type="text" id="sfamilyWork1" name="sfamilyWork1" value="${stu.sfamilyWork1}" class="form-control" maxlength="32" placeholder="所在单位" /></td>
			    	<td><input type="text" id="sfamilyWorkDuty1" name="sfamilyWorkDuty1" value="${stu.sfamilyWorkDuty1}" class="form-control" maxlength="20" placeholder="职务" /></td>
				</tr>
				<tr>
			    	<td><input type="text" name="sfamilyRel2" value="${stu.sfamilyRel2}" class="form-control"  maxlength="10" placeholder="称呼" /></td>
			    	<td><input type="text" name="sfamilyName2" value="${stu.sfamilyName2}" class="form-control" maxlength="32" placeholder="姓名" /></td>
			    	<td><input type="text" name="sfamilyAge2" value="${stu.sfamilyAge2}" class="form-control" maxlength="2" placeholder="年龄" /></td>
			    	<td><input type="text" name="sfamilyPolitical2" value="${stu.sfamilyPolitical2}" maxlength="10" class="form-control"  placeholder="政治面貌" /></td>
			    	<td><input type="text" name="sfamilyWork2" value="${stu.sfamilyWork2}" class="form-control" maxlength="32" placeholder="所在单位" /></td>
			    	<td><input type="text" name="sfamilyWorkDuty2" value="${stu.sfamilyWorkDuty2}" class="form-control" maxlength="20" placeholder="职务" /></td>
				</tr>
				<tr>
			    	<td><input type="text" name="sfamilyRel3" value="${stu.sfamilyRel3}" class="form-control"  maxlength="10" placeholder="称呼" /></td>
			    	<td><input type="text" name="sfamilyName3" value="${stu.sfamilyName3}" class="form-control"  maxlength="32" placeholder="姓名" /></td>
			    	<td><input type="text" name="sfamilyAge3" value="${stu.sfamilyAge3}" class="form-control" maxlength="2" placeholder="年龄" /></td>
			    	<td><input type="text" name="sfamilyPolitical3" value="${stu.sfamilyPolitical3}" maxlength="10" class="form-control"  placeholder="政治面貌" /></td>
			    	<td><input type="text" name="sfamilyWork3" value="${stu.sfamilyWork3}" class="form-control" maxlength="32" placeholder="所在单位" /></td>
			    	<td><input type="text" name="sfamilyWorkDuty3" value="${stu.sfamilyWorkDuty3}" class="form-control" maxlength="20" placeholder="职务" /></td>
				</tr>
			</table>
			<table class="table table-bordered table-condensed table-striped">
				<tr>
					<th rowspan="3" style="width: 30px;vertical-align: middle;">本</br>人</br>简</br>历</th>
				    <th><span class="xinghao">*</span>毕业时间</th>
				    <th><span class="xinghao">*</span>学校</th>
				    <th><span class="xinghao">*</span>证明人</th>
				    <th><span class="xinghao">*</span>毕业时间</th>
				    <th><span class="xinghao">*</span>学校</th>
				    <th><span class="xinghao">*</span>证明人</th>
				</tr>
				<tr>
			    	<td><input type="text" id="sresumeDate1" name="sresumeDate1" value="${stu.sresumeDate1}" class="form-control" maxlength="10" placeholder="毕业时间" /></td>
			    	<td><input type="text" id="soldSchool1" name="soldSchool1" value="${stu.soldSchool1}" class="form-control" maxlength="32" placeholder="学校" /></td>
			    	<td><input type="text" id="sresCertifier1" name="sresCertifier1" value="${stu.sresCertifier1}" class="form-control" maxlength="32" placeholder="证明人" /></td>
			    	<td><input type="text" id="sresumeDate2" name="sresumeDate2" value="${stu.sresumeDate2}" class="form-control" maxlength="10" placeholder="毕业时间" /></td>
			    	<td><input type="text" name="soldSchool2" value="${stu.soldSchool2}" class="form-control" maxlength="32" placeholder="学校" /></td>
			    	<td><input type="text" name="sresCertifier2" value="${stu.sresCertifier2}" class="form-control" maxlength="32" placeholder="证明人" /></td>
				</tr>
				<tr>
			    	<td><input type="text" id="sresumeDate3" name="sresumeDate3" value="${stu.sresumeDate3}" class="form-control" maxlength="10" placeholder="毕业时间" /></td>
			    	<td><input type="text" name="soldSchool3" value="${stu.soldSchool3}" class="form-control" maxlength="32" placeholder="学校" /></td>
			    	<td><input type="text" name="sresCertifier3" value="${stu.sresCertifier3}" class="form-control" maxlength="32" placeholder="证明人" /></td>
			    	<td><input type="text" id="sresumeDate4" name="sresumeDate4" value="${stu.sresumeDate4}" class="form-control" maxlength="10" placeholder="毕业时间" /></td>
			    	<td><input type="text" name="soldSchool4" value="${stu.soldSchool4}" class="form-control" maxlength="32" placeholder="学校" /></td>
			    	<td><input type="text" name="sresCertifier4" value="${stu.sresCertifier4}" class="form-control" maxlength="32" placeholder="证明人" /></td>
				</tr>
			</table>
			<div align="center">
				<button type="button" class="btn btn-info" id="tjBtn">提交</button>
				<button type="button" class="btn btn-info" id="fhBtn">返回</button>
			</div>
		</form>
	</body>
</html>
