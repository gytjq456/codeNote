<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<%q="prod"%>
<!-- #include virtual="/site/manage/inc/head.asp" -->
<script type="text/javascript">
function CateSet(depth, p_code, s_code){
	var nTime = new Date().getTime();
	$.ajax({
		type: "GET",
		url : "cate-select.asp?_dc="+nTime+"&depth=" + depth + "&p_code=" + p_code + "&s_code=" + s_code,
		cache: false,
		success: function(resdata){
			$("div#catesel"+depth).html(resdata);
		},
		error: function(xhr, status, error) { 
			alert(error); 
		}
	});
}
</script>
</head>

<%
	r_idx			= Request("r_idx")
	recruit			= Request("recruit")

	r_birth1		= Request("r_birth1")
	birth			= Request("birth")
	r_addr			= Request("r_addr")
	rs_school	= Request("rs_school")
	r_name		= Request("r_name")
	com_NM		= Request("com_NM")
	r_state		= Request("r_state")
	
	s_keyword	= Request("s_keyword")
	s_hide		= Request("s_hide")

	s_align		= Request("s_align")

	page			= Request("page")
	If page = "" Then page = 1

	If InStr(r_birth1,"'") <> 0 Or InStr(r_birth1,"%") <> 0 Or InStr(r_birth1,",") <> 0 Or InStr(r_addr,"'") <> 0 Or InStr(r_addr,"%") <> 0 Or InStr(r_addr,",") <> 0 Or InStr(rs_school,"'") <> 0 Or InStr(rs_school,"%") <> 0 Or InStr(rs_school,",") <> 0 Or InStr(r_name,"'") <> 0 Or InStr(r_name,"%") <> 0 Or InStr(r_name,",") <> 0 Then
		Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
		Response.End
	End If

	pLink = "r_birth1=" & r_birth1 & "&birth=" & birth & "&r_addr=" & r_addr & "&rs_school=" & rs_school & "&r_name=" & r_name
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>지원자 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>지원자 관리</li>
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
				<col width="150px" />
				<col width="" />
				<col width="150px" />
				<col width="" />
			</colgroup>
			<tr>
				<th class="bdb bdr">생년월일</th>
				<td class="bdb bdr">
					<input type="text" name="r_birth1" value="<%=r_birth1%>" class="AXInput W100" placeholder="">
					<input type="radio" name="birth" value="up" class="AXInput W30" placeholder="" <% If birth = "up" Then Response.write "checked"%>>이상
					<input type="radio" name="birth" value="down" class="AXInput W30" placeholder="" <% If birth = "down" Then Response.write "checked"%>>이하
				</td>
				<th class="bdb bdr">거주지</th>
				<td class="bdb bdr"><input type="text" name="r_addr" value="<%=r_addr%>" class="AXInput W200" placeholder="거주지"></td>
			</tr>
			<tr>
			  <th class="bdb bdr">학력</th>
			  <td class="bdb bdr">
				<!--<input type="text" name="rs_school" value="<%=rs_school%>" class="AXInput W100" placeholder="학력">
					<input type="radio" name="school" value="up" class="AXInput W30" placeholder="">이상	-->
					<select name="rs_school" class="AXSelect">
						<option value=""<% If rs_school = "" Then Response.write " selected"%>>선택</option>
						<option value="고등학교"<% If rs_school = "고등학교" Then Response.write " selected"%>>고등학교</option>
						<option value="대학교"<% If rs_school = "대학교" Then Response.write " selected"%>>대학교</option>
						<option value="석사"<% If rs_school = "석사" Then Response.write " selected"%>>석사</option>
						<option value="박사"<% If rs_school = "박사" Then Response.write " selected"%>>박사</option>
					</select>
				</td>
				<th class="bdb bdr">지원자</th>
				<td class="bdb bdr"><input type="text" name="r_name" value="<%=r_name%>" class="AXInput W100" placeholder="지원자"></td>
			</tr>
			<tr>
				<th class="bdb bdr">공고명</th>
				<td class="bdb bdr">
					<input type="text" name="com_NM" value="<%=com_NM%>" class="AXInput W100" placeholder="">
				</td>
				<th class="bdb bdr">진행사항</th>
				<td class="bdb bdr">
					<select name="r_state" class="AXSelect">
						<option value="0"<% If r_state = "0" Then Response.write " selected"%>>서류전형</option>
						<option value="1"<% If r_state = "1" Then Response.write " selected"%>>서류합격</option>
						<option value="2"<% If r_state = "2" Then Response.write " selected"%>>서류불합격</option>
						<option value="3"<% If r_state = "3" Then Response.write " selected"%>>면접합격</option>
						<option value="4"<% If r_state = "4" Then Response.write " selected"%>>면접불합격</option>
						<option value="5"<% If r_state = "5" Then Response.write " selected"%>>최종합격</option>
						<option value="6"<% If r_state = "6" Then Response.write " selected"%>>지원취소</option>
						<option value="8"<% If r_state = "8" Then Response.write " selected"%>>삭제요청</option>
						<option value="9"<% If r_state = "9" Then Response.write " selected"%>>임시저장</option>
					</select>
				</td>
			</tr>
		</table>

		<div class="btn_rb">
			<ul>
				<li><input type="button" value="  초기화  " class="AXButton" style="color:#fff;background:#c4c5c9;border:1px solid #c4c5c9" onclick="location.href='?'"></li>&nbsp;
				<li><input type="submit" value="   검색   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></li>
			</ul>
		</div>
	</div>
	<!-- tb_search -->

	</form>

	<form name="listform" method="post" action="?">
	<input type="hidden" name="s_r_birth1" value="<%=r_birth1%>">
	<input type="hidden" name="s_birth" value="<%=birth%>">
	<input type="hidden" name="s_r_addr" value="<%=r_addr%>">
	<input type="hidden" name="s_rs_school" value="<%=rs_school%>">
	<input type="hidden" name="s_r_name" value="<%=r_name%>">
	<!-- tb_list -->
	<div class="tb_list">
		<h4>지원자 리스트</h4>
		<div class="btn_rb">
			<ul>
				<li>
					<select name="sel_state" class="AXSelect" onChange="javascript:SelectChk(this.value);">
						<option value="">일괄변경</option>
						<option value="0">서류전형</option>
						<option value="1">서류합격</option>
						<option value="2">서류불합격</option>
						<option value="3">면접합격</option>
						<option value="4">면접불합격</option>
						<option value="5">최종합격</option>
						<option value="6">지원취소</option>
						<option value="9">임시저장</option>
					</select>
				</li>
			</ul>
		</div><br>
		<table>
			<colgroup>
				<col width="50px" />
				<col width="50px" />
				<col width="80px" />
				<col width="" />
				<col width="100px" />
				<col width="200px" />
				<col width="100px" />
				<col width="100px" />
				<col width="200px" />
			</colgroup>
			<tr>
				<th class="bdr"><input type="checkbox" name="all" onclick="AllChk()" /></th>
				<th class="bdr">번호</th>
				<th class="bdr">사진</th>
				<th class="bdr">공고명</th>
				<th class="bdr">지원자명</th>
				<th class="bdr">연락처</th>
				<th class="bdr">진행사항</th>
				<th class="bdr">등록일</th>
				<th>관리</th>
			</tr>
			<%
				Set Rs = Server.Createobject("ADODB.Recordset")
				SQL = "SELECT A.idx, A.recruit, A.com_NM, A.work_NM, B.idx AS ridx, B.resumeid, B.r_idx, B.mid, B.r_name, B.r_hp, B.r_addr, B.r_email, B.r_file1, B.r_file, B.state, B.regdate FROM tbl_recruit A LEFT JOIN tbl_resume B ON A.idx = B.r_idx WHERE B.r_idx != '' "

				If r_birth1 <> "" Then
					If birth = "up" Then
						SQL = SQL & " AND (r_birth1 >= '" & r_birth1 & "') "
					ElseIf birth = "down" Then
						SQL = SQL & " AND (r_birth1 <= '" & r_birth1 & "') "
					Else
						SQL = SQL & " AND (r_birth1 LIKE '%" & r_birth1 & "%') "
					End If
				End If

				If r_addr <> "" Then
					SQL = SQL & " AND (B.r_addr LIKE '%" & r_addr & "%') "
				End If

				If rs_school <> "" Then
					SQL = SQL & " AND mid IN (SELECT mid FROM tbl_resume_school WHERE rs_school LIKE '%"&rs_school&"%') "
				End If

				If r_name <> "" Then
					SQL = SQL & " AND (B.r_name LIKE '%" & r_name & "%') "
				End If

				If r_state <> "" Then
					SQL = SQL & " AND (B.state = '" & r_state & "') "
				End If

				If com_NM <> "" Then
					SQL = SQL & " AND (A.com_NM LIKE '%" & com_NM & "%' OR A.work_NM LIKE '%" & com_NM & "%') "
				End If

				Select Case s_align
					Case "0"
						SQL = SQL & " ORDER BY A.com_NM ASC, A.work_NM ASC"
					Case "1"
						SQL = SQL & " ORDER BY B.state ASC"
					Case Else
						SQL = SQL & " ORDER BY B.idx DESC"
				End Select

				Rs.Open SQL, Dbcon, 1

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
						idx				= Rs("idx")
						recruit			= Rs("recruit")
						com_NM		= Rs("com_NM")
						work_NM	= Rs("work_NM")
						ridx				= Rs("ridx")
						resumeid	= Rs("resumeid")
						r_idx			= Rs("r_idx")
						m_id			= Rs("mid")
						'r_title			= Rs("r_title")
						'r_sort			= Rs("r_sort")
						'r_pay			= Rs("r_pay")
						r_name		= Rs("r_name")
						'r_birth1		= Rs("r_birth1")
						'r_birth2		= Rs("r_birth2")
						'r_birth3		= Rs("r_birth3")
						r_hp			= Rs("r_hp")
						r_addr			= Rs("r_addr")
						r_email		= Rs("r_email")
						r_file1			= Rs("r_file1")
						r_file			= Rs("r_file")
						state			= Rs("state")
						regdate		= Rs("regdate")
			%>
			<tr>
				<td class="bdr bdt"><input type="checkbox" name="sel_idx" id="sel_idx" value="<%=ridx%>" /></td>
				<td class="bdr bdt"><%=num%></td>
				<td class="bdr bdt"><% If r_file1 <> "" Then%><img src="/upload/recruit/<%=r_file1%>" alt="<%=r_file1%>" style="width:50px" /><% End If %></td>
				<td class="bdr bdt tit"><%=com_NM%> (<%=work_NM%>)</td>
				<td class="bdr bdt"><%=r_name%></td>
				<td class="bdr bdt"><%=r_hp%></td>
				<td class="bdr bdt">
					<select name="state" class="AXSelect" onChange="javascript:tradeChange(<%=ridx%>,this.value);">
						<option value="0"<% If state = "0" Then Response.write " selected"%>>서류전형</option>
						<option value="1"<% If state = "1" Then Response.write " selected"%>>서류합격</option>
						<option value="2"<% If state = "2" Then Response.write " selected"%>>서류불합격</option>
						<option value="3"<% If state = "3" Then Response.write " selected"%>>면접합격</option>
						<option value="4"<% If state = "4" Then Response.write " selected"%>>면접불합격</option>
						<option value="5"<% If state = "5" Then Response.write " selected"%>>최종합격</option>
						<option value="6"<% If state = "6" Then Response.write " selected"%>>지원취소</option>
						<option value="8"<% If state = "8" Then Response.write " selected"%>>삭제요청</option>
						<option value="9"<% If state = "9" Then Response.write " selected"%>>임시저장</option>
					</select>
				</td>
				<td class="bdr bdt"><%=Left(regdate,10)%></td>
				<td class="bdt">
				<% If recruit = "2" Then %>
					<input type="button" value="다운로드" class="AXButtonSmall Blue" onclick="location.href='/site/Down.asp?fileName=<%=r_file%>'">
				<% Else %>
					<input type="button" value="상세보기" class="AXButtonSmall Blue" onclick="location.href='application-reg.asp?mode=mod&resumeid=<%=resumeid%>&idx=<%=ridx%>&r_idx=<%=r_idx%>&m_id=<%=m_id%>&recruit=<%=recruit%>&per=ALL'">
				<% End If %>
					<input type="button" value=" 삭제 " class="AXButtonSmall" style="background:#cbac7b; color:#fff; border:1px solid #cbac7b" onclick="if(confirm('해당 지원서를 삭제 하시겠습니까?')){ location.href='application-reg-ok.asp?mode=del&per=ALL&r_idx=<%=r_idx%>&resumeid=<%=resumeid%>' }">
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
					<td colspan="9" class="bdr bdt">등록된 지원자가 없습니다.</td>
				</tr>
			<%
				End If
				Rs.Close
				Set Rs = Nothing
			%>
		</table>
	</div>
	<!-- tb_list -->

	</form>

	<form name="form" method="post" action="state_ok.asp">
	<input type="hidden" name="state_idx" value="">
	<input type="hidden" name="state_value" value="">
	</form>

	<!-- page -->
	<div class="page">
		<ul>
			<% Call pagelist("?" & pLink, CInt(page), 20, 10, Rs_RecordCount) %>
		</ul>
	</div>
	<!-- //page -->

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
			<!--<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='application_excel.asp?<%=pLink%>'"></span>-->
			<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="excel()"></span>
			<!--span><input type="button" value="  엑셀일괄등록  " class="AXButton Green" onclick="location.href='prod-excel-reg.asp'"></span-->
		</p>
		<p class="right">
			<!--<span><input type="button" value="   채용등록   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="location.href='recruit-reg.asp?mode=reg'"></span>-->
			<%If sc_email<>"" Then%>
			<span><input type="button" value="  선택메일발송  " class="AXButton" style="color:#fff;background:#95a1ba; color:#fff; border:1px solid #95a1ba;" onclick="MessageSend('m')"></span>
			<%End If%>
		</p>
	</div>
	<!-- //btn_left_right -->

