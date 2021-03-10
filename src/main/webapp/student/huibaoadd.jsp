<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="web" uri="/WEB-INF/webcontrol.tld"%>
<%@ include file="law.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
 <head>
  <title>汇报</title>
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
	                   $("#txtHbdate").datepicker({
                         dateFormat:'yy-mm-dd'
                      }).datepicker("setDate",new Date());
			           $('#btnFileurl').uploadify({  
			               'formData': { 'folder': 'upload/attachment' },  
			                'buttonText': '选择汇报文档',  
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
            $("#huibaoForm").validate();
        });  
    </script>
</head>
<body>
	<div class="search-title">
		<h2>新建汇报</h2>
		<div class="description"></div>
	</div>
	<form name="huibaoform" method="post"
		action="${pageContext.request.contextPath}/admin/huibaomanager.do"
		id="huibaoForm">
		<table class="grid" cellspacing="1" width="100%">
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="actiontype" value="${actiontype}" />
			<input name="hbren" placeholder="汇报人"
					validate="{required:true,messages:{required:'请输入汇报人'}}"
					value="${sessionScope.student.stno}" class="input-txt" type="hidden"
					 />
			<input type="hidden" name="seedid" value="${seedid}" />
			<input type="hidden" name="errorurl" value="/student/huibaoadd.jsp" />
		
		    <input name="hbrname" placeholder="姓名"
					validate="{required:true,messages:{required:'请输入姓名'}}"
					value="${sessionScope.student.name}" class="input-txt"
					type="hidden" id="txtHbrname" />
			<input type="hidden" name="forwardurl"
				value="/admin/huibaomanager.do?actiontype=get&hbren=${sessionScope.student.stno}&forwardurl=/student/huibaomanager.jsp" />
			<tr>
				<td colspan="4">${errormsg}</td>
			</tr>
			<tr>
				<td align="right">标题:</td>
				<td><input name="title" placeholder="标题"
					validate="{required:true,messages:{required:'请输入标题'}}"
					value="${requestScope.huibao.title}" class="input-txt" type="text"
					id="txtTitle" /></td>
			</tr>
			<tr>
				<td align="right">汇报日期:</td>
				<td><input name="hbdate" value="${requestScope.huibao.hbdate}"
					type="text" id="txtHbdate" class="input-txt"
					validate="{required:true}" /></td>
			</tr>
			<tr>
				<td height="32px" class="title" align="right">文件：</td>
				<td>
					<div>
						<input type="hidden" id="hidFileurl" name="fileurl"
							value="${requestScope.huibao.fileurl}" /> <input type="file"
							name="upload" id="btnFileurl" />
					</div>
					<div id="Fileurlfilelist" class="uploadify-queue">
						<div class="uploadify-queue-item">
							<ul>
								<c:if test="${requestScope.huibao.fileurl!=null}">
									<li>${requestScope.huibao.fileurl} <a href="#"
										onclick="$(this).parent().remove();">移除</a>
									</li>
								</c:if>
							</ul>
						</div>
					</div>
				</td>
			</tr>
		

			<tr>
				<td align="right">汇报内容:</td>
				<td colspan="3"><textarea name="dcontent" id="txtDcontent"
						style="width: 98%; height: 200px;">${requestScope.huibao.dcontent}</textarea>
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
