package com.daowen.service;
import org.springframework.stereotype.Service;
import com.daowen.mapper.StudentMapper;
import com.daowen.ssm.simplecrud.SimpleBizservice;
@Service
public class StudentService extends SimpleBizservice<StudentMapper>{

    public  int  getStudentCount(){
        return getRecordCount("");

    }


}
