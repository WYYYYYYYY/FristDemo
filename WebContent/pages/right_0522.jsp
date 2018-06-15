<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 
<script src="../public/js/jquery-1.10.2.min.js"></script>
<script src="../public/js/jquery.form.js"></script>
<!-- bootstrap-table -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>	
<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="../public/js/sco.ajax.js"></script>
<script src="../public/js/sco.collapse.js"></script>
<script src="../public/js/sco.confirm.js"></script>
<script src="../public/js/sco.countdown.js"></script>
<script src="../public/js/sco.message.js"></script>
<script src="../public/js/sco.modal.js"></script>
<script src="../public/js/sco.panes.js"></script>
<script src="../public/js/sco.tab.js"></script>
<script src="../public/js/sco.tooltip.js"></script>

<!-- 表单验证 -->
<script src="../public/js/sco.valid.js"></script>
<link href="../public/css/sco.message.css" rel="stylesheet">
<link href="../public/css/scojs.css" rel="stylesheet">
<!-- 表格 -->
<script src="../public/js/bootstrap-table.js"></script>
<link href="../public/css/bootstrap-table.css" rel="stylesheet">
<!-- date插件 -->
<link href="../public/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
<script src="../public/js/bootstrap-datetimepicker.js"></script>
<script src="../public/js/bootstrap-datetimepicker.min.js"></script>
<!-- 
----动态增改 
<script type="text/javascript">
    var mdata = [];
        $(function () {
            $.ajax({
                type: "GET",
                url: "../public/data/data2.json",
                dataType: "json",
                success: function (msg) {
                	mdata = msg;
                	console.log("data===="+JSON.stringify(msg));
                    $("#table").bootstrapTable('load', msg);
                },
                error: function () {
                    //alert("错误");
                }
            });
        });
        
        window.setTimeout(function(){
        	alert("add ele....");
	        mdata.push({
	            "id": 100,
	            "name": "wy",
	            "price": "women",
	            "birthday": "1994-04-28",
	            "email": "1525147008@qq.com",
	            "phone": "546546546546" 
	        });
	        $("#table").bootstrapTable('load', mdata);
        }, 5000)
                       
</script>
-->

