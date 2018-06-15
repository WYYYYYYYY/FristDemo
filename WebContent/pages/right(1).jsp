
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    
<html>
<head>


<link href="../public/css/bootstrap.min.css" rel="stylesheet">
<script src="../public/js/jquery-1.10.2.min.js"></script>
<script src="../public/js/bootstrap.min.js"></script>

<!--  
<link href="../public/css/normalize.css" rel="stylesheet">
<link href="../public/css/bootstrap-switch.css" rel="stylesheet">
<link href="../public/css/bootstrap-fileupload.min.css" rel="stylesheet">
<link href="../public/css/bootstrap-datetimepicker.css" rel="stylesheet">

<script src="../public/js/bootstrap-switch.min.js"></script>
<script src="../public/js/bootstrap-fileupload.min.js"></script>
<script src="../public/js/bootstrap-paginator.js"></script>
<script src="../public/js/bootstrap-datetimepicker.min.js"></script>
<script src="../public/js/json2.js"></script>
<script src="../public/js/stupidtable.js"></script>
<script src="../public/js/dragtable.min.js"></script>
<script src="../public/js/tablelist.js"></script> 
<script src="../public/js/inputvalid.js"></script>
<script src="../public/js/actions.js"></script>
<script src="../public/js/comm.js"></script>
<script src="../public/js/respond.min.js"></script>
<script src="../public/js/html5shiv.min.js"></script>
-->


<style>
	body {
		padding-top: 30px;
		/* overflow-y: scroll; */
	}
	
    .table-bordered  tr , th {
        border: 1px solid blank; /* 整体表格边框 */
    }
</style>
</head>

<body>



