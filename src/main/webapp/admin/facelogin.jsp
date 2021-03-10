<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>刷脸登录</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/admin/css/login.css">
     <script src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>

    <script src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" type="text/javascript"></script>
     <script type="text/javascript"> 
  
      
       if(top.window!=window)
    	   top.location.href="login.jsp";
      
      $(function(){

          let video = document.getElementById("video");
          function getMedia() {
              let constraints = {
                  video: {width: 400, height: 300}
              };

              let promise = navigator.mediaDevices.getUserMedia(constraints);
              promise.then(function (MediaStream) {
                  video.srcObject = MediaStream;
                  video.play();
              }).catch(function (PermissionDeniedError) {
                  console.log(PermissionDeniedError);
              })
          }
          function takePhoto() {
              let canvas = document.getElementById("canvas");
              let ctx = canvas.getContext('2d');
              ctx.drawImage(video, 0, 0, 400, 300);
              let img = document.getElementById('canvas').toDataURL();
              $('#base64photo').val(img);
          }

          $("#btnLogin").click(function () {

              takePhoto();
              let base64photo=$("[name=base64photo]").val();

              $.ajax({
                  url: "${pageContext.request.contextPath}/admin/facelogin",
                  type: 'POST',
                  data: {
                      base64photo
                  },
                  success: function (res) {
                      console.log(res);
                      let data=res.data;
                      if(data!=null){
                          alert("登录成功");
                          window.location.href="${pageContext.request.contextPath}/student/index.jsp";
                          return;
                      }
                      alert("无效蛋蛋,酸化");

                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      alert(XMLHttpRequest.status + errorThrown);
                  }
              });

          });
          getMedia();
      
      });
  
  </script>
				
    
</head>
<body>
<div id="div_background" >

    <div id="div_main">
        <div id="div_head"><p>班级公告管理<span>系统</span></p></div>
        <div>
            <video id="video" width="400px" height="300px" autoplay="autoplay"></video>
            <canvas id="canvas" width="400px" height="300px" style="display: none;" ></canvas>
            <input type="hidden" name="base64photo" id="base64photo"/>

            <div id="btnLogin" class="dw-btn">登录</div>
            <a href="${pageContext.request.contextPath}/admin/login.jsp" class="dw-btn">账号登录</a>

        </div>
    </div>

</div>

</body>
</html>