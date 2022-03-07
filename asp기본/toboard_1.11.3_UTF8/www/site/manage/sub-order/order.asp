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
s_state = Request("s_state")
s_pay_method = Request("s_pay_method")

page = Request("page")
If page="" Then page=1

If InStr(s_keyword,"'")<>0 Or InStr(s_keyword,"%")<>0 Or InStr(s_keyword,",")<>0 Then
	Response.Write "<script>alert('사용할 수 없는 문자가 포함되어 있습니다.'); history.back();</script>"
	Response.End
End If

pLink = "s_keyword=" & s_keyword & "&s_srdate=" & s_srdate & "&s_erdate=" & s_erdate & "&s_state=" & s_state & "&s_pay_method=" & s_pay_method
%>

<!-- header -->
<!-- #include virtual="/site/manage/inc/header.asp" -->

<!-- location -->
<div class="location">
	<p>주문 관리</p>
	<ul>
		<li>Home <span>&gt;</span></li>
		<li>주문 관리</li>
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
			</colgroup>
			<tr>
				<th class="bdb bdr">주문일</th>
				<td class="bdb bdr">
					<div class="inlineBlock"><input type="text" name="s_srdate" id="s_srdate" value="<%=s_srdate%>" class="AXInput W90" autocomplete="off" /></div> ~
					<div class="inlineBlock"><input type="text" name="s_erdate" id="s_erdate" value="<%=s_erdate%>" class="AXInput W90" autocomplete="off" /></div>
				</td>
				<th class="bdb bdr">진행상태</th>
				<td class="bdb">
				<select name="s_state" id="s_state" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<option value="결제대기" <%If s_state="결제대기" Then Response.Write "selected"%>>결제대기</option>
					<option value="결제완료" <%If s_state="결제완료" Then Response.Write "selected"%>>결제완료</option>
					<option value="발송준비" <%If s_state="발송준비" Then Response.Write "selected"%>>발송준비</option>
					<option value="발송완료" <%If s_state="발송완료" Then Response.Write "selected"%>>발송완료</option>
					<option value="주문취소" <%If s_state="주문취소" Then Response.Write "selected"%>>주문취소</option>
					<option value="교환" <%If s_state="교환" Then Response.Write "selected"%>>교환</option>
					<option value="반품" <%If s_state="반품" Then Response.Write "selected"%>>반품</option>
				</select></td>
			</tr>
			<tr>
				<th class="bdb bdr">통합검색</th>
				<td class="bdb bdr"><input type="text" name="s_keyword" value="<%=s_keyword%>" class="AXInput" style="width:95%" placeholder="주문자명, 아이디 등"></td>
				<th class="bdb bdr">결제수단</th>
				<td class="bdb">
				<select name="s_pay_method" id="s_pay_method" class="AXSelect">
					<option value="">---- 전체 ----</option>
					<%If mc_bank_flag=True Then%><option value="무통장입금" <%If s_pay_method="무통장입금" Then Response.Write "selected"%>>무통장입금</option><%End If%>
					<option value="신용카드" <%If s_pay_method="신용카드" Then Response.Write "selected"%>>신용카드</option>
				</select></td>
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

	<%If s_state="-1" Then%>
	<!-- tip_box -->
	<div class="tip_box" style="width:100%">
		<p>
			<b>미주문 내역</b>은 최종적으로 주문이 완료되지 않은 리스트 입니다.
			실제로 구매한 것이 아니므로 참고 바랍니다.
		</p>
	</div>
	<!-- //tip_box -->
	<%End If%>

	<form name="listform" method="post" action="?">

	<!-- tb_list -->
	<div class="tb_list">
		<h4>주문 리스트</h4>
		<table>
			<colgroup>
				<col width="8%" />
				<col width="12%" />
				<col width="8%" />
				<col width="9%" />
				<col width="7%" />
				<col width="7%" />
				<col width="" />
				<col width="12%" />
			</colgroup>
			<tr>
				<th class="bdr">주문코드</th>
				<th class="bdr">아이디</th>
				<th class="bdr">이름</th>
				<th class="bdr">결제수단</th>
				<th class="bdr">진행상태</th>
				<th class="bdr">총 결제 금액(원)</th>
				<th class="bdr">배송지주소</th>
				<th class="">주문일</th>
			</tr>
			<%
			Set Rs = Server.Createobject("ADODB.Recordset")
			Sql = "SELECT A.* FROM tbl_mall_order A "
			Sql = Sql & " LEFT JOIN tbl_member B ON A.m_id=B.m_id "
			Sql = Sql & " WHERE A.idx!='' AND A.o_state!='' "

			If s_keyword<>"" Then
				Sql = Sql & " AND (A.o_code LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.m_id LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.o_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.o_tel LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.o_email LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_name LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_tel LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_addr1 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_addr2 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_zip LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.s_text LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR B.addtext2 LIKE '%" & s_keyword & "%' "
				Sql = Sql & " OR A.o_memo LIKE '%" & s_keyword & "%') "
			End If

			If s_state="-1" Then
				Sql = Sql & " AND A.o_state='' "
			ElseIf s_state<>"" Then
				Sql = Sql & " AND A.o_state='" & s_state & "' "
			End If 
			If s_pay_method<>"" Then Sql = Sql & " AND A.o_pay_method='" & s_pay_method & "' "

			If s_srdate<>"" And s_erdate<>"" Then
				Sql = Sql & "AND A.regdate BETWEEN '" & s_srdate & "' AND '" & DateAdd("d", 1, s_erdate) & "' "
			ElseIf s_srdate<>"" Then
				Sql = Sql & "AND A.regdate>'" & s_srdate & "' "
			ElseIf s_erdate<>"" Then
				Sql = Sql & "AND A.regdate<'" & DateAdd("d", 1, s_erdate) & "' "
			End If

			Sql = Sql & " ORDER BY A.regdate DESC"
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
					o_code = Rs("o_code")
					o_name = Rs("o_name")
					o_total_amount = FormatNumber(Rs("o_amount")+Rs("o_deli_amount")+Rs("o_vat")-Rs("o_pay_point")-Rs("o_coupon_amount"), 0)
					o_pay_method = Rs("o_pay_method")
					o_state = Rs("o_state")
					s_addr1 = Rs("s_addr1")
					s_addr2 = Rs("s_addr2")
					regdate = Rs("regdate")
					%>
					<tr>
						<td class="bdr bdt"><a href="order-reg.asp?mode=mod&o_code=<%=o_code%>" style="text-decoration:underline"><%=o_code%></a></td>
						<td class="bdr bdt"><a href="order-reg.asp?mode=mod&o_code=<%=o_code%>" style="text-decoration:underline">
						<%=SnsMemberIcon(m_id)%>
						<%If m_id="" Then : Response.Write "(비회원)" : Else : Response.Write m_id : End If%></a></td>
						<td class="bdr bdt"><a href="order-reg.asp?mode=mod&o_code=<%=o_code%>" style="text-decoration:underline"><%=o_name%></a></td>
						<td class="bdr bdt"><%=o_pay_method%></td>
						<td class="bdr bdt">
						<select name="o_state" id="o_state" class="AXSelect" onchange="location.href='order-reg-ok.asp?mode=st_mod&o_code=<%=o_code%>&<%=pLink%>&o_state='+this.value">
							<option value="결제대기" <%If o_state="결제대기" Then Response.Write "selected"%>>결제대기</option>
							<option value="결제완료" <%If o_state="결제완료" Then Response.Write "selected"%>>결제완료</option>
							<option value="발송준비" <%If o_state="발송준비" Then Response.Write "selected"%>>발송준비</option>
							<option value="발송완료" <%If o_state="발송완료" Then Response.Write "selected"%>>발송완료</option>
							<option value="주문취소" <%If o_state="주문취소" Then Response.Write "selected"%>>주문취소</option>
							<option value="교환" <%If o_state="교환" Then Response.Write "selected"%>>교환</option>
							<option value="반품" <%If o_state="반품" Then Response.Write "selected"%>>반품</option>
						</select>
						</td>
						<td class="bdr bdt"><%=o_total_amount%></td>
						<td class="bdr bdt"><%=s_addr1 & " " & s_addr2%></td>
						<td class="bdt"><%=regdate%></td>
					</tr>
					<%
					num=num-1
					cnt=cnt+1
					Rs.MoveNext
				Loop
			Else
			%>
				<tr>
					<td colspan="8" class="bdr bdt">주문건이 존재하지 않습니다.</td>
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
<!-- 			<span><input type="button" value="   선택삭제   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="DelChk()"></span> -->
		</p>
		<p class="right">
			<span><input type="button" value="  엑셀다운로드  " class="AXButton Green" onclick="location.href='order-excel.asp?<%=pLink%>'"></span>
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

function DelChk(){
	var frm = document.listform;
	var tmpb=false;
	var cnt=0;
	if(document.getElementsByName("o_code").length==1){
		if(frm.o_code.checked){
			tmpb=true;
			cnt=cnt+1;
		}
	}else{
		for (i=0; i<document.getElementsByName("o_code").length; i++){
			if(frm.o_code[i].checked){
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
		frm.action = "order-reg-ok.asp?mode=seldel_p";
		frm.submit();
	}else{
		return;
	}
}
</script>

<!-- #include virtual="/site/manage/inc/footer.asp" -->