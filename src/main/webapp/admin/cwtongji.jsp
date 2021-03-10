<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.text.*"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="law.jsp"%>
<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>后台用户信息</title>
	<script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js" type="text/javascript"></script>
	 <link href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	 <link href="${pageContext.request.contextPath}/webui/bstable/bootstrap-table.css" rel="stylesheet" type="text/css"/>
	 <link href="${pageContext.request.contextPath}/admin/css/table1.css" rel="stylesheet" type="text/css"/>
	 <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>
	 <script src="${pageContext.request.contextPath}/webui/echarts/echarts-all.js"></script>
	 <script src="${pageContext.request.contextPath}/webui/echarts/echart-plus.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/vue-2.4.0.js"></script>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/webui/vue/axios.min.js"></script>

 </head>
<body >

	<div id="app">
		<div class="search-title">
			<h2>公告统计</h2>


		</div>


		<div style="width:100%;" class="charts">
			<p class="charts_p">阅读人数</p>
			<div id="divClickStat" style="height:250px;width: 100%"></div>
			<div style="width: 100%;margin-top: 0px">
				<table class="annyTable" border="1">
					<tr>
						<td style="text-align: left;padding: 12px 50px" colspan="3">
							<a  href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=exportstat" class="orange-href">导出</a>
						</td>
					</tr>
					<tr>
						<td class="first_td">名称</td>
						<td>已阅读人数(人)</td>
						<td>未阅读人数(人)</td>

					</tr>


					<tr v-for="item in listClickStat">
						<td class="first_td">{{item.name}}</td>
						<td>
							<a :href="'${pageContext.request.contextPath}/admin/coursewaredetails.jsp?id='+item.id" v-if="item.value>0">{{item.value}}</a>
							<span  v-if="item.value<=0">{{item.value}}</span>
							人
						</td>
						<td><a :href="'${pageContext.request.contextPath}/admin/coursewaredetails.jsp?id='+item.id" v-if="item.notread>0">{{item.notread}}</a>
							<span  v-if="item.notread<=0">{{item.notread}}</span>
							人</td>
					</tr>


				</table>
			</div>

		</div>

	</div>

</body>
</html>
<script type="text/javascript">

	let vm=new Vue({
		el:"#app",
		data:{
			listClickStat:[]

		},
		created(){
			this.getClickStat();
		},
		methods:{

			getClickStat(){
				let url="${pageContext.request.contextPath}/admin/courseware/readstat";
				axios.post(url).then(res=>{
							console.log(res.data);
							this.listClickStat=res.data.data;
							echartPlus.echartBar({
								data:this.listClickStat,
								dom:document.querySelector("#divClickStat"),
								title:"阅读人数"
							});
						});

			}

		}//end methods

	});


</script>
