<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script>
$( function() {
	$("#s_srdate").datepicker({dateFormat: 'yy-mm-dd'});
	$("#s_erdate").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>
</head>

<%
s_keyword = Request("s_keyword")
s_srdate = Request("s_srdate")
s_erdate = Request("s_erdate")
s_mailing = Request("s_mailing")
s_sort = Request("s_sort")
s_m_lang = Request("s_m_lang")

s_align = Request("s_align")
If s_align="" Then s_align="0"

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_mailing=" & s_mailing & "&s_sort=" & s_sort & "&s_align=" & s_align

ReDim mem_lev(100), mem_sort(100)
Set RsL = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_member_level "
Sql = Sql & " WHERE m_lev!='' "
Sql = Sql & " ORDER BY m_lev, m_sort  "
'Response.Write Sql
RsL.Open Sql, Dbcon, 1
l_num=0
Do Until RsL.EOF
	mem_lev(l_num) = RsL("m_lev")
	mem_sort(l_num) = RsL("m_sort")
	l_num=l_num+1
	RsL.MoveNext
Loop
RsL.Close
Set RsL = Nothing

%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>회원 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>회원 관리</li>
	</ul>
</div>
<!-- //location -->


<!-- contents --><!-- ---------------------------------------------------------------------------------------------- -->
<div class="contents">

	<form name="searchform" method="post" action="?">

	<!-- tb_search -->
	<div class="tb_search">
		<table>
			<colgroup>
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
				<col width="90px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="이름, 아이디, 이메일, 주소 등"></td>
				<th class="bdb bdr">가입일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W100" autocomplete="off" maxlength="10" /></div>
				</td>
				<th class="bdb bdr">메일수신여부</th>
				<td class="bdb">
				<select name="s_mailing" id="s_mailing" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="1" <%If s_mailing="1" Then Response.Write "selected"%>>수신함</option>
					<option value="0" <%If s_mailing="0" Then Response.Write "selected"%>>수신안함</option>
				</select></td>
			</tr>
			<tr>
				<th class="bdb bdr">정렬</th>
				<td class="bdb bdr">
				<select name="s_align" id="s_align" class="AXSelect">
					<option value="0" <%If s_align="0" Then Response.Write "selected"%>>가입일(-)</option>
					<option value="1" <%If s_align="1" Then Response.Write "selected"%>>가입일(+)</option>
					<option value="2" <%If s_align="2" Then Response.Write "selected"%>>이름(-)</option>
					<option value="3" <%If s_align="3" Then Response.Write "selected"%>>이름(+)</option>
					<option value="4" <%If s_align="4" Then Response.Write "selected"%>>아이디(-)</option>
					<option value="5" <%If s_align="5" Then Response.Write "selected"%>>아이디(+)</option>
					<option value="6" <%If s_align="6" Then Response.Write "selected"%>>접속횟수(-)</option>
					<option value="7" <%If s_align="7" Then Response.Write "selected"%>>접속횟수(+)</option>
				</select>
				</td>
				<th class="bdb bdr">회원등급</th>
				<td class="bdb bdr">
				<select name="s_sort" id="s_sort" class="AXSelect">
				<%
				Response.Write "<option value=''>---- 전체 ----</option>" & Chr(13) & Chr(10)				
				For l_num=0 To 99
					If mem_lev(l_num)<>"" Then
						Response.Write "<option value='" & mem_sort(l_num) & "' "
						If Trim(mem_sort(l_num))=Trim(s_sort) Then Response.Write "selected"
						Response.Write ">" & mem_lev(l_num) & ":" & mem_sort(l_num) & "</option>" & Chr(13) & Chr(10)
					End If
				Next%>
				</select>
				</td>
				<th class="bdb bdr"></th>
				<td class="bdb bdr"></td>
				<!--th class="bdb bdr">언어</th>
				<td class="bdb bdr">
				<select name="s_m_lang" id="s_m_lang" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="kr" <%If s_m_lang="kr" Then Response.Write "selected"%>>한국어</option>
					<option value="en" <%If s_m_lang="en" Then Response.Write "selected"%>>영어</option>
				</select>
				</td-->
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton Blue"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<form name="listform" method="post" action="?">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>회원 리스트</h4>
		<table>
			<colgroup>
				<col width="4%" />
<!-- 				<col width="4%" /> -->
				<col width="4%" />
				<col width="10%" />
				<col width="13%" />
				<col width="9%" />
				<col width="" />
				<col width="11%" />
				<col width="6%" />
				<col width="12%" />
				<col width="9%" />
			</colgroup>
			<tr>
				<th class="bdr"><input type="checkbox" name="all" onclick="AllChk()" /></th>
<!-- 				<th class="bdr">언어</th> -->
				<th class="bdr">번호</th>
				<th class="bdr">회원등급</th>
				<th class="bdr">아이디</th>
				<th class="bdr">이름</th>
				<th class="bdr">이메일</th>
				<th class="bdr">휴대전화</th>
				<th class="bdr">접속횟수</th>
				<th class="bdr">가입일</th>
				<th>관리</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT * FROM tbl_member "
			Sql = Sql & " WHERE idx!='' "
			Sql = Sql & " AND m_lev>=10 "	'관리자를 제외한 회원만 검색

			If s_keyword<>"" Then
				Sql = Sql & " AND (m_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_id LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_email LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR m_addr2 LIKE '%" & s_keyword & "%') "
			End If

			If s_mailing<>"" Then Sql = Sql & " AND m_mailing='" & s_mailing & "' "
			If s_sort<>"" Then Sql = Sql & " AND m_sort='" & s_sort & "' "

			If s_srdate<>"" And s_erdate<>"" Then
				Sql = Sql & "AND regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
			ElseIf s_srdate<>"" Then
				Sql = Sql & "AND regdate>'" & s_srdate & "' "
			ElseIf s_erdate<>"" Then
				Sql = Sql & "AND regdate<'" & DateAdd("d", 1, s_erdate) & "' "
			End If

			If s_m_lang<>"" Then Sql = Sql & " AND m_lang='" & s_m_lang & "' "

			Select Case s_align
				Case "0"
					Sql = Sql & " ORDER BY regdate DESC"
				Case "1"
					Sql = Sql & " ORDER BY regdate"
				Case "2"
					Sql = Sql & " ORDER BY m_name DESC"
				Case "3"
					Sql = Sql & " ORDER BY m_name"
				Case "4"
					Sql = Sql & " ORDER BY m_id DESC"
				Case "5"
					Sql = Sql & " ORDER BY m_id"
				Case "6"
					Sql = Sql & " ORDER BY m_logcount DESC"
				Case "7"
					Sql = Sql & " ORDER BY m_logcount"
			End Select
			'Response.Write Sql
			Rs.Open Sql, Dbcon, 1

			'페이지 설정
			If Rs.EOF=False Then
				Rs.PageSize = 20
				Rs.AbsolutePage = page
				Rs_RecordCount = Rs.RecordCount
				If Rs_RecordCount Mod Rs.PageSize>0 Then
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)+1
				Else
					maxpage = CInt(Rs_RecordCount/Rs.PageSize)
				End If
			End If

			If Rs.EOF=False Then
				cnt=0
				num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
				Do Until Rs.EOF Or cnt>=Rs.pagesize
					idx = Rs("idx")
					m_id = Rs("m_id")
					m_lang = Rs("m_lang")
					m_lev = Rs("m_lev")
					m_sort = Rs("m_sort")
					m_name = Rs("m_name")
					m_email = Rs("m_email")
					m_mailing = Rs("m_mailing")
					m_cell1 = Rs("m_cell1")
					m_cell2 = Rs("m_cell2")
					m_cell3 = Rs("m_cell3")
					m_logcount = Rs("m_logcount")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><input type="checkbox" name="m_id" id="m_id" value="<%=m_id%>" /></td>
<!-- 						<td class="bdr bdt"><%=m_lang%></td> -->
						<td class="bdr bdt"><%=num%></td>
						<td class="bdr bdt">
						<select name="m_levmxd" id="m_levmxd" class="AXSelect" onchange="location.href='member-reg-ok.asp?mode=levmod&m_id=<%=m_id%>&page=<%=page%>&m_levmxd='+this.value+'&<%=pLink%>'">
						<%
						For l_num=0 To 99
							If mem_lev(l_num)<>"" Then
								Response.Write "<option value='" & mem_lev(l_num) & ":" & mem_sort(l_num) & "' "
								If m_lev & ":" & m_sort=mem_lev(l_num) & ":" & mem_sort(l_num) Then Response.Write "selected"
								Response.Write ">" & mem_lev(l_num) & ":" & mem_sort(l_num) & "</option>" & Chr(13) & Chr(10)
							End If
						Next%>
						</select></td>
						<td class="bdr bdt">
						<%=SnsMemberIcon(m_id)%>
						<%=Left(m_id, 15)%>
						<%If Len(m_id)>15 Then Response.write ".."%></td>
						<td class="bdr bdt"><%=m_name%></td>
						<td class="bdr bdt"><%=m_email%>
						<%If m_mailing=False Then Response.Write " <span class='red'>(미수신)</span>"%></td>
						<td class="bdr bdt"><%=m_cell1 & "-" & m_cell2 & "-" & m_cell3%></td>
						<td class="bdr bdt"><%=m_logcount%></td>
						<td class="bdr bdt"><%=regdate%></td>
						<td class="bdt">
						<input type="button" value=" 보기 " class="AXButtonSmall" style="background:#7b88cb; color:#fff; border:1px solid #7b88cb" onclick="location.href='member-reg.asp?m_lang=<%=m_lang%>&mode=mod&m_id=<%=m_id%>'">
						<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 회원의 모든 정보가 삭제됩니다. 진행하시겠습니까?')){ location.href='member-reg-ok.asp?mode=del_p&m_id=<%=m_id%>' }">
						<%If mc_point_use=True Then%>
						<br /><input type="button" value="포인트내역" class="AXButtonSmall Classic" style="background:#95a1ba; color:#fff; border:1px solid #95a1ba; margin-top:4px;" onclick="open('point.asp?mode=mod&s_m_id=<%=m_id%>', 'mp', 'width=1000px, height=800px, scrollbars=yes')">
						<%End If%>						
						</td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="10" class="bdr bdt">회원이 존재하지 않습니다.</td>
				</tr>
			<%
			End If
			Rs.Close
			Set Rs = Nothing%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<!-- page -->
	<%Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount)%>
	<!-- //page -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<span><input type="button" value="   선택삭제   " class="AXButton Blue" onclick="DelChk()"></span>
			<%If sc_email<>"" Then%>
			<span><input type="button" value="  선택메일발송  " class="AXButton" style="color:#fff;background:#95a1ba; color:#fff; border:1px solid #95a1ba;" onclick="MessageSend('m')"></span>
			<%End If%>
			<%If sms_key<>"" Then%>
			<span><input type="button" value="  선택문자발송  " class="AXButton" style="color:#fff;background:#95a1ba; color:#fff; border:1px solid #95a1ba;" onclick="MessageSend('s')"></span>
			<%End If%>
		</p>
		<p class="right">
			<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='member-excel.asp?<%=pLink%>'"></span>
			<span><input type="button" value="   회원등록   " class="AXButton Blue" onclick="location.href='member-reg.asp?mode=reg'"></span>
		</p>
	</div>
	<!-- //btn_left_right -->

	<%If W_LEVEL="1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>회원 관련 폼 삽입 방법</b><br />
			&lt;%b_lang="kr" '한국어:kr, 영어:en%&gt;<br />
			&lt;%mode="join" '가입:join, 정보수정:mod, 로그인:login, ID/PW찾기:idpw%&gt;<br />
			&lt;%rturl="/" 'DB처리 후 페이지 이동 주소%&gt;<br />
			&lt;!--#include virtual="/site/member/member.asp"--&gt;<br />
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

