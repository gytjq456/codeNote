<%
'게시판보기권한
If CInt(a_list)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('게시판 목록보기 권한이 없습니다.'); history.back(); </script>"
	Response.End
End If

'검색 사용불가 문자
If disableChar(s_keyword)=False Then
	Response.Write "<script>alert('검색에 사용할 수 없는 문자가 있습니다.'); history.back();</script>"
	Response.End
End If

Sql_Where = "WHERE board_idx='" & bid & "' "

If s_type="mem_name" Then
	Sql_Where = Sql_Where & "AND mem_name like '%" & s_keyword & "%' "
ElseIf s_type="title" Then
	Sql_Where = Sql_Where & "AND title like '%" & s_keyword & "%' "
ElseIf s_type="content" Then
	Sql_Where = Sql_Where & "AND content like '%" & s_keyword & "%' "
ElseIf s_type="addtext1" Then
	Sql_Where = Sql_Where & "AND addtext1 like '%" & s_keyword & "%' "
ElseIf s_type="addtext2" Then
	Sql_Where = Sql_Where & "AND addtext2 like '%" & s_keyword & "%' "
ElseIf s_type="addtext3" Then
	Sql_Where = Sql_Where & "AND addtext3 like '%" & s_keyword & "%' "
ElseIf s_type="addtext4" Then
	Sql_Where = Sql_Where & "AND addtext4 like '%" & s_keyword & "%' "
ElseIf s_type="addtext5" Then
	Sql_Where = Sql_Where & "AND addtext5 like '%" & s_keyword & "%' "
End If

If s_cate<>"" Then Sql_Where = Sql_Where & "AND cate like '" & s_cate & "' "
If e1_idx<>"" Then Sql_Where = Sql_Where & "AND e1_idx like '" & e1_idx & "' "

Sql = "SELECT * FROM tbl_board_data " & Sql_Where
'스킨 종류에 따른 정렬
If k_mode="history" Then
	Sql = Sql & " ORDER BY CONVERT(int, addtext1) DESC, CONVERT(int, addtext2) DESC, CONVERT(int, addtext3) DESC"
Else 
	Sql = Sql & " ORDER BY notice DESC, p_num DESC, r_num ASC"
End If


Rs.Open Sql, Dbcon, 1

'페이지 설정
If Rs.EOF=False Then
	Rs.PageSize = k_pagelist
	Rs.AbsolutePage = page
	Rs_RecordCount = Rs.RecordCount
	If Rs_RecordCount Mod Rs.PageSize>0 Then
		maxpage = CInt(Rs_RecordCount/k_pagelist)+1
	Else
		maxpage = CInt(Rs_RecordCount/k_pagelist)
	End If	
End If
%>
<div class="ntb-area" style="width:<%=T_WIDTH%>;">

<%
'리스트 스킨 관리 (PC, 모바일)
Select Case k_mode%>
	<%'반응형 스킨%>
	<%Case "resp_normal"%><!--#include file="../skin/resp_normal/list.asp"-->
	<%Case "resp_normal_en"%><!--#include file="../skin/resp_normal_en/list.asp"-->
	<%Case "resp_gallery"%><!--#include file="../skin/resp_gallery/list.asp"-->
	<%Case "resp_gallery_en"%><!--#include file="../skin/resp_gallery_en/list.asp"-->
	<%Case "resp_gallery2"%><!--#include file="../skin/resp_gallery2/list.asp"-->
	<%Case "resp_gallery2_en"%><!--#include file="../skin/resp_gallery2_en/list.asp"-->
	<%Case "resp_photo"%><!--#include file="../skin/resp_photo/list.asp"-->
	<%Case "resp_photo2"%><!--#include file="../skin/resp_photo2/list.asp"-->
	<%Case "resp_photo2_en"%><!--#include file="../skin/resp_photo2_en/list.asp"-->
	<%Case "resp_agent_map"%><!--#include file="../skin/resp_agent_map/list.asp"-->
	<%Case "resp_agent_map2"%><!--#include file="../skin/resp_agent_map2/list.asp"-->
	<%Case "resp_schedule3"%><!--#include file="../skin/resp_schedule3/list.asp"-->
	<%Case "resp_recruit"%><!--#include file="../skin/resp_recruit/list.asp"-->
	<%Case "resp_recruit_en"%><!--#include file="../skin/resp_recruit_en/list.asp"-->
	<%Case "resp_faq"%><!--#include file="../skin/resp_faq/list.asp"-->
	<%Case "resp_video"%><!--#include file="../skin/resp_video/list.asp"-->
	<%Case "resp_video_en"%><!--#include file="../skin/resp_video_en/list.asp"-->
	<%Case "resp_cert"%><!--#include file="../skin/resp_cert/list.asp"-->
	<%Case "resp_cert_en"%><!--#include file="../skin/resp_cert_en/list.asp"-->
	<%Case "resp_square"%><!--#include file="../skin/resp_square/list.asp"-->
	<%Case "resp_square2"%><!--#include file="../skin/resp_square2/list.asp"-->
	<%Case "resp_thesis"%><!--#include file="../skin/resp_thesis/list.asp"-->
	<%Case "resp_catalog"%><!--#include file="../skin/resp_catalog/list.asp"-->
	<%'PC 스킨%>
	<%Case "history"%><!--#include file="../skin/history/list.asp"-->
	<%Case "ordercancel"%><!--#include file="../skin/ordercancel/list.asp"-->
	<%Case Else%><!--#include file="../skin/resp_normal/list.asp"-->
<%End Select%>

</div>
<%
Set Rs = Nothing
%>