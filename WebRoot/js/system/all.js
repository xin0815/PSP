if(parent.document.getElementById("mainTitleContent") != undefined && parent.document.getElementById("mainTitleContent") != null){
	var maintitle = parent.document.getElementById("mainTitleContent").innerHTML;
}

var $id = function(id) {
	return document.getElementById(id);
};
var $$ = function(n) {
	return document.getElementsByName(n);
};
var $$$ = function(t) {
	return document.getElementsByTagName(t);
};
function checkall(obj) {
	if (obj.checked) {
		for (var i = 0; i < $$$("input").length; i++) {
			if ($$$("input")[i].type == "checkbox") {
				$$$("input")[i].checked = "checked";
			}
		}
	} else {
		for (var i = 0; i < $$$("input").length; i++) {
			if ($$$("input")[i].type == "checkbox") {
				$$$("input")[i].checked = "";
			}
		}
	}
}
function clickTitle(obj, taxisfield) {
	$$("taxisfield")[0].value = taxisfield;
	var flg = obj.style.background.split(".gif")[0].split("/")[3];
	if (flg == "D" || flg == undefined) {
		$$("taxis")[0].value = "asc";
		document.forms[0].submit();
	} else {
		$$("taxis")[0].value = "desc";
		document.forms[0].submit();
	}
}

function changeUpdateCss(id) {
	for (var i = 0; i < $$$("tr").length; i++) {
		if ($$$("tr")[i].className == "update_tr") {
			$$$("tr")[i].className = "";
		}
	}
	if (id != undefined) {
		$id("" + id + "_tr").className = "update_tr";
	}
}

function showMD(title, url, h) {
	parent.echoDialog(title, url);
}

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
