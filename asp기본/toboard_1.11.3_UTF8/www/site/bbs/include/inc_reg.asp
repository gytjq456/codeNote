<%
'reg : 쓰기
'mod : 수정
'rep : 답변
'del : 삭제

'쓰기권한
If CInt(a_write)<CInt(W_LEVEL) And (mode="reg" Or mode="mod") Then
	Response.Write "<script>alert('글쓰기 권한이 없습니다.'); history.back();	</script>"
	Response.End
End If

'답변권한
If CInt(a_reply)<CInt(W_LEVEL) And mode="rep" Then
	Response.Write "<script>alert('답글쓰기 권한이 없습니다.'); history.back();</script>"
	Response.End
End If

If mode="reg" Then
	c_mem_name = W_NAME
	c_mem_id = W_ID
	c_mem_pw = W_PW
	c_mem_email = W_EMAIL
	c_mem_url = "http://"
	c_cate_idx = Request("s_cate")

ElseIf mode="mod" Then

	req_pw = Request("pw")
	If disableChar(req_pw)=False Then
		Response.Write "<script>alert('수정권한이 없습니다.');history.back();</script>"
		Response.End
	End If 

	If c_mem_id<>"" And W_ID="" Then
		Response.Write "<script>alert('수정권한이 없습니다.');history.back();</script>"
		Response.End
	End If

	If Not((c_mem_id<>"" And c_mem_id=W_ID) Or c_mem_pw=req_pw Or W_LEVEL="1" Or W_LEVEL="2") Then
		Response.Write "<script>alert('수정권한이 없습니다.');history.back();</script>"
		Response.End
	End If	

ElseIf mode="rep" Then

	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT title, content, p_num, mem_pw, lock FROM tbl_board_data WHERE idx='" & idx & "'"
	Rs.open Sql, Dbcon, 1
	If Rs.EOF=False Then
		c_mem_name = W_NAME
		c_mem_id = W_ID
		c_mem_email = W_EMAIL
		c_title = Rs("title")
		c_content = Rs("content")
		c_p_num = Rs("p_num")
		c_mem_pw = AESDecrypt(Rs("mem_pw"), "webmoa")
		c_lock = Rs("lock")
	Else
		Response.Write "<script>alert('잘못된 접근입니다.');history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing

	If lock=False Then mem_pw = W_PW

	c_content = "<br /><br /><br />-------------------------------------------------------------<br /><br />" & c_content
End If

'쓰기 스킨
Select Case k_mode%>
	<%'반응형 스킨%>
	<%Case "resp_normal"%><!--#include file="../skin/resp_normal/reg.asp"-->
	<%Case "resp_normal_en"%><!--#include file="../skin/resp_normal_en/reg.asp"-->
	<%Case "resp_gallery"%><!--#include file="../skin/resp_gallery/reg.asp"-->
	<%Case "resp_gallery_en"%><!--#include file="../skin/resp_gallery_en/reg.asp"-->
	<%Case "resp_gallery2"%><!--#include file="../skin/resp_gallery2/reg.asp"-->
	<%Case "resp_gallery2_en"%><!--#include file="../skin/resp_gallery2_en/reg.asp"-->
	<%Case "resp_photo"%><!--#include file="../skin/resp_photo/reg.asp"-->
	<%Case "resp_photo2"%><!--#include file="../skin/resp_photo2/reg.asp"-->
	<%Case "resp_photo2_en"%><!--#include file="../skin/resp_photo2_en/reg.asp"-->
	<%Case "resp_schedule3"%><!--#include file="../skin/resp_schedule3/reg.asp"-->
	<%Case "resp_square"%><!--#include file="../skin/resp_square/reg.asp"-->
	<%Case "resp_square2"%><!--#include file="../skin/resp_square2/reg.asp"-->
	<%Case "resp_recruit"%><!--#include file="../skin/resp_recruit/reg.asp"-->
	<%Case "resp_recruit_en"%><!--#include file="../skin/resp_recruit_en/reg.asp"-->
	<%Case "resp_faq"%><!--#include file="../skin/resp_faq/reg.asp"-->
	<%Case "resp_video"%><!--#include file="../skin/resp_video/reg.asp"-->
	<%Case "resp_video_en"%><!--#include file="../skin/resp_video_en/reg.asp"-->
	<%Case "resp_agent_map"%><!--#include file="../skin/resp_agent_map/reg.asp"-->
	<%Case "resp_agent_map2"%><!--#include file="../skin/resp_agent_map2/reg.asp"-->
	<%Case "resp_thesis"%><!--#include file="../skin/resp_thesis/reg.asp"-->
	<%Case "resp_catalog"%><!--#include file="../skin/resp_catalog/reg.asp"-->
	<%'PC 스킨%>
	<%Case "inquiry"%><!--#include file="../skin/inquiry/reg.asp"-->
	<%Case "inquiry_en"%><!--#include file="../skin/inquiry_en/reg.asp"-->
	<%Case "history"%><!--#include file="../skin/history/reg.asp"-->
	<%Case "ordercancel"%><!--#include file="../skin/ordercancel/reg.asp"-->
	<%Case Else%><!--#include file="../skin/resp_normal/reg.asp"-->
<%End Select%>