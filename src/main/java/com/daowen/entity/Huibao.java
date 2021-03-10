package com.daowen.entity;
import java.util.Date;
import javax.persistence.*;
@Entity
public class Huibao
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
   private String title ;
   public String getTitle() 
   {
      return title;
  }
   public void setTitle(String title) 
   {
      this.title= title;
  }
   private Date hbdate ;
   public Date getHbdate() 
   {
      return hbdate;
  }
   public void setHbdate(Date hbdate) 
   {
      this.hbdate= hbdate;
  }
   private String fileurl ;
   public String getFileurl() 
   {
      return fileurl;
  }
   public void setFileurl(String fileurl) 
   {
      this.fileurl= fileurl;
  }
   private String dcontent ;
   public String getDcontent() 
   {
      return dcontent;
  }
   public void setDcontent(String dcontent) 
   {
      this.dcontent= dcontent;
  }
   private String hbren ;
   public String getHbren() 
   {
      return hbren;
  }
   public void setHbren(String hbren) 
   {
      this.hbren= hbren;
  }
   private String hbrname ;
   public String getHbrname() 
   {
      return hbrname;
  }
   public void setHbrname(String hbrname) 
   {
      this.hbrname= hbrname;
  }
}
