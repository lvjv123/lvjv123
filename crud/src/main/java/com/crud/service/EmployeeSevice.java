package com.crud.service;

import java.util.List;

import org.aspectj.weaver.patterns.ExactAnnotationFieldTypePattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.DepartmentExample.Criteria;
import com.crud.bean.Employee;
import com.crud.bean.EmployeeExample;
import com.crud.dao.EmployeeMapper;

import net.sf.jsqlparser.statement.create.function.CreateFunction;

@Service
public class EmployeeSevice {
	@Autowired
	EmployeeMapper employeeMapper;
	
	/**
	 * 查询员工数据
	 * @return
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub 
		return employeeMapper.selectByExampleWithDept(null);
	}
	//保存员工数据方法
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insert(employee);
	}
	
	/**
	 * 检验用户名是否可用
	 * @param empName
	 * @return true count==0可用
	 */
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		com.crud.bean.EmployeeExample.Criteria criteria=example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count=employeeMapper.countByExample(example);
		return count==0;
	}
	/**
	 * 按照员工id查询员工
	 * @param integer
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee=employeeMapper.selectByPrimaryKeyWithDept(id);
		return employee;
	}
	/**
	 * 员工更新
	 * @param employee
	 */

	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	public void deleteEmp(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example=new EmployeeExample();
		com.crud.bean.EmployeeExample.Criteria criteria=example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
