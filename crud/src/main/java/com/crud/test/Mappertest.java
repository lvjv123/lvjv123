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
 * 	����dao��Ĺ���
 * @author Lenovo
 * �Ƽ�spring����Ŀ����ʹ��spring�ĵ�Ԫ���ԣ������Զ�ע����������Ҫ�����
 * 1.����SpringTestģ��
 * 2.@contextconfigurationָ��spring�����ļ���λ��
 * 3.ֱ��autowiredҪʹ�õ��������
 */


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"classpath:applicationContext.xml"})
public class Mappertest {
	/**
	 * ����Departmentmapper
	 */
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;
	
	
	@Test
	public void testCRUD() {
	/*	//1.����springioc����
		ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
		//2.�������л�ȡmapper
		DepartmentMapper bean =ioc.getBean(DepartmentMapper.class);*/
		System.out.println(departmentMapper);
		//1.���뼸������
		//departmentMapper.insertSelective(new Department(1,"������"));
		//departmentMapper.insertSelective(new Department(2,"���Բ�"));
		//2.����Ա�����ݣ�����Ա������
		//employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
		//3.����������Ա��;������ʹ�ÿ���ִ������������sqlSession
		//ֱ��for������������
		/*for(){
			employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
		}*/
		//ִ����������
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++)
		{
			String uid=UUID.randomUUID().toString().substring(0,5)+""+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@qq.com",1));
		}
	}
}