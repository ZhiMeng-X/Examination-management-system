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



		pageList(1,5)

		$("#qx").click(function () {
			$("input[name=xz]").prop("checked",this.checked)
		})

		$("#exam").on("click",$("input[name=xz]"),function () {
			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length)
		})


    })


	function pageList(pageNo,pageSize){
		$.ajax({
			url : "exam/testLove.do",
			dataType : "json",
			data : {
				"id" : "${stu.id}",
				"pageNo" : pageNo,
				"pageSize" : pageSize,

			},
			type : "post",
			success : function (data) {
				if(data.success){

					var html = ""

					$.each(data.nc,function (i,n) {

						html += '<tr class="active" align="center">'
						html += '<td><input type="checkbox" id="'+n.id+'" name="xz"/></td>'
						html += '<td>'+n.title+'</td>'
						html += '<td>'+n.optionA+'</td>'
						html += '<td>'+n.optionB+'</td>'
						html += '<td>'+n.optionC+'</td>'
						html += '<td>'+n.optionD+'</td>'
						html += '<td>'+n.answer+'</td>'
						html += '<td><button type="button" onclick="deleteColl(\''+n.id+'\')" class="btn btn-danger">删除</button></td>'
						html += '</tr>'
					})
					$("#exam").html(html);
					var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;


					//数据处理完毕后，结合分页查询，对前端展现分页信息
					$("#testPage").bs_pagination({
						currentPage: pageNo, // 页码
						rowsPerPage: pageSize, // 每页显示的记录条数
						maxRowsPerPage: 20, // 每页最多显示的记录条数
						totalPages: totalPages, // 总页数
						totalRows: data.total, // 总记录条数

						visiblePageLinks: 3, // 显示几个卡片

						showGoToPage: true,
						showRowsPerPage: true,
						showRowsInfo: true,
						showRowsDefaultInfo: true,

						//该回调函数时在，点击分页组件的时候触发的
						onChangePage : function(event, data){
							pageList(data.currentPage , data.rowsPerPage);
						}
					});

				}else {
					alert("查询失败，请联系管理员")
				}

			}
		})
	}

	function deleteColl(id) {

		if(confirm("是否删除该数据？")){
			$.ajax({
				url : "exam/deleteColl.do",
				dataType : "json",
				data : {
					"NetChoose_id" : id,
					"student_id" : "${stu.id}"
				},
				type : "post",
				success : function (data) {
					if (data.success){
						pageList(1,5)
						alert("删除成功")
					}else {
						alert("删除失败，请联系管理员")
					}
				}

			})
		}

    }


	
</script>
</head >
<body >


	
	<div >
	<div>
		<div style="position: relative; left: 10px; top: -10px;" >
			<div class="page-header">
				<h3 id="res" align="center">&nbsp;我的收藏</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;" >
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">


			<div style="position: relative;top: 10px;">
				<table class="table table-hover" >
					<thead>
						<tr style="color: #B3B3B3;" align="center">
							<td><input type="checkbox" id="qx"/></td>
							<td>题目</td>
							<td>选项 A</td>
							<td>选项 B</td>
							<td>选项 C</td>
							<td>选项 D</td>
							<td>答案</td>
							<td>操作</td>

						</tr>
					</thead>
					<tbody id="exam">

					</tbody>
				</table>
			</div>

			<div style="height: 50px; position: relative;top: 30px;">

				<div id="testPage">

				</div>
			</div>
		</div>
		
	</div>
	</div>
</body>
</html>