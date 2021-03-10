<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="law.jsp" %>
<%
    String id = request.getParameter("id");
    CoursewareService coursewareSrv = BeansUtil.getBean("coursewareService", CoursewareService.class);
    if (id != null) {
        Courseware temobjcourseware = coursewareSrv.load(" where id=" + id);
        request.setAttribute("courseware", temobjcourseware);
        HashMap<String,Object> map=new HashMap<String,Object>();
        map.put("id",id);
        List<Student> listReaded=coursewareSrv.getReadedStudent(map);
        if(listReaded!=null)
            request.setAttribute("listReaded",listReaded);
        List<Student> listUnread=coursewareSrv.getUnreadStudent(map);
        if(listUnread!=null)
            request.setAttribute("listUnread",listUnread);
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>公告信息查看</title>
    <script type="text/javascript" src="${pageContext.request.contextPath}/webui/jquery/jquery-1.12.4.min.js"></script>
    <link href="${pageContext.request.contextPath}/admin/css/web2table.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/webui/bootstrap/css/font-awesome.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="search-title">
    <h2>
        查看公告
    </h2>
    <div class="description">
    </div>
</div>
<table cellpadding="0" cellspacing="1" class="grid" width="100%">
    <tr>
        <td width="10%" align="right">标题:</td>
        <td>
            ${requestScope.courseware.title}
        </td>
    </tr>
    <tr>
        <td width="10%" align="right">发布人:</td>
        <td>
            ${requestScope.courseware.pubren}
        </td>
    </tr>
    <tr>
        <td width="10%" align="right">发布人姓名:</td>
        <td>
            ${requestScope.courseware.pubname}
        </td>
    </tr>
    <tr>
        <td align="right">文件:</td>
        <td>
            <li>
                <a href="${pageContext.request.contextPath}/plusin/download.jsp?filename=${requestScope.courseware.fileurl}">
                    下载</a></li>
        </td>
    </tr>
    <tr>
        <td align="right">发布时间:</td>
        <td>
            <fmt:formatDate value="${requestScope.courseware.pubtime}" pattern="yyyy-MM-dd"/>
        </td>
    </tr>
    <tr>
        <td align="right">内容:</td>
        <td colspan="3">
            ${requestScope.courseware.dcontent}
        </td>
    </tr>
</table>

<table  width="100%" border="0" cellspacing="0"
       cellpadding="0" class="ui-record-table">
    <thead>
    <tr>
        <th style="text-align: left;padding:2px 22px " colspan="7">
          已读人员${fn:length(requestScope.listReaded)}人
            <a class="orange-href" href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=exportReaded&id=${requestScope.courseware.id}"><i class="fa fa-file-excel-o"></i>导出</a>
        </th>
    </tr>
    <tr>

        <th><b>学号</b>
        </th>
        <th><b>姓名</b>
        </th>
        <th><b>性别</b>
        </th>
        <th><b>相片</b>
        </th>
        <th><b>班级</b>
        </th>
        <th><b>籍贯</b>
        </th>
        <th><b>联系电话</b>
        </th>

    </tr>
    </thead>
    <tbody>
    <c:if test="${fn:length(listReaded) == 0}">
        <tr>
            <td colspan="20">暂无已读学生</td>
        </tr>
    </c:if>
   <c:forEach var="student" items="${requestScope.listReaded}">
       <tr>
           <td>${student.stno}</td>
           <td>${student.name}</td>
           <td>${student.sex}</td>
           <td ><img width="80" height="80" src="${pageContext.request.contextPath}${student.photo}"/></td>
           <td>${student.bjname}</td>
           <td>${student.jiguan}</td>
           <td>${student.mobile}</td>
       </tr>

   </c:forEach>


    </tbody>
</table>



<table  width="100%" border="0" cellspacing="0"
        cellpadding="0" class="ui-record-table">
    <thead>
    <tr>
        <th style="text-align: left;padding:2px 22px " colspan="7">
            未读人员${fn:length(requestScope.listUnread)}人
            <a class="orange-href" href="${pageContext.request.contextPath}/admin/coursewaremanager.do?actiontype=exportUnread&id=${requestScope.courseware.id}"><i class="fa fa-file-excel-o"></i>导出</a>
        </th>
    </tr>
    <tr>

        <th><b>学号</b>
        </th>
        <th><b>姓名</b>
        </th>
        <th><b>性别</b>
        </th>
        <th><b>相片</b>
        </th>
        <th><b>班级</b>
        </th>
        <th><b>籍贯</b>
        </th>
        <th><b>联系电话</b>
        </th>

    </tr>
    </thead>
    <tbody>
    <c:if test="${fn:length(listReaded) == 0}">
        <tr>
            <td colspan="20">暂无未读学生</td>
        </tr>
    </c:if>
    <c:forEach var="student" items="${requestScope.listUnread}">
        <tr>
            <td>${student.stno}</td>
            <td>${student.name}</td>
            <td>${student.sex}</td>
            <td ><img width="80" height="80" src="${pageContext.request.contextPath}${student.photo}"/></td>
            <td>${student.bjname}</td>
            <td>${student.jiguan}</td>
            <td>${student.mobile}</td>
        </tr>

    </c:forEach>
    </tbody>
</table>

</body>
</html>
