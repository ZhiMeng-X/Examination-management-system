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





		if(confirm("是否开始练习?")){
			pageList(1,5)

		}else {
			document.location.href = "workbench/main/index.jsp";
		}



    })

	function pageList(pageNo,pageSize){
		$.ajax({
			url : "exam/testList.do",
			dataType : "json",
			data : {
				"pageNo" : pageNo,
				"pageSize" : pageSize,
			},
			type : "post",
			success : function (data) {
				if(data.success){

					var html = ""

					$.each(data.nc,function (i,n) {

						html += '<tr class="active" align="center">'
						if(n.isCollection == 1){
							html += '<td><span id="'+n.id+'" isCollection="'+n.isCollection+'" class="glyphicon glyphicon-heart-empty" onclick="sc(\''+n.id+'\')"   style="font-size: 20px; color:red"></span></td>';

						}else {
							html += '<td><span id="'+n.id+'" isCollection="'+n.isCollection+'" class="glyphicon glyphicon-heart-empty" onclick="sc(\''+n.id+'\')"  style="font-size: 20px; "></span></td>';

						}
						html += '<td>'+n.title+'</td>'
						html += '<td align="left"><input type="radio" onclick="xz(\''+n.id+'\')"  name="'+n.id+'" value="A" answer ="'+n.answer+'"/> '+n.optionA+'</td>'
						html += '<td align="left"><input type="radio" onclick="xz(\''+n.id+'\')" name="'+n.id+'" value="B" answer ="'+n.answer+'"/> '+n.optionB+'</td>'
						html += '<td align="left"><input type="radio" onclick="xz(\''+n.id+'\')" name="'+n.id+'" value="C" answer ="'+n.answer+'"/> '+n.optionC+'</td>'
						html += '<td align="left"><input type="radio" onclick="xz(\''+n.id+'\')" name="'+n.id+'" value="D" answer ="'+n.answer+'"/> '+n.optionD+'</td>'
						html += '<td name="'+n.id+'"><span class="glyphicon glyphicon-ok" name="yes" style="font-size: 20px; color: #E6E6E6;"></span>&nbsp;&nbsp;'
						html += '<span class="glyphicon glyphicon-remove" name="no" style="font-size: 20px; color: #E6E6E6;"></span>&nbsp;&nbsp;<span class="glyphicon glyphicon-question-sign" id="an_'+n.id+'"  style="font-size: 20px; color: #E6E6E6;"></span></td>'
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
					alert("出题失败，请重新开始")
				}

			}
		})
	}
	function xz(id) {
		var $xz = $("input[name="+id+"]:checked");
		if($.trim($xz.val()) == $.trim($xz.attr("answer"))){
			$("#an_"+id).html("")
			$("#an_"+id).prop("class","glyphicon glyphicon-question-sign")
			$("#an_"+id).css("color","#E6E6E6")
			$("#exam").children("tr").children("td[name="+id+"]").children("span[name=yes]").css("color","green");
			$("#exam").children("tr").children("td[name="+id+"]").children("span[name=no]").css("color","#E6E6E6");

		}else {
			$("#an_"+id).html($.trim($xz.attr("answer")))
			$("#an_"+id).prop("class","")
			$("#an_"+id).css("color","green")
			$("#exam").children("tr").children("td[name="+id+"]").children("span[name=yes]").css("color","#E6E6E6");
			$("#exam").children("tr").children("td[name="+id+"]").children("span[name=no]").css("color","red");

		}

	}

	function sc(id) {
		var isCollection = $("#"+id).attr("isCollection")

		if(isCollection == 1){
			$("#"+id).css("color","")
			collection(id,isCollection)
			$("#"+id).attr("isCollection","0")

		}else {
			$("#"+id).css("color","red")
			$("#"+id).attr("isCollection","1")
			collection(id,isCollection)

		}

	}
	function collection(id,isCollection) {
		$.ajax({
			url : "exam/isCollection.do",
			data : {
				"id" : id,
				"isCollection" : isCollection,
			},
			dataType : "json",
			type : "post",
			success : function (data) {
				if(data.success){
					if(isCollection == 1){
						alert("取消收藏")
					}else {
						alert("收藏成功")
					}
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
				<h3 id="res" align="center">&nbsp;练习正在进行中，请不要退出该界面</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;" >
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		


			<div style="position: relative;top: 10px;">
				<table class="table table-hover" >
					<thead>
						<tr style="color: #B3B3B3;" align="center">
							<td>收藏</td>
							<td>题目</td>
                            <td>选项 A</td>
                            <td>选项 B</td>
                            <td>选项 C</td>
                            <td>选项 D</td>
                            <td>结果</td>

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