<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>지점별 매출 현황</h3>
<table border=1>
<tr>
	<td>지점 코드</td>
	<td>지점명</td>
	<td>총매출액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		String query = "SELECT shop.scode, shop.sname, SUM(salelist.amount * pizza.cost) " +
                "FROM tbl_shop_01 shop, tbl_salelist_01 salelist, tbl_pizza_01 pizza " +
                "WHERE shop.scode = salelist.scode " +
                "AND pizza.pcode = salelist.pcode " +
                "GROUP BY shop.scode, shop.sname " +
                "ORDER BY shop.scode ASC" ;
		
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);
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