<%
'게시물 정보 취득
If mode="reg" Then
	c_mem_name = W_NAME
	c_mem_id = W_ID
	c_mem_pw = W_PW
	c_mem_email = W_EMAIL
	c_mem_url = "http://"
	c_cate_idx = Request("s_cate")

ElseIf mode="mod" Then

	ReDim c_file(15)

	Set Rs = Server.CreateObject("ADODB.RecordSet")
	Sql = "SELECT * FROM tbl_board_data WHERE board_idx='" & bid & "' AND idx='" & idx & "'"
	Rs.open Sql, Dbcon, 1
	If Rs.EOF=False Then
		c_idx = Rs("idx")
		c_board_idx = Rs("board_idx")
		c_cate = Rs("cate")
		c_e1_idx = Rs("e1_idx")
		c_e2_idx = Rs("e2_idx")
		c_num = Rs("num")
		c_p_num = Rs("p_num")
		c_r_num = Rs("r_num")
		c_d_num = Rs("d_num")
		c_mem_name = Rs("mem_name")
		c_mem_id = Rs("mem_id")
		c_mem_pw = AESDecrypt(Rs("mem_pw"), "webmoa")
		c_mem_tel = Rs("mem_tel")
		c_mem_fax = Rs("mem_fax")
		c_mem_url = Rs("mem_url")
		c_mem_email = Rs("mem_email")
		c_addtext1 = Rs("addtext1")
		c_addtext2 = Rs("addtext2")
		c_addtext3 = Rs("addtext3")
		c_addtext4 = Rs("addtext4")
		c_addtext5 = Rs("addtext5")
		c_addtext6 = Rs("addtext6")
		c_addtext7 = Rs("addtext7")
		c_addtext8 = Rs("addtext8")
		c_addtext9 = Rs("addtext9")
		c_addtext10 = Rs("addtext10")
		c_addtext11 = Rs("addtext11")
		c_addtext12 = Rs("addtext12")
		c_addtext13 = Rs("addtext13")
		c_addtext14 = Rs("addtext14")
		c_addtext15 = Rs("addtext15")
		c_addtext16 = Rs("addtext16")
		c_addtext17 = Rs("addtext17")
		c_addtext18 = Rs("addtext18")
		c_addtext19 = Rs("addtext19")
		c_addtext20 = Rs("addtext20")
		c_title = Rs("title")
		c_content = Rs("content")
		c_seo_title = Rs("seo_title")
		c_seo_keyword = Rs("seo_keyword")
		c_seo_description = Rs("seo_description")
		c_comment_count = Rs("comment_count")
		c_read_count = Rs("read_count")
		c_ip = Rs("ip")
		For fc=0 To k_upload-1
			c_file(fc) = Rs("file" & fc+1)
		Next
		c_html = Rs("html")
		c_notice = Rs("notice")
		c_repmail = Rs("repmail")
		c_lock = Rs("lock")
		c_popup = Rs("popup")
		c_regdate = Rs("regdate")
	Else
		Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
		Response.End
	End If
	Rs.Close
	Set Rs = Nothing

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
%>

<script>
$(function(){
	$("input[type=checkbox]").checkboxradio();

	$("#regdate").datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'HH:mm',
		controlType:'select',
        oneLine:true,
	});
});
</script>

