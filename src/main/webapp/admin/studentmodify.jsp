<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>考生</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.8.3.min.js"></script>
     <link href="${pageContext.request.contextPath}/webui/artDialog/skins/default.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/artDialog/jquery.artDialog.source.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/webui/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script  type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery.validate.min.js"></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.validateex.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/jquery.metadata.js" ></script>
    <script type="text/javascript"  src="${pageContext.request.contextPath}/webui/jquery/messages_cn.js" ></script>
	    <link href="${pageContext.request.contextPath}/webui/easydropdown/themes/easydropdown.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/webui/easydropdown/jquery.easydropdown.js" type="text/javascript"></script>    
    <link href="${pageContext.request.contextPath}/uploadifyv3.1/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/uploadifyv3.1/jquery.uploadify-3.1.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/kindeditor-min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/editor/lang/zh_CN.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/webui/jqueryui/themes/base/jquery.ui.all.css" type="text/css"></link>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jqueryui/ui/i18n/jquery.ui.datepicker-zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/webui/jqueryui/ui/jquery-ui-timepicker-addon.js" type="text/javascript"></script>
     <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript">
        function initControl(){
	 
			           $('#btnulPhoto').uploadify({  
			                'formData': { 'folder': '${pageContext.request.contextPath}/Upload' },  
			                'buttonText': '照片',  
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
                   //开始绑定
                    //结束绑定
			            editor = KindEditor.create('textarea[name="des"]', {
			            uploadJson : '../plusin/upload_json.jsp',
				        fileManagerJson : '../plusin/file_manager_json.jsp',
			            resizeType: 1,
				        allowFileManager: true
				       });
	                  $("#txtBirthday").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
	                   $("#bjid").change(function(){
	        	           $("[name=bjname]").val($("#bjid option:selected").text());
	                  });
	                   $("[name=bjname]").val($("#bjid option:selected").text());
        }
        $(function ()
        {
            initControl();
            $.metadata.setType("attr","validate");
            $("#studentForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>编辑考生信息</h2>
		<div class="description"></div>
	</div>
	<form name="studentform" method="post"
		action="${pageContext.request.contextPath}/admin/studentmanager.do"
		id="studentForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="actiontype" value="update" />
			<input type="hidden" name="seedid" value="${seedid}" />
			<input type="hidden" name="errorurl" value="/admin/studentadd.jsp" />
			<input type="hidden" name="forwardurl"
				value="/admin/studentmanager.do?actiontype=get&forwardurl=/admin/studentmanager.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>
			<tr>
				<td align="right">学号:</td>
				<td>${requestScope.student.stno}<input name="stno" placeholder="学号"
					validate="{required:true,messages:{required:'请输入学号'}}"
					value="${requestScope.student.stno}" class="input-txt" type="hidden"
					id="txtStno" />
				</td>
				<td colspan="2" rowspan="6"><img id="imgPhoto" width="200px" height="200px"
					src="${requestScope.student.photo}" />
					<div>
						<input type="file" name="upload" id="btnulPhoto" />
					</div> <input type="hidden" id="hidPhoto" name="photo"
					value="${requestScope.student.photo}" /></td>
			</tr>
			<tr>
				<td align="right">姓名:</td>
				<td><input name="name" placeholder="姓名"
					validate="{required:true,messages:{required:'请输入姓名'}}"
					value="${requestScope.student.name}" class="input-txt" type="text"
					id="txtName" /></td>
			</tr>
			<tr>
				<td align="right">性别:</td>
				<td><select name="sex" id="ddlSex" class="dropdown">
						<option value="男">男</option>
						<option value="女">女</option>
				</select></td>
			</tr>
			<tr>
				<td align="right">专业:</td>
				<td><input name="zhuanye" placeholder="请输入专业"
					validate="{required:true,messages:{required:'请输入专业'}}"
					value="${requestScope.student.zhuanye}" class="input-txt"
					type="text"  /></td>
			</tr>
			<tr>
			    <td align="right">家庭住址:</td>
				<td><input name="address" placeholder="家庭住址"
					validate="{required:true,messages:{required:'请输入家庭住址'}}"
					value="${requestScope.student.address}" class="input-txt"
					type="text" id="txtAddress" /></td>
				
			</tr>
			<tr>
				<td align="right">联系电话:</td>
				<td><input name="mobile" placeholder="联系电话"
					validate="{required:true,messages:{required:'请输入联系电话'}}"
					value="${requestScope.student.mobile}" class="input-txt"
					type="text" id="txtMobile" /></td>
			</tr>
			<tr>
				<td align="right">班级:</td>
				<td><web:dropdownlist name="bjid" id="bjid" cssclass="dropdown"
						value="${requestScope.student.bjid}"
						datasource="${bjid_datasource}" textfieldname="name"
						valuefieldname="id">
					</web:dropdownlist> <input id="hidbjname" name="bjname" type="hidden"
					value="${requestScope.student.bjname}" />
				</td>
			</tr>

			<tr>
				
			    <td align="right">籍贯:</td>
				<td><input name="jiguan" placeholder="籍贯"
					validate="{required:true,messages:{required:'请输入籍贯'}}"
					value="${requestScope.student.jiguan}" class="input-txt"
					type="text" id="txtJiguan" /></td>
				<td align="right">民族:</td>
				<td><input name="nation" placeholder="民族"
					validate="{required:true,messages:{required:'请输入民族'}}"
					value="${requestScope.student.nation}" class="input-txt"
					type="text" id="txtNation" /></td>
			</tr>
			<tr>
				
			
				<td align="right">面貌:</td>
				<td><select name="mianmao" id="ddlMianmao" class="dropdown">
						<option value="党员">党员</option>
						<option value="团员">团员</option>
						<option value="其他">其他</option>
				</select></td>
			
				<td align="right">出生日期:</td>
				<td><input name="birthday"
					value="${requestScope.student.birthday}" type="text"
					id="txtBirthday" class="input-txt" validate="{required:true}" /></td>
			</tr>
			
			<tr>
				<td align="right">说明:</td>
				<td colspan="3"><textarea name="des" id="txtDes"
						style="width:98%;height:200px;">${requestScope.student.des}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="4">
						<button class="orange-button">
							<i class="icon-ok icon-white"></i>提交
						</button>
					</td>
			</tr>
		</table>
	</form>
</body>
</html>
