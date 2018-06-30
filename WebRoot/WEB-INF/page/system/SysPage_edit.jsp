<%@ page language="java" pageEncoding="UTF-8"%>
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
		<title>系统菜单维护</title>
		<base href="<%=basePath%>" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>css/bg_new.css" />
		<link rel="STYLESHEET" type="text/css"
			href="<%=basePath%>css/system/dhtmlxtree.css">
		<script src="<%=basePath%>js/system/dhtmlxcommon.js"></script>
		<script src="<%=basePath%>js/system/dhtmlxtree_imnu.js"></script>
		<script src="<%=basePath%>js/system/dhtmlXTree_xw.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>bootstrap/css/bootstrap.min.css" />
        <script language="javascript" src="<%=basePath%>js/jquery/jquery.min.js"></script>
        <script language="javascript" src="<%=basePath%>sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" type="text/css" href="<%=basePath%>sweetalert/dist/sweetalert.css" />
		<script language="javascript" src="<%=basePath%>js/common.js"></script>
		
		<script>
			function showNewNextItem(){
             	document.getElementById("date").style.display="";
           		document.getElementById("updatePage").style.display="";
            	document.getElementById("updateButton").style.display ="none";
            	document.getElementById("newItem").style.display = "";
            	document.getElementById("newChildItem").style.display = "none";
            	document.getElementById("superPageTr").style.display = "none";
            	document.getElementById("brotherPageTr").style.display = "";
            	cancelUpdatePage();
            	document.getElementById("brotherPage").value=tree.getSelectedItemText();
            	cancelUpdatePage();
            	unchainText();
            	document.getElementById("selectedItemID").value = tree.getSelectedItemId();
            	document.getElementById("titleInfo").innerHTML = "<font size=3 style='font-weight:bold'> 同级菜单添加 </font>";
            	var time =new Date();
				var src ="<%=basePath%>sysPage/findNextLevelCode?selectedItemID="+tree.getSelectedItemId()+"&time="+time; 
            	ajaxfindNextLevelCode(src);
            
            }
             function showNewChidItem(){
            	document.getElementById("date").style.display="";
           		document.getElementById("updatePage").style.display="";
            	document.getElementById("updateButton").style.display ="none";
            	document.getElementById("newItem").style.display = "none";
            	document.getElementById("newChildItem").style.display = "";
            	document.getElementById("superPageTr").style.display = "";
            	document.getElementById("brotherPageTr").style.display = "none";
            	cancelUpdatePage();
            	document.getElementById("superPageName").value=tree.getSelectedItemText();
            	cancelUpdatePage();
            	unchainText();
            	document.getElementById("selectedItemID").value = tree.getSelectedItemId();
            	document.getElementById("titleInfo").innerHTML = "<font size=3 style='font-weight:bold'> 子菜单添加 </font>";
            	var time =new Date();
				var src ="<%=basePath%>sysPage/findNextChildLevelCode?method=findNextChildLevelCode&selectedItemID="+tree.getSelectedItemId()+"&time="+time; 
            	ajaxfindNextChildLevelCode(src);
            }
            
            
            function ajaxfindNextLevelCode(src){
	        	initAjaxXmlHttpRequest();
	            xmlhttp.open("POST", src, true);
	            xmlhttp.onreadystatechange =function(){setNextLevelCode()};
	            xmlhttp.send(null);
	        }
	        
	         function ajaxfindNextChildLevelCode(src){
	        	initAjaxXmlHttpRequest();
	            xmlhttp.open("POST", src, true);
	            xmlhttp.onreadystatechange =function(){setNextChildLevelCode()};
	            xmlhttp.send(null);
	        }
	        
	        
	        function setNextLevelCode(){
	            if (xmlhttp.readyState == 4) {
	               	var message =xmlhttp.responseText;
	                document.getElementsByName("levelCode")[0].value =  message;
	            }
	        }
            
            
	        function setNextChildLevelCode(){
	            if (xmlhttp.readyState == 4) {
	               	var message =xmlhttp.responseText;
	                document.getElementsByName("levelCode")[0].value =  message;
	            }
	        }
            
            function newSysPage(){
            	$("#form1").attr('action','<%=basePath%>sysPage/newSysPage');
            	document.forms[0].submit();
            }
             function saveChildItem(){
            	 $("#form1").attr('action','<%=basePath%>sysPage/newChildItem');
             	document.forms[0].submit();
            }
            
            function deleteItem(){
            	question = confirm("删除菜单可能造成之前系统菜单无法使用,您确定删除吗？")
				if (question != "0"){
					//调用后台方法删除PAGE  
					var time =new Date();
					var src ="<%=basePath%>/sysPage/delete?id="+tree.getSelectedItemId()+"&time="+time; 
					ajaxDeleteSysPage(src);	
				}
            }
            function findItemByText(){
                tree.findItem(document.getElementById("findText").value);
            }
            function getXML(){
              alert(tree.serializeTree());
            }
            function updateSysPage(){
           	 $("#form1").attr('action','<%=basePath%>sysPage/update');
            	document.forms[0].submit();
            }
            
            function showUpdatePage(){
           		//加载对应PAGE对象数据
           		cancelUpdatePage();
            	document.getElementById("date").style.display="";
           		document.getElementById("updatePage").style.display="";
            	document.getElementById("updateButton").style.display ="";
            	document.getElementById("newItem").style.display = "none";
            	document.getElementById("newChildItem").style.display = "none";
            	document.getElementById("superPageTr").style.display = "none";
            	document.getElementById("brotherPageTr").style.display = "none";
            	unchainText();
           		var time =new Date();
				var src ="<%=basePath%>sysPage/editSysPage?id="+tree.getSelectedItemId()+"&time="+time; 
				ajaxInitSysPage(src);
            	document.getElementById("titleInfo").innerHTML = "<font size=3 style='font-weight:bold'> 菜单修改 </font>";	
            }
            function cancelUpdatePage(){
            	//清空所有文本
            	document.getElementsByName("pageId")[0].value = "";
            	document.getElementsByName("pageName")[0].value = "";
            	document.getElementsByName("sysModule.moduleId")[0].value = "";
            	document.getElementsByName("url")[0].value = "";
            	document.getElementsByName("description")[0].value = "";
            	document.getElementsByName("functionDepict")[0].value = "";
            	document.getElementsByName("functionMethod")[0].value = "";
            	document.getElementsByName("levelCode")[0].value = "";
            	document.getElementsByName("imgSrc")[0].value = "";
            }
            
            
            function closeDiv(){
            	cancelUpdatePage();
            	document.getElementById("date").style.display="none";
           		document.getElementById("updatePage").style.display="none";
            }
            
            var xmlhttp;
			function initAjaxXmlHttpRequest()
			{
				if(window.XMLHttpRequest)
				{
					xmlhttp = new XMLHttpRequest();
				}
				else if(window.ActiveXObject){
					try
					{
						xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
					}
					catch(e)
					{
						try
						{
							xmlhttp= new ActiveXObject("Microsoft.XMLHTTP"); 	
						}catch(e)
						{
							xmlhttp=null;
						}
					}
				}
			}
			
			 function ajaxInitSysPage(src){
	        	initAjaxXmlHttpRequest();
	            // 指定要打开的页面
	            xmlhttp.open("POST", src, true);
	            // 指定页面打开完之后要进行的操作.
	            xmlhttp.onreadystatechange =function(){initSysPage()};
	            // 开始发起浏览请求, Mozilla 必须加 null
	            xmlhttp.send(null);
	        }
	        
	         // 这个函数就是每次状态改变要调用的函数
	        function initSysPage(){
	            // 请求已完成
	            if (xmlhttp.readyState == 4) {
	               	var message =xmlhttp.responseText;
	                if(message=="error"||message=="null")
	                {
	                	alert("数据加载错误");   
	                	
	                }else
	                {
	                	//解析字符串
	                	var info = message.split("*");
	                	document.getElementsByName("pageId")[0].value = info[0];
	                	document.getElementsByName("pageName")[0].value = info[1];
	                	document.getElementsByName("sysModule.moduleId")[0].value = info[2]
		            	document.getElementsByName("url")[0].value = info[3];
		            	document.getElementsByName("description")[0].value = info[4];
		            	document.getElementsByName("functionDepict")[0].value = info[5];
		            	document.getElementsByName("functionMethod")[0].value = info[6];
		            	document.getElementsByName("levelCode")[0].value = info[7];
		            	document.getElementsByName("imgSrc")[0].value = info[8];
	                }
	                var lcode = document.getElementsByName("levelCode")[0].value;
	                if(lcode.length >= 10 ) {
	                	document.getElementById("newChidItem").disabled = true;
	                }else {
	                	document.getElementById("newChidItem").disabled = false;
	                }
	            }
	        }
			function ajaxDeleteSysPage(src){
	        	initAjaxXmlHttpRequest();
	            // 指定要打开的页面
	            xmlhttp.open("POST", src, true);
	            // 指定页面打开完之后要进行的操作.
	            xmlhttp.onreadystatechange =function(){mychange()};
	            // 开始发起浏览请求, Mozilla 必须加 null
	            xmlhttp.send(null);
	        }
	        
	        // 这个函数就是每次状态改变要调用的函数
	        function mychange(){
	            // 请求已完成
	            if (xmlhttp.readyState == 4) {
	               	var message =xmlhttp.responseText;
	                if(message=="success")
	                {
            			window.location.href = '<%=basePath%>sysPage/edit';
	                }else
	                {
	                	alert(message);   
	                }
	            }
	        }
	        
	        function tonclick(id){
            	var time =new Date();
				var src ="<%=basePath%>sysPage/editSysPage?id="+tree.getSelectedItemId()+"&time="+time; 
				ajaxInitSysPage(src);
				document.getElementById("date").style.display="";
           		document.getElementById("updatePage").style.display="";
            	document.getElementById("updateButton").style.display = "none";
            	document.getElementById("newItem").style.display = "none";
            	document.getElementById("newChildItem").style.display = "none";
            	document.getElementById("superPageTr").style.display = "none";
            	document.getElementById("brotherPageTr").style.display = "none";
            	document.getElementById("titleInfo").innerHTML = "<font size=3 style='font-weight:bold'> 菜单查看 </font>";	
            	//超过五级  置为不可用
            	lockText();
            };
            
            
            function lockText(){
            	document.getElementsByName("pageName")[0].readOnly = true;
            	document.getElementsByName("url")[0].readOnly = true;
            	document.getElementsByName("sysModule.moduleId")[0].disabled = true;
            	document.getElementsByName("description")[0].readOnly = true;
            	document.getElementsByName("functionDepict")[0].readOnly = true;
            	document.getElementsByName("functionMethod")[0].readOnly = true;
            	document.getElementsByName("levelCode")[0].readOnly = true;
            	document.getElementsByName("imgSrc")[0].readOnly = true;
            }
            
            function unchainText(){
            	document.getElementsByName("pageName")[0].readOnly = false;
            	document.getElementsByName("url")[0].readOnly = false;
            	document.getElementsByName("sysModule.moduleId")[0].disabled = false;
            	document.getElementsByName("description")[0].readOnly = false;
            	document.getElementsByName("functionDepict")[0].readOnly = false;
            	document.getElementsByName("functionMethod")[0].readOnly = false;
            	document.getElementsByName("levelCode")[0].readOnly = false;
            	document.getElementsByName("imgSrc")[0].readOnly = false;
            }
	        
        </script>
	</head>
	<body>
		<form action="sysPage/edit" method="post" id="form1"
			class="form-horizontal">
			<input type="hidden" name="selectedItemID" id="selectedItemID"
				value="">
			<div id="kBody0">
				&nbsp;&nbsp;菜单名称
				<input type="text" id="findText" name="findText"
					class="input-medium search-query" />
				<button type="button" class="btn btn-info" id="chaxun"
					onclick="findItemByText();">
					搜索
				</button>
			</div>
			<span style="color: red">${errorInfo }</span>
			<div class="div_k_content">
				<div align="center">
					<table style="width: 100%">
						<tr>
							<td width="50%">
								<div id="treeboxbox_tree"
									style="width: 100%; height: 360; border: 1px solid Silver;; overflow: auto;"
									align="left">
								</div>
							</td>
							<td>
								<div id="date" style="display: none;" align="center">
									<table>
										<tr>
											<td colspan="2" align="center" id="titleInfo">
											</td>
										</tr>
										<tr id="superPageTr" style="display: none">
											<td>
												父菜单
											</td>
											<td>
												<input type="text" id="superPageName" name="superPageName"
													class="input-xlarge" readonly="readonly" />
											</td>
											<td>
												&nbsp;
											</td>
										</tr>

										<tr id="brotherPageTr" style="display: none">
											<td>
												平级菜单
											</td>
											<td>
												<input type="text" id="brotherPage" name="brotherPage"
													class="input-xlarge" readonly="readonly" />
											</td>
											<td>
												&nbsp;
											</td>
										</tr>

										<tr>
											<td>
												菜单名称
											</td>
											<td>
												<input type="hidden" name="pageId" />
												<input type="text" name="pageName" readonly="readonly"
													class="input-xlarge" maxlength="20" />
											</td>
											<td>
												&nbsp;
											</td>
										</tr>

										<tr>
											<td nowrap="nowrap">
												上下文路径
											</td>
											<td>
												<select name="sysModule.moduleId" class="input-xlarge">
													<c:forEach var="sysModule" items="${sysModuleList}">
														<option value="${sysModule.moduleId }">
															${sysModule.name }
														</option>
													</c:forEach>
												</select>
											</td>
											<td>
												&nbsp;
											</td>
										</tr>

										<tr>
											<td nowrap="nowrap">
												编码
											</td>
											<td>
												<input type="text" name="levelCode" readonly="readonly"
													maxlength="16" class="input-xlarge" />
											</td>
											<td>
												&nbsp;
											</td>
										</tr>

										<tr>
											<td>
												访问地址
											</td>
											<td colspan="2">
												<input type="text" name="url" maxlength="256"
													class="input-xlarge" />
											</td>
										</tr>
										<tr>
											<td>
												菜单描述
											</td>
											<td>
												<textarea name="description" class="input-xlarge">
													</textarea>
											</td>
										</tr>
										<tr style="display: none;">
											<td>
												功能描述
											</td>
											<td>
												<textarea name="functionDepict"
													onkeydown="this.value = this.value.substring(0, 128)"
													class="input-xlarge">
													</textarea>
											</td>
										</tr>
										<tr style="display: none;">
											<td>
												功能方法
											</td>
											<td>
												<textarea name="functionMethod" class="input-xlarge">
													</textarea>
											</td>
										</tr>
										<tr style="display: none;">
											<td>
												图标路径
											</td>
											<td>
												<input type="text" name="imgSrc" class="input-xlarge"
													readonly="readonly" />
											</td>
										</tr>
										<tr id="updatePage" style="display: none;" align="center">
											<td colspan="3">
												<button type="button" class="btn btn-primary"
													id="updateButton" onclick="updateSysPage();">
													保存
												</button>
												<button type="button" class="btn btn-primary"
													onclick="newSysPage();" id="newItem">
													添加节点
												</button>
												<button type="button" class="btn btn-primary"
													onclick="saveChildItem();" id="newChildItem">
													添加子节点
												</button>
												<button type="button" class="btn btn-info"
													onclick="closeDiv();">
													关闭
												</button>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="form-actions">
					<button type="button" class="btn btn-primary"
						onclick="showNewNextItem();" id="newItem">
						添加菜单
					</button>
					<button type="button" class="btn btn-primary"
						onclick="showNewChidItem();" id="newChidItem">
						添加子菜单
					</button>
					<button type="button" class="btn btn-primary"
						onclick="showUpdatePage()">
						编辑
					</button>
					<button type="button" class="btn btn-warning"
						onclick="deleteItem()">
						删除
					</button>
				</div>
			</div>
			<script>
                tree = new dhtmlXTreeObject("treeboxbox_tree", "100%", "100%", 0);
	            tree.setImagePath("<%=path%>/images/treeImg/bluebooks/");
	          //tree.enableDragAndDrop(true);
	            tree.setOnClickHandler(tonclick);
	             var time =new Date();
	             //文档加载优化
	             tree.enableSmartXMLParsing(true);
	             //分布式运算树形菜单
				tree.enableDistributedParsing(true,200); 
				//菜单延迟加载
				tree.setXMLAutoLoading("<%=basePath%>sysPage/downloadTree?time="+ time);
	       	    tree.loadXML("<%=basePath%>sysPage/downloadTree?time="+ time);
</script>
		</form>
	</body>
</html>
