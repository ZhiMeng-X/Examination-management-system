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
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

</head>
<body>


	<div style="position:  relative; left: 30px;">
		<br>
		<h3>个人信息</h3>
		<hr style="position: relative; top: -40px;">
	</div>


		<div style="position: relative; top: 0px;">
			<div style="position: relative; left: 40px; height: 30px;">
				<div style="width: 300px; color: gray;">账号名</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&emsp;&emsp;${stu.loginAct}</b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>&emsp;&emsp;${stu.name}</b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 10px;">
				<div style="width: 300px; color: gray;">邮箱</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&emsp;&emsp;${stu.email}</b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">账户失效日期</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>&emsp;&emsp;${stu.expireTime}</b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 20px;">
				<div style="width: 300px; color: gray;">账户状态</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&emsp;&emsp;${stu.lockState}</b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">学校</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">&emsp;&emsp;${stu.school}</b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 30px;">
				<div style="width: 300px; color: gray;">二级学院</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&emsp;&emsp;${stu.academic}</b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">班级</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="possibility">&emsp;&emsp;${stu.clazz}</b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>
			<div style="position: relative; left: 40px; height: 30px; top: 40px;">
				<div style="width: 300px; color: gray;">创建时间</div>
				<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&emsp;&emsp;${stu.createTime}</b></div>
				<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">创建人</div>
				<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>&emsp;&emsp;${stu.createBy}</b></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
				<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
			</div>

		</div>
		

</body>
</html>