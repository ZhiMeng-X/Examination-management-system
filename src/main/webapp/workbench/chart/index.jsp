<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2021/3/20
  Time: 9:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="echarts/echarts.min.js"></script>
    <script type="text/javascript">

        $(function () {



            $.ajax({
                url : "exam/examscore.do",
                dataType : "json",
                data : {
                    "id" : "${stu.id}"

                },
                type : "post",
                success : function (data) {
                    var myChart = echarts.init(document.getElementById('main'));
                    var time = []
                    var score = []
                    if(data.success){
                        $.each(data.score,function (i,n) {

                            time[i] = (n.createTime).substr(0,10)
                            score[i] = n.score

                        })

                        option = {
                            xAxis: {
                                type: 'category',
                                data: time
                            },
                            yAxis: {
                                type: 'value'
                            },
                            series: [{
                                data: score,
                                type: 'line',
                                symbol: 'triangle',
                                symbolSize: 15,
                                lineStyle: {
                                    color: 'green',
                                    width: 4,
                                    type: 'dashed'
                                },
                                itemStyle: {
                                    borderWidth: 1,
                                    borderColor: 'yellow',
                                    color: 'blue'
                                }
                            }]
                        };

                        myChart.setOption(option);
                    }else {
                        alert("数据调取失败，请联系管理员")
                    }
                }
            })







        })


    </script>
</head>
<body>
<div id="main" align="center"  style="width: 600px;height:400px; padding-top: 5%;padding-left: 20%"></div>
</body>
</html>
