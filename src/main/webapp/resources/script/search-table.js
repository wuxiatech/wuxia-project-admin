/**
 * Copyright 2011-2020 www.tradeserving.com
 *
 * All right reserved.
 */

/**
 * 弹出选择框
 * xuejiang   2012-07-21
 * 
 * id: 生成的divid
 * url: 请求后台数据url
 * width: 列表宽度
 * colWidth: 列宽度
 * colName: 列名称
 * colValue: 列名称对应的显示信息
 * colHideName: 列隐藏名称
 * colHideValue: 列隐藏名称对应的信息
 * multiple: 是否支持多选，默认false
 * searchAble: 是否支持搜索，默认true
 * doNextPageDisplayAble:是否支持页面显示数据的处理，默认为false
 * doNextPageDisplay:页面数据处理的方法
 * key：多选情况下选择框包含的值，默认id
 */
function SearchTable(arg){
	this.id = arg.id!=undefined?arg.id:new Date().getTime();
	this.url = arg.url;
	this.width = arg.width!=undefined?arg.width:"400px";
	this.colWidth = arg.colWidth!=undefined?arg.colWidth:[];
	this.colName = arg.colName!=undefined?arg.colName:[];
	this.colValue = arg.colValue!=undefined?arg.colValue:[];
	this.colHideName = arg.colHideName!=undefined?arg.colHideName:[];
	this.colHideValue = arg.colHideValue!=undefined?arg.colHideValue:[];
	this.multiple = arg.multiple!=undefined?arg.multiple:false;
	this.searchAble = arg.searchAble!=undefined?arg.searchAble:true;
	this.doNextPageDisplayAble=arg.doNextPageDisplayAble!=undefined?arg.doNextPageDisplayAble:false;
	this.doNextPageDisplay=arg.doNextPageDisplay!=undefined?arg.doNextPageDisplay:function(colValue){};
	this.key = arg.key!=undefined?arg.key:"id";
	this.onRowClick = arg.onRowClick!=undefined?arg.onRowClick:function(btnthis, rowData){};
	this.onRowDblclick = arg.onRowDblclick!=undefined?arg.onRowDblclick:function(btnthis, rowData){};
	/*this.nodeValue=arg.nodeValue!=undefined?arg.nodeValue:[];
	this.isChildren=arg.isChildren!=undefined?arg.isChildren:false;
	this.nodeEvent=arg.nodeEvent!=undefined?arg.nodeEvent:[];
	this.nodeDoFunction=arg.nodeDoFunction!=undefined?arg.nodeDoFunction:function(){};*/
			
	this.initialization = function(){
		var id = this.id;
		var url = this.url;
		var width = this.width;
		var colWidth = this.colWidth;
		var colName = this.colName;
		var colValue = this.colValue;
		var colHideName = this.colHideName;
		var colHideValue = this.colHideValue;
		var multiple = this.multiple;
		var searchAble = this.searchAble;
		var doNextPageDisplayAble=this.doNextPageDisplayAble;  //对于翻页的显示是否需要自己的处理 默认为false
		var doNextPageDisplay=this.doNextPageDisplay;      //对翻页的处理方法
		var key = this.key;
		// 增加初始化div
		$("body").eq(0).append("<div id='"+id+"' class='fn-hide'>"
				+"<img src='/resources/images/loading24.gif' style='height:300px;margin-top:-50px;margin-left:50px;'></img>"
				+"</div>");
		$.ajax({
			type: 'GET',
			url: url,
			success: function(data){
				var table_tr = data.rows;
				var html = "";
				if(searchAble){
					html = "<div style='height:40px;width:"+width+";'><p><span>"
							+ "<input type='text' class='ipt2 w_240 bold' id='"+id+"_search' autocomplete='off'/>"
							+ "<a href='javascript:;' class='search_btn1' id='"+id+"_search_a'></a>"
							+ "</span><p style='padding-top:6px;'>双击选择或者选列表行后单击确认选择</p></p></div>"
							+ "<div class='table1' id='"+id+"_table1' style='width:"+width+";'>"
								+ "<table width='100%' cellspacing='0' cellpadding='0' id='"+id+"_contacts_table'>"
								+ "<tr style='background-color:#f0f3f5;'>";
				}else{
					html = "<div class='table1' id='"+id+"_table1' style='width:"+width+";'>"
							+ "<table width='100%' cellspacing='0' cellpadding='0' id='"+id+"_contacts_table'>"
							+ "<tr style='background-color:#f0f3f5;'>";
				}
					
				
				// 增加多选框
				if(multiple){
					html += "<td width='10%'>选择</td>";
				}
				
				for(var i=0,j=colName.length; i<j; i++){
					html += "<td width='"+colWidth[i]+"'>"+colName[i]+"</td>";
				}
				for(var i=0,j=colHideName.length; i<j; i++){
					html += "<td class='fn-hide'>"+colHideName[i]+"</td>";
				}
				html += "</tr>";
				for(var z=0,k=table_tr.length; z<k; z++){
					html += "<tr name='"+id+"_contacts_tr' bSelected='false'>";
					// 多选框
					if(multiple){
						html += "<td width='10%'><input type='checkbox' name='"+id+"_check' value='"
							+table_tr[z][key]+"'/></td>";
					}
					for(var i=0,j=colValue.length; i<j; i++){
						 if(table_tr[z][colValue[i]]==null){
							 html += "<td width='"+colWidth[i]+"' name='"+colValue[i]+"'>无</td>";
						 }
						 else
						html += "<td width='"+colWidth[i]+"' name='"+colValue[i]+"'>"+table_tr[z][colValue[i]]+"</td>";
					}
					for(var i=0,j=colHideValue.length; i<j; i++){
						if(table_tr[z][colHideValue[i]]==null){
							html += "<td class='fn-hide' name='"+colHideValue[i]+"'>无</td>";
						}
						else
						html += "<td class='fn-hide' name='"+colHideValue[i]+"'>"+table_tr[z][colHideValue[i]]+"</td>";
					}
					html += "</tr>";
				}
				// 显示页面位置
				html += "</table></div><div id='"+id+"_table2' class='mt_5 f_r'>共<strong>"+data.total
						+ "</strong>条记录，页面：<strong class='mr_10'>" + (data.pageIndex+1)+"/"+data.totalPage+ "</strong>"
						+ "<span class='mr_10'>首页</span><span class='mr_10'>上页</span>";

				// 判断是否是末页
				if(data.isLastPage){
					html += "<span class='mr_10'>下页</span><span class='mr_10'>末页</span></div>";
				}else{
					html += "<a class='mr_10' itempage='"+(data.pageIndex+1)+"'>下页</a><a class='mr_10' itempage='"+(data.totalPage-1)+"'>末页</a></div>";
				}
				$("#"+id).html(html);
				if(doNextPageDisplayAble){
					doNextPageDisplay(table_tr);
				}
				
			}
		});
	};
	
	this.initialization();
};

