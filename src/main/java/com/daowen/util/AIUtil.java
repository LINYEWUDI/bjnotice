package com.daowen.util;


import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;

public class AIUtil {

    public  static void main(String [] args){

        String image="";
        //image=image.split(",")[1];
        String json= faceMatch(image,image);
       //String res= AIUtil.toBase64String("http://localhost:8080/noticemis/upload/temp/20210120222031.jpg");
        System.out.println("json="+json);
    }

    public static String faceMatch(String image1,String image2) {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/match";
        try {

            JSONObject joImage1=new JSONObject();
            joImage1.put("image",image1);
            joImage1.put("image_type","BASE64");
            joImage1.put("quality_control","LOW");
            joImage1.put("liveness_control","HIGH");

            JSONObject joImage2=new JSONObject();
            joImage2.put("image",image2);
            joImage2.put("image_type","BASE64");
            joImage2.put("quality_control","LOW");
            joImage2.put("liveness_control","HIGH");

            JSONArray  jsonArray=new JSONArray();
            jsonArray.add(joImage1);
            jsonArray.add(joImage2);
            String param=JSONArray.toJSONString(jsonArray);
            System.out.println("param"+param);
            // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
            String accessToken = Auth2Util.getAuth();
            String result = HttpUtil.post(url, accessToken, "application/json", param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static InputStream toInputStream(String strUrl){
        URL url = null;
        try {
            url = new URL(strUrl);
        } catch (MalformedURLException e) {
            e.printStackTrace();
        }
        HttpURLConnection conn = null;
        try {
            conn = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }
        InputStream inputStream = null;
        try {
            inputStream = conn.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return inputStream;
    }


    public static String toBase64String(String url){
        InputStream inputStream=toInputStream(url);
        if(inputStream==null)
            return null;
        byte[] imgData = new byte[0];
        try {
            imgData = FileUtil.readInputStream(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
        String b64Str = Base64Util.encode(imgData);
        return b64Str;
    }


    public static String animalIdentify(InputStream is){

        if(is==null)
            return null;
        String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/animal";
        try {
            byte[] imgData = FileUtil.readInputStream(is);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");
            String param = "image=" + imgParam;
            String accessToken = Auth2Util.getAuth();
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String advancedGeneral(InputStream inputStream) {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/image-classify/v2/advanced_general";
        try {

            byte[] imgData =FileUtil.readInputStream(inputStream);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");

            String param = "image=" + imgParam;
            String accessToken = Auth2Util.getAuth();
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String ingredient(InputStream inputStream) {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/classify/ingredient";
        try {
            // 本地文件路径
            byte[] imgData =FileUtil.readInputStream(inputStream);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");

            String param = "image=" + imgParam;

            // 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
            String accessToken = Auth2Util.getAuth();
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String plant(InputStream inputStream) {
        // 请求url
        String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/plant";
        try {

            byte[] imgData =FileUtil.readInputStream(inputStream);
            String imgStr = Base64Util.encode(imgData);
            String imgParam = URLEncoder.encode(imgStr, "UTF-8");

            String param = "image=" + imgParam;
            String accessToken = Auth2Util.getAuth();
            String result = HttpUtil.post(url, accessToken, param);
            System.out.println(result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


}