<script type="text/javascript">
var mdata = [];
var deletes = [];
/*way 1
$.ajax({
    type: "GET",
    async:false,
    url: "../public/data/data2.json",
    dataType: "json",
    success: function (msg) {
    	mdata = msg;
    	console.log("data===="+JSON.stringify(msg));
    },
    error: function () {
        //alert("错误");
    }
});
*/

	/* 表格设置及动态获取json中数据 */
	$(document).ready(function() {
		$("#table").bootstrapTable({
			url:"../public/data/data2.json",
			columns:[
				{field:"status", checkbox:true},
				{title:"No.",field:"id",sortable:false},
				{title:"name",field:"name",sortable:false},
				{title:"age",field:"age", sortable:true},
				{title:"sex",field:"sex", sortable:false},
				{title:"birthday",field:"birthday", sortable:false},
				{title:"email",field:"email", sortable:false},
				{title:"phone",field:"phone", sortable:false},
				{title:"address",field:"address1", sortable:false}
			],
			clickToSelect:true,
			//sortName:"age",
			//sortOrder:"asc",
			pagination:true,
			paginationLoop:false,
			pageNumber:1,
			pageSize:10,
			pageList:[10,20,50],
			onLoadSuccess:function(data){
				console.log("load suc.........."+data)
				mdata = data;
			}
		});
		
		//$("#table").on("check.bs.table", function(){alert("check");})
		/*动态增加数据*/
		/*
		window.setTimeout(function(){
	    	alert("add ele....");
	        mdata.push({ 
	        	"id":22,
	            "name": "wy",
	            "age": 24,
	            "sex":"women",
	            "birthday":"2018-05-24",
	            "email":"111111@.com",
	            "phone":"123456789"
	        });
	        $("#table").bootstrapTable('load', mdata);
	    }, 5000)*/
	    
	});
	
	//增加
    function addStudent(){
    	var valid = $.scojs_valid('#lbtForm', {rules:{ name: ['not_empty'],age:['not_empty'],sex:['not_empty'],birthday:['not_empty'],
   			email:['not_empty', 'email'],phone:['not_empty','numeric']}});
    	if(valid.validate()){
	    	console.log(valid.validate());
   			var name=$("#name").val();
   			var age = $("#age").val();
   			//var sex = $("input[name='sex']:checked").val();
   			
   			var sex = "";
   			$("#addtDialog").find("input[name='sex']").each(function(){
   				console.log($(this).is(':checked'));
   				if($(this).is(':checked')){
   					sex = $(this).val();
   					console.log(sex);
   					return true;
   				}
   			});
   			var birthday = $("#addtDialog").find("input[name='date_birthday']").val();
   			
   			var email = $("#email").val();
   			var phone = $("#phone").val();
   			mdata.push({
   				name:name,
   				age:age,
   				sex:sex,
   				birthday:birthday,
   				email:email,
   				phone:phone
   			})		
   			$("#table").bootstrapTable('load', mdata); //加载数据
   			console.log("======"+mdata);
			$("#addtDialog").modal("hide");
    	}
	}
	//删除
	 function delStudent(){
		for(var a in deletes){
			 var id = deletes[a];
			 console.log(id);
			 for(var i in mdata){
				console.log(mdata[i]);
				if(id == mdata[i].id){
					mdata.splice( i, 1 );
				}
			 }
		}
		$("#table").bootstrapTable('load', mdata); //加载数据
		console.log(mdata);
		$("#delDialog").modal("hide");
	}
	//修改
	function updateStudent(){
		var id = $("#updateDialog").find("input[name='id']").val();
		var name = $("#updateDialog").find("input[name='name']").val();
		var age = $("#updateDialog").find("input[name='age']").val();
		var birthday = $("#birthday").val();
		var email = $("#updateDialog").find("input[name='email']").val();
		var phone = $("#updateDialog").find("input[name='phone']").val();
		var sex = "";
		$("#sex input").each(function(){
			if($(this).is(':checked')){
				sex = $(this).val();
				return true;
			}
		});
		/* var name=$("#name").val();
		var age = $("#age").val();
		var sex = $("#sex").val();
		var birthday = $("#birthday").val();
		var email = $("#email").val();
		var phone = $("#phone").val(); */
		for(var i in mdata){
			if(mdata[i].id == id){
				mdata[i].id = id;
				mdata[i].name = name;
				mdata[i].age = age;
				mdata[i].birthday = birthday;
				mdata[i].email = email;
				mdata[i].phone = phone;
				mdata[i].sex = sex;
			}
		}
		/* mdata.push({
			name:name,
			age:age,
			sex:sex,
			birthday:birthday,
			email:email,
			phone:phone
		}) */	
		$("#table").bootstrapTable('load', mdata); 
		console.log(mdata)
		$("#updateDialog").modal("hide");
	}
	//查询
	function searchStudent(){
		var list = [];
		var name=$("#name_search").val();
		var age = $("#age_search").val();
		var address = $("#address_search").val();
		console.log(name + "=" + age + "=" + address);		
		//var name_find = $("#table").find("input[type='checkbox']:checked").attr("data-index");
		//总的数据预源  -----》mdata
		for(var i in mdata){
			var ne = mdata[i].name;
			var ae = mdata[i].age;
			var ad = mdata[i].address1;
			
			if(ne == name && age == ae && ad == address){
				list.push(mdata[i]);
			}
		}
		$("#table").bootstrapTable('load', list); //加载数据
	}
</script>


</head>
<body>

