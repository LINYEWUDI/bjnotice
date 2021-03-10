package com.daowen.service;
import com.daowen.entity.Courseware;
import com.daowen.entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.daowen.mapper.CoursewareMapper;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CoursewareService extends SimpleBizservice<CoursewareMapper>{

    @Autowired
    private CoursewareMapper coursewareMapper;
    public List<Courseware> getUnread(Map map){

        return coursewareMapper.getUnread(map);
    }

    public List<Student> getReadedStudent(Map map){
        return coursewareMapper.getReadedStudent(map);
    }

    public List<Student> getUnreadStudent(Map map){
        return coursewareMapper.getUnreadStudent(map);
    }

    public List<Courseware> getReaded(Map map){

        return coursewareMapper.getReaded(map);
    }

    public void updateCheckTime(int id){
        coursewareMapper.updateCheckTime(id);
    }


}
