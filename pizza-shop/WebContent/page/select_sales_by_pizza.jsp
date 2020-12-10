<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>SELECT</h3>
<table border=1>
<tr>
	<td>피자 코드</td>
	<td>피자명</td>
	<td>총매출액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery("SELECT pizza.pcode, pizza.pname, SUM(pizza.cost * salelist.amount) " +
                					"FROM tbl_pizza_01 pizza, tbl_salelist_01 salelist " +
                					"WHERE pizza.pcode = salelist.pcode " +
                					"GROUP BY pizza.pcode, pizza.pname " +
                					"ORDER BY SUM(pizza.cost * salelist.amount) DESC");
		while (rs.next()) {
			%>
				<tr>
					<td><% out.println(rs.getString(1)); %></td>
					<td><% out.println(rs.getString(2)); %></td>
					<td><% out.println(rs.getInt(3)); %></td>
				</tr>
			<%
		}
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>
</table>