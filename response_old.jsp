<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : response
    Created on : Aug 21, 2014, 9:59:16 AM
    Author     : Prachi



--%> <sql:query var="result" dataSource="jdbc/ECEDatasource">
SELECT*  FROM sensor_data
</sql:query>
    
<table border="1">
<!-- column headers -->
<tr>
<c:forEach var="columnName" items="${result.columnNames}">
<th><c:out value="${columnName}"/></th>
</c:forEach>
</tr>
<!-- column data -->
<c:forEach var="row" items="${result.rowsByIndex}">
<tr>
    <c:forEach var="column" items="${row}">
<td><c:out value="${column}"/></td>
    </c:forEach>
</tr>
</c:forEach>
</table>
 
<sql:query var="result" dataSource="jdbc/ECEDatasource">
SELECT acc_x, acc_y,acc_z  FROM sensor_data order by label
</sql:query>
<%
       ArrayList accx = new ArrayList();
       ArrayList accy = new ArrayList();
       ArrayList accz = new ArrayList ();
 %>
<c:forEach var="row" items="${result.rowsByIndex}">
    <% accx.add(new Float(%> $(result.acc_x) <%)); %>
</c:forEach>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
       
    </body>
</html>
