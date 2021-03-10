package com.daowen.entity;

import java.util.Date;

import javax.persistence.*;

/**
 * 阅读记录
 */

public class Readrecord {


    //编码
    private int id;

    //阅读人
    private int actorid;

    //目标编号
    private int targetid;

    //时间
    private Date createtime;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getActorid() {
        return actorid;
    }

    public void setActorid(int actorid) {
        this.actorid = actorid;
    }

    public int getTargetid() {
        return targetid;
    }

    public void setTargetid(int targetid) {
        this.targetid = targetid;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }
}