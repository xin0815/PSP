<%@ page contentType="text/html;charset=utf-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/fileTag.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		
	</style>
		<script language="javascript">
			function upload(){
				var file = document.getElementsByName("filePath")[0].value;
				if(file == ""){
					alert("请选择上传文件");
					return false;
				}
				if(file.lastIndexOf(".")!=-1){
					var fileType = (file.substring(file.lastIndexOf(".")+1,file.length)).toLowerCase();
					if("xls"!=fileType && "xlsx" != fileType){
						swal("错误提示", "不支持文件类型"+fileType, "error");
						return false;
					}
				}else{
					swal("错误提示", "无法识别的文件类型", "error");
					return false;
				}
	        	swal({title: "温馨提示",text: "您确定要提交吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
					$("#uploadForm").submit();
	        	});
			}
			
		</script>
	</head>
	<body>
		<legend>
			导入日常班级信息
		</legend>
		<form action="classInfo/upload" method="post" enctype="multipart/form-data" id="uploadForm">
			<input type="hidden" name="aacademyCode" value="${aca.aacademyCode }" />
			<input type="hidden" name="bsCode" value="${bs.bscode }" />
			请单击此处，下载导入模板：<a href="<%=basePath%>template/ClassInfoTemplate.xls" class="btn btn-info active" role="button">日常班级信息导入模版下载</a>
			<br/>
			<br/>
			<div class="well form-search">
				<h5>学院：${aca.aname }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;学年学期：${bs.bname }</h5>
				<br />
				
				<div class="a-upload">
					<input type="file" id="filePath" name="filePath" style="width: 400px" onkeydown="return false;" />
				</div>
				<input type="button" class="btn btn-info" onclick="upload()" value="上传" />
				<button type="button" class="btn btn-info" id="fhBtn" onclick="history.back();">
   					返回
   				</button>
			</div>
			<table class="table table-striped table-bordered table-condensed">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<span style="color: #770000">${error}</span>
				<c:forEach var="errorInfo" items="${errorList}" begin="0" end="0">
					<tr>
						<td style="color: #770000">
							${errorInfo}
						</td>
					</tr>
				</c:forEach>
				<c:forEach var="errorInfo" items="${errorList}" begin="1">
					<tr>
						<td style="color: #770000">
							${errorInfo}
						</td>
					</tr>
				</c:forEach>
			</table>
		</form>
	</body>
</html>
