package com.mmc.crud.test;


import com.mmc.crud.bean.Department;
import com.mmc.crud.bean.Employee;
import com.mmc.crud.dao.DepartmentMapper;
import com.mmc.crud.dao.EmployeeMapper;
import org.junit.Test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.UUID;

/**
 * Created with IntelliJ IDEA.
 * User: hui
 * Date: 2018-06-02
 * Content:
 */

public class MapperTest {
    @Test
    public void testCRUD() {
        ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//        DepartmentMapper departmentMapper = ioc.getBean(DepartmentMapper.class);
        EmployeeMapper employeeMapper = ioc.getBean(EmployeeMapper.class);
        Employee employee = employeeMapper.selectByPrimaryKey(25);
        System.out.println(employee.getDepartment());

        //1.插入几个部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //2.生成员工数据
//        employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@qq.com",1));
        //3.批量插入多个员工
        for (int i = 0; i < 100; i++) {
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            employeeMapper.insertSelective(new Employee(null, uid, "M", uid+"@qq.com", 1));
        }
    }
}
