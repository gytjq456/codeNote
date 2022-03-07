<%
If b_lang="" Then b_lang="kr"
%>

<%If b_lang="kr" Then%>
	<%If mode="list" Then%><!--#include file="include/inc_list.asp"-->
	<%ElseIf mode="view" Then%><!--#include file="include/inc_content.asp"-->
	<%End If%>
<%End If%>
