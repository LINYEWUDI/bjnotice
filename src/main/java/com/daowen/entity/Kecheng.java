package com.daowen.entity;
import java.util.Date;
import javax.persistence.*;
@Entity
public class Kecheng
{
@Id
@GeneratedValue(strategy =GenerationType.AUTO)
   private int id ;
   public int getId() 
   {
      return id;
  }
   public void setId(int id) 
   {
      this.id= id;
  }
   private String mingcheng ;
   public String getMingcheng() 
   {
      return mingcheng;
  }
   public void setMingcheng(String mingcheng) 
   {
      this.mingcheng= mingcheng;
  }
   private int xuefen ;
   public int getXuefen() 
   {
      return xuefen;
  }
   public void setXuefen(int xuefen) 
   {
      this.xuefen= xuefen;
  }
   private String tupian ;
   public String getTupian() 
   {
      return tupian;
  }
   public void setTupian(String tupian) 
   {
      this.tupian= tupian;
  }
   private String des ;
   public String getDes() 
   {
      return des;
  }
   public void setDes(String des) 
   {
      this.des= des;
  }
}
