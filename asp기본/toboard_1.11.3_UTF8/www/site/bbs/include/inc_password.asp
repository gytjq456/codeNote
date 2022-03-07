<%
com_idx = Request("com_idx")
%>
<div class="ntb-password-area" style="width:<%=T_WIDTH%>;">

<%
'패스워드 입력 스킨 관리
If InStr(k_mode, "_en") Then%><!--#include file="../skin/resp_normal_en/password.asp"-->
<%Else%><!--#include file="../skin/resp_normal/password.asp"-->
<%End If%>

</div>