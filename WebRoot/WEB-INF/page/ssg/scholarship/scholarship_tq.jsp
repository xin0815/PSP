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
					$("#_Saulevel").val($("#saulevel").val());
					$("#_SausingleLevel").val($("#sausingleLevel").val());
					if(checkSaulevel()){
						$("#shtgForm").submit();
					}else{
						swal("错误提示", "请选择学校审批等级或单项奖类型", "error");
					}
				});
			})
			function checkSaulevel(){
				var studentCode = $('*[name="studentCode"]');
				var saulevel = $('*[name="saulevel"]');
				var sausingleLevel = $('*[name="sausingleLevel"]');
				for(var i=0;i<saulevel.length;i++){
					if(saulevel[i].value == ""){
						swal("错误提示", "请选择学校审批等级", "error");
			       		return false;
					}else if(saulevel[i].value == "4"){//单项奖
	  					if(sausingleLevel[i].value == ""){
	  	  					swal("错误提示", "请选择单项奖类型", "error");
	  	  					return false;
	  	  				}
	  				}
				}
				return true;
			}
			function showSingleLevel(value,index){
  				if(value == '4'){
  					$('*[name="sausingleLevel"]')[index].style.display="";
  				}else{
  					$('*[name="sausingleLevel"]')[index].style.display="none";
  					$('*[name="sausingleLevel"]')[index].value="";
  				}
  			}
			
		</script>
	</head>
	<body>
		<legend>
			特权
		</legend>
			<form action="sauCheck/tq" method="post" class="form-inline">
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
						学校审批等级
					</th>
					<th>
						学校审批单项奖类型
					</th>
				</tr>
				<form action="sauCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
				<input type="hidden" name="said" value="${sa.said}" />
				<input type="hidden" name="studentCode" value="${sa.student.sstudentCode}" />
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
					    	<select name="saulevel" id="saulevel" class="form-control" onchange="showSingleLevel(this.value,0)">
					    		<option value="">--请选择--</option>
					    		<option value="1" >一等奖学金</option>
					    		<option value="2" >二等奖学金</option>
					    		<option value="3" >三等奖学金</option>
					    		<option value="4" >单项奖</option>
					    		<option value="5" >优秀学生干部奖</option>
					    	</select>
					    </td>
					    <td>
					    	<select name="sausingleLevel" id="sausingleLevel" class="form-control" style="display:none">
					    		<option value="">--请选择--</option>
					    		<option value="1" >道德风尚奖</option>
					    		<option value="2" >科技创新奖</option>
					    		<option value="3" >民族团结奖</option>
					    		<option value="4" >社会公益活动奖</option>
					    		<option value="5" >鼓励进步奖</option>
					    		<option value="6" >学习优秀奖</option>
					    		<option value="7" >文体技能奖</option>
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
		<form method="post" action="sauCheck/addStu" id="shtgForm" class="form-inline">
			<input type = "hidden" id = "studentCode" name = "studentCode" value="${student.sstudentCode}"/>
			<input type = "hidden" id = "_Saulevel" name = "Saulevel" value=""/>
			<input type = "hidden" id = "_SausingleLevel" name = "SausingleLevel" value=""/>
		</form>
	</body>
</html>