SearchTable.prototype = {
	show: function(btnthis){
		var id = this.id;
		var url = this.url;
		var colWidth = this.colWidth;
		var colName = this.colName;
		var colValue = this.colValue;
		var colHideName = this.colHideName;
		var colHideValue = this.colHideValue;
		var click = this.onRowClick;
		var dblclick = this.onRowDblclick;
		var multiple = this.multiple;
		var key = this.key;
		var doNextPageDisplayAble=this.doNextPageDisplayAble;  
		var doNextPageDisplay=this.doNextPageDisplay;
		/*var nodeValue=this.nodeValue;
		var isChildren=this.isChildren;
		var nodeEvent=this.nodeEvent;
		var nodeDoFunction=this.nodeDoFunction;*/
		// 解除之前所有的绑定
		$(document).undelegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]","click");
		$(document).undelegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]","dblclick");
		$(document).undelegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]","mouseover");
		$(document).undelegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]","mouseout");
		$(document).undelegate("#"+id+"_table2 a","click");
		$(document).undelegate("#"+id+"_search_a","click");
		art.dialog({
			id: id+"_dialog",
			button: [{
				value: "关闭",
				callback: function () {
					return true;
	         	}
	         },{
	        	value: "确定",
	        	callback: function () {
	        		if(multiple){
	        			// 获取选中行
	        			var rowDataList = [];
						$("#"+id+"_contacts_table tr[bSelected=true]").each(function(){
							if($(this).attr("name") != null){
								var rowData = {};
								$(this).find("td").each(function(){
									rowData[$(this).attr("name")] = $(this).html();
								});
								rowDataList.push(rowData);
							}
						});
						click(btnthis, rowDataList);
	        		}else{
	        			// 获取选中行
						var oSelectedTr = $("#"+id+"_contacts_table tr[bSelected=true]");
						if(oSelectedTr.attr("name") != null){
							// 将数据组合成一个json对象返回
							var rowData = {};
							oSelectedTr.find("td").each(function(){
								rowData[$(this).attr("name")] = $(this).html();
							});
							click(btnthis, rowData);
						}
	        		}
	        		return true;
	        	}
	        }],
			lock: true,
			padding: "20px 25px 0",
		    content: $("#"+id)[0]
		});
		  
		// 列表行单点操作
		$(document).delegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]", "click", function(){
			// 行未被选中情况下，去掉已经选中的行状态，将本行设置为选中状态
			if(!multiple){
				$("#"+id+"_contacts_table tr[bSelected=true]").css("background-color", "#FFFFFF");
			}
			var bSelected = $(this).attr("bSelected") == "true";
			if(!bSelected){
				if(multiple){
					$(this).find("input[type=checkbox]").attr("checked",true);
				}else{
					$("#"+id+"_contacts_table tr[bSelected=true]").attr("bSelected", "false");
				}
				$(this).attr("bSelected", "true");
				$(this).css("background-color", "#EFEFEF");
			}else{
				// 行已被选中情况下，去掉本身的选中状态
				$(this).attr("bSelected", "false");
				if(multiple){
					$(this).find("input[type=checkbox]").removeAttr("checked");
					$(this).css("background-color", "#FFFFFF");
				}
			}
		});
		// 鼠标滑过行，行背景变灰效果
		$(document).delegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]", "mouseover", function(){
			// 行未被选中情况下，去掉已经选中的行状态，将本行设置为选中状态
			$("#"+id+"_contacts_table tr[bSelected=false]").css("background-color", "#FFFFFF");
			$(this).css("background-color", "#EFEFEF");
		});
		// 鼠标滑出去掉未选择行的选中色
		$(document).delegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]", "mouseout", function(){
			// 行未被选中情况下，去掉已经选中的行状态，将本行设置为选中状态
			$("#"+id+"_contacts_table tr[bSelected=false]").css("background-color", "#FFFFFF");
		});
		
		// 列表行双击操作
		$(document).delegate("#"+id+"_contacts_table tr[name="+id+"_contacts_tr]", "dblclick", function(){
			// 将数据组合成一个json对象返回
			var rowData = {};
			// 对行数据进行遍历
			$(this).find("td").each(function(){
				rowData[$(this).attr("name")] = $(this).html();
			});
			
			dblclick(btnthis, rowData);
			var art_dialog = art.dialog.list[id+"_dialog"];
			if(art_dialog!=null){
				art_dialog.close();
			}
			return false;
		});
		
		// 首页，末页以及上下页翻页
		$(document).delegate("#"+id+"_table2 a", "click", function(){
			reacquire($(this).attr("itempage"));
		});
		
		// 搜索列表
		$(document).delegate("#"+id+"_search_a", "click", function(){
			reacquire(0);
		});
		
		function reacquire(pageIndex){
			$.ajax({
				type: 'GET',
				url: url,
				data: {
					searchData: $("#"+id+"_search").val(),
					pageIndex: pageIndex
				},
				success: function(data){
					var table_tr = data.rows;
					var html =
							"<table width='100%' cellspacing='0' cellpadding='0' id='"+id+"_contacts_table'>"
							+ "<tr style='background-color:#f0f3f5;'>";
					
					// 增加多选框
					if(multiple){
						html += "<td width='10%'>选择</td>";
					}
					
					for(var i=0,j=colName.length; i<j; i++){
						html += "<td width='"+colWidth[i]+"'>"+colName[i]+"</td>";
					}
					for(var i=0,j=colHideName.length; i<j; i++){
						html += "<td class='fn-hide'>"+colHideName[i]+"</td>";
					}
					html += "</tr>";
					for(var z=0,k=table_tr.length; z<k; z++){
						html += "<tr name='"+id+"_contacts_tr' bSelected='false'>";
						
						// 多选框
						if(multiple){
							html += "<td width='10%'><input type='checkbox' name='"+id+"_check' value='"
								+table_tr[z][key]+"'/></td>";
						}
						
						for(var i=0,j=colValue.length; i<j; i++){
							if(table_tr[z][colValue[i]] == null){
								html += "<td width='"+colWidth[i]+"' name='"+colValue[i]+"'>无</td>";
							}else{
								html += "<td width='"+colWidth[i]+"' name='"+colValue[i]+"'>"+table_tr[z][colValue[i]]+"</td>";
							}
						}
						for(var i=0,j=colHideValue.length; i<j; i++){
							if(table_tr[z][colHideValue[i]] == null){
								html += "<td class='fn-hide' name='"+colHideValue[i]+"'></td>";
							}else{
								html += "<td class='fn-hide' name='"+colHideValue[i]+"'>"+table_tr[z][colHideValue[i]]+"</td>";
							}
						}
						html += "</tr>";
					}
					html += "</table>";
					
					// 显示页面位置
					var html2 = "共<strong>"+data.total
							+"</strong>条记录，页面：<strong class='mr_10'>" + (data.pageIndex+1)+"/"+data.totalPage + "</strong>";
					// 判断是否是首页
					if(data.isFirstPage){
						html2 += "<span class='mr_10'>首页</span><span class='mr_10'>上页</span>";
					}else{
						html2 += "<a class='mr_10' itempage='0'>首页</a><a class='mr_10' itempage='"+(data.pageIndex-1)+"'>上页</a>";
					}
					// 判断是否是末页
					if(data.isLastPage){
						html2 += "<span class='mr_10'>下页</span><span class='mr_10'>末页</span></div>";
					}
					else{
						html2 += "<a class='mr_10' itempage='"+(data.pageIndex+1)+"'>下页</a><a class='mr_10' itempage='"+(data.totalPage-1)+"'>末页</a></div>";
					}
					$("#"+id+"_table1").html(html);
					$("#"+id+"_table2").html(html2);
					if(doNextPageDisplayAble){
						doNextPageDisplay(table_tr);
					}
					
				}
			});
		}
	}
};