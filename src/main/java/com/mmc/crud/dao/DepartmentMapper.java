package com.mmc.crud.dao;

import com.mmc.crud.bean.Department;
import com.mmc.crud.bean.DepartmentExample;

import java.util.List;

import com.mmc.crud.bean.Employee;
import org.apache.ibatis.annotations.Param;

public interface DepartmentMapper {
    long countByExample(DepartmentExample example);

    int deleteByExample(DepartmentExample example);

    int insert(Department record);

    int insertSelective(Department record);

    List<Department> selectByExample(DepartmentExample example);

    int updateByExampleSelective(@Param("record") Department record, @Param("example") DepartmentExample example);


    int updateByExample(@Param("record") Department record, @Param("example") DepartmentExample example);
}