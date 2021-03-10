package com.daowen.mapper;

import com.daowen.entity.Yingpian;
import com.daowen.ssm.simplecrud.SimpleMapper;
import com.daowen.vo.YingpianVo;

import java.util.List;
import java.util.Map;

public interface YingpianMapper extends SimpleMapper<Yingpian> {

    List<YingpianVo> getEntityPlus(Map map);

    YingpianVo  loadPlus(Map map);

}
