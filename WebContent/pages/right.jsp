<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="../public/js/jquery-1.10.2.min.js"></script>
<script src="../public/js/jquery.form.js"></script>
<script src="../public/js/bootstrap.min.js"></script>
<link href="../public/css/bootstrap.min.css" rel="stylesheet">
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
<link href="../public/css/bootstrap-datetimepicker.min.css"
	rel="stylesheet" media="screen">
<script src="../public/js/bootstrap-datetimepicker.js"></script>
<script src="../public/js/bootstrap-datetimepicker.min.js"></script>

<script type="text/javascript">
	var mdata = [];
	var deletes = [];
	var updateId = "";
	/* 表格设置及动态获取json中数据 */
	$(document).ready(function() {
		$("#table").bootstrapTable({
			url:"/FirstDemo/student/list.do",
			//url:"../public/data/data2.json",
			sidePagination: "server",
			columns : [ {
				field : "status",
				checkbox : true
			},
			{title:"No.",field:"id",sortable:false},
			/*{
				title : "No.",
				field : "id",
				formatter : function(value, row, index) {
					return index + 1;
				}
			},*///自动生成列序号
			{
				title : "name",
				field : "name",
				sortable : false
			}, {
				title : "age",
				field : "age",
				sortable : true
			}, {
				title : "sex",
				field : "sex",
				sortable : false
			}, {
				title : "birthday",
				field : "birthday",
				sortable : false
			}, {
				title : "email",
				field : "email",
				sortable : false
			}, {
				title : "phone",
				field : "phone",
				sortable : false
			}, {
				title : "address",
				field : "address",
				sortable : false
			} ],
			clickToSelect : true,
			smartDisplay:false,
			pagination : true,
			pageNumber : 1,
			pageSize : 10,
			pageList : [ 10, 20, 50 ]
		});

	});

	var valid = $.scojs_valid('#lbtForm', {
		rules : {
			name : [ 'not_empty' ],
			age : [ 'not_empty' ],
			sex : [ 'not_empty' ],
			birthday : [ 'not_empty' ],
			email : [ 'not_empty', 'email' ],
			phone : [ 'not_empty', 'numeric' ]
		}
	});
	
	function checkData(){
		console.log("check data........");
		if (!valid.validate()) {
			return false;
		}
		if(true)return true;
		console.log("check true........");
	}
	

	//删除
	function deleteStudent() {
		$.ajax({
		    type:"post",
		    url:"<%=request.getContextPath()%>/student/delStudent.do?ids="+deletes,
		    success:function(data){
		    	deletes = [];
				$("#delDialog").modal("hide");
				var opt = {
				        url: "/FirstDemo/student/list.do",
				    };
				 $("#table").bootstrapTable('refresh', opt);
		    }			
		});
	}
	//查找
	function search(){
		var name = $("#name_search").val();
		var age = $("#age_search").val(); //  #age_search :age的id
		//var address = $("#searchMode option").val();
		var address=$("#searchMode option:selected").val(); //获取选中的项的值   #searchMode : select 的id
		//console.log("seach name:"+name);
		var opt = {
		        url: "/FirstDemo/student/list.do?name="+name+"&age="+age+"&address="+address,
		    };
		 $("#table").bootstrapTable('refresh', opt);
	}
</script>

