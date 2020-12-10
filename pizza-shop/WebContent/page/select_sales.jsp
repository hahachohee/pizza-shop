<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<h3>통합매출현황조회</h3>
<table border=1>
<tr>
	<td>매출전표번호</td>
	<td>지점</td>
	<td>판매일자</td>
	<td>피자코드</td>
	<td>피자명</td>
	<td>판매수량</td>
	<td>매출액</td>
</tr>

<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		
		Statement stmt = conn.createStatement();
		
		String query = "SELECT " + 
			    "SALELIST.SALENO,SHOP.SCODE || '-' || SHOP.SNAME, SALELIST.SALEDATE, " + 
			    "PIZZA.PCODE, PIZZA.PNAME, SALELIST.AMOUNT, PIZZA.COST * SALELIST.AMOUNT AS TOTAL_COST " +
			"FROM " + 
			    "TBL_SALELIST_01 SALELIST, TBL_SHOP_01 SHOP, TBL_PIZZA_01 PIZZA " +
			"WHERE " +
			    "SALELIST.SCODE = SHOP.SCODE AND "+
			    "SALELIST.PCODE = PIZZA.PCODE " +
			"ORDER BY SALELIST.SALENO";
		
		ResultSet rs = stmt.executeQuery(query);
		
		while (rs.next()) {
			%>
				<tr>
					<td><% out.println(rs.getInt(1)); %></td>
					<td><% out.println(rs.getString(2)); %></td>
					<td><% out.println(rs.getString(3)); %></td>
					<td><% out.println(rs.getString(4)); %></td>
					<td><% out.println(rs.getString(5)); %></td>
					<td><% out.println(rs.getString(6)); %></td>
					<td><% out.println(rs.getInt(7)); %></td>
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