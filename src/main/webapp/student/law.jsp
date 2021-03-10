<%@ page import="com.daowen.util.*" %>
<%@ page import="com.daowen.entity.*" %>
<%@ page import="com.daowen.service.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
      Student tem_student= (Student) request.getSession().getAttribute("student");
      if(tem_student==null)
          response.sendRedirect(request.getContextPath()+"/admin/login.jsp");
%>
