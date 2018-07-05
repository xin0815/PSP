<%@ page contentType="text/html;charset=utf-8" language="java"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html lang="true">
	<head>
		<title>相关项目维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="stylesheet" type="text/css"
			href="<%=basePath%>bootstrap/css/bootstrap.css" />
		<script language="javascript" src="<%=basePath%>js/jquery-1.6.4.js"></script>
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
	</head>

<script language="javascript">
	function edit(DID){
     		window.location.href="<%=basePath%>sysModule/toAdd?id="+DID;
	};
	function del(DID){
     	window.location.href="<%=basePath%>sysModule/del?id="+DID;
	};
$(function(){
	//跳到添加页，进行添加操作
	$("#tj").click(function(){
          window.location.href="<%=basePath%>sysModule/toAdd";
		});
	//查询
	$("#sousuo").click(function(){
		trimAll();
        $("#sysModuleForm").submit();
		
	});
	
	//删除
    $("#del").click(function(){
    	     var checks = $("input[name='checkbox']:checked");
    	     if(checks.size() == 0)
        	     {
                     alert("未选择条件!");
                     return;
        	     } else
            	     {
                         if(confirm('您确定要删除记录吗？'))
                             {//删除
                                 if(checks.size() == 1)
                                     {
                                	   $("#delId").val(checks.val());
                                     }else
                                         {
                                           var str = "";
                                    	   checks.each(function(i,o){
                                                  str = str + $(o).val()+",";
                                        	   });
                                    	   $("#delId").val(str);
                                         }
                                 $("#delForm").submit();
                                 document.all.tj.disabled=true;
                        		document.all.update.disabled = true;
                        		document.all.del.disabled=true;
                             }
            	     }
        });
     
    //全选和全不选操作
    $("#selectAll").click(function(){
           var size = $("#selectAll:checked").size();
           if(size == 1)//全选
               {
                     $("input[name='checkbox']").each(function(i,o){
                          o.checked = true;   
                     });
               }
           if(size == 0)//全不选
               {
        	      $("input[name='checkbox']").each(function(i,o){
                       o.checked = false;   
                   });
               }
        });

})

</script>

	<body>
		<form action="sysModule/query" method="post" id="sysModuleForm">
		<div class="well form-search">
			学位
			<input type="text" name="degreename" value="${degree}">
			英文
			<input type="text" name="name"class="input-medium search-query" />
			<button type="button" class="btn btn-info" id="sousuo">搜索</button>
			<button type="button" class="btn btn-info" id="tj">新增</button>
		</div>
			<center>
				<table class="table table-striped table-bordered table-condensed">
					<tr>

						<td>
							学位
						</td>
						<td>
							对应英文
						</td>
						<td>
						操作
						</td>
					</tr>
					<c:forEach var="degree" items="${pager.data}">
						<tr>
							<td>
								${degree.DNAME}
							</td>
							<td>
								${degree.DNAME1}
								</td>
								<td>
						<button type="button" class="btn btn-info" onclick="edit(${degree.DID})">修改</button>
						<button type="button" class="btn btn-warning"  onclick="del(${degree.DID})">删除</button>
						</td>
						</tr>

					</c:forEach>
				</table>
				
				<div class="pageBody">
					<jsp:include page="../common/Page.jsp" />
				</div> 
			</center>
		</form>
		<form action="sysModule/delete" method="post" id="delForm">
			<input type="hidden" value="" id="delId" name="ids" />
		</form>
		<form action="sysModule/toUpdate" method="post" id="updateForm">
			<input type="hidden" value="" id="updId" name="updId" />
		</form>
	</body>
</html>