</div>
<!-- //contents --><!-- ---------------------------------------------------------------------------------------------- -->

<script>

function AllChk() {
	var frm = document.listform;
	var is_check = (frm.all.checked) ? true : false;
	for (var i=0; i<frm.elements.length; i++) frm.elements[i].checked = is_check;
}

// 상태 변경
function tradeChange(idx,pval1){

	var frm	=	document.form;

	frm.state_idx.value		=	idx;
	frm.state_value.value	=	pval1;

	if(pval1==0) {
	    var choose = confirm( '서류전형 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==1) {
		var choose = confirm( '서류합격 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==2) {
	    var choose = confirm( '서류불합격 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==3) {
	    var choose = confirm( '면접합격 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==4) {
	    var choose = confirm( '면접불합격 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==5) {
	    var choose = confirm( '최종합격 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==6) {
	    var choose = confirm( '지원취소 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	} else if(pval1==9) {
	    var choose = confirm( '임시저장 상태로 변경 하시겠습니까?');
		if(choose) {	frm.submit(); }
	}
	
}

function SelectChk(){
	var frm = document.listform;
	var tmpb=false;
	var cnt=0;
	if(document.getElementsByName("sel_idx").length==1){
		if(frm.sel_idx.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("sel_idx").length; i++){
			if(frm.sel_idx[i].checked){
				tmpb=true;
				cnt=cnt+1;
			}
		}
	}

	if(tmpb==false){
		alert('하나이상 체크해주세요.');
		return;
	}

	if (confirm("선택된 " + cnt + "개의 항목을 변경하시겠습니까?")){
		frm.action = "state_ok.asp?mode=sel_p";
		frm.submit();
	}else{
		return;
	}
}

function MessageSend(d){
	var frm = document.listform;
	var tmpb=false;
	var cnt=0;
	if(document.getElementsByName("sel_idx").length==1){
		if(frm.sel_idx.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("sel_idx").length; i++){
			if(frm.sel_idx[i].checked){
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

function excel() {
	var sel_idx		= listform.sel_idx.value;
	var r_birth1		= searchform.r_birth1.value;
	var birth			= searchform.birth.value;
	var r_addr			= searchform.r_addr.value;
	var rs_school	= searchform.rs_school.value;
	var r_name		= searchform.r_name.value;

	var frm = document.listform;
	var cnt=0;
	if(document.getElementsByName("sel_idx").length==1){
		if(frm.sel_idx.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("sel_idx").length; i++){
			if(frm.sel_idx[i].checked){
				tmpb=true;
				cnt=cnt+1;
			}
		}
	}
	//location.href="application_excel.asp?r_birth1="+r_birth1+"&birth="+birth+"&r_addr="+r_addr+"&rs_school="+rs_school+"&r_name="+r_name+"&sel_idx="+sel_idx;
	frm.action = "application_excel.asp";
	frm.submit();
}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->