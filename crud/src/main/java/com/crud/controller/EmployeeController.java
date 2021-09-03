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
 * ����Ա��crud����
 * @author Lenovo
 *
 */	
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeSevice employeeSevice;
	
	/**
	 * ������������һ
	 * ����ɾ����1-2-3
	 * @param id
	 * @return
	 */
	
	@ResponseBody
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	public Msg deletebyId(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids=new ArrayList<Integer>();
			String[] str_ids=ids.split("-");
			//��װid��list
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
	 * ���ֱ�ӷ���ajax=put����
	 * ��Employee [empId=1008, empName=null, gender=null, email=null, dId=null]
	 * ���⣺
	 * ��������������
	 * Ա�����·���
	 * ����employee�����װ����
	 * ԭ��
	 * tomcat�������е����ݣ���װһ��map��
	 * request.getParameter("empName")�ͻ��map��ȡֵ
	 * springMvc��װpojo�����ʱ��
	 * 			���pojo��ÿ�����Ե�ֵrequest.getParameter("email")
	 * AJAX����PUT����������Ѫ����
	 * 		PUT���������е�����request.getParameter("empName")�ò���
	 * 		tomcatһ����put���󲻻��װ�������е�����Ϊmap��ֻ��post�ŷ�װ������Ϊmap
	 * org.apache.catalina.connector.Request--parseParameters()(3111�еķ�����
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee, HttpServletRequest request) {
		System.out.println("�������е�ֵ"+request.getParameter("email"));
		//�������е�ֵnull
		System.out.println("Ҫ���µ�Ա�����ݣ�"+employee.toString());
		//Ҫ���µ�Ա�����ݣ�Employee [empId=1008, empName=null, gender=null, email=null, dId=null]
		employeeSevice.updateEmp(employee);
		return Msg.success();
	}
	/**
	 * ����id��ѯԱ��
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
	 * ����û����Ƿ����
	 *   
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName")String empName){
		//���ж��û����Ƿ��ǺϷ��ı��ʽ��
		String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "�û���������6-16λӢ�ĺ����ֵ���ϻ���2-5λ����");
		};
		//���ݿ��û����ظ�У��
		boolean b=employeeSevice.checkUser(empName);
		if(b) {
			return Msg.success();
		}
		else {
			return Msg.fail().add("va_msg","�û���������");
		}
	}
	
	/**
	 * Ա������
	 * 1.֧��jsr303У��
	 * 2.����hibernate-validatord
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result){
		if (result.hasErrors()) {
			//У��ʧ�ܣ�Ӧ�÷���ʧ�ܣ���ģ�������ʾУ��ʧ�ܵĴ�����Ϣ
			Map<String, Object> map=new HashMap<String, Object>();
			List<FieldError> errors=result.getFieldErrors();
			for(FieldError fieldError:errors)
			{
				System.out.println("������ֶ���"+fieldError.getField());
				System.out.println("������Ϣ��"+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeSevice.saveEmp(employee);
			return Msg.success();
		}
	}
	
	/**
	 * ��ѯԱ�����ݣ���ҳ��ѯ��
	 *   
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		//�ڲ�ѯ֮ǰֻ��Ҫ����,����ҳ�룬�Լ�ÿҳ�Ĵ�С
		PageHelper.startPage(pn, 5);
		//startpage��������������ѯ����һ����ҳ��ѯ
		List<Employee> emps=employeeSevice.getAll();
		//ʹ��pageInfo��װ��ѯ��Ľ����ֻ��Ҫ��pageinfo����ҳ�������
		//pageInfo��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ����������  ����������ʽ��ҳ��
		PageInfo page = new PageInfo(emps,5); 
		return Msg.success().add("pageInfo",page);
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,
			Model model) {
		//�ⲻ��һ����ҳ��ѯ
		//����PageHelper��ҳ���
		//����pagehelper���
		//�ڲ�ѯ֮ǰֻ��Ҫ����,����ҳ�룬�Լ�ÿҳ�Ĵ�С
		PageHelper.startPage(pn, 5);
		//startpage��������������ѯ����һ����ҳ��ѯ
		List<Employee> emps=employeeSevice.getAll();
		//ʹ��pageInfo��װ��ѯ��Ľ����ֻ��Ҫ��pageinfo����ҳ�������
		//pageInfo��װ����ϸ�ķ�ҳ��Ϣ�����������ǲ�ѯ����������  ����������ʽ��ҳ��
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
