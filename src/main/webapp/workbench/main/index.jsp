<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

</head>
<body background="image/bg.png">
<div class="list-group" style="width: 20%;  padding-top: 10% ; margin-left: 20% ;display:inline-block">
	<a href="workbench/exam/index.jsp" class="list-group-item active" style="text-align: center">
		<h4 class="list-group-item-heading" style="padding: 20px">开始考试</h4>
	</a>
</div>
<div class="list-group" style="width: 20%;  padding-top: 10% ; margin-left: 20% ; display:inline-block">
	<a href="workbench/test/index.jsp" class="list-group-item active" style="text-align: center">
		<h4 class="list-group-item-heading" style="padding: 20px">开始练习</h4>
	</a>
</div>
<div class="list-group" style="width: 20%;  padding-top: 5% ; margin-left: 20% ; display:inline-block">
    <a href="workbench/examHistory/index.jsp" class="list-group-item active" style="text-align: center">
        <h4 class="list-group-item-heading" style="padding: 20px">考试记录</h4>
    </a>
</div>
<div class="list-group" style="width: 20%;  padding-top: 5% ; margin-left: 20% ; display:inline-block">
	<a href="workbench/chart/index.jsp" class="list-group-item active" style="text-align: center">
		<h4 class="list-group-item-heading" style="padding: 20px">考试分析</h4>
	</a>
</div>
</body>
</html>