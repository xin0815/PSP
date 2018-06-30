/*
 * 去掉页面所有text和textarea元素内容中的空格
 */
function trimAll() {
	var element = document.forms[0].elements;
	String.prototype.trim = function() {
		return this.replace(/(^\s*)|(\s*$)/g, "");
	}
	for (var i = 0; i < element.length; i++) {
		if (element[i].type == "text" || element[i].type == "textarea") {
			element[i].value = element[i].value.trim();
		}
	}
};

String.prototype.trim = function () {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};

var xmlhttp;
function initAjaxXmlHttpRequest(){
	if(window.XMLHttpRequest) {
		xmlhttp = new XMLHttpRequest();
	}
	else if(window.ActiveXObject){
		try {
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e) {
			try {
				xmlhttp= new ActiveXObject("Microsoft.XMLHTTP"); 	
			}catch(e) {
				xmlhttp=null;
			}
		}
	}
}
/*
	src中必须包含id值和验证字段值
*/
function ajaxCommonCheck(src){
	var flag = true;
	initAjaxXmlHttpRequest();
    // 指定要打开的页面
    xmlhttp.open("POST", src, false);
    // 指定页面打开完之后要进行的操作.
    xmlhttp.onreadystatechange =function(){
		// 请求已完成
		if (xmlhttp.readyState == 4) {
			var message =xmlhttp.responseText;
			if(message=="error"||message=="null"){
				flag = false;
			}
		}
	};
    // 开始发起浏览请求, Mozilla 必须加 null
    xmlhttp.send();
    return flag;
}

function checkInteger(obj,maxlength){
	//如果未空直接返回；
	var objValue=obj.value;
	if(objValue==null||objValue.length==0) return;
	//将所有非数字替换成空白；
	if(objValue.match(/\D/)){
		objValue=objValue.replaceAll(/\D/,"");
		obj.value=objValue;
	}
	//去掉首位多余的0；
	if(objValue.match(/^0+$/)){
		obj.value=objValue.replace(/^0+$/,"0");
		objValue=obj.value;
	}else if(objValue.match(/^0+/)){
		obj.value=objValue.replace(/^0+/,"");
		objValue=obj.value;
	}
	if(obj.value.length>maxlength)
		obj.value=obj.value.substring(0,maxlength);
}

function checkDouble(obj, precision, scale){
	//如果未空直接返回；
	var objValue=obj.value;
	if(objValue==null||objValue.length==0) return;
	//将所有非数字，非"."去掉；
	if(objValue.match(/[^0-9\.]+/)){
		obj.value=objValue.replaceAll(/[^0-9\.]+/,"");
		objValue=obj.value;
	}
	//小数点最多一个，超过一个，保留第一个；
	if(objValue.indexOf(".")!=objValue.lastIndexOf(".")){
		obj.value=objValue.dotClear();
		objValue=obj.value;
	}
	//去掉首位多余的0；
	if(objValue.match(/^0+$/)){
		obj.value=objValue.replace(/^0+$/,"0");
		objValue=obj.value;
	}else if(objValue.match(/^0+/)){
		obj.value=objValue.replace(/^0+/,"");
		objValue=obj.value;
	}
	
	//alert();
	//截断字符串；使其不超过最大长度；
	//if(objValue.length>(precision+scale+1)){
	//	objValue=objValue.substring(0,precision+scale+1);
	//	obj.value=objValue;
	//}
	
	if(!objValue.match(/\./)){
		//如果没有小数点
		if(objValue.length-precision>0){
			//最大长度precision
			obj.value=objValue.substring(obj.value.length-precision,obj.value.length);
			objValue=obj.value;
		}
	}else{
		//有小数点；
		var dotIndex=objValue.indexOf("\.");
		if(dotIndex===0){
			//如果小数点在首位，前面加0
			obj.value="0"+objValue;
			objValue=obj.value;
		}
		
		dotIndex=objValue.indexOf("\.");
		if(dotIndex-precision>0){
			//保证小数点左边最多 precision位；(超出的话向左移动小数点)
			obj.value=objValue.substring(dotIndex-precision,dotIndex)+objValue.substring(dotIndex);
			objValue=obj.value;
		}
		
		dotIndex=objValue.indexOf("\.");
		var realScale=objValue.length-(dotIndex+1);
		if(realScale-scale>0){
			//保证小数点右边最多sacle位；
			obj.value=objValue.substring(0,objValue.length-(realScale-scale));	
			objValue=obj.value;	
		}
	}
}

String.prototype.replaceAll=function(pattern,str){
	var sourceStr=new String(this);
	while(sourceStr.match(pattern)){
		sourceStr=sourceStr.replace(pattern,str);
	}
	return sourceStr;
};

String.prototype.dotClear=function(){
	var sourceStr=new String(this);
	var lastIndex=sourceStr.lastIndexOf(".");
	while(sourceStr.indexOf(".")!=lastIndex){
		sourceStr=sourceStr.substring(0,lastIndex)+sourceStr.substring(lastIndex+1);
		lastIndex=sourceStr.lastIndexOf(".");
	}
	return sourceStr;
};
function checkInputText(){
	trimAll();
	//验证所有输入框内容均不能为空
	var flag = true;
	$("input[type='text']").each(function(){
       if($(this).prop("name") != "" && $(this).val() == ""){//sweetalert弹出会创建name为空的text框，因此加$(this).prop("name") != ""判断
       	$(this).focus();
			swal("错误提示", "内容不能为空。若没有名额请填写0", "error");
       	flag = false;
       	return false;
       }
    });
    return flag;
}