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
		<title>学校审核</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script type="text/javascript">
			$(function(){
				$("#shtg").click(function(){
					$("#bcdjForm").submit();
				});
			})
			
		</script>
	</head>
	<body>
		<legend>
			特权
		</legend>
			<form action="pauCheck/tq" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>学号</label>
						<input type="text" name="studentCode" value="${student.sstudentCode}" class="form-control" />
					</div>
					<input type="submit" class="btn btn-primary" value="查询" />
				</div>
			</form>
			<table class="table table-bordered table-hover ">
				<tr>
					<th>
						学生姓名
					</th>
					<th>
						公民身份证号码
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
						等级
					</th>
				</tr>
				<form action="pauCheck/saveGrade" method="post" id="bcdjForm">
					<input type = "hidden" name = "sstudentCode" value="${student.sstudentCode}" />
					<tr>
						<td>
							${student.sname}
						</td>
						<td>
							${student.sidCard}
						</td>
						<td>
							${student.cclass.cmajor}
						</td>
						<td>
							${student.sstudentCode}
						</td>
						<td>
							${student.ssex}
						</td>
						<td>
							${student.snation.name}
						</td>
						<td>
							${student.cclass.cgrade}
						</td>
						<td>
							<select name="pagrd" class="form-control">
					    		<option value="">--请选择--</option>
					    		<option value="1" >特别困难</option>
					    		<option value="2" >困难</option>
					    		<option value="3" >一般困难</option>
					    	</select>
						</td>
					</tr>
				</form>
			</table>
		</div>
		<center>
			<c:if test="${not empty student.sstudentCode}">
			<button type="button" class="btn btn-primary" id="shtg">审核通过</button>
			</c:if>
		</center>
	</body>
</html>
