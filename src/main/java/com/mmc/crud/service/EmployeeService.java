package com.mmc.crud.service;

import com.mmc.crud.bean.Employee;
import com.mmc.crud.bean.EmployeeExample;
import com.mmc.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: hui
 * Date: 2018-06-02
 * Content:
 */
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     *
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }


    /**
     * 员工保存
     *
     * @return
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * 校验用户名是否可用
     *
     * @param empName
     * @return true,代表当前姓名可用
     */
    public boolean checkUser(String empName) {
        System.out.println(empName);
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
     * 按照id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee  = employeeMapper.selectByPrimaryKey(id);
        System.out.println(employee);
        return employee;
    }

    /**
     * 员工更新
     * @param employee
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 员工删除
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample employee = new EmployeeExample();
        EmployeeExample.Criteria criteria = employee.createCriteria();
        //delete from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employee);
    }
}
