 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
    <title></title>
    <link href="../public/css/bootstrap.min.css" rel="stylesheet">
    <link href="../public/css/bootstrap-table.css" rel="stylesheet">
    <script src="../public/js/jquery.min.js"></script>
    <script src="../public/js/bootstrap.min.js"></script>
    <script src="../public/js/bootstrap-table.js"></script>

    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: "GET",
                url: "../public/data/data2.json",
                dataType: "json",
                success: function (msg) {
                    $("#table").bootstrapTable('load', msg);
                },
                error: function () {
                    //alert("错误");
                }
            });
        });
    </script>
</head>
<body>
    <table data-toggle="table" id="table" data-pagination="true">
        <thead>
            <tr>
           		<!-- <th style="width:30px;"><input id="checkAll" type="checkbox"></input></th> -->
				<!--<th style="width:30px;">#</th>-->
                <th data-field="id">姓名</th>
                <th data-field="name">年龄</th>
                <th data-field="price">性别</th>
                <th data-field="birthday">出生年月</th>
                <th data-field="email">邮件</th>
                <th data-field="phone">电话</th> 
            </tr>
        </thead>
    </table>
</body>
</html>