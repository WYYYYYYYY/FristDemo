<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bootstrap Table Examples</title>
    <script src="../public/js/jquery-1.10.2.min.js"></script>
	<script src="../public/js/jquery.form.js"></script>
	<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<link href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<!-- è¡¨æ ¼ -->
	<script src="../public/js/bootstrap-table.js"></script>
	<link href="../public/css/bootstrap-table.css" rel="stylesheet">
	
	<script type="text/javascript">
	
	$(document).ready(function() {
		$("#table").bootstrapTable({
			url:"welcome.json",
			columns:[
				{field:"status", checkbox:true},
				{title:"name",field:"name",sortable:false},
				{title:"age",field:"age", sortable:true}
			],
			clickToSelect:true,
			sortName:"age",
			sortOrder:"desc",
			pagination:true,
			paginationLoop:false,
			pageNumber:1,
			pageSize:10,
			pageList:[10,20,50],
			onDblClickCell:function(){
				alert("dbclick");
			}
		});
		
		$("#table").on("check.bs.table", function(){alert("check");})

	});
	
	</script>
</head>
<body>


<nav class="navbar navbar-default navbar-fixed-top"> 
		<div class="row" >
        	 <div class="col-md-8 col-xs-8" style="margin-top:10px" >      	 
         		<form class="navbar-form navbar-left form-inline" id="searchForm"  >
         			姓名：<input type="text"  placeholder="请输入姓名" >
         			年龄：<input type="text"  placeholder="请输入年龄" >
         			<select  name="searchMode" class="form-control" >
							<option value="cityId">北京</option>
							<option value="cityId">上海</option>
							<option value="cityId">成都</option>
							<option value="cityId">长春</option>
					</select>
					<button class="btn btn-primary" id="searchBtn" type="button">
							<span class="glyphicon glyphicon-search">查询</span>           
					</button>					 					 
         		</form>
      		</div>
      		<div class="col-md-4 col-xs-4" style="margin-top:10px;padding-left:110px">
         		<button type="button" class="btn btn-success navbar-btn glyphicon glyphicon-plus" onClick="showDialog('add');">
							增加
				</button>
				<div id="toolbar">						  
				<button  id="button"  type="button" class="btn btn-danger navbar-btn glyphicon glyphicon-minus" >
							删除
				</button>	
				</div>					  
				<button  type="button" class="btn btn-warning navbar-btn glyphicon glyphicon-pencil" onClick="showDialog('edit');">
							修改
				</button>
			</div>
		</div>
</nav>

<div style="margin-top:200px"  >
<table id="table" data-toggle="table" data-toolbar="#toolbar"></table>
</div>
 
<script>
    var $table = $('#table'),
        $button = $('#button');
    $(function () {
        $button.click(function () {
            var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id;
            });
            $table.bootstrapTable('remove', {
                field: 'name',
                values: ids
            });
        });
    });
</script>

</body>
</html>
