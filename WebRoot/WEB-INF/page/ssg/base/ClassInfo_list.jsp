<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java"%>
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
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>班级信息维护</title>
		<base href="<%=basePath%>" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
		<script language="javascript">
			$(function(){
				$("#daoru").click(function(){//导入操作
		            window.location.href="<%=basePath%>classInfo/toUpload?aacademyCode="+$("#aacademyCode").val()+"&bsCode="+$("#bsCode").val()+"";
			
				});
				$("#daochu").click(function(){//导入操作
		            window.location.href="<%=basePath%>classInfo/exportExcel?aacademyCode="+$("#aacademyCode").val()+"&bsCode="+$("#bsCode").val()+"";
				});
			})
		</script>
	</head>
	<body>
		<legend>
			日常班级信息维护
		</legend>
		<form action="classInfo/list" class="form-inline" id="classInfoForm" method="post">
			<input type="hidden" name="aacademyCode" id="aacademyCode" value="${aca.aacademyCode }"/>
			<div class="well form-search">
				<div class="form-group">
		    		<label>学院：</label><c:if test="${aca.aname != null}"><input type="text" readonly="readonly" class="form-control" value="${aca.aname }"/></c:if>
		    							<c:if test="${aca.aname == null}">
		    								<select id="acaCode" name="acaCode" class="form-control">
		    										<option value="0">全部</option>
												<c:forEach var="ac" items="${allAca }">
									 	 			<c:if test="${ac.aacademyCode!=101}">
									 	 				<option value="${ac.aacademyCode }" <c:if test="${ac.aacademyCode eq acaCode }" >selected="selected"</c:if>>${ac.aname }</option>
									 	 			</c:if>
									 	 		</c:forEach>
											</select>
		    							</c:if>
				</div>
				<div class="form-group">
					<label for="bsCode">学年学期</label>
					<select id="bsCode" name="bsCode" class="form-control">
						<c:forEach var="bs" items="${bsList }">
			 	 			<option value="${bs.bscode }" <c:if test="${bs.bscode eq bsCode }" >selected="selected"</c:if>>${bs.bname }</option>
			 	 		</c:forEach>
					</select>
				</div>
				<c:if test="${aca.aname == null}">
				<div class="form-group">
					<label for="bsCode">共</label>
							<input style="width:50px;" type="text" readonly="readonly" class="form-control" value="${claasize }"/>
					<label for="bsCode">个班级</label>
				</div>
				</c:if>
				<button type="submit" class="btn btn-primary">查询</button>
				<c:if test="${aca.aname != null}">
					<button type="button" id="daochu" class="btn btn-info">导出Excel</button>
					<button type="button" id="daoru" class="btn btn-info">导入班级信息</button>
				</c:if>
			</div>
		</form>
		<table class="table table-bordered table-hover">
			<tr>
            	<th>院系</th>
            	<th>年级</th>
	            <th>专业</th>
	            <th>授课语种</th>
	            <th>培养层次</th>
	            <th>是否师范</th>
	            <th>学生人数</th>
	            <th>女生人数</th>
	            <th>男生人数</th>
	            <th>班长</th>
	            <th>团支书</th>
	            <th>组织委员</th>
	            <th>宣传委员</th>
	            <th>体育委员</th>
	            <th>生活委员</th>
	            <th>学习委员</th>
	            <th>班主任姓名</th>
	            <th>班主任教工号</th>
	            <th>班主任出生年月</th>
	            <th>班主任职称</th>
	            <th>班主任学历</th>
	            <th>班主任电话</th>
			</tr>
			<c:forEach var="ci" items="${ciList }">
				<tr>
					<td>
						${ci.cclass.academyInfo.aname }
					</td>
					<td>
						${ci.cclass.cgrade }
					</td>
					<td>
						${ci.cclass.cmajor }
					</td>
					<td>
						${ci.cclass.clanguage }
					</td>
					<td>
						${ci.cclass.clevel }
					</td>
					<td>
						<c:if test="${ci.cclass.cisTeacher eq true}">是</c:if>
						<c:if test="${ci.cclass.cisTeacher eq false}">否</c:if>
					</td>
					<td>
						${ci.cclass.cfemaleNum + ci.cclass.cmaleNum }
					</td>
					<td>
						${ci.cclass.cfemaleNum }
					</td>
					<td>
						${ci.cclass.cmaleNum }
					</td>
					<td>
						${ci.bcstuMonitor }
					</td>
					<td>
						${ci.bcstuSecretary }
					</td>
					<td>
						${ci.bcstuOrganizer }
					</td>
					<td>
						${ci.bcstuPropagandist }
					</td>
					<td>
						${ci.bcstuSport }
					</td>
					<td>
						${ci.bcstuLive }
					</td>
					<td>
						${ci.bcstuLeaner }
					</td>
					<td>
						${ci.teacher.tname }
					</td>
					<td>
						${ci.teacher.bteacherId	 }
					</td>
					<td>
						${ci.teacher.tbirthDay }
					</td>
					<td>
						${ci.teacher.tproTitle }
					</td>
					<td>
						${ci.teacher.teduBackground }
					</td>
					<td>
						${ci.teacher.tphone }
					</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>