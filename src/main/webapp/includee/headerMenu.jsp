<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-dark sticky-top bg-dark flex-md-nowrap w-100 p-0 shadow">
  <a class="navbar-brand col-md-3 col-lg-2 mr-0 px-3" href="javascript:;">Class3.5</a>
  <button class="navbar-toggler position-absolute d-md-none collapsed" type="button" data-toggle="collapse" data-target="#sidebarMenu" aria-controls="sidebarMenu" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <ul class="nav px-3 col">
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="javascript:;">상단메뉴1</a>
    </li>
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="javascript:;">상단메뉴2</a>
    </li>
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="javascript:;">상단메뉴3</a>
    </li>
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="javascript:;">상단메뉴4</a>
    </li>
    <%
    	Map<String, String> menuMap = (Map) request.getAttribute("welcomeMenu");
    	if (menuMap != null) {
    		%>
    		<li class="nav-item text-nowrap">
    			<a class="nav-link" href="<%=menuMap.get("menuURL") %>"><%=menuMap.get("menuText") %></a>
    		</li>
    		<%
    	}
    %>
  </ul>
  <ul class="nav px-3 col-2">
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="<%=request.getContextPath() %>/login/loginForm.jsp">Sign in</a>
    </li>
    <li class="nav-item text-nowrap">
      <a class="nav-link" href="<%=request.getContextPath() %>/login/logout.do">Sign out</a>
    </li>
  </ul>
</nav>