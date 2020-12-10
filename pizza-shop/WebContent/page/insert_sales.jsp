<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3>매출점표등록</h3>
<%
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
			("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");

		
%>

<script>
	function reset_form() {
		document.input_form.reset();
	}
	function submit_form() {
		if(document.input_form.sale_code.value === ''){
			alert("매출전표번호을 입력해야 합니다");
			document.input_form.sale_code.focus();
			return;
		}
		if(document.input_form.scode.value === ''){
			alert("지점코드를 입력해야 합니다");
			document.input_form.scode.focus();
			return;
		}
			if(document.input_form.sale_date.value === ''){
			alert("판매 일자를 입력해야 합니다");
			document.input_form.sale_date.focus();
			return;
		}
			if(document.input_form.sale_amount.value === ''){
			alert("판매 개수를 입력해야 합니다");
			document.input_form.sale_amount.focus();
			return;
			}
		alert("정상적으로 처리되었습니다!");
		document.input_form.submit();
	}
</script>
<form action="action/insert_salelist.jsp" method="post" name="input_form">
	<table border="1">
		<tr>
			<td>매출전표번호</td> 
			<td><input type="text" name="sale_code"/></td>
		</tr>
		<tr>
			<td>지점코드</td>
			<td><input type="text" name="scode"/></td>
		</tr>
		<tr>
			<td>판매일자</td>
			<td><input type="date" name="sale_date"/></td>
		</tr>
		<tr>
			<td>피자코드</td>
			<td>
				<select name="pcode">
					<%
						Statement stmt_pizza = conn.createStatement();
						ResultSet rs_pizza = stmt_pizza.executeQuery("SELECT PCODE, PNAME FROM TBL_PIZZA_01");
						while (rs_pizza.next()) {
							%>
								<option value="<%=rs_pizza.getString(1) %>"> [<%=rs_pizza.getString(1) %>] <%=rs_pizza.getString(2) %></option>
							<%
						}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>판매수량</td>
			<td><input type="number" name="sale_amount"/></td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="button" value="등록하기" onclick="submit_form()">
				<input type="button" value="다시쓰기" onclick="reset_form()">
			</td>
		</tr>
	</table>
</form>
	
<%
		stmt_pizza.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
%>

