<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!-- 引入标签库 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">
<!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
<!-- web路径
	不以‘/’开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
	以‘/’开始的相对路径，找资源，以服务局的路径为基准（http://localhost:3306"）
 -->

</head>
<body>
	<!--  搭建显式页面-->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row"></div>
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		<!-- 显式表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
				<tr>
					<th>#</th>
					<th>empName</th>
					<th>email</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				<c:forEach items="${pageInfo.list}" var="emp">
				<tr>
					<th>${emp.empId }</th>
					<th>${emp.empName }</th>
					<th>${emp.gender=="M"?"男":"女"}</th>
					<th>${emp.email }</th>
					<th>${emp.department.deptName} </th>
					<th>
						<button class="btn btn-primary btn-sm">
						<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
						编辑
						</button>
						<button class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
						删除</button>
					</th>
				</tr>
				</c:forEach>
				</table>
			</div>
		</div>
		<!-- 显式分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6">
				当前${pageInfo.pageNum }页，总${pageInfo.pages }页，总${pageInfo.total }条记录
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  <li><a href="${APP_PATH }/emps?pn=1">首页</a>
					  <c:if test="${pageInfo.hasPreviousPage }">
						  <li>
						      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum-1 }" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
					  </c:if>
					  </li>
					    
					    <c:forEach items="${pageInfo.navigatepageNums }" var="page_Num">
					    	<c:if test="${page_Num == pageInfo.pageNum }">
					    		<li class="active"><a href="#">${page_Num } </a></li>
					    	</c:if>
					    	<c:if test="${page_Num != pageInfo.pageNum}">
					    		<li><a href="${APP_PATH }/emps?pn=${page_Num }">${page_Num } </a></li>
					    	</c:if>
					    </c:forEach>
					    <c:if test="${pageInfo.hasNextPage }">
					    <li>
					      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum+1 }" aria-label="Next">
					        <span aria-hidden="true">&raquo;</span>
					      </a>
					    </li>
					    </c:if>
					    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages } ">末页</a></li>
					  </ul>
					 </nav>
			</div>
		</div>
		</div>
</body>
</html>