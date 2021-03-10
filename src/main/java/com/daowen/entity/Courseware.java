package com.daowen.entity;
import lombok.Data;

import java.util.Date;
import javax.persistence.*;
@Entity
@Data
public class Courseware {

   @Id
   @GeneratedValue(strategy =GenerationType.AUTO)
   private int id ;

   private String title ;

   private String pubren ;

   private String pubname ;

   private String fileurl ;

   private String dcontent ;

   private Date pubtime ;

   private Date lastCheckTime ;



}
