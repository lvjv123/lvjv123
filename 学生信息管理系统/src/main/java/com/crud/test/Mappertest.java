package com.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;

/**
 * 	测试dao层的工作
 * @author Lenovo
 * 推荐spring的项目可以使用spring的单元测试，可以自动注入我们所需要的组件
 * 1.导入SpringTest模块
 * 2.@contextconfiguration指定spring配置文件的位置
 * 3.直接autowired要使用的组件即可
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class Mappertest {
	/**
	 * 测试Departmentmapper
	 */
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	
	@Test
	public void testCRUD() {
	/*	//1.创建springioc容器
		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.从容器中获取mapper
		DepartmentMapper bean =ioc.getBean(DepartmentMapper.class);*/
		System.out.println(departmentMapper);
		//1.插入几个部门
		//departmentMapper.insertSelective(new Department(1,"开发部"));
		//departmentMapper.insertSelective(new Department(2,"测试部"));
		//2.生成员工数据，测试员工插入
		//employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
		//3.批量插入多个员工;批量，使用可以执行批量操作的sqlSession
		//直接for不是批量操作
		/*for(){
			employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
		}*/
		//执行批量操作
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++)
		{
			String uid=UUID.randomUUID().toString().substring(0,5)+""+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
		}
	}
}
