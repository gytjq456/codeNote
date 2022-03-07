<%
'읽기권한
If CInt(a_content)<CInt(W_LEVEL) Then
	Response.Write "<script>alert('게시물 읽기 권한이 없습니다.[1]'); history.back();</script>"
	Response.End
End If

req_pw = Request("pw")
If InStr(req_pw,"'")>0 Or InStr(req_pw,"%")>0 Then
	Response.Write "<script>alert('게시물 읽기 권한이 없습니다.[2]'); history.back();</script>"
	Response.End
End If 

'읽기권한 체크
If (c_lock=True And c_mem_pw<>req_pw) And (W_ID="" Or W_ID<>c_mem_id) And (W_LEVEL<>"1" And W_LEVEL<>"2") Then
	Response.Write "<script>alert('게시물 읽기 권한이 없습니다.[3]'); history.back();</script>"
	Response.End
End If

'새로고침시 조회수 증가 방지용 쿠키
If Request.Cookies("BBS_HIT_" & idx)="" Then
	Dbcon.Execute "UPDATE tbl_board_data SET read_count=read_count+1 WHERE board_idx='" & bid & "' AND idx='" & idx & "'"
	Response.Cookies("BBS_HIT_" & idx) = "y"
End If

'뷰 스킨
Select Case k_mode%>
	<%'반응형 스킨%>
	<%Case "resp_normal"%><!--#include file="../skin/resp_normal/content.asp"-->
	<%Case "resp_normal_en"%><!--#include file="../skin/resp_normal_en/content.asp"-->
	<%Case "resp_gallery"%><!--#include file="../skin/resp_gallery/content.asp"-->
	<%Case "resp_gallery_en"%><!--#include file="../skin/resp_gallery_en/content.asp"-->
	<%Case "resp_gallery2"%><!--#include file="../skin/resp_gallery2/content.asp"-->
	<%Case "resp_gallery2_en"%><!--#include file="../skin/resp_gallery2_en/content.asp"-->
	<%Case "resp_photo"%><!--#include file="../skin/resp_photo/content.asp"-->
	<%Case "resp_photo2"%><!--#include file="../skin/resp_photo2/content.asp"-->
	<%Case "resp_photo2_en"%><!--#include file="../skin/resp_photo2_en/content.asp"-->
	<%Case "resp_agent_map"%><!--#include file="../skin/resp_agent_map/content.asp"-->
	<%Case "resp_agent_map2"%><!--#include file="../skin/resp_agent_map2/content.asp"-->
	<%Case "resp_schedule3"%><!--#include file="../skin/resp_schedule3/content.asp"-->
	<%Case "resp_square"%><!--#include file="../skin/resp_square/content.asp"-->
	<%Case "resp_square2"%><!--#include file="../skin/resp_square2/content.asp"-->
	<%Case "resp_thesis"%><!--#include file="../skin/resp_thesis/content.asp"-->
	<%Case "resp_recruit"%><!--#include file="../skin/resp_recruit/content.asp"-->
	<%Case "resp_recruit_en"%><!--#include file="../skin/resp_recruit_en/content.asp"-->
	<%Case "resp_faq"%><!--#include file="../skin/resp_faq/content.asp"-->
	<%Case "resp_video"%><!--#include file="../skin/resp_video/content.asp"-->
	<%Case "resp_video_en"%><!--#include file="../skin/resp_video_en/content.asp"-->
	<%'PC 스킨%>
	<%Case "history"%><!--#include file="../skin/history/content.asp"-->
	<%Case "ordercancel"%><!--#include file="../skin/ordercancel/content.asp"-->
	<%Case Else%><!--#include file="../skin/resp_normal/content.asp"-->
<%End Select%>

<script type="text/javascript">document.cookie = "read_count<%=idx%>=" + escape("y") + ";path=/;"</script>