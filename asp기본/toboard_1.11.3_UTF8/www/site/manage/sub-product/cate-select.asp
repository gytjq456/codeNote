<%@CodePage = 65001%>
<!--#include virtual="/site/common/dbconn.asp" -->
<!--#include virtual="/site/common/function.asp" -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<%
depth = Request("depth")
p_code = Request("p_code")
s_code = Request("s_code")
%>

<select name="catcode<%=depth%>" class="AXSelect" <%If depth<3 Then%>onchange="CateSet(<%=depth+1%>, this.value, '')" onfocus="CateSet(<%=depth+1%>, this.value, '')"<%End If%> style="float:left; margin-right:5px">
	<option value="">---분류<%=depth%>---</option>
	<%
	Set RsC =Server.Createobject("ADODB.Recordset")
	Sql = "SELECT * FROM tbl_cate WHERE c_depth='" & depth & "' "
	If depth>1 Then Sql = Sql & " AND c_code LIKE '" & p_code & ".%' "
	Sql = Sql & "ORDER BY c_lev ASC"
	RsC.Open Sql, Dbcon, 1
	Do Until RsC.EOF
		c_code = RsC("c_code")
		c_name = RsC("c_name")
		%>
		<option value="<%=c_code%>" <%If c_code=s_code Then Response.Write "selected"%>><%=c_name%></option>
		<%
		RsC.MoveNext
	Loop
	RsC.Close
	Set RsC=Nothing
	%>
</select>

<div id="catesel<%=depth+1%>" style="float:left"></div>
<%If depth=2 And s_code="" Then%><script type="text/javascript">CateSet(3, '', '')</script><%End If%>