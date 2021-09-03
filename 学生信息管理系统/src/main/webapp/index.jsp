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
<script src="https://cdn.jsdelivr.net/npm/jquery@1.12.4/dist/jquery.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>
</head>
<body>
	<!-- 员工修改的模态框 -->
		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  			<div class="modal-dialog" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        				<h4 class="modal-title" id="myModalLabel">员工修改</h4>
      	</div>
			  <div class="modal-body">
			      <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <p class="form-control-static" id="empName_update_static"></p>
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="23123@qq.com">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      <!-- 部门提交部门id即可 -->
			      <select class="form-control" name="dId" id="dept_add_select">
				  </select>
			    </div>
			  </div>
			  
			  
			 </form>
			 </div>
			 
			  

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>
	<!-- 员工添加的模态框 -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  			<div class="modal-dialog" role="document">
    			<div class="modal-content">
      				<div class="modal-header">
        				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        				<h4 class="modal-title">员工增加</h4>
      	</div>
			  <div class="modal-body">
			      <form class="form-horizontal">
			  <div class="form-group">
			    <label class="col-sm-2 control-label">empName</label>
			    <div class="col-sm-10">
			      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">email</label>
			    <div class="col-sm-10">
			      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="23123@qq.com">
			      <span id="helpBlock2" class="help-block"></span>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">gender</label>
			    <div class="col-sm-10">
			      <label class="radio-inline">
					<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
					</label>
					<label class="radio-inline">
					  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
					</label>
			    </div>
			  </div>
			  <div class="form-group">
			    <label  class="col-sm-2 control-label">deptName</label>
			    <div class="col-sm-4">
			      <!-- 部门提交部门id即可 -->
			      <select class="form-control" name="dId" id="dept_add_select">
				  </select>
			    </div>
			  </div>
			  
			  
			 </form>
			 </div>
			 
			  

      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_sava_btn">保存</button>
      </div>
    </div>
  </div>
