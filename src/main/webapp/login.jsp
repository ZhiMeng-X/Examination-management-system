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

	<script>

		$(function () {



			if(window.top != window){
				window.top.location = window.location;
			}

			$("#loginAct").val("")
			$("#loginPwd").val("")

			$("#loginAct").focus()

			$("#submitBtn").click(function () {
				login()
			})

			$(window).keydown(function (event) {
				if(event.keyCode == 13){
					login()
				}

			})
			$("#show_regiest").click(function () {
				getSchool()
				$("#createRegisterModal").modal("show");
			})

			$("#register-school").change(function () {
				var v = $("#register-school option:selected").val()
				var id = $("#register-school option:selected").prop("id")
				getAcademic(id)
			})

			$("#register-academic").change(function () {
				var school_id = $("#register-school option:selected").prop("id")
				var academic_id = $("#register-academic option:selected").prop("id")
				getClazz(school_id,academic_id)
			})

			$("#registerBtn").click(function () {

				var name = $.trim($("#register-name").val());
				var loginAct = $.trim($("#register-login").val());
				var loginPwd = $.trim($("#register-password").val());
				var loginPwds = $.trim($("#register-passwords").val());
				var email = $.trim($("#register-email").val());
				var school = $.trim($("#register-school").val());
				var academic = $.trim($("#register-academic").val());
				var clazz = $.trim($("#register-clazz").val());

				// alert(loginAct + "==" + name + "==" + loginPwd + "==" + loginPwds  + "==" + email
				// 		+ "==" + school + "==" + academic + "==" + clazz)
				if (name.length == 0){
					alert("请输入姓名")
					return
				}else if(loginAct.length == 0){
					alert("请输入学号")
					return
				}else if(school.length == 0){
					alert("请选择学校")
					return
				}else if(academic.length == 0){
					alert("请选择二级学院")
					return
				}else if(clazz.length == 0){
					alert("请选择班级")
					return
				}else if(email.length == 0){
					alert("请输入邮箱")
					return
				}else if(loginPwd.length == 0){
					alert("请输入密码")
					return
				}else if(loginPwds.length == 0){
					alert("请确认密码")
					return
				}else if(loginPwds != loginPwd){
					alert("密码不一致，请重新输入")
					return
				}

				$.ajax({
					url : "student/register.do",
					data : {
						"loginAct" : loginAct,
						"name" : name,
						"loginPwd" : loginPwd,
						"email" : email,
						"school" : school,
						"academic" : academic,
						"clazz" : clazz,

					},
					dataType : "json",
					type : "post",
					success : function (data) {
						if(data.success){
							alert("注册成功，等待老师审核后即可登录")
							$("#createRegisterModal").modal("hide");
						}else {
							alert("注册失败，请联系管理员")
						}
					}
				})


			})

		})

		function getClazz(school_id,academic_id) {
			$.ajax({
				url : "student/clazz.do",
				dataType: "json",
				data: {
					"school_id" : school_id,
					"academic_id" : academic_id
				},
				type: "get",
				success : function (data) {
					html = "<option></option>"
					$.each(data,function (i,n) {
						html += '<option id="'+n.id+'" value="'+n.clazz+'">'+ n.clazz +'</option>'
					})

					$("#register-clazz").html(html)
				}
			})
		}


		function getAcademic(id) {
			$.ajax({
				url : "student/academic.do",
				dataType: "json",
				data: {
					"id" : id
				},
				type: "get",
				success : function (data) {
					html = "<option></option>"
					$.each(data,function (i,n) {
						html += '<option id="'+n.id+'" value="'+n.academic+'">'+ n.academic +'</option>'
					})

					$("#register-academic").html(html)
				}
			})
		}
		function getSchool() {

			$("#register-clazz").html("")
			$("#register-academic").html("")
			$.ajax({
				url : "student/school.do",
				dataType: "json",
				type: "get",
				success : function (data) {
					html = "<option></option>"
					$.each(data,function (i,n) {
						html += '<option id="'+n.id+'" value="'+n.school+'">'+ n.school +'</option>'
					})

					$("#register-school").html(html)
				}
			})

		}
		function login() {
			$("#msg").html("")

			var $loginAct = $.trim($("#loginAct").val())
			var $loginPwd = $.trim($("#loginPwd").val())

			if($loginPwd == "" || $loginAct == ""){

				$("#msg").html("用户名和密码不能为空")

				return false;
			}

			$.ajax({
				url : "student/login.do",
				data : {
					"loginAct" : $loginAct,
					"loginPwd" : $loginPwd
				},
				type : "post",
				dataType : "json",
				success : function (data) {
				    if(data.success){
				        window.location.href = "workbench/index.jsp"
                    }else {
				        $("#msg").html(data.msg)
                    }
				}
			})




		}
	</script>
</head>
<body>
	<!--注册用户 -->
	<div class="modal fade" id="createRegisterModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">学生注册</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" action="#">

						<div class="form-group">

							<label for="register-name" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="register-name" required>
							</div>

							<label for="register-login" class="col-sm-2 control-label">学号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="register-login">
							</div>


						</div>

						<div class="form-group">
							<label for="register-school" class="col-sm-2 control-label">所属学校<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="register-school" required>
									<option></option>

								</select>
							</div>
							<label for="register-academic" class="col-sm-2 control-label">二级学院<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="register-academic" required>

								</select>
							</div>

						</div>

						<div class="form-group">
							<label for="register-clazz" class="col-sm-2 control-label">班级<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="register-clazz">
									<option></option>

								</select>
							</div>

							<label for="register-email" class="col-sm-2 control-label">邮箱<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="register-email">
							</div>

						</div>

						<div class="form-group">
							<label for="register-password" class="col-sm-2 control-label">密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="register-password">
							</div>
							<label for="register-passwords" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="register-passwords">
							</div>
						</div>


					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-default" id="registerBtn">注册</button>
				</div>
			</div>
		</div>
	</div>

	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="image/IMG_7114.JPG" style="width: 100%; height: 90%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">&nbsp;&nbsp;在线考试管理系统 &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;谢智猛</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.jsp" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" type="text" placeholder="学号" id="loginAct">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" type="password" placeholder="密码" id="loginPwd">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg" style="color: red"></span>
						
					</div>
					<div class="checkbox"  style="position: relative;top: 5px; bottom: 10px; left: 220px;">

						<a href="javascript:void(0);" id="show_regiest">没有账户，去注册</a>

					</div>
					<button type="button" id="submitBtn" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 25px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>