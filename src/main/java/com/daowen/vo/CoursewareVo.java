package com.daowen.vo;

import com.daowen.entity.Courseware;
import com.daowen.entity.Student;

import java.util.List;

public class CoursewareVo extends Courseware {


    private List<Student> readeds;

    private List<Student> unreads;


    public List<Student> getReadeds() {
        return readeds;
    }

    public void setReadeds(List<Student> readeds) {
        this.readeds = readeds;
    }

    public List<Student> getUnreads() {
        return unreads;
    }

    public void setUnreads(List<Student> unreads) {
        this.unreads = unreads;
    }
}
