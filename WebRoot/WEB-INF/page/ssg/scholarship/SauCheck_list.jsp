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
				$("#ckxx").click(function(){
					if($("input[name='_radio']:checked").size() != 1){
			    		swal("错误提示", "请先选择您要查看的记录", "error");
			            return;
			       	}
			        $("#ckxx_said").val($("input[name='_radio']:checked").val());
					$("#ckxxForm").submit();
				}); 
				$("#th").click(function(){
					swal({title: "温馨提示",text: "该学院申请信息将整体退回，您确定要退回吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#thForm").submit();
					});
				});
				$("#shtg").click(function(){
					swal({title: "温馨提示",text: "您确定要审核通过吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
						$("#shtgForm").submit();
		        	});
				});
				$("#bcdj").click(function(){
					if(checkSaulevel()){
						swal({title: "温馨提示",text: "您确定要修改等级吗？", type: "warning", showCancelButton: true, confirmButtonColor: "#DD6B55",   confirmButtonText: "ok",   closeOnConfirm: false }, function(){
			        		$("#bcdjForm").submit();
			        	});
					}
				});
				$("#xgdj").click(function(){
					$('*[name="saulevel"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$('*[name="sausingleLevel"]').each(function(){
						$(this).attr("disabled",false);
				    });
					$("#ckxx").attr("disabled",true);
					$("#bcdj").attr("disabled",false);
					$("#th").attr("disabled",true);
					$("#shtg").attr("disabled",true);
	    		}); 
	    		$("#tx").click(function(){
	    			window.location.href="<%=basePath%>sauCheck/tq";
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
			校内奖学金学校审核
		</legend>
		<c:if test="${empty scholarshipInfo }">
			<div class="alert alert-warning" role="alert"><h4>学校尚未发布当前年度校内奖学金指标，请等待发布。</h4></div>
		</c:if>
		<c:if test="${not empty scholarshipInfo }">
			<c:if test="${empty acaList}">
				<div class="alert alert-warning" role="alert"><h4>暂无待审核学院。</h4></div>
			</c:if>
			<form action="sauCheck/queryBySaaLevel" method="post" class="form-inline">
				<div class="well form-search">
					<div class="form-group">
						<label>校内奖学金年度：${scholarshipInfo.schoolYear.syname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>	
					<div class="form-group">
						<label>校内奖学金名称：
						${scholarshipInfo.sname}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
					</div>
					<div class="form-group">
						<label>学院：</label>
						<select id = "acade" name="aacademyCode" class="form-control">
							<c:forEach var="aca" items="${acaList}">
								<option value="${aca.aacademyCode}" <c:if test="${aca.aacademyCode eq aacademyCode }">selected="selected"</c:if> >${aca.aname}</option>
							</c:forEach>
						</select>
					</div>	
					<div class="form-group">
					<label for="">奖学金等级：</label> <select id="saaLevel" name="saaLevel"
						class="form-control" >
						<option value="0"<c:if test="${saaLevel eq 0 }">selected="selected"</c:if>>全部</option>
						<option value="1"<c:if test="${saaLevel eq 1 }">selected="selected"</c:if>>一等</option>
						<option value="2"<c:if test="${saaLevel eq 2 }">selected="selected"</c:if>>二等</option>
						<option value="3"<c:if test="${saaLevel eq 3 }">selected="selected"</c:if>>三等</option>
						<option value="4"<c:if test="${saaLevel eq 4 }">selected="selected"</c:if>>单项奖</option>
						<option value="5"<c:if test="${saaLevel eq 5 }">selected="selected"</c:if>>优秀学生干部奖</option>
					</select>
					</div>
					<input type="submit" class="btn btn-primary" value="查询" />
					<c:if test="${not empty pager.data}">
					<button type="button" class="btn btn-primary" id="xgdj">修改等级</button>
					</c:if>
					<button type="button" class="btn btn-primary" id="tx">特权模式</button>
			</div>
				<jsp:include page="../../common/Page.jsp" />
			</form>
			<label>学院学生人数：${bean.acaStudentNum}&nbsp;&nbsp;&nbsp;&nbsp;一等奖学金：${bean.salevel1}&nbsp;&nbsp;&nbsp;&nbsp;二等奖学金：${bean.salevel2}&nbsp;&nbsp;&nbsp;&nbsp;三等奖学金：${bean.salevel3}&nbsp;&nbsp;&nbsp;&nbsp;单项奖：${bean.sasingle}</label>
			<table class="table table-bordered table-hover ">
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
					<th>
						学院审核等级
					</th>
					<th>
						学院审核单项奖类型
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
				<c:forEach var="sa" items="${pager.data}" varStatus="st">
				<input type="hidden" name="said" value="${sa.said}" />
				<input type="hidden" name="studentCode" value="${sa.student.sstudentCode}" />
					<tr>
						<td width="30px">
							<input type="radio" " name="_radio" value="${sa.said}" />
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
							<c:if test="${sa.satlevel eq 1}">一等</c:if>
							<c:if test="${sa.satlevel eq 2}">二等</c:if>
							<c:if test="${sa.satlevel eq 3}">三等</c:if>
							<c:if test="${sa.satlevel eq 4}">单项奖</c:if>
							<c:if test="${sa.satlevel eq 5}">优秀学生干部奖</c:if>
							<c:if test="${sa.satlevel eq 6}">不通过</c:if>
						</td>
						<td>
							<c:if test="${sa.satsingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.satsingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.satsingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.satsingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.satsingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.satsingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.satsingleLevel eq 7}">文体技能奖</c:if>
					    </td>
					    <td>
							<c:if test="${sa.saalevel eq 1}">一等</c:if>
							<c:if test="${sa.saalevel eq 2}">二等</c:if>
							<c:if test="${sa.saalevel eq 3}">三等</c:if>
							<c:if test="${sa.saalevel eq 4}">单项奖</c:if>
							<c:if test="${sa.saalevel eq 5}">优秀学生干部奖</c:if>
							<c:if test="${sa.saalevel eq 6}">不通过</c:if>
						</td>
						<td>
							<c:if test="${sa.saasingleLevel eq 1}">道德风尚奖</c:if>
							<c:if test="${sa.saasingleLevel eq 2}">科技创新奖</c:if>
							<c:if test="${sa.saasingleLevel eq 3}">民族团结奖</c:if>
							<c:if test="${sa.saasingleLevel eq 4}">社会公益活动奖</c:if>
							<c:if test="${sa.saasingleLevel eq 5}">鼓励进步奖</c:if>
							<c:if test="${sa.saasingleLevel eq 6}">学习优秀奖</c:if>
							<c:if test="${sa.saasingleLevel eq 7}">文体技能奖</c:if>
					    </td>
					    <td>
					    	<select name="saulevel" id="saulevel" class="form-control" onchange="showSingleLevel(this.value,${st.index})" disabled="disabled">
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${sa.saulevel eq '1'}">selected="selected"</c:if>>一等奖学金</option>
					    		<option value="2" <c:if test="${sa.saulevel eq '2'}">selected="selected"</c:if>>二等奖学金</option>
					    		<option value="3" <c:if test="${sa.saulevel eq '3'}">selected="selected"</c:if>>三等奖学金</option>
					    		<option value="4" <c:if test="${sa.saulevel eq '4'}">selected="selected"</c:if>>单项奖</option>
					    		<option value="5" <c:if test="${sa.saulevel eq '5'}">selected="selected"</c:if>>优秀学生干部奖</option>
					    		<option value="6" <c:if test="${sa.saulevel eq '6'}">selected="selected"</c:if>>不通过</option>
					    	</select>
					    </td>
					    <td>
					    	<select name="sausingleLevel" id="sausingleLevel" class="form-control" disabled="disabled" <c:if test="${sa.saulevel ne '4'}">style="display:none"</c:if>>
					    		<option value="">--请选择--</option>
					    		<option value="1" <c:if test="${sa.sausingleLevel eq 1}">selected="selected"</c:if>>道德风尚奖</option>
					    		<option value="2" <c:if test="${sa.sausingleLevel eq 2}">selected="selected"</c:if>>科技创新奖</option>
					    		<option value="3" <c:if test="${sa.sausingleLevel eq 3}">selected="selected"</c:if>>民族团结奖</option>
					    		<option value="4" <c:if test="${sa.sausingleLevel eq 4}">selected="selected"</c:if>>社会公益活动奖</option>
					    		<option value="5" <c:if test="${sa.sausingleLevel eq 5}">selected="selected"</c:if>>鼓励进步奖</option>
					    		<option value="6" <c:if test="${sa.sausingleLevel eq 6}">selected="selected"</c:if>>学习优秀奖</option>
					    		<option value="7" <c:if test="${sa.sausingleLevel eq 7}">selected="selected"</c:if>>文体技能奖</option>
					    	</select>
					    </td>
					</tr>
				</c:forEach>
				</form>
			</table>
		</div>
		<center>
			<c:if test="${not empty pager.data}">
			<button type="button" class="btn btn-primary" id="ckxx">查看详情</button>
			<button type="button" class="btn btn-primary" id="bcdj" disabled="disabled">保存等级</button>
			<button type="button" class="btn btn-warning" id="th">整院退回</button>
			<button type="button" class="btn btn-warning" id="shtg">整院通过</button>
			</c:if>
		</center>
			<form action="scholarshipApplication/info" method="post" id="ckxxForm">
				<input type="hidden" name="said" id="ckxx_said"/>
			</form>
			<form action="sauCheck/cancel" method="post" id="thForm">
				<input type="hidden" name="sid" value="${scholarshipInfo.sid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
			<form action="sauCheck/review" method="post" id="shtgForm">
				<input type="hidden" name="sid" value="${scholarshipInfo.sid}" />
				<input type="hidden" name="aacademyCode" value="${aacademyCode}" />
			</form>
		</c:if>
	</body>
</html>
