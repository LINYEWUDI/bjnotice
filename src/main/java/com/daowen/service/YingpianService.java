package com.daowen.service;

import com.daowen.entity.Ypcate;
import com.daowen.vo.YingpianVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.daowen.mapper.YingpianMapper;
import com.daowen.ssm.simplecrud.SimpleBizservice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class YingpianService extends SimpleBizservice<YingpianMapper> {

    @Autowired
    private YingpianMapper yingpianMapper;
    @Autowired
    private YpcateService ypcateService;

    public List<Ypcate> getMyLanmus() {
        return ypcateService.getEntity("");
    }


    public List<YingpianVo> find(Map map){
        return yingpianMapper.getEntityPlus(map);
    }

    public  List<YingpianVo> find(int typeId){
        HashMap<String,Object> map=new HashMap();
        map.put("typeid",typeId);
        return yingpianMapper.getEntityPlus(map);
    }
    public YingpianVo loadPlus(int id){
        HashMap<String,Object> map=new HashMap();
        map.put("id",id);
        return yingpianMapper.loadPlus(map);
    }


}
