package com.daowen.mapper;
import com.daowen.entity.Courseware;
import com.daowen.entity.Student;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CoursewareMapper extends SimpleMapper<Courseware> {


       List<Courseware> getReaded(Map map);
       List<Courseware> getUnread(Map map);

       List<Student> getReadedStudent(Map map);
       List<Student> getUnreadStudent(Map map);

       void updateCheckTime(@Param("id") int id);

}