<script>
function AllChk() {
	var frm = document.listform;
	var is_check = (frm.all.checked) ? true : false;
	for (var i=0; i<frm.elements.length; i++) frm.elements[i].checked = is_check;
}

function DelChk(){
	var frm = document.listform;
	var tmpb=false;
	var cnt=0;
	if(document.getElementsByName("m_id").length==1){
		if(frm.m_id.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("m_id").length; i++){
			if(frm.m_id[i].checked){
				tmpb=true;
				cnt=cnt+1;
			}
		}
	}

	if(tmpb==false){
		alert('하나이상 체크해주세요.');
		return;
	}

	if (confirm("선택된 " + cnt + "개의 항목을 삭제하시겠습니까?")){
		frm.action = "member-reg-ok.asp?mode=seldel_p";
		frm.submit();
	}else{
		return;
	}
}

function MessageSend(d){
	var frm = document.listform;
	var tmpb=false;
	var cnt=0;
	if(document.getElementsByName("m_id").length==1){
		if(frm.m_id.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("m_id").length; i++){
			if(frm.m_id[i].checked){
				tmpb=true;
				cnt=cnt+1;
			}
		}
	}

	if(tmpb==false){
		alert('하나이상 체크해주세요.');
		return;
	}
	
	if (d=="m"){
		frm.action = "mail-send.asp";
	}else if (d=="s"){
		frm.action = "sms-send.asp";
	}
	frm.submit();
}
</script>

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->