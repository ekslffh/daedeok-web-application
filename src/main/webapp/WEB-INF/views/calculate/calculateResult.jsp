<%@page import="kr.or.ddit.calculate.CalculateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CalculateVO target = (CalculateVO) request.getAttribute("calculate");
%>
<h4><%=target.getExpr() %></h4>