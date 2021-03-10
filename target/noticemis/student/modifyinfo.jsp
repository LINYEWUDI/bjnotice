<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@ page  contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<%
     Student student= (Student)request.getSession().getAttribute("student");
     StudentService studentSrv=BeansUtil.getBean("studentService", StudentService.class);
	 if(student!=null)
	 {
	     Student temstudent   =studentSrv.load("where id="+((Student)student).getId());
	     request.setAttribute("student",temstudent);
	 }
				
		
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>考生</title>
	 <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
  <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
   <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/webui/treetable/skin/jquery.treetable.theme.default.css" rel="stylesheet"
        type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/treetable/js/jquery.treetable.js" type="text/javascript"></script>
  <link href="${pageContext.request.contextPath}/uploadifyv3.1/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/uploadifyv3.1/jquery.uploadify-3.1.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
   <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   
   <script type="text/javascript">
        function initControl(){
			           $('#btnulPhoto').uploadify({  
			                'formData': { 'folder': '${pageContext.request.contextPath}/Upload' },  
			                'buttonText': '选择图片',  
			                'buttonClass': 'browser',  
			                'removeCompleted': true,  
			                'swf': '${pageContext.request.contextPath}/uploadifyv3.1/uploadify.swf', 
			                'fileTypeExts':"*.jpg;*.gif;*.png;",
			                'auto':true, 
			                'removeTimeout':0,
			                'debug': false,  
			                'height': 15,  
			                'width':90,  
			                'uploader': '${pageContext.request.contextPath}/admin/uploadmanager.do',
			                 'fileSizelimit':'2048KB',
			                 'queueSizelimit':'5',
			                 'onUploadSuccess':function(file, data, response){
			                     $("#filelist").show();
			                     $("#imgPhoto").attr("src","${pageContext.request.contextPath}/upload/temp/"+file.name);
                                 $("#hidPhoto").val("/upload/temp/"+file.name);
			                  }
			             }); 
			          var imgphotosrc="${requestScope.student.photo}";
				       if(imgphotosrc==""){
				         $("#imgPhoto").attr("src","${pageContext.request.contextPath}/upload/nopic.jpg");
				         $("#hidPhoto").val("/upload/nopic.jpg");
				       }else
				       {
				          $("#imgPhoto").attr("src","${pageContext.request.contextPath}"+imgphotosrc);
				          $("#hidPhoto").val(imgphotosrc); 
				       }
			            editor = KindEditor.create('textarea[name="des"]', {
			            resizeType: 1,
				        allowFileManager: true
				       });
                       $("#txtBirthday").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
        }
        $(function (){
            initControl();
            $.metadata.setType("attr","validate");
            $("#teacherForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>账户信息管理</h2>
		<div class="description">修改帐户信息</div>
	</div>
	<form name="studentform" method="post"
		action="${pageContext.request.contextPath}/admin/studentmanager.do"
		id="studentForm">
		<input type="hidden" name="actiontype" value="update" /> <input
			type="hidden" name="id" value="${requestScope.student.id}" /> <input
			type="hidden" name="forwardurl"
			value="/student/accountinfo.jsp?seedid=101" />
		<table border="0" cellspacing="1" class="grid" cellpadding="0"
			width="100%">
			<tr>
				<td height="30" align="right">工号:</td>
				<td>${requestScope.student.stno}</td>
				
				<td colspan="2" rowspan="6"><img id="imgPhoto" width="200px" height="200px"
					src="${requestScope.student.photo}" />
					<div>
						<input type="file" name="upload" id="btnulPhoto" />
					</div> <input type="hidden" id="hidPhoto" name="photo"
					value="${requestScope.student.photo}" /></td>
			</tr>
			<tr>
				<td height="30" align="right">姓名:</td>
				<td><input name="name" value="${requestScope.student.name}"
					class="input-txt" type="text" id="txtName"
					validate="{required:true,messages:{required:'请输入姓名'}}" /></td>
			</tr>

			

			<tr>
				<td height="30" align="right">联系电话:</td>
				<td><input name="mobile"
					value="${requestScope.student.mobile}" class="input-txt"
					type="text" id="txtMobile"
					validate="{required:true,messages:{required:'请输入联系电话'}}" /></td>
			</tr>
			<tr>
				
				<td height="30" align="right">面貌:</td>
				<td><select name="mianmao" id="ddlMianmao">
						<option value="党员">党员</option>
						<option value="团员">团员</option>
						<option value="其他">其他</option>
				</select></td>
			</tr>


			<tr>
				<td align="right">说明:</td>
				<td colspan="3"><textarea name="des" class="l-textarea"
						id="txtDes" style="width:98%;height:200px;">${requestScope.student.des}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">

					<button class="orange-button">提交</button>


				</td>
			</tr>
		</table>
	</form>
</body>
</html>
