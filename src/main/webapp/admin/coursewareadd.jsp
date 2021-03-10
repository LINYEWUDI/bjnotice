<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>公告</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
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
			           $('#btnFileurl').uploadify({  
			               'formData': { 'folder': 'upload/attachment' },  
			                'buttonText': '选择公告文档',
			                'buttonClass': 'browser',  
			                'removeCompleted': true,  
			                'swf': '${pageContext.request.contextPath}/uploadifyv3.1/uploadify.swf', 
			                 'fileTypeExts':"*.doc;*.pdf;*.zip;*.txt;*.docx;*.ppt;*.pptx",
			                'auto':true, 
			                'removeTimeout':0,
			                'debug': false,  
			                'height': 15,  
			                'width':90,  
			                'uploader': '${pageContext.request.contextPath}/admin/uploadmanager.do',
			                 'fileSizelimit':'2048KB',
			                 'queueSizelimit':'5',
			                 'onUploadSuccess':function(file, data, response){
			                     $("#Fileurlfilelist").show();
		 	                     var filesize=Math.round(file.size/1024);
			                     $("#Fileurlfilelist div ul").append("<li >"+file.name+"["+filesize+"KB] <a href=\"#\" onclick=\"$(this).parent().remove();\">移除</a> </li> ");
			                      $("#hidFileurl").val("/upload/temp/"+file.name);
			                  }
			             }); 
			            editor = KindEditor.create('textarea[name="dcontent"]', {
			            uploadJson : '../plusin/upload_json.jsp',
				        fileManagerJson : '../plusin/file_manager_json.jsp',
			            resizeType: 1,
				        allowFileManager: true
				       });

        }
        $(function ()
        {
            initControl();
            $.metadata.setType("attr","validate");
            $("#coursewareForm").validate();
        });  
    </script>
</head>
<body>
<div class="search-title">
	<h2>
		新建公告
	</h2>
	<div class="description">
	</div>
</div>
<form name="coursewareform" method="post" action="${pageContext.request.contextPath}/admin/coursewaremanager.do"
	  id="coursewareForm">
	<table class="grid" cellspacing="1" width="100%">
		<input type="hidden" name="id" value="${id}"/>
		<input name="pubname" placeholder="发布人姓名" validate="{required:true,messages:{required:'请输入发布人姓名'}}"
			   value="${sessionScope.users.realname}" class="input-txt" type="hidden" />
		<input name="pubren" placeholder="发布人" validate="{required:true,messages:{required:'请输入发布人'}}"
			   value="${sessionScope.users.username}" class="input-txt" type="hidden"/>
		<input type="hidden" name="actiontype" value="${actiontype}"/>
		<input type="hidden" name="seedid" value="${seedid}"/>
		<input type="hidden" name="errorurl" value="/admin/coursewareadd.jsp"/>
		<input type="hidden" name="forwardurl"
			   value="/admin/coursewaremanager.do?actiontype=get&forwardurl=/admin/coursewaremanager.jsp"/>
		<tr>
			<td colspan="4">
				${errormsg}
			</td>
		</tr>
		<tr>
			<td align="right">标题:</td>
			<td>
				<input name="title" placeholder="标题" validate="{required:true,messages:{required:'请输入标题'}}"
					   value="${requestScope.courseware.title}" class="input-txt" type="text" id="txtTitle"/>
			</td>
		</tr>


		<tr>
			<td height="32px" class="title" align="right">
				文件：
			</td>
			<td>
				<div>
					<input type="hidden" id="hidFileurl" name="fileurl" value="${requestScope.courseware.fileurl}"/>
					<input type="file" name="upload" id="btnFileurl"/>
				</div>
				<div id="Fileurlfilelist" class="uploadify-queue">
					<div class="uploadify-queue-item">
						<ul>
							<c:if test="${requestScope.courseware.fileurl!=null}">
								<li> ${requestScope.courseware.fileurl} <a href="#"
																		   onclick="$(this).parent().remove();">移除</a>
								</li>
							</c:if>
						</ul>
					</div>
				</div>
			</td>

		<tr>
			<td align="right">内容:</td>
			<td colspan="3">
				<textarea name="dcontent" id="txtDcontent"
						  style="width:98%;height:200px;">${requestScope.courseware.dcontent}</textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<button class="orange-button"><i class="icon-ok icon-white"></i>提交</button>
			</td>
		</tr>
	</table>
</form>
</body>
</html>