<!-- 
data-url：索取数据的url。
data-method：请求方式。
data-height：设置表格的高
data-query-params="queryParams" ：设置
data-toolbar="#toolbar"  ：设置装按钮的容器为id为toolbar的。
data-pagination="true"  ：设置是否显示页码数
data-search="true"       ：设置search框
data-show-refresh="true" ：设置刷新按钮
data-show-toggle="true"  ：设置数据显示格式
Navbar 指导航条，它在移动设备上显示为折叠状态，在宽屏幕上水平展开 
navbar-fixed-top :固定在顶部 
navbar-form :让表单在导航条中水平、居中显示
navbar-left :将表单放置在导航栏左边
navbar-btn 向不在 <form> 中的 <button> 元素添加按钮，按钮在导航栏上垂直居中 
table :为任意 <table> 添加基本样式 (只有横向分隔线)
table-bordered:为所有表格的单元格添加边框 
table-hover:在 <tbody> 内的任一行启用鼠标悬停状态 
table-striped:在 <tbody> 内添加斑马线形式的条纹 ( IE8 不支持 
table-condensed:让表格更加紧凑 
placeholder:属性提供可描述输入字段预期值的提示信息（hint）,该提示会在输入字段为空时显示，并会在字段获得焦点时消失 
modal:Bootstrap 模态框（Modal）插件 
modal-dialog:对话框
form-horizontal:Bootstrap框架默认的表单是垂直显示风格，在Bootstrap框架中要实现水平表单效果 
form-group :改变“form-group”的表现形式，类似于网格系统的“row” 
form-control :通过定制了一个类名`form-control`，也就是说，如果这几个元素使用了类名“form-control”
col-xs-8 : 在超小屏中占八列  8/12 
control-label:文本采用右对齐方式 
data-dismiss="modal":modal弹窗里面加上这个按钮，那么点击则会关闭当前弹窗 
 -->
<!-- 导航栏 -->
<nav class="navbar navbar-default navbar-fixed-top"> 
		<div class="row" >
        	 <div class="col-md-8 col-xs-8" style="margin-top:10px" >      	 
         		<form class="navbar-form navbar-left form-inline" id="searchForm"  >
         			姓名：<input type="text"  placeholder="请输入姓名" id = "name_search" name = "name_search">
         			年龄：<input type="text"  placeholder="请输入年龄" id = "age_search" name = "age_search">
         			<select  name="searchMode" class="form-control"  id = "address_search">
						<option value="北京">北京</option>
						<option value="上海">上海</option>
						<option value="成都">成都</option>
						<option value="长春">长春</option>
					</select>
					<button class="btn btn-primary" id="searchBtn" name = "searchBtn" type="button" onClick="searchStudent()">
							<span class="glyphicon glyphicon-search">查询</span>           
					</button>					 					 
         		</form>
      		</div>
      		<div class="col-md-4 col-xs-4" style="margin-top:10px;padding-left:110px">
         		<button type="button" class="btn btn-success navbar-btn glyphicon glyphicon-plus" onclick="showDialog('add')">
							增加
				</button>						  
				<button id="del" type="button" class="btn btn-danger navbar-btn glyphicon glyphicon-minus" onClick="showDialog('del');">
							删除
				</button>						  
				<button type="button" class="btn btn-warning navbar-btn glyphicon glyphicon-pencil" onClick="showDialog('edit');">
							修改
				</button>
			</div>
		</div>
</nav>

<table id="table" style = "margin-top:60px">	
</table>  

<!-- 增加modal -->
<div id="addtDialog" class="modal" >
	<div class="modal-dialog" style="width: 600px;">
		<div class="modal-content">
			<div class="modal-header">
					<h4 id="userHeader"></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="lbtForm" >					
						<div class="form-group">
							<label class="col-xs-2 control-label" >姓名</label>
							<div class="col-xs-3" >
								<input   id = "name" class="form-control" type="text" name="name" maxlength="16" placeholder="请输入姓名">
							</div>
							<label class="col-xs-2 control-label" >年龄</label>
							<div class="col-xs-5">
								<input id = "age" class="form-control" type="text" name="age"  maxlength="8" placeholder="请输入年龄">
							</div>
						</div>
					
						<div class="form-group" >
							<label class="col-xs-2 control-label">性别</label>
							<div class="col-xs-3" style="height:30px;text-align:center;padding-top:5px">
								<input id="sex" name="sex"  type="radio" name="optionsRadios" value="man" checked style = "margin-left:-40px" >男								
								
								<input id="sex" name="sex"  type="radio" name="optionsRadios" value="woman" style = "margin-left:20px">女 
							</div>
							<label class="col-xs-2 control-label" for="dtp_input1">年月</label>							
							<div class="col-xs-5" >
								<!--  
								<input  class="form-control" type="text" name="birthday"  maxlength="64" 
								placeholder="请输入出生年月">
								-->
								<div class="col-xs-5 input-group date form_datetime  data-date="1979-09-16" data-date-format="yyyy-MM-dd " data-link-field="dtp_input1" style = "width:220px;">
				                    <input class="form-control" name="date_birthday" type="text" value="" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span> 
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
								<input type="hidden" id="dtp_input1" value="" /><br/>
								
							</div>
						</div>

						<div class="form-group" >
							<label class="col-xs-2 control-label">邮件</label>
							<div class="col-xs-3">
								<input  id = "email" class="form-control" type="email" name="email"  maxlength="64" 
								placeholder="请输入邮件" data-valid="[{rule:'not_empty',message:'不能为空!'}]" >
							</div>						
							<label class="col-xs-2 control-label" >电话</label>							
							<div class="col-xs-5" >
								<input  id = "phone" class="form-control" type="text" name="phone"  maxlength="64" 
								placeholder="请输入电话" >
							</div>
						</div>
						
						<div class="form-group" >
							<label class="col-xs-2 control-label">住址</label>
							<div class="col-xs-3">
								<select class="form-control" id = "address">
								      <option>北京</option>
								      <option>上海</option>
								      <option>成都</option>
								      <option>重庆</option>
								      <option>长春</option>
    							</select>
							</div>						
						</div>
					
				</form>
			</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">
						取消
					</button>
					<!--  <button class="btn btn-primary" onClick="lbtAction();" type="submit"> -->
					<button class="btn btn-primary"  type="submit" id = "submit" onclick="addStudent()">
						确认
					</button>
				</div>
		</div>
	</div>
</div>
<!-- 删除medal -->
<div id="delDialog" class="modal" >
		<div class="modal-dialog" style="width: 300px;">
			<div class="modal-content">
				<div class="modal-header">
					<input type="hidden" id="delete_id" name="name" value="">
					<h4 id ="userHeader2"></h4>
				</div>
				<div class="modal-body" id="alertContent"></div>
				<div class="modal-footer" style="text-align: center;">
					<button class="btn btn-default" data-dismiss="modal">
						取消
					</button>
					<button class="btn btn-primary" onClick="delStudent()">
						确认
					</button>
				</div> 
			</div>
		</div>
</div>
<!-- 修改medal -->
<div id="updateDialog" class="modal" tabindex="-1">
		<div class="modal-dialog" style="width: 600px;">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="userHeader3"></h4>
				</div>
				<div class="modal-body">
				<form class="form-horizontal" id="lbtForm" >
						<input type="hidden" name="id" value="">
						<div class="form-group">
							<label class="col-xs-2 control-label" >姓名</label>
							<div class="col-xs-3" >
								<input  class="form-control" type="text" name="name" maxlength="16" placeholder="请输入姓名" >
							</div>
							<label class="col-xs-2 control-label" >年龄</label>
							<div class="col-xs-5">
								<input   class="form-control" type="text" name="age"  maxlength="8" placeholder="请输入年龄" >
							</div>
						</div>
															
						<div class="form-group" >
							<label class="col-xs-2 control-label">性别</label>
							<div class="col-xs-3" style="height:30px;text-align:center;padding-top:5px" id="sex" >
								<input name="sex"  type="radio" name="optionsRadios" value="man" style = "margin-left:-40px" >男								
								
								<input name="sex"  type="radio" name="optionsRadios" value="woman" style = "margin-left:20px">女 
							</div>
							<label class="col-xs-2 control-label">年月</label>							
							<div class="col-xs-5" >
								<!--  
								<input  class="form-control" type="text" name="birthday"  maxlength="64" 
								placeholder="请输入出生年月">
								-->
								<div class="col-xs-5 input-group date form_datetime  data-date="1979-09-16" data-date-format="yyyy-MM-dd " data-link-field="dtp_input1" style = "width:220px;">
				                    <input id = "birthday" class="form-control"  type="text" value="" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span> 
									<span class="input-group-addon"><span class="glyphicon glyphicon-th"></span></span>
				                </div>
								<input type="hidden" id="dtp_input1" value="" /><br/>
								
							</div>
						</div>
										
						<div class="form-group" >
							<label class="col-xs-2 control-label">邮件</label>
							<div class="col-xs-3">
								<input  class="form-control" type="email" name="email"  maxlength="64" 
								placeholder="请输入邮件" data-valid="[{rule:'not_empty',message:'不能为空!'}]" >
							</div>						
							<label class="col-xs-2 control-label" >电话</label>							
							<div class="col-xs-5" >
								<input  class="form-control" type="text" name="phone"  maxlength="64" 
								placeholder="请输入电话" >
							</div>
						</div>					
				</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal">
						取消
					</button>
					<button class="btn btn-primary" onClick="updateStudent()">
						确认
					</button>
				</div>
			</div>
		</div>
</div>	


<script type="text/javascript">
var actionMode = "add";
	function showDialog(mode,obj) {
		$("#checkbox").checked = false;
	    actionMode = mode;
	    if (actionMode == "add") {
			$("#userHeader").html('增加');
			$("#addtDialog").modal("show");
	    } else if (actionMode == "edit") {
	    	if($("#table").find("input[type='checkbox']:checked").length==1){
	    		var updateId = "";
	    		$("#userHeader3").html('修改');
		    	/* $("#table").find("input[type='checkbox']:checked").each(function(){
		    		updateId = $(this).children('td').eq(1).text();
		    	}); */
		    	//attr:设置或返回被选元素的属性值。
		    	var num = $("#table").find("input[type='checkbox']:checked").attr("data-index");
				console.log("num:====="+num);
				$("#table").find("tr[data-index='"+num+"']").each(function(){
					updateId = $(this).children('td').eq(1).text();
				});
		    	//alert(updateId);
		    	for(var i in mdata){
		    		if(updateId == mdata[i].id){
		    			console.log(mdata[i]);
		    			//mdata[i]----->{id: 1, name: "name1", age: "1", sex: "man", birthday: "1994-04-28", …}
		    			$("#updateDialog").find("input[name='id']").val(mdata[i].id);
		    			$("#updateDialog").find("input[name='name']").val(mdata[i].name);
		    			$("#updateDialog").find("input[name='age']").val(mdata[i].age);
		    			$("#birthday").val(mdata[i].birthday);
		    			$("#updateDialog").find("input[name='email']").val(mdata[i].email);
		    			$("#updateDialog").find("input[name='phone']").val(mdata[i].phone);
		    			$("#sex input").each(function(){
		    				if($(this).val() == mdata[i].sex){
		    					$(this).prop("checked",true);
		    				}else{
		    					$(this).prop("checked",false);
		    				}
		    			});
		    			break;
		    		}
		    	}
				$("#updateDialog").modal("show");
	    	}else{
	    		alert("选中一项可修改,不可选中多项");
	    	}

	    }else {	
	    	var selected = $("#table").bootstrapTable('getSelections');
	    	console.log("selected.lenght=========="+ selected.lenght);
	    	if(selected.lenght==0){
	    		alert("至少选择一项");
	    		return;
	    	}
	    	
	    	for(var i=0;i<selected.length;i++){
	    		deletes.push(selected[i].id);
	    	}
	    	
	    	$("#alertContent").html('确认删除吗？');
			$("#userHeader2").html('删除');
			$("#delDialog").modal("show");
	    }
	}
	

	/*表单验证*/
	//$("#submit").click(function(){
		/* $("#lbtForm").submit(); */
		 /* $("#lbtForm").validate({
	        submitHandler:function(form){
	            alert("submitted");   
	            form.submit();
	        }    
	    }); */
	//});
	
	/*date插件*/
	 $('.form_datetime').datetimepicker({
	        //language:  'fr',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1
	    });
</script>

</html>