<!-- Navbar 指导航条，它在移动设备上显示为折叠状态，在宽屏幕上水平展开 -->
<!-- navbar-fixed-top :固定在顶部 -->
<!-- navbar-form :让表单在导航条中水平、居中显示-->
<!-- navbar-left :将表单放置在导航栏左边-->
<!-- navbar-btn 向不在 <form> 中的 <button> 元素添加按钮，按钮在导航栏上垂直居中 -->
<!-- table :为任意 <table> 添加基本样式 (只有横向分隔线)-->
<!-- table-bordered:为所有表格的单元格添加边框 -->
<!-- table-hover:在 <tbody> 内的任一行启用鼠标悬停状态 -->
<!-- table-striped:在 <tbody> 内添加斑马线形式的条纹 ( IE8 不支持 -->
<!-- table-condensed:让表格更加紧凑 -->
<!-- placeholder:属性提供可描述输入字段预期值的提示信息（hint）,该提示会在输入字段为空时显示，并会在字段获得焦点时消失 -->
<!-- modal:Bootstrap 模态框（Modal）插件 -->
<!-- modal-dialog:对话框 -->
<!-- form-horizontal:Bootstrap框架默认的表单是垂直显示风格，在Bootstrap框架中要实现水平表单效果 -->
<!-- form-group :改变“form-group”的表现形式，类似于网格系统的“row” -->
<!-- form-control :通过定制了一个类名`form-control`，也就是说，如果这几个元素使用了类名“form-control”-->
<!-- col-xs-8 : 在超小屏中占八列  8/12 -->
<!-- control-label:文本采用右对齐方式 -->
<!-- form-control:换行+填充整行  -->
<!--  data-dismiss="modal":modal弹窗里面加上这个按钮，那么点击则会关闭当前弹窗 -->
	<nav class="navbar navbar-default navbar-fixed-top" > 
	 <form class="navbar-form navbar-left" id="searchForm">
		<table >
			<tbody>
				<tr>
					<td>姓名：</td>
					<td><input type="text"  placeholder="请输入姓名" ></td>
					<td>&nbsp;年龄：</td>
					<td><input type="text"  placeholder="请输入年龄" ></td>
					<td>&nbsp;城市：</td>
					<td>
						<select class="form-control" name="searchMode">
							<option value="cityId">北京</option>
							<option value="cityId">上海</option>
							<option value="cityId">成都</option>
							<option value="cityId">长春</option>
						</select>
					</td>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;
						<button class="btn btn-primary" id="searchBtn" type="button">
							<span class="glyphicon glyphicon-search">查询           <!-- 字体图形 -->
						</button>
					</td>
					
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="button" class="btn btn-primary navbar-btn glyphicon glyphicon-plus" onClick="showDialog('add');">
							增加
						</button>
						  
						<button type="button" class="btn btn-primary navbar-btn glyphicon glyphicon-minus" onClick="showDialog('del');">
							删除
						</button>
						  
						<button type="button" class="btn btn-primary navbar-btn glyphicon glyphicon-pencil" onClick="showDialog('edit');">
							修改
						</button>
						
					</td>
				</tr>


			</tbody>
		</table>
		
	 </form> 
	</nav>  
	
		<br><br>
		<table  id="lbttable" class="table table-bordered table-hover table-striped table-condensed">
			<thead>
				<tr>
					<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">#</th>
					<th style="width:200px;">姓名</th> 
					<th style="width:200px;">年龄</th>
					<th style="width:200px;">性别</th>
					<th style="width:200px;">出生日期</th>
					<th style="width:200px;">居住地址</th>
				</tr>
			</thead>
			<tbody >
				  <tr class="success">
				  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">1</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			   <tr >
    			   	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">2</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr class="success">
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">3</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr >
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">4</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr class="success">
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">5</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr >
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">6</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr class="success">
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">7</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr >
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">8</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
    			  <tr class="success">
    			  	<th style="width:30px;"><input id="checkAll" type="checkbox"></input></th>
					<th style="width:30px;">9</th>
      				<th style="width:200px;">java</th>
      				<th style="width:200px;">100</th>
      				<th style="width:200px;">man</th>
      				<th style="width:200px;">1994-04-28</th>
      				<th style="width:200px;">北京</th>
    			  </tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="7">&nbsp;</td>
				</tr>
			</tfoot>
		</table>

</body>

<div id="lbtDialog" class="modal" tabindex="-1">
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="userHeader"></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="lbtForm">
						<div class="form-group" style="display: none">
							<div class="col-xs-8">
								<input   class="form-control" type="text" name="id" >
							</div>
						</div>	
						
							<div class="form-group">
								<label class="col-xs-4 control-label">姓名</label>
								<div class="col-xs-8">
									<input   class="form-control" type="text" name="name" data-valid="[{rule:'not_empty',message:'不能为空!'}]"  maxlength="16"
									placeholder="姓名">
								</div>
							</div>	
							<div class="form-group" >
								<label class="col-xs-4 control-label">年龄</label>
								<div class="col-xs-8">
									<input   class="form-control" type="text" name="cityId" data-valid="[{rule:'not_empty',message:'不能为空!'},{rule:'positive',message:'请输入正确的市地区代码'}]"  maxlength="8"
									placeholder="年龄">
								</div>
							</div>
						
						
						<div class="form-group"  >
							<label class="col-xs-4 control-label">性别</label>
							<div class="col-xs-8">
								<input  class="form-control" type="text" name="CmdURL"  maxlength="64" 
								placeholder="" data-valid="[{rule:'not_empty',message:'不能为空!'},{rule:'url',message:'不能为空'}]">
							</div>
						</div>
						<div class="form-group"  >
							<label class="col-xs-4 control-label">出生日期</label>
							<div class="col-xs-8">
								<input  class="form-control" type="text" name="logURL"  maxlength="64" 
								placeholder="" data-valid="[{rule:'not_empty',message:'不能为空!'},{rule:'url',message:'不能为空'}]">
							</div>
						</div>
						
						<div class="form-group"  >
							<label class="col-xs-4 control-label">居住地址</label>
							<div class="col-xs-8">
								<input  class="form-control" type="text" name="upgradeURL"  maxlength="64" 
								placeholder="" data-valid="[{rule:'not_empty',message:'不能为空!'},{rule:'url',message:'居住地址'}]">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">
						取消
					</button>
					<button class="btn btn-primary" onClick="lbtAction();">
						确认
					</button>
				</div>
			</div>
		</div>
	</div>
	
<div id="alertDialog" class="modal" tabindex="-1">
		<div class="modal-dialog" style="width: 300px;">
			<div class="modal-content">
				<div class="modal-header">
					<h4>删除</h4>
				</div>
				<div class="modal-body" id="alertContent"></div>
				<div class="modal-footer" style="text-align: center;">
					<button class="btn btn-default" onClick="closeAlertDialog();">
						取消
					</button>
					<button class="btn btn-primary" onClick="lbtAction()">
						确认
					</button>
				</div> 
			</div>
		</div>
</div>


<div id="updateDialog" class="modal" tabindex="-1">
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="userHeader">修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="lbtForm">
						<div class="form-group" style="display: none">
							<div class="col-xs-8">
								<input   class="form-control" type="text" name="id" >
							</div>
						</div>	
					
						<div class="form-group">
							<label class="col-xs-4 control-label">姓名</label>
							<div class="col-xs-8">
								<input class="form-control" type="text" name="name" value="java">
							</div>
						</div>	
						<div class="form-group" >
							<label class="col-xs-4 control-label">年龄</label>
							<div class="col-xs-8">
								<input class="form-control" type="text" name="name" value="100">							</div>
							</div>
						<div class="form-group"  >
							<label class="col-xs-4 control-label">性别</label>
							<div class="col-xs-8">
								<input class="form-control" type="text" name="name" value="man">
							</div>
						</div>
						<div class="form-group"  >
							<label class="col-xs-4 control-label">出生日期</label>
							<div class="col-xs-8">
								<input class="form-control" type="text" name="name" value="1994-04-28">
							</div>
						</div>
						<div class="form-group"  >
							<label class="col-xs-4 control-label">居住地址</label>
							<div class="col-xs-8">
								<input class="form-control" type="text" name="name" value="北京">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">
						取消
					</button>
					<button class="btn btn-primary" onClick="lbtAction();">
						确认
					</button>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript">
var lbtList = new Array();
var actionMode = "add";
var delFlag = true;
var lbtObj = null;
var lbtFormObj = null;
/*
$(function () {
	$("#lbttable").dragTable();
	lbtFormObj = $("#lbtForm").inputValid(valid_message_options);
	lbtObj = $("#lbttable").tableList({
        url:"lbt/lbt_list.do",
        paging:true,		//是否分页
        finishCallBack:initCameraList,//回调函数
        template:htmlTemplate //分页（表格）
    }); 
	
	actionObj = new Actions({
        successCallBack:function(){
        	lbtObj.refresh();//refresh() 全局更新方法成功返回一个空的字符串，失败返回非空字符串
        }
    });
	 $("#searchBtn").click(function() {
		 lbtObj.search({
	            param:$("#searchForm").serialize()
	        });
	    });
	 
});
*/
/*
	function initCameraList(data){
		
		console.log(data)
		lbtList = data;
	}
*/
/*
	function refresh() {
		lbtObj.refresh()
	}
*/	
/*
	function htmlTemplate(index,data ,recordIndex) { 
		console.log(data)
		var html = '<tr>';
		html += '<td><input id="checkbox" type="checkbox"  name="IDS" value="'+data.id+'"/></td>';
		html += '<td>'+recordIndex+'</td>';
		html += '<td><a href="javascript:void(null);" class="title" data-toggle="tooltip" title="'+ data.cityId+'" onClick="showDialog(\'edit\','+index+');"><strong>'+data.name+'</strong></a></td>';	
		html += '<td>'+data.cityId+'</td>';
		html += '<td>'+data.cmdURL+'</td>';
		html += '<td>'+data.logURL+'</td>';
		html += '<td>'+data.upgradeURL+'</td>';
		html += '</tr>';
		return html; 
	}
*/
	function showDialog(mode,obj) {
		$("#checkbox").checked = false;
		console.log(obj)
	    actionMode = mode;
	    if (actionMode == "add") {
	    	console.log(1)
	    	$("#lbtDialog input").val("");
	        $("#lbtDialog input").popover("destroy");
	        $("#lbtDialog .form-group").removeClass("has-error");
			$("#userHeader").html('增加');
			$("input[name='name']").val("");
	        $("input[name='cityId']").val("");
	        $("input[name='CmdURL']").val("");
	        $("input[name='logURL']").val("");
	        $("input[name='upgradeURL']").val("");
			$("#lbtDialog").modal("show");
	    } else if (actionMode == "edit") {
	    	//var lbt=lbtList[obj]
	    	//console.log(lbt)
	    	//$("#lbtDialog input").val("");
	        //$("#lbtDialog input").popover("destroy");
	        //$("#lbtDialog .form-group").removeClass("has-error");
			//$("#userHeader").html('修改');
			//$("input[name='name']").val(lbt.name);
	        //$("input[name='cityId']").val(lbt.cityId);
	        //$("input[name='CmdURL']").val(lbt.cmdURL);
	        //$("input[name='logURL']").val(lbt.logURL);
	        //$("input[name='upgradeURL']").val(lbt.upgradeURL);
	        //$("input[name='id']").val(lbt.id);
			$("#updateDialog").modal("show");
	    }else {
	    	delFlag = true;
	    	
			if (Boolean(obj)) {
				closeAlertDialog();
				console.log(obj)
			    $(obj).parent().parent().parent().find("input[name='IDS']").prop("checked",true);
			} else if ($("input[name='IDS']:checked").length == 0) {
				console.log($("input[name='IDS']:checked").length)
			    delFlag = false;
			    $("#alertContent").html('至少选择一项');
			    $("#alertDialog").modal("show");
			    return;
			}
			if (actionMode == "del") {
				$("#alertContent").html('确认删除吗？');
				$("#alertDialog").modal("show");
			}  else {
			    lbtAction();
			}
	    	
	    	
	    }
	}
	
	function lbtAction() {
	    var url = "", param = "";
	    if (actionMode == "add") {
			if (!lbtFormObj.validate_all()) return;
			url = "lbt/lbt_add.do";
			param = $("#lbtForm").serialize();//jQuery序列化
			console.log(param)
			$("#lbtDialog").modal("hide");
	    } else if (actionMode == "edit"){
			if (!lbtFormObj.validate_all()) return;
			url = "lbt/lbt_edit.do";
			param = $("#lbtForm").serialize();
			console.log(param)
			$("#lbtDialog").modal("hide");
	    }else{
				if(!delFlag) {
			    closeAlertDialog();
			    return;
			}
			 if (actionMode == "enable") {
				url = "u";
		    } else if (actionMode == "disable") {
				url = "";
		    } else {
				url = "lbt/lbt_del.do";
		    } 
			 param += "&ids=";
			$.each($("input[name='IDS']:checked"),function(i){
			    param += $(this).val()+" ";
			});
			console.log(param)
			closeAlertDialog();
			
	    }
	    actionObj.submit({url:url,param:param});
	    setTimeout(function(){  //使用  setTimeout（）方法设定定时2000毫秒
	    	window.location.reload();//页面刷新
	    	},1000);
	}

	function closeAlertDialog() {
	    $("#alertDialog").modal("hide");
	    $("#checkAll").get(0).checked = false;
	    $("input[name='IDS']:checked").each(function(){this.checked=false;});
	}


</script>
</html>