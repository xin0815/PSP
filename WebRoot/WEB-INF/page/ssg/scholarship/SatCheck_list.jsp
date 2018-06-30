<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head>
    	<base href="<%=basePath%>">
    	<title>校内奖学金-班主任审核</title>
    	
		<link rel="stylesheet" type="text/css"  href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
	    <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
	    <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
	    <script language="javascript" src="<%=basePath%>js/common.js"></script>
    
		<script type="text/javascript">
			$(function(){
				$("#ckxx").click(function(){
					if($("input[name='_checkbox']:checked").size() != 1){
			    		swal("错误提示", "请选择且只选择一条记录", "error");
			            return;
			       	}
			        $("#ckxx_said").val($("input[name='_checkbox']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					var checks = $("input[name='_checkbox']:checked");
					if(checks.size() < 1){
			    		swal("错误提示", "请先选择您要退回的记录", "error");
			            return;
			       	}
					swal({title: "温馨提示",text: "您确定要退回该申请吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						if(checks.size() == 1){
		                    $("#th_saids").val(checks.val());
		                }else{
		                    var str = "";
		                    checks.each(function(i,o){
		                    	str = str + $(o).val()+",";
		               	 	});
		                	$("#th_saids").val(str);
		          		 }
						$("#thForm").submit();
					});
				});
				$("#tjrd").click(function(){
					swal({title: "温馨提示",text: "班级所有申请信息将整体提交认定，您确定要提交认定吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#tjrdForm").submit();
		        	});
				});
				$("#bcdj").click(function(){
					if(checkSatlevel()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="satlevel"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$('*[name="satsingleLevel"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#tjrd").attr("disabled",true);
	    		});
	    		$("#_expore").click(function(){
	    			$("#_exporeForm").submit();
	    		}); 
			})
			function checkSatlevel(){
				var studentCode = $('*[name="studentCode"]');
				var satlevel = $('*[name="satlevel"]');
				var satsingleLevel = $('*[name="satsingleLevel"]');
				for(var i=0;i<satlevel.length;i++){
					if(satlevel[i].value == ""){
						swal("错误提示", "请选择班级认定等级", "error");
			       		return false;
					}else if(satlevel[i].value == "4"){//单项奖
	  					if(satsingleLevel[i].value == ""){
	  	  					swal("错误提示", "请选择单项奖类型", "error");
	  	  					return false;
	  	  				}
	  				}else if(!ajaxCheck(studentCode[i].value,satlevel[i].value,satsingleLevel[i].value)){
	  					return false;
	  				}
				}
				return true;
			}
			function showSingleLevel(value,index){
  				if(value == '4'){
  					$('*[name="satsingleLevel"]')[index].style.display="";
  				}else{
  					$('*[name="satsingleLevel"]')[index].style.display="none";
  					$('*[name="satsingleLevel"]')[index].value="";
  				}
  			}
			
			function ajaxCheck(studentCode,saslevel,sassingleLevel){
				var flag = true;
				initAjaxXmlHttpRequest();
				var src = "<%=basePath%>satCheck/ajaxCheck?studentCode="+studentCode+"&saslevel="+saslevel+"&sassingleLevel="+sassingleLevel;
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
			校内奖学金班主任审核
		</legend>
		<c:if test="${empty scholarshipInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度校内奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty scholarshipInfo }">
			<form action="satCheck/list" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>校内奖学金年度：${scholarshipInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>校内奖学金名称：
						${scholarshipInfo.sname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：${acaInfo.aname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>班级：</label>
						<select name="cclassId" class="form-control">
							<c:forEach var="cc" items="${classList}">
								<option value="${cc.cid }" <c:if test="${cclassId eq cc.cid }">selected="selected"</c:if>>${cc.cclassName }</option>
							</c:forEach>
						</select>
					</div>	
					<input type="submit" class="btn btn-primary" value="查询" />
					<c:if test="${not empty saList}">
					<button type="button" class="btn btn-primary" id="xgdj" <c:if test="${satCheck eq 2 }">disabled="disabled"</c:if>>修改等级</button>
					</c:if>
					<button type="button" class="btn btn-primary" id="_expore">信息导出</button>
				</div>
			</form>
			<table class="table table-bordered table-hover">
				<tr>
					<th width="30"></th>
					<th>
						序号
					</th>
					<th>
						学生姓名
					</th>
					<th>
						公民身份证号码
					</th>
					<th>
						院系
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
						学生申请等级
					</th>
					<th>
						学生申请单项奖类型
					</th>
					<th>
						班级认定等级
					</th>
					<th>
						班级认定单项奖类型
					</th>
				</tr>
				<form action="satCheck/saveGrade" method="post" id="bcdjForm">
				<input type="hidden" name="classId" value="${cclassId}" />
				<c:forEach var="sa" items="${saList}" varStatus="st">
					<input type="hidden" name="said" value="${sa.said}" />
					<input type="hidden" name="studentCode" value="${sa.student.sstudentCode}" />
					<tr>
						<td width="30px">
							<input type="checkbox" " name="_checkbox" value="${sa.said}" />
						</td>
						<td>
							${st.index + 1}
						</td>
						<td>
							${sa.student.sname}
						</td>
						<td>
							${sa.student.sidCard}
						</td>
						<td>
							${sa.bclass.academyInfo.aname}
						</td>
						<td>
							${sa.bclass.cmajor}
						</td>
						<td>
							${sa.student.sstudentCode}
						</td>
						<td>
							${sa.student.ssex}
						</td>
						<td>
							${sa.student.snation.name}
						</td>
						<td>
							${sa.bclass.cgrade}
						</td>
						<td>
							<c:if test="${sa.saslevel eq 1}">一等</c:if>
							<c:if test="${sa.saslevel eq 2}">二等</c:if>
							<c:if test="${sa.saslevel eq 3}">三等</c:if>
							<c:if test="${sa.saslevel eq 4}">单项奖</c:if>
							<c:if test="${sa.saslevel eq 5}">优秀学生干部奖</c:if>
						</td>
						<td>
							<c:if test="${sa.sassingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.sassingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.sassingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.sassingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.sassingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.sassingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.sassingleLevel eq 7}">文体技能奖</c:if>
					    </td>
						<td>
					    	<select name="satlevel" id="satlevel" class="form-control" onchange="showSingleLevel(this.value,${st.index})" disabled="disabled">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${sa.satlevel eq '1'}">selected="selected"</c:if>>一等奖学金</option>
					    		<option value="2" <c:if test="${sa.satlevel eq '2'}">selected="selected"</c:if>>二等奖学金</option>
					    		<option value="3" <c:if test="${sa.satlevel eq '3'}">selected="selected"</c:if>>三等奖学金</option>
					    		<option value="4" <c:if test="${sa.satlevel eq '4'}">selected="selected"</c:if>>单项奖</option>
					    		<option value="5" <c:if test="${sa.satlevel eq '5'}">selected="selected"</c:if>>优秀学生干部奖</option>
					    		<option value="6" <c:if test="${sa.satlevel eq '6'}">selected="selected"</c:if>>不通过</option>
					    	</select>
					    </td>
					    <td>
					    	<select name="satsingleLevel" id="satsingleLevel" class="form-control" disabled="disabled" <c:if test="${sa.satlevel ne '4'}">style="display:none"</c:if>>
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${sa.satsingleLevel eq 1}">selected="selected"</c:if>>道德风尚奖</option>
					    		<option value="2" <c:if test="${sa.satsingleLevel eq 2}">selected="selected"</c:if>>科技创新奖</option>
					    		<option value="3" <c:if test="${sa.satsingleLevel eq 3}">selected="selected"</c:if>>民族团结奖</option>
					    		<option value="4" <c:if test="${sa.satsingleLevel eq 4}">selected="selected"</c:if>>社会公益活动奖</option>
					    		<option value="5" <c:if test="${sa.satsingleLevel eq 5}">selected="selected"</c:if>>鼓励进步奖</option>
					    		<option value="6" <c:if test="${sa.satsingleLevel eq 6}">selected="selected"</c:if>>学习优秀奖</option>
					    		<option value="7" <c:if test="${sa.satsingleLevel eq 7}">selected="selected"</c:if>>文体技能奖</option>
					    	</select>
					    </td>
					</tr>
				</c:forEach>
				</form>
			</table>
			<center>
			<c:if test="${not empty saList}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th" <c:if test="${satCheck eq 2 }">disabled="disabled"</c:if>>退回申请</button>
			<button type="button" class="btn btn-warning" id="tjrd" <c:if test="${satCheck eq 2 }">disabled="disabled"</c:if>>整班提交</button>
			</c:if>
			</center>
			<form action="scholarshipApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="said" id="ckxx_said"/>
			</form>
			<form action="satCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="saids" id="th_saids"/>
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="satCheck/review" method="post" id="tjrdForm">
				<input type="hidden" name="sid" value="${scholarshipInfo.sid}" />
				<input type="hidden" name="cid" value="${cclassId}" />
			</form>
			<form action="satCheck/expore" method="post" id="_exporeForm">
				<input type="hidden" id = "ss" name="classid" value="${cclassId}" />
			</form>
		</c:if>
	</body>
</html>
