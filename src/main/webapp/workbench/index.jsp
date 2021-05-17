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
<script type="text/javascript">

	//页面加载完毕
	$(function(){
		
		//导航中所有文本颜色为黑色
		$(".liClass > a").css("color" , "black");
		
		//默认选中导航菜单中的第一个菜单项
		$(".liClass:first").addClass("active");
		
		//第一个菜单项的文字变成白色
		$(".liClass:first > a").css("color" , "white");
		
		//给所有的菜单项注册鼠标单击事件
		$(".liClass").click(function(){
			//移除所有菜单项的激活状态
			$(".liClass").removeClass("active");
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");
			//当前项目被选中
			$(this).addClass("active");
			//当前项目颜色变成白色
			$(this).children("a").css("color","white");
		});
		
		
		window.open("workbench/main/index.jsp","workareaFrame");




		//确定修改按钮
		$("#updatePwd").click(function () {
			var oldPwd = $("#oldPwd").val()
			var newPwd = $("#newPwd").val()
			var confirmPwd = $("#confirmPwd").val()

			if(oldPwd.length == 0){

				$("#msg").html("请输入原始密码！！！")
				return false;
			}else if(newPwd.length < 3 || newPwd.length > 8){
				$("#msg").html("密码个数必须大于3小于8！！！")
				return false;
			}else if(confirmPwd != newPwd){
				$("#msg").html("密码不一致，请重新输入！！！")
				return false;
			}
			$("#msg").html("")
			if(confirm("确定修改密码？")){
				$.ajax({
						url : "pwd/Reset.do",
						data : {
							"oldPwd" : $.trim($("#oldPwd").val()),
							"newPwd" : $.trim($("#newPwd").val()),
							"confirmPwd" : $.trim($("#confirmPwd").val()),
                            "id" : "${stu.id}"
						},
						dataType : "json",
						type : "post",
						success : function (data) {

							if (data.success){
								alert("密码修改成功")
								$("#editPwdModal").modal("hide")
							}else {
								alert(data.mag)
							}

						}
					})
			}else {
				return false
			}



		})


		
	});

	
</script>

</head>
<body>
	


	<!-- 修改密码的模态窗口 -->
	<div class="modal fade" id="editPwdModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 70%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="oldPwd" class="col-sm-2 control-label">原密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="oldPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="newPwd" class="col-sm-2 control-label">新密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="newPwd" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
								<div class="checkbox"  style="top: 10px; ; text-align: left">

									<span id="msg" style="color: red"></span>

								</div>
							</div>

						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" id="updatePwd">修改</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 退出系统的模态窗口 -->
	<div class="modal fade" id="exitModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">离开</h4>
				</div>
				<div class="modal-body">
					<p>您确定要退出系统吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='session/removeSession.do';">确定</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 顶部 -->
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">&nbsp;&nbsp;欢迎你 &nbsp;<span style="font-size: 12px;">${stu.name}&nbsp;同学</span></div>
		<div style="position: absolute; top: 15px; right: 15px;">
			<ul>
				<li class="dropdown user-dropdown">
					<a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-user"></span> 更多 <span class="caret"></span>&emsp;&emsp;
					</a>
					<ul class="dropdown-menu">

						<li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
						<li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;" >
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;" background="image/bg.png">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="workbench/exam/index.jsp" target="workareaFrame"><span class="glyphicon glyphicon-pencil"></span> 开始考试</a></li>

				<li class="liClass"><a href="#no2" class="collapsed" data-toggle="collapse"><span class="glyphicon glyphicon-plus"></span> 练习模式</a>
					<ul id="no2" class="nav nav-pills nav-stacked collapse">
						<li class="liClass"><a href="workbench/test/index.jsp" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-edit"></span> 开始练习</a></li>
						<li class="liClass"><a href="workbench/test/mylove.jsp" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span class="glyphicon glyphicon-star"></span> 我的收藏</a></li>
					</ul>
				</li>
				<li class="liClass"><a href="workbench/examHistory/index.jsp" target="workareaFrame"><span class="glyphicon glyphicon-tag"></span> 考试记录</a></li>
				<li class="liClass"><a href="workbench/chart/index.jsp" target="workareaFrame"><span class="glyphicon glyphicon-signal"></span> 考试分数分析</a></li>
				<li class="liClass"><a href="workbench/transaction/edit.jsp" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 个人中心</a></li>
				</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
</body>
</html>