<form name="regform" action="?<%=pLink%>&amp;mode=<%=mode%>_p&amp;idx=<%=idx%>&amp;page=<%=page%>&amp;p_num=<%=p_num%>" method="post" enctype="multipart/form-data" onsubmit="return RegChk(this)">
	<input type="hidden" name="ssid" value="<%=Left(Session.SessionID,2)%>" />
	<input type="hidden" name="html" value="<%=k_html%>" />

	<div class="tb_info">
		<h4>게시물 관리</h4>
		<table>
			<colgroup>
				<col width="20%" />
				<col width="" />
			</colgroup>
			<%If k_category<>"" Then%>
			<tr>
				<th class="title bdr bdt">카테고리</th>
				<td class="bdt bdr">
					<select name="cate" class="AXSelect">
						<%
						a_category = Split(k_category, "|")
						For Each cate_item In a_category
						%>
							<option value="<%=cate_item%>" <%If Trim(c_cate)=Trim(cate_item) Then Response.Write "selected"%>><%=cate_item%></option>
						<%
						Next
						%>
					</select>
				</td>
			</tr>
			<%End If%>

			<tr>
				<th class="title bdr bdt">이름</th>
				<td class="bdt bdr"><input type="text"  name="name" size="15" value="<%=c_mem_name%>" class="AXInput" required /></td>
			</tr>

			<%If k_counsel=True Then%>
				<input type="hidden"  name="pw" value="1111" />
			<%Else%>
				<%If (W_ID="" And mode="reg") Or (W_ID="" And mode="rep") Then%>
				<tr>
					<th class="title bdr bdt">비밀번호</th>
					<td class="bdt bdr"><input type="password"  name="pw" size="15" value="<%If mode="rep" Then Response.Write c_mem_pw%>" class="AXInput" required/></td>
				</tr>
				<%Else%>
				<input type="hidden"  name="pw" value="<%=c_mem_pw%>">
				<%End If%>
			<%End If%>

			<%If u_tel=True Then%>
			<tr>
				<th class="title bdr bdt">연락처</th>
				<td class="bdt bdr"><input type="text"  name="mem_tel" size="15" maxlength="15" value="<%=c_mem_tel%>" class="AXInput" /> 예) 02-123-4567</td>
			</tr>
			<%End If%>

			<%If u_fax=True Then%>
			<tr>
				<th class="title bdr bdt">FAX</th>
				<td class="bdt bdr"><input type="text"  name="mem_fax" size="15" maxlength="15" value="<%=c_mem_fax%>" class="AXInput" /> 예) 02-123-4568</td>
			</tr>
			<%End If%>

			<%If u_url=True Then%>
			<tr>
				<th class="title bdr bdt">링크URL</th>
				<td class="bdt bdr"><input type="text"  name="mem_url" value="<%=c_mem_url%>" class="AXInput" style="width:80%;" /></td>
			</tr>
			<%End If%>

			<tr style="display:none">
				<th class="title bdr bdt">이메일</th>
				<td class="bdt bdr"><input type="text"  name="email" maxlength="50" value="<%=c_mem_email%>" class="AXInput" style="width:80%; max-width:300px" /></td>
			</tr>

			<tr>
				<th class="title bdr bdt">제목</th>
				<td class="bdt bdr"><input type="text"  name="title" style="width:95%" maxlength="200" value="<%=TagText(c_title)%>" class="AXInput" required /></td>
			</tr>

			<%If k_counsel=False Then%>
			<tr>
				<th class="title bdr bdt">옵션</th>
				<td class="bdt bdr">
				<label><input type="checkbox" name="lock" value="1" <%If c_lock=True Then Response.Write "checked"%> class="vmiddle" />비공개글</label>
				<%If W_LEVEL="1" Or W_LEVEL="2" Then%>
				<label><input type="checkbox" name="notice" value="1" <%If c_notice=True Then Response.Write "checked"%> class="vmiddle" />최상단</label>
				<%End If
				If k_repmail=True Then
					If (mode="reg" Or (mode="mod" And d_num="0")) And a_reply<>"0" Then%>
						<label><input type="checkbox" name="repmail" value="1" <%If c_repmail=True Then Response.Write "checked"%> class="vmiddle" />답변메일받기</label>
					<%End If
				End If%>
				</td>
			</tr>
			<%End If%>

			<tr>
				<th class="title bdr bdt">내용</th>
				<td class="bdt bdr">
				<textarea cols="" rows="" name="content" id="content" style="width:100%; height:250px"><%=c_content%></textarea></td>
			</tr>

			<!-- 파일첨부 -->
			<%For fc=0 To k_upload-1%>
			<tr>
				<th class="title bdr bdt"><%If fc=0 Then : Response.Write " 썸네일" : Else : Response.Write " 파일첨부" & fc : End If%></th>
				<td class="bdt bdr">
				<%If mode="mod" Then
					if c_file(fc)="" Then%>
						현재 등록된 파일이 없습니다.<br />
					<%Else%>
						현재 <span class="font_comcnt"><%=c_file(fc)%></span> 파일이 등록되어 있습니다.(<input type="checkbox" name="file<%=fc+1%>_del" value="1" class="vmiddle" />삭제)<br />
					<%End If
				End If%>
				<input type="file"  name="file<%=fc+1%>" size="33" /></td>
			</tr>
			<%Next%>
			<!-- //파일첨부 -->

			<%If k_seo=True Then%>
			<!-- SEO 적용시 -->
			<tr>
				<th class="title bdr bdt">Head Title</th>
				<td class="bdt bdr"><input type="text"  name="seo_title" style="width:98%" value="<%=c_seo_title%>" class="AXInput" /></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Meta Tag Keyword</th>
				<td class="bdt bdr"><input type="text"  name="seo_keyword" style="width:98%" value="<%=c_seo_keyword%>" class="AXInput" /></td>
			</tr>
			<tr>
				<th class="title bdr bdt">Meta Tag Description</th>
				<td class="bdt bdr"><input type="text"  name="seo_description" style="width:98%" value="<%=c_seo_description%>" class="AXInput" /></td>
			</tr>
			<!-- //SEO 적용시 -->
			<%End If%>

			<%If k_spamcode=True Then%>
			<tr>
				<th class="title bdr bdt">자동등록방지</th>
				<td class="bdt bdr">
				<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /> <input type="button" value="새로고침" class="AXButton Classic" onclick="RefreshImage('imgCaptcha');" />
				<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput vmiddle" style="width:118px" maxlength="5" autocomplete="off" required /><br /></td>
			</tr>
			<%End If%>

			<%If c_regdate<>"" Then%>
			<tr style="display:none">
				<th class="title bdr bdt">등록일</th>
				<td class="bdt bdr"><input type="text" id="regdate" name="regdate" size="16" maxlength="16" value="<%=FormatDateTime(c_regdate, 2) & " " & FormatDateTime(c_regdate, 4)%>" class="AXInput" /> 예) 2019-07-01 01:14</td>
			</tr>
			<%End If%>
		</table>
	</div>
	<!-- tb_info -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="right">
			<span><input type="submit" value="   적용   " class="AXButton Blue"></span>
			<span><input type="button" value="   취소   " class="AXButton" onclick="history.back()"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

</form>

<script type="text/javascript">
function RegChk(obj){
	<%If k_editor="smarteditor2" Then%>oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);<%End If%>
}


<%If k_editor="smarteditor2" Then%>
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
  oAppRef: oEditors,
  elPlaceHolder: "content",
  sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
  fCreator: "createSEditor2"
});
<%End If%>
</script>