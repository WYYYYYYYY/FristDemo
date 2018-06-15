<!--  <%@ include file="/base.jsp"%> -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>left</title>

<link href="../public/css/bootstrap.min.css" rel="stylesheet">
<script src="../public/js/jquery-1.10.2.min.js"></script>  <!-- ?为什么用在后面不可以？ -->
<script src="../public/js/bootstrap.min.js"></script>


<style>

body {
	background-color: #006699;
	<!--overflow-y: scroll;--> <!--left 页面滚动条-->
	
}


.panel{
	margin-top: 0px;
}
.panel-primary{
	margin-top:0px;
}

.btn {
	border-radius: 0;
	margin-top: 0px;
	padding-top:0px;
}

.btn-primary {
	border: 0;
	margin-top: 0px;
}

.list-group {
	margin-bottom: 0;
}

.list-group-item {
	padding: 6px 15px;
	text-align: center;
}


.list-group-item:first-child,.list-group-item:last-child {
	border-radius: 0;
}

</style>
</head>
<body>
<!-- panel:面板 -->
<!-- panel-primary:带语境状态的修饰（颜色） -->
<!-- data-toggle :以什么事件触发 -->	
<!-- data-target :事件的目标 -->	
<!-- btn-primary 原始按钮 -->
<!-- btn-block 块级按钮(拉伸至父元素100%的宽度)-->
<!-- btn： Bootstrap 按钮（Button）插件 -->
<!-- collapse ：Bootstrap 折叠（Collapse）插件 -->
<!-- list-group:列表组 -->

		<div class="panel panel-primary">
				<button type="button" class="btn btn-primary btn-block"
					data-toggle="collapse" data-target="#collapse12"
					data-parent="#accordion" >
					学生管理系统1111111
				</button>
				
				<div id="collapse12" class="panel-collapse collapse">
					<div class="list-group">
							<a href="right.jsp" target = "right_frame" class="list-group-item">
								学生管理
							</a>
					</div>
					<div class="list-group">
							<a href="praph.jsp" target = "right_frame" class="list-group-item">
								图形界面
							</a>
					</div>
					<div class="list-group">
							<a href="test.jsp" target = "right_frame" class="list-group-item">
								测试界面
							</a>
					</div>
				</div>
		</div>
</body>
</html>