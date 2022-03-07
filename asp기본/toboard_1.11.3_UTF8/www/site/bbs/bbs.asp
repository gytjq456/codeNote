<%
Response.Write "<!--timer : " & timer() & "-->"

'게시판 경로
If mode="list" Then 
%>
<!--#include file="include/inc_list.asp"-->
<%
ElseIf mode="reg" Or mode="mod" Or mode="rep" Then
%>
<!--#include file="include/inc_reg.asp"-->
<%
ElseIf mode="view" Then
%>
<!--#include file="include/inc_content.asp"-->
<%
ElseIf mode="mod_l" Or mode="del_l" Or mode="view_l" Or mode="comment_del_l" Then
%>
<!--#include file="include/inc_password.asp"-->
<%
ElseIf mode="reg_p" Or mode="mod_p" Or mode="rep_p" Or mode="del_p" Or mode="comment_reg_p" Or mode="comment_del_p" Or mode="seldel_p" Then
%>
<!--#include file="include/reg_ok.asp"-->
<%
End If

Response.Write "<!--timer : " & timer() & "-->"
%>