package com.crud.controller;

import static org.junit.Assert.assertNotNull;

import java.security.spec.MGF1ParameterSpec;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Binding;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jmx.export.naming.IdentityNamingStrategy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.EmployeeSevice;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 处理员工crud请求
 * @author Lenovo
 *
 */	
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeSevice employeeSevice;
	
	/**
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * @param id
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deletebyId(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids=ids.split("-");
			//组装id的list
			for(String string:str_ids)
			{
				del_ids.add(Integer.parseInt(string));
			}
			employeeSevice.deleteBatch(del_ids);
			return Msg.success();
		}else {
			Integer id=Integer.parseInt(ids);
			employeeSevice.deleteEmp(id);
			return Msg.success();
		}
	}
	
	
	/**
	 *  
	 * 如果直接发送ajax=put请求
	 * ：Employee [empId=1008, empName=null, gender=null, email=null, dId=null]
	 * 问题：
	 * 请求体中有数据
	 * 员工更新方法
	 * 但是employee对象封装不上
	 * 原因：
	 * tomcat将请求中的数据，封装一个map。
	 * request.getParameter("empName")就会从map中取值
	 * springMvc封装pojo对象的时候
	 * 			会把pojo中每个属性的值request.getParameter("email")
	 * AJAX发送PUT请求引发的血案：
	 * 		PUT请求，请求中的数据request.getParameter("empName")拿不到
	 * 		tomcat一看是put请求不会封装请求体中的数据为map，只有post才封装请求体为map
	 * org.apache.catalina.connector.Request--parseParameters()(3111行的方法）
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee, HttpServletRequest request) {
		System.out.println("请求体中的值"+request.getParameter("email"));
		//请求体中的值null
		System.out.println("要跟新的员工数据："+employee.toString());
		//要跟新的员工数据：Employee [empId=1008, empName=null, gender=null, email=null, dId=null]
		employeeSevice.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * 根据id查询员工
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee=employeeSevice.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	/**
	 * 检查用户名是否可用
	 *   
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否是合法的表达式；
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名必须是6-16位英文和数字的组合或者2-5位中午");
		};
		//数据库用户名重复校验
		boolean b=employeeSevice.checkUser(empName);
		if(b) {
			return Msg.success();
		}
		else {
			return Msg.fail().add("va_msg","用户名不可用");
		}
	}
	
	/**
	 * 员工保存
	 * 1.支持jsr303校验
	 * 2.导入hibernate-validatord
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if (result.hasErrors()) {
			//校验失败，应该返回失败，在模拟框中显示校验失败的错误信息
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors=result.getFieldErrors();
			for(FieldError fieldError:errors)
			{
				System.out.println("错误的字段名"+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeSevice.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * 查询员工数据（分页查询）
	 *   
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		//在查询之前只需要调用,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		//startpage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps=employeeSevice.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageinfo交给页面就行了
		//pageInfo封装了详细的分页信息，包括有我们查询出来的数据  传入连续显式的页数
		PageInfo page = new PageInfo(emps,5); 
		return Msg.success().add("pageInfo",page);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) {
		//这不是一个分页查询
		//引入PageHelper分页插件
		//引入pagehelper插件
		//在查询之前只需要调用,传入页码，以及每页的大小
		PageHelper.startPage(pn, 5);
		//startpage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps=employeeSevice.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageinfo交给页面就行了
		//pageInfo封装了详细的分页信息，包括有我们查询出来的数据  传入连续显式的页数
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
