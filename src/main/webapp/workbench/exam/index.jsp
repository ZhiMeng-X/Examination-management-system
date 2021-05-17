<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html id="body">
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>
<script type="text/javascript">

	$(function(){



		TimeDown("show", 60000)

		if(confirm("是否开始考试?")){
			$.ajax({
				url : "exam/examList.do",
				dataType : "json",
				type : "get",
				success : function (data) {
					if(data.success){

						var html = ""

						$.each(data.nc,function (i,n) {

							html += '<tr class="active" align="center">'
							html += '<td> '+(i+1)+' </td>'
							html += '<td>'+n.title+'</td>'
							html += '<td><input type="radio"  name="'+n.id+'" value="A" answer ="'+n.answer+'"/> '+n.optionA+'</td>'
							html += '<td><input type="radio"  name="'+n.id+'" value="B" answer ="'+n.answer+'"/> '+n.optionB+'</td>'
							html += '<td><input type="radio"  name="'+n.id+'" value="C" answer ="'+n.answer+'"/> '+n.optionC+'</td>'
							html += '<td><input type="radio"  name="'+n.id+'" value="D" answer ="'+n.answer+'"/> '+n.optionD+'</td>'
							html += '<td name="'+n.id+'"><span class="glyphicon glyphicon-ok" name="yes" style="font-size: 20px; color: #E6E6E6;"></span>&nbsp;&nbsp;'
							html += '<span class="glyphicon glyphicon-remove" name="no" style="font-size: 20px; color: #E6E6E6;"></span></td>'
							html += '</tr>'
						})
						$("#exam").html(html);

					}else {
						alert("出题失败，请重新考试")
					}

				}
			})
            $("#body").mouseleave(function () {
                alert("请不要离开考试界面")
            })

		}else {
			document.location.href = "workbench/main/index.jsp";
		}


		$("#saveBtn").click(function () {

			if(confirm("确定提交试卷？")){

				OverExam();

			}

		})


    })

	//倒计时
	function TimeDown(id, value) {

		//倒计时的总秒数
		var totalSeconds = parseInt(value / 1000);

		//取模（余数）
		var modulo = totalSeconds % (60 * 60 * 24);
		//小时数
		var hours = Math.floor(modulo / (60 * 60));
		modulo = modulo % (60 * 60);
		//分钟
		var minutes = Math.floor(modulo / 60);
		//秒
		var seconds = modulo % 60;

		hours = hours.toString().length == 1 ? '0' + hours : hours;
		minutes = minutes.toString().length == 1 ? '0' + minutes : minutes;
		seconds = seconds.toString().length == 1 ? '0' + seconds : seconds;

		//输出到页面
		$("#time").html(hours + ":" + minutes + ":" + seconds)

		//延迟一秒执行自己
		if(hours == "00" && minutes == "00" && parseInt(seconds)-1<0){
			alert("时间到，考试结束，正在上传成绩");
			OverExam()
		}else{
			setTimeout(function () {
				TimeDown(id, value-1000);
			}, 1000)
		}

	}

	function OverExam() {

		var $xz = $("input[type=radio]:checked");
		var $qx = $("input[type=radio]");

		var result = 0;
		var flag = [];

		for (var i = 0; i < $xz.length;i++){
			flag[i] = $xz.attr("name");
			var option = $.trim($($xz[i]).val());
			var answer = $.trim($($xz[i]).attr('answer'));


			if(answer == option){
				result += 20;

				$("#exam").children("tr").children("td[name="+$($xz[i]).attr('name')+"]").children("span[name=yes]").css("color","green");
			}else {
				$("#exam").children("tr").children("td[name="+$($xz[i]).attr('name')+"]").children("span[name=no]").css("color","red");

			}

		}
		for (var i = 0; i < $qx.length; i += 4){

			for (var j=0; j<flag.length; j++){
				if($($xz[j]).attr('name') == $($qx[i]).attr('name')){
					break;
				}
			}
			if(j == flag.length){
				$("#exam").children("tr").children("td[name="+$($qx[i]).attr('name')+"]").children("span[name=no]").css("color","red");

			}
		}

		$.ajax({
			url : "exam/result.do",
			data : {
				"result" : result
			},
			dataType: "json",
			type: "post",
			success : function (data) {
				if(data.success){
					$("#res").html("成绩上传成功，你的分数为："+result+"分&nbsp;&nbsp;<a href='workbench/exam/index.jsp'><span style=\"font-size: 12px;\">点击重新考试</span></a>")
					$("#body").unbind();
					$("#saveBtn").prop("type","hidden")
				}else {
					$("#res").html("成绩上传失败，请联系管理员&nbsp;&nbsp;<a href='workbench/exam/index.jsp'><span style=\"font-size: 12px;\">点击重新考试</span></a>")
					$("#body").unbind();

				}
			}
		})

	}

	
</script>
</head >
<body >


	
	<div >
	<div>
		<div style="position: relative; left: 10px; top: -10px;" >
			<div class="page-header">
				<h3 id="res" align="center">&nbsp;考试正在进行中，请不要退出该界面<span style="margin-left: 40%" id="time"></span></h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;" >
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		


			<div style="position: relative;top: 10px;">
				<table class="table table-hover" >
					<thead>
						<tr style="color: #B3B3B3;" align="center">
							<td>题号</td>
							<td>题目</td>
                            <td>选项 A</td>
                            <td>选项 B</td>
                            <td>选项 C</td>
                            <td>选项 D</td>
                            <td>结果</td>

						</tr>
					</thead>
					<tbody id="exam">
<%--						<tr class="active" align="center">--%>
<%--							<td> 1 </td>--%>
<%--							<td></td>--%>
<%--                            <td><input type="radio" name="optionsRadios" /> A</td>--%>
<%--							<td><input type="radio" name="optionsRadios" /> C</td>--%>
<%--							<td><input type="radio" name="optionsRadios" /> D</td>--%>
<%--							<td><input type="radio" name="optionsRadios" /> D</td>--%>
<%--							<td><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span>&nbsp;&nbsp;--%>
<%--							<span class="glyphicon glyphicon-ok" style="font-size: 20px; color: #E6E6E6;"></span></td>--%>
<%--						</tr>--%>

					</tbody>
				</table>
			</div>
			

			<div class="modal-footer">

				<input type="button" class="btn btn-primary" id="saveBtn" value="交卷"></input>&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			
		</div>
		
	</div>
	</div>
</body>
</html>