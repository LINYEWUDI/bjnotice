package com.daowen.mapper;
import com.daowen.entity.*;
import com.daowen.ssm.simplecrud.SimpleMapper;
import org.springframework.stereotype.Repository;
import java.util.*;
/*
*  阅读记录
**/
@Repository
public interface ReadrecordMapper  extends SimpleMapper<Readrecord> {

          List<Readrecord>   getEntity();

}