</head>
<body>
	<nav class="navbar navbar-default navbar-fixed-top">
		<div class="row">
			<div class="col-md-8 col-xs-8" style="margin-top: 10px">
				<form class="navbar-form navbar-left form-inline" id="searchForm" >
					姓名：<input type="text" placeholder="请输入姓名" id="name_search"
						name="name_search"> 年龄：<input type="text"
						placeholder="请输入年龄" id="age_search" name="age_search">
						 <select name="searchMode" class="form-control" id="searchMode">
									<option value = "beijing">beijing</option>
									<option value = "shanghai">shanghai</option>
									<option value = "chengduo">chengduo</option>
									<option value = "chongqing">chongqing</option>
									<option value = "changchun">changchun</option>
						</select>
					<button class="btn btn-primary" id="searchBtn" name="searchBtn" type="button" onclick="search()">
						<span class="glyphicon glyphicon-search">查询</span>
					</button>
				</form>
			</div>
			<div class="col-md-4 col-xs-4"
				style="margin-top: 10px; padding-left: 110px">
				<button type="button"
					class="btn btn-success navbar-btn glyphicon glyphicon-plus"
					onclick="showDialog('add')">增加</button>
				<button id="del" type="button"
					class="btn btn-danger navbar-btn glyphicon glyphicon-minus"
					onClick="showDialog('del');">删除</button>
				<button type="button"
					class="btn btn-warning navbar-btn glyphicon glyphicon-pencil"
					onClick="showDialog('edit');">修改</button>
			</div>
		</div>
	</nav>

	<table id="table" style="margin-top: 60px">
	</table>

	<!-- 增加modal -->
	<div id="addtDialog" class="modal">
		<div class="modal-dialog" style="width: 600px;">
			<div class="modal-content">
				<div class="modal-header">
					<h4 id="userHeader"></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="lbtForm" onsubmit="return checkData();"
						action="<%=request.getContextPath()%>/student/addStudent.do">
						<div class="form-group">
							<label class="col-xs-2 control-label">姓名</label>
							<div class="col-xs-3">
								<input id="name" class="form-control" type="text" name="name"
									maxlength="16" placeholder="请输入姓名">
							</div>
							<label class="col-xs-2 control-label">年龄</label>
							<div class="col-xs-5">
								<input id="age" class="form-control" type="text" name="age" maxlength="8" placeholder="请输入年龄">
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">性别</label>
							<div class="col-xs-3" style="height: 30px; text-align: center; padding-top: 5px">
								<input name="sex" type="radio"  value="man" checked style="margin-left: -40px">男
							    <input name="sex" type="radio"  value="woman" style="margin-left: 20px">女
							</div>
							<label class="col-xs-2 control-label" for="dtp_input1">年月</label>
							<div class="col-xs-5">
								<div class="col-xs-5 input-group date form_datetime  data-date="1979-09-16" data-date-format="yyyy-MM-dd "
									data-link-field="dtp_input1" style="width: 220px;">
									<input class="form-control" name="birthday" type="text"
										value="" readonly> <span class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
								<input type="hidden" id="dtp_input1" value="" /><br />
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">邮件</label>
							<div class="col-xs-3">
								<input id="email" class="form-control" type="email" name="email"
									maxlength="64" placeholder="请输入邮件"
									data-valid="[{rule:'not_empty',message:'不能为空!'}]">
							</div>
							<label class="col-xs-2 control-label">电话</label>
							<div class="col-xs-5">
								<input id="phone" class="form-control" type="text" name="phone"
									maxlength="64" placeholder="请输入电话">
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">住址</label>
							<div class="col-xs-3">
								<select class="form-control" id="address" name = "address">
									<option value = "beijing">beijing</option>
									<option value = "shanghai">shanghai</option>
									<option value = "chengduo">chengduo</option>
									<option value = "chongqing">chongqing</option>
									<option value = "changchun">changchun</option>
								</select>
							</div>
						</div>

						<div class="modal-footer">
							<button class="btn btn-default" data-dismiss="modal">取消</button>
							<button class="btn btn-primary" type="submit" id="submit" >确认</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 删除medal -->
	<div id="delDialog" class="modal">
		<div class="modal-dialog" style="width: 300px;">
			<div class="modal-content">
				<div class="modal-header">
					<!-- <input type="hidden" id="delete_id" name="name" value=""> --> <!-- 隐藏域!!!! -->
					<h4 id="userHeader2"></h4>
				</div>
					<div class="modal-body" id="alertContent"></div>
					<div class="modal-footer" style="text-align: center;">
						<button class="btn btn-default" data-dismiss="modal">取消</button>
						<button class="btn btn-primary" onClick="deleteStudent()" type="submit">确认</button>
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
					<form class="form-horizontal" id="lbtForm" action="<%=request.getContextPath()%>/student/updateStudent.do">
						<input type="hidden" name="id" value=""><!-- 隐藏域!!!! -->
						<div class="form-group">
							<label class="col-xs-2 control-label">姓名</label>
							<div class="col-xs-3">
								<input class="form-control" type="text" name="name" maxlength="16" placeholder="请输入姓名">
							</div>
							<label class="col-xs-2 control-label">年龄</label>
							<div class="col-xs-5">
								<input class="form-control" type="text" name="age" maxlength="8" placeholder="请输入年龄">
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">性别</label>
							<div class="col-xs-3" style="height: 30px; text-align: center; padding-top: 5px" id="sex">
								<input name="sex" type="radio"  value="man" style="margin-left: -40px">男 
								<input name="sex" type="radio"  value="woman" style="margin-left: 20px">女
							</div>
							<label class="col-xs-2 control-label">年月</label>
							<div class="col-xs-5">
								<div class="col-xs-5 input-group date form_datetime  data-date="1979-09-16" data-date-format="yyyy-MM-dd "
									data-link-field="dtp_input1" style="width: 220px;">
									<input id="birthday" name = "birthday"class="form-control" type="text" value=""
										readonly> <span class="input-group-addon"><span
										class="glyphicon glyphicon-remove"></span></span> <span
										class="input-group-addon"><span
										class="glyphicon glyphicon-th"></span></span>
								</div>
								<!--<input type="hidden" id="dtp_input1" value="" /><br/>  --><!-- 隐藏域!!!! -->
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">邮件</label>
							<div class="col-xs-3">
								<input class="form-control" type="email" name="email"
									maxlength="64" placeholder="请输入邮件"
									data-valid="[{rule:'not_empty',message:'不能为空!'}]">
							</div>
							<label class="col-xs-2 control-label">电话</label>
							<div class="col-xs-5">
								<input class="form-control" type="text" name="phone"
									maxlength="64" placeholder="请输入电话">
							</div>
						</div>

						<div class="form-group">
							<label class="col-xs-2 control-label">住址</label>
							<div class="col-xs-3">
								<select class="form-control" id="address_update" name = "address">
									<option value = "beijing">beijing</option>
									<option value = "shanghai">shanghai</option>
									<option value = "chengduo">chengduo</option>
									<option value = "chongqing">chongqing</option>
									<option value = "changchun">changchun</option>
								</select>
							</div>
						</div>
					<div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal">取消</button>
						<button class="btn btn-primary" onClick="updateStudent()">确认</button>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		var actionMode = "add";
		function showDialog(mode, obj) {
			$("#checkbox").checked = false;
			actionMode = mode;
			if (actionMode == "add") {
				$("#userHeader").html('增加');
				$("#addtDialog").modal("show");
			} else if (actionMode == "edit") {
				if ($("#table").find("input[type='checkbox']:checked").length == 1) {
					var updateId = "";
					$("#userHeader3").html('修改');
					var num = $("#table")
							.find("input[type='checkbox']:checked").attr(
									"data-index");
					console.log("num:=====" + num);
					$("#table").find("tr[data-index='" + num + "']").each(
						function() {
							updateId = $(this).children('td').eq(1).text();
						});
					
					$.ajax({
					    type:"post",
					    url:"<%=request.getContextPath()%>/student/findByIdStudent.do?id="+updateId,
					    success:function(data){
					    	console.log("======" + data);
					    	$("#updateDialog").find("input[name='id']").val(data.id);
			    			$("#updateDialog").find("input[name='name']").val(data.name);
			    			$("#updateDialog").find("input[name='age']").val(data.age);
			    			$("#birthday").val(data.birthday);
			    			$("#updateDialog").find("input[name='email']").val(data.email);
			    			$("#updateDialog").find("input[name='phone']").val(data.phone);
			    			$("#sex input").each(function(){
			    				if($(this).val() == data.sex){
			    					$(this).prop("checked",true);
			    				}else{
			    					$(this).prop("checked",false);
			    				}
			    			});
			    			
			    			$("#address_update option").each(function(){
			    				if($(this).val() == data.address){
			    					$(this).prop("selected",true);
			    					
			    				}else{
			    					$(this).prop("selected",false);
			    				}
			    			});
							$("#updateDialog").modal("show");
					    }			
					});
				} else {
					//alert("选中一项可修改,不可选中多项");
					$("#alertContent").html('选择且只能选择一项');
					$("#userHeader2").html('修改');
					$("#delDialog").modal("show");
				}

			} else {
				if ($("#table").find("input[type='checkbox']:checked").length == 0) {
					$("#alertContent").html('至少选择一项');
					$("#userHeader2").html('删除');
					$("#delDialog").modal("show");
				} else {
					$("#table").find("input[type='checkbox']:checked").each(
							function() {
								/*attr() 方法设置或返回被选元素的属性和值。*/
								var num = $(this).attr("data-index");
								//alert(num);								
								$("#table")
										.find("tr[data-index='" + num + "']")
										.each(
												function() {
													deletes.push($(this)
															.children('td').eq(
																	1).text());
												});
							});
					$("#alertContent").html('确认删除吗？');
					$("#userHeader2").html('删除');
					$("#delDialog").modal("show");
				}
			}
		}

		/*date插件*/
		$('.form_datetime').datetimepicker({
			weekStart : 1,
			todayBtn : 1,
			autoclose : 1,
			todayHighlight : 1,
			startView : 2,
			forceParse : 0,
			showMeridian : 1
		});
	</script>
</html>