<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8"%>
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
		<title>贫困认定申请</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>css/bg_new.css" />
		<script language="javascript"
			src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript"
			src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>css/fileTag.css" />
		<style>
	.xinghao{
		color: red;
		font-size: 20px;
		margin-right: 5px;
		vertical-align: top;
	}
</style>
		<script>   
		var isIE = /msie/i.test(navigator.userAgent) && !window.opera; 
  			$(function(){
  				$("#tjBtn").click(function(){//提交
  					if(check()){
  						swal({title: "温馨提示",text: "提交后将不能修改，您确定要提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
  							$("#isSubmit").val(true);
  	  						$("#applyForm").submit();
  						});
  					}
				});
  				$("#zcBtn").click(function(){//暂存
  					if(check()){
  						swal({title: "温馨提示",text: "您确定要暂存吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
  							$("#isSubmit").val(false);
  							$("#applyForm").submit();
  						});
  					}
				});
			})   
			function check(){
  				trimAll();
  				if($("#pahaverageIncome").val() == ""){
  					swal("错误提示", "请填写家庭年收入", "error");
  					$("#pahaverageIncome").focus();
  					return false;
  				}
  				/*else if($("#pgrade").val() == ""){
  					swal("错误提示", "请选择贫困等级", "error");
  					$("#pgrade").focus();
  					return false;
  				}*/
  				else if($("#pacard").val() == ""){
  					swal("错误提示", "请填写银行卡号", "error");
  					$("#pacard").focus();
  					return false;
  				}else if($("#pareason").val() == ""){
  					swal("错误提示", "请填写学生陈述申请认定理由", "error");
  					$("#pareason").focus();
  					return false;
  				}
  				else if($("#pahomeInvestigation").val() == "" && $("#pahomeInvestigationcechek").val()== "" ){
  					swal("错误提示", "请选择学生及家庭情况调查表扫描文件", "error");
  					$("#pahomeInvestigation").focus();
  					return false;
  				}else if($("#paevidence").val() == "" && $("#paevidencechek").val()=="" ){
  					swal("错误提示", "请上传家庭困难佐证", "error");
  					$("#paevidence").focus();
  					return false;
  				}
  				else if(!ajaxCheckSubmit()){
  					return false;
  				}
  				return true;
  			}
  		
			//家庭困难佐证文件上传限制
			function fileChange(target) {
			     var fileSize = 0;         
			     if (isIE && !target.files) {     
			       var filePath = target.value;     
			       var fileSystem = new ActiveXObject("Scripting.FileSystemObject");        
			       var file = fileSystem.GetFile (filePath);     
			       fileSize = file.Size;    
			     } else {    
			      fileSize = target.files[0].size;     
			      }   
			      var size = fileSize / 1024;    
			      if(size>2000){  
			      	swal("错误提示", "家庭困难佐证文件不能大于2M", "error");
			        target.value="";
			       return
			      }
			      var name=target.value;
			      var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
			      if(fileName !="zip" && fileName !="rar" ){
			          swal("错误提示", "家庭困难佐证文件请选择zip,rar之一压缩文件格式上传！", "error");
			          target.value="";
			          return
			      }
    		} 
			
			function filefujianChange(target) {
		       var fileSize = 0;         
		       if (isIE && !target.files) {     
			         var filePath = target.value;     
			         var fileSystem = new ActiveXObject("Scripting.FileSystemObject");        
			         var file = fileSystem.GetFile (filePath);     
			         fileSize = file.Size;    
		       } else {    
		        	fileSize = target.files[0].size;     
		       }   
		       		 var size = fileSize / 1024;    
		       if(size>800){ 
		      		 swal("错误提示", "请选择学生及家庭情况调查表扫描文件不能大于800K", "error"); 
		        	 target.value="";
		         return
		        }
		        	var name=target.value;
		       		var fileName = name.substring(name.lastIndexOf(".")+1).toLowerCase();
		       if(fileName !="jpg" && fileName !="png"){
		       		swal("错误提示", "学生及家庭情况调查表扫描文件请选择 jpg,png 之一图片格式上传！", "error"); 
		            target.value="";
		            return
		        }
             }
  			
  			function ajaxCheckSubmit(){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>poorApplication/ajaxCheckSubmit";
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
			贫困认定申请
		</legend>
		<c:if test="${empty poorInfo }">
			<div class="alert alert-warning" role="alert">
				<h4>
					学校尚未发布当前年度贫困认定指标，请发布后再申请。
				</h4>
			</div>
		</c:if>
		<c:if test="${not empty poorInfo }">
			<div class="well form-search">
				<h6>
					贫困认定年度：
					<u>${poorInfo.schoolYear.syname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;贫困认定名称：
					<u>${poorInfo.pname}</u>
				</h6>
			</div>
			<fieldset
				<c:if test="${paInfo.isSubmit eq true}">disabled="disabled"</c:if>>
				<form action="poorApplication/apply" method="post" id="applyForm"
					class="form-horizontal" enctype="multipart/form-data">
					<input type="hidden" name="paid" value="${paInfo.paid}" />
					<input type="hidden" name="sstudentCode"
						value="${stu.sstudentCode}" />
					<input type="hidden" name="pid" value="${poorInfo.pid}" />
					<input type="hidden" name="cclassId" value="${stu.cclass.cid}" />
					<input type="hidden" name="isSubmit" id="isSubmit" />
					<p>
					<h3 class="text-center">
						内蒙古师范大学家庭经济困难学生认定申请表
					</h3>
					</p>
					<p>
					<h5 class="text-center">
						院系：
						<u>${stu.cclass.academyInfo.aname}</u>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学号：
						<u>${stu.sstudentCode}</u>
					</h5>
					</p>
					<table class="table table-bordered table-condensed table-striped">
						<tr>
							<th>
								姓名
							</th>
							<td>
								${stu.sname}
							</td>
							<th>
								性别
							</th>
							<td>
								${stu.ssex}
							</td>
							<th>
								出生年月
							</th>
							<td>
								${stu.sbirthDate}
							</td>
							<th>
								民族
							</th>
							<td>
								${stu.snation.name}
							</td>
							<th>
								政治面貌
							</th>
							<td>
								${stu.spolitical}
							</td>
						</tr>
						<tr>
							<th>
								身份证号码
							</th>
							<td colspan="2">
								${stu.sidCard}
							</td>
							<th>
								专业
							</th>
							<td colspan="2">
								${stu.cclass.cmajor}
							</td>
							<th>
								年级
							</th>
							<td>
								${stu.cclass.cgrade}
							</td>
							<th>
								班级
							</th>
							<td>
								${stu.cclass.cclassName}
							</td>
						</tr>
						<tr>
							<th>
								<span class="xinghao">*</span>家庭年总收入
							</th>
							<td colspan="2">
								<input type="text" id="pahaverageIncome" name="pahaverageIncome"
									value="${paInfo.pahaverageIncome}" class="form-control"
									onkeydown="checkInteger(this,6)"
									onkeypress="checkInteger(this,6)"
									onkeyup="checkInteger(this,6)" maxlength="6"
									placeholder="家庭年收入"></input>
							</td>
							<!-- <th><span class="xinghao">*</span>贫困等级</th>
					    <td colspan="2">
					    	<select name="pgrade" id="pgrade" class="form-control">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${paInfo.pgrade eq '1'}">selected="selected"</c:if>>特别困难</option>
					    		<option value="2" <c:if test="${paInfo.pgrade eq '2'}">selected="selected"</c:if>>困难</option>
					    		<option value="3" <c:if test="${paInfo.pgrade eq '3'}">selected="selected"</c:if>>一般困难</option>
					    	</select>	
					    </td> -->
							<th>
								<span class="xinghao">*</span>中国农业银行卡号
							</th>
							<td colspan="3">
								<input type="text" id="pacard" name="pacard"
									value="${paInfo.pacard}" class="form-control" maxlength="20"
									placeholder="中国农业银行卡号" />
							</td>
						</tr>
						<tr>
							<th colspan="10">
								<span class="xinghao">*</span>学生陈述申请认定理由
							</th>
						</tr>
						<tr>
							<td colspan="10">
								<textarea class="form-control" id="pareason" name="pareason"
									rows="5" maxlength="512">${paInfo.pareason}</textarea>
							</td>
						</tr>
						<tr>
							<td colspan="10">
								<label>
									<span class="xinghao">*</span>学生家庭情况调查表扫描图片文件上传(图片格式：jpg,png)：
								</label>
								<div class="a-upload">
									<input type="file" name="pahomeInvestigation" id="pahomeInvestigation" onchange="filefujianChange(this);" />
									<input type="hidden" id="pahomeInvestigationcechek"
										value="${paInfo.pahomeInvestigation}" />
								</div>

								<c:if test="${not empty paInfo.pahomeInvestigation}">
									
									<a
										href="<%=basePath%>pahomeInvestigation/${paInfo.pahomeInvestigation}">下载原家庭调查表图片文件。</a>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan="10">
								<label>
									<span class="xinghao">*</span>家庭困难佐证上传(请压缩后上传,压缩文件支持 rar,zip)：
								</label>
								<div class="a-upload">
									<input type="file" id="paevidence" name="paevidence" onchange="fileChange(this)" />
									<input type="hidden" id="paevidencechek"
										value="${paInfo.paevidence}" />
								</div>

								<c:if test="${not empty paInfo.paevidence}">
									
									<a href="<%=basePath%>paevidence/${paInfo.paevidence}">下载原家庭困难佐证文件</a>   
								</c:if>
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
		</c:if>
	</body>
</html>