</div>
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
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		<!-- 显式表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
				<thead> 
				<tr>
					<th>
						<input type="checkbox" id="check_all"/>
					</th>
					<th>#</th>
					<th>empName</th>
					<th>email</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				</thead>
				<tbody>
				
				</tbody>
				</table>
			</div>
		</div>
		<!-- 显式分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
			</div>
		</div> 
		</div>
		<script type="text/javascript">
		
		var totalaRecord,currentNum;
		//1.页面加载完成以后，直接发送一个ajax请求，到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
		
		function to_page(pn){
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);
					//1.解析并显式员工数据
					build_emps_tables(result);
					//2解析并显式分页数据
					build_page_info(result);
					//3.解析显式分页条数据
					build_emps_nav(result)
				}
			});
		}
		
		function build_emps_tables(result){
			//清空table表格
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps,function(index,item){
				//1.网页提醒
				//alert(item.empName);
				//2.显式
				var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=item.gender=="M"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				var editBtn=$("<button></butto>").addClass("btn btn-primary btn-sm edit_btn")
							.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				var delBtn=$("<button></butto>").addClass("btn btn-danger btn-sm delete_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//为删除按钮添加一个自定义的属性来表示当前删除的员工id
				delBtn.attr("del-id",item.empId);
				var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>")
					.append(checkBoxTd)	
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd) 
					.appendTo("#emps_table tbody");
			})
		}
		//解析显式分页信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
					result.extend.pageInfo.pages+"页,总"+
					result.extend.pageInfo.total+"条记录");
			totalRecord=result.extend.pageInfo.total;
			currentNum=result.extend.pageInfo.pageNum;
			
		}
		//解析显式分页条,点击分页能去下一页
		function build_emps_nav(result){
			//$("#page_nav_area")
			$("#page_nav_area").empty();
			var ul=$("<ul></ul>").addClass("pagination");
			var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePageli=$("<li></li>").append($("<a></a>").append("&laquo;"));
			if(result.extend.pageInfo.hasPreviousPage==false){
				firstPageLi.addClass("disabled");
				prePageli.addClass("disabled");
			}
			else{
				//为元素添加点击翻页的事件
				firstPageLi.click(function(){
					to_page(1);
				})
				prePageli.click(function(){
					to_page(result.extend.pageInfo.pageNum-1)
				})
			}
			
			
			var nextPageli=$("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageli=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			if(result.extend.pageInfo.hasNextPage==false){
				nextPageli.addClass("disabled");
				lastPageli.addClass("disabled");
			}
			else{
				//为元素添加点击翻页的事件
				lastPageli.click(function(){
					to_page(result.extend.pageInfo.pages);
				})
				nextPageli.click(function(){
					to_page(result.extend.pageInfo.pageNum+1)
				})
			}
			//添加首页和前一页
			ul.append(firstPageLi).append(prePageli);
			//1,2,3遍历给ul中添加页码提示
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){	
					var numLi=$("<li></li>").append($("<a></a>").append(item));
					if(result.extend.pageInfo.pageNum==item){
						numLi.addClass("active");
					}
					numLi.click(function(){
						to_page(item);
					});
					ul.append(numLi)
			});
			//添加下一页和末页的提示
			ul.append(nextPageli).append(lastPageli);
			//把ul加入nav中
			var navEle=$("<nav></nav>").append(ul)
			navEle.appendTo("#page_nav_area")
		}
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据(表单完整重置(表单的数据和样式))
			reset_form("#empAddModal form");
			//清除表单数据
			//$("#empAddModal form")[0].reset();
			//发送ajax请求，查出部门信息，显式在下拉列表
			//弹出模态框
			getDepts("#empAddModal select");
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		//查出所有的部门信息，并显式在部门列表中
		function getDepts(ele)
		{
			//清空之前下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//控制台打印
					//console.log(result)
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//校验表单数据
		function validate_add_form(){
			//1.拿到要校验的数据，使用正则表达式
			var empName=$("#empName_add_input").val();
			var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","用户名可以是2-5位中午或者6-16位英文和数字的组合");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","")
			}
			//2.校验邮箱
			var email=$("#email_add_input").val();
			var regemail=/^([a-z0-9\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if(!regemail.test(email)){
				show_validate_msg("#email_add_input","error","请输入正确的邮箱格式");
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","")
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			//清楚当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error")
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg)
			}else if("error"==status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg)
			}
		}
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName=this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_sava_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_sava_btn").attr("ajax-va","error");	
					}
				}
			});
		});
		
		$("#emp_sava_btn").click(function(){
			//1.模拟框中填写的表单数据提交给服务器进行保存
			//3.发送ajax请求保存员工
			//alert($("#empAddModal form").serialize());
			//2.先对要提交给服务器的数据进行校验
			if(!validate_add_form()){
				return false;
			}
			//1.判断之前的ajax校验是成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			$.ajax({
			 	url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg)
					if(result.code==100){
					//员工保存成功；
					//1.关闭模态框
					$('#empAddModal').modal('hide')
					//来到最后一页，显式刚才保存的数据
					//发送ajax请求返回最后一页
					to_page(totalRecord);
				}
					else{
						//console.log(result);
						//有哪个字段的错误信息就显示那个字段
						if(undefined !=result.extend.errorFields.email)
						{
							//显示邮箱的错误信息
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined !=result.extend.errorFields.empName){
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.email);
						}
						//alert(result.extend.errorFields.email);
						//alert(result.extend.errorFields.empName);
					}
				}
			});  
		});

		//1.我们是按钮创建之前就绑定了click，所以绑定不上
		//1)可以在创建按钮的时候绑定
		//2.绑定点击。live() 但是jQuery新版本没有live方法，所有可以用on方法
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			//0、查出员工信息，并显式员工信息
			//1.查出部门信息，并显式部门列表
			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit-id"));
			//把员工id传递给模态框的更新按钮
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
			
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData=result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
					
				}
			});
		}
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function(){
			//校验邮箱是否合法
			var email=$("#email_update_input").val();
			var regemail=/^([a-z0-9\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/
			if(!regemail.test(email)){
				show_validate_msg("#email_add_input","error","请输入正确的邮箱格式");
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","")
			}
			//发送ajax请求更新员工数据 
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				type:"PUT",
				//(此方法可以成功，比较麻烦)
				//type:"POST"
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT"
				//若想用put请求成功，应在web.xml中添加一些过滤器
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					//关闭模态框
					$("#empUpdateModal").modal("hide");
					//回到本页面
					to_page(currentNum);
				}
			});
		});
		//单个删除
		$(document).on("click",".delete_btn",function(){
			//1.弹出是否删除对话框
			var empName =$(this).parents("tr").find("td:eq(2)").text();
			var empId=$(this).attr("del-id");
			//alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("确认删除 ["+empName+"]吗? ")){
				//确认发送ajax请求删除即可 
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentNum);
					}
				}); 
			}
		});
		//完成全选/全不选的功能
		$("#check_all").click(function(){
			//attr获取checked是undefined
			//我们这些dom原生的属性最好用prop取值  ，attr获取自定的值
			$(".check_item").prop("checked",$(this).prop("checked")); 
		});
		
		
		$(document).on("click",".check_item",function(){
			var flag= $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		//点击全部删除，就批量删除
		$("#emp_delete_all_btn").click(function(){
			var empNames="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
				});
			//取出empNames多余的逗号
			empNames = empNames.substring(0,empNames.length-1);
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除 ["+empNames+"]吗? ")){
				//发送ajax请求
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentNum);
					}});
			}
		});
		</script>
</body>
</html>