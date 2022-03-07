<%@CodePage = 65001%>
<!DOCTYPE HTML>
<html lang="ko">
<head>
<!-- #include virtual="/site/manage/inc/head.asp" -->

<script>
$( function() {
	$("#o_deli_date").datepicker({dateFormat: 'yy-mm-dd'});
});
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function NewPostcode(md) {new daum.Postcode({
            oncomplete: function(data) {
                var fullAddr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    fullAddr = data.roadAddress;

                } else {
                    fullAddr = data.jibunAddress;
                }

                if(data.userSelectedType === 'R'){
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

				if (md=="o"){
					document.getElementById('o_zip').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('o_addr1').value = fullAddr;
					document.getElementById('o_addr2').focus();
				}else if (md=="s"){
					document.getElementById('s_zip').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('s_addr1').value = fullAddr;
					document.getElementById('s_addr2').focus();
				}

            }
        }).open();
    }
</script>
</head>

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

<%
o_code = Request("o_code")
%>

<!-- contents -->
<div class="contents">

<%
Set Rs = Server.CreateObject("ADODB.RecordSet")
Sql = "SELECT * FROM tbl_mall_order WHERE o_code='" & o_code & "' "
'Response.write sql
Rs.open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_id = Rs("m_id")
	o_code = Rs("o_code")
	o_comp = Rs("o_comp")
	o_name = Rs("o_name")
	o_tel = Rs("o_tel")
	o_zip = Rs("o_zip")
	o_addr1 = Rs("o_addr1")
	o_addr2 = Rs("o_addr2")
	o_email = Rs("o_email")
	s_comp = Rs("s_comp")
	s_name = Rs("s_name")
	s_tel = Rs("s_tel")
	s_zip = Rs("s_zip")
	s_addr1 = Rs("s_addr1")
	s_addr2 = Rs("s_addr2")
	s_text = Rs("s_text")
	o_amount = Rs("o_amount")
	o_deli_amount = Rs("o_deli_amount")
	o_vat = Rs("o_vat")
	o_deli = Rs("o_deli")
	o_deli_code = Rs("o_deli_code")
	o_deli_date = Rs("o_deli_date")
	o_pay_bank = Rs("o_pay_bank")
	o_pay_bank_name = Rs("o_pay_bank_name")
	o_pay_method = Rs("o_pay_method")
	o_pay_log = Rs("o_pay_log")
	o_pay_point = Rs("o_pay_point")
	o_coupon_code = Rs("o_coupon_code")
	o_coupon_amount = Rs("o_coupon_amount")
	o_state = Rs("o_state")
	regdate = Rs("regdate")
	o_memo = Rs("o_memo")
Else
	Response.Write "<script>alert('조회 내역이 없습니다.'); history.back();</script>"
	Response.End
End If
Rs.Close

Sql = "SELECT * FROM tbl_member WHERE m_id='" & m_id & "' "
'Response.write sql
Rs.open Sql, Dbcon, 1
If Rs.EOF=False Then
	m_lev = Rs("m_lev")
	m_sort = Rs("m_sort")
	m_email = Rs("m_email")
	m_regdate = Rs("regdate")
End If
Rs.Close
Set Rs = Nothing

If o_deli="" Then o_deli=mc_deli
%>

	<form name="regform" method="post" action="order-reg-ok.asp?mode=mod&o_code=<%=o_code%>&<%=pLink%>">

		<div class="tb_info">
			<h4>주문자 정보</h4>
			<table >
				<colgroup>
					<col style="width:22%"><col style="">
					<col style="width:22%"><col style="">
				</colgroup>
				<tr>
					<th class="title bdr bdt">회원ID</th>
					<td colspan="3" class="bdr bdt"><%If m_id="" Then : Response.Write "비회원" : Else : Response.Write m_id : End If%></td>
				</tr>
				<tr>
					<th class="title bdr bdt">이름</th>
					<td class="bdr bdt"><input type="text" name="o_name" size="20" value="<%=o_name%>" class="AXInput" required /></td>
					<th class="title bdr bdt">연락처</th>
					<td class="bdr bdt"><input type="text" name="o_tel" size="20" value="<%=o_tel%>" class="AXInput" required /></td>
				</tr>
				<tr>
					<th class="title bdr bdt">주소</th>
					<td colspan="3" class="bdr bdt">					
						<input type="text" name="o_zip" id="o_zip" value="<%=o_zip%>" class="AXInput W60" maxlength="5" placeholder="우편번호" readonly required />
						<button type="button" onclick="NewPostcode('o');" class="AXButton Classic">주소검색</button><br />
						<input type="text" name="o_addr1" id="o_addr1" value="<%=o_addr1%>" style="width:90%" placeholder="기본주소" readonly class="AXInput" required /><br />
						<input type="text" name="o_addr2" id="o_addr2" value="<%=o_addr2%>" style="width:90%" placeholder="상세주소" class="AXInput" required />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">이메일</th>
					<td colspan="3" class="bdr bdt"><input type="text" name="o_email" size="35" value="<%=o_email%>" class="AXInput" required /></td>
				</tr>
			</table>
		</div>

		<div class="tb_info">
			<h4>배송지 정보</h4>
			<table>
				<colgroup>
					<col style="width:22%"><col style="">
					<col style="width:22%"><col style="">
				</colgroup>
				<tr>
					<th class="title bdr bdt">이름</th>
					<td class="bdr bdt"><input type="text" name="s_name" size="20" value="<%=s_name%>" class="AXInput" required /></td>
					<th class="title bdr bdt">연락처</th>
					<td class="bdr bdt"><input type="text" name="s_tel" size="20" value="<%=s_tel%>" class="AXInput" required /></td>
				</tr>
				<tr>
					<th class="title bdr bdt">주소</th>
					<td colspan="3" class="bdr bdt">					
						<input type="text" name="s_zip" id="s_zip" value="<%=s_zip%>" class="AXInput W60" maxlength="5" placeholder="우편번호" readonly required />
						<button type="button" onclick="NewPostcode('s');" class="AXButton Classic">주소검색</button><br />
						<input type="text" name="s_addr1" id="s_addr1" value="<%=s_addr1%>" style="width:90%" placeholder="기본주소" readonly class="AXInput" required /><br />
						<input type="text" name="s_addr2" id="s_addr2" value="<%=s_addr2%>" style="width:90%" placeholder="상세주소" class="AXInput" required />
					</td>
				</tr>
				<tr>
					<th class="title bdr bdt">배송 요청사항</th>
					<td colspan="3" class="bdr bdt"><textarea cols="" rows="" name="s_text" id="s_text" style="width:90%; height:100px" class="AXInput"><%=s_text%></textarea></td>
				</tr>
			</table>
		</div>

		<a name="pdlist"></a>

		<div class="tb_list">
			<h4>주문 내역</h4>
			<table>
				<colgroup>
					<col style="width:80px;">
					<col style="width:60px;">
					<col>
					<col style="width:27%;">
					<col style="width:10%;">
					<col style="width:10%;">
					<col style="width:10%;">
					<col style="width:10%;">
				</colgroup>
				<tr>
					<th class="title bdr bdt">번호</th>
					<th class="title bdr bdt"></th>
					<th class="title bdr bdt">제품명</th>
					<th class="title bdr bdt">옵션</th>
					<th class="title bdr bdt">가격(원)</th>
					<th class="title bdr bdt">수량</th>
					<th class="title bdr bdt">합계(원)</th>
					<th class="title bdr bdt">삭제</th>
				</tr>
				<%
				Set Rs = Server.Createobject("ADODB.Recordset")
				Sql = "SELECT A.*, C.idx ct_idx, C.p_name, C.p_option, C.p_amount, C.p_point_a, C.p_qty, D.p_image1 FROM tbl_mall_order A "
				Sql = Sql & " LEFT JOIN tbl_mall_cart C ON A.o_code=C.o_code "
				Sql = Sql & " LEFT JOIN tbl_prod D ON C.p_idx=D.idx "
				Sql = Sql & " WHERE A.idx!='' AND A.o_state!='' AND A.o_code='" & o_code & "' "
				Sql = Sql & " ORDER BY A.regdate DESC"
				'Response.Write Sql
				Rs.Open Sql, Dbcon, 1
				total=0
				all_total=0
				p_point_total=0				
				If Rs.EOF=False Then
					num=1
					Do Until Rs.EOF
						idx = Rs("idx")
						ct_idx = Rs("ct_idx")
						p_name = Rs("p_name")
						p_option = Rs("p_option")
						p_amount = Rs("p_amount")
						p_point_a = Rs("p_point_a")
						p_image1 = Rs("p_image1")
						p_qty = Rs("p_qty")
						total = p_amount * p_qty
						all_total = all_total+total
						p_point_total = p_point_total+(p_point_a * p_qty)%>
						<tr>
							<td class="bdr bdt"><%=num%></td>
							<td class="bdr bdt"><img src="/upload/prod/thumb_s/<%=p_image1%>" alt="이미지" style="width:50px" /></td>
							<td class="bdr bdt"><%=p_name%></td>
							<td class="bdr bdt"><%=p_option%></td>
							<td class="bdr bdt ta_right"><%=FormatNumber(p_amount, 0)%></td>
							<td class="bdr bdt">
							<%If o_state="결제대기" Or o_state="결제완료" Or o_state="발송준비" Then%>
								<select name="qty" onchange="location.href='cart-ok.asp?mode=mod&o_code=<%=o_code%>&idx=<%=idx%>&p_qty='+this.value" class="AXSelect">
									<%For q=1 To 99%>
									<option value="<%=q%>" <%If q=p_qty Then Response.Write "selected"%>><%=q%></option>
									<%Next%>
								</select>
							<%Else%>
								<input type="text" name="qty" value="<%=p_qty%>" class="AXInput W40" readonly />
							<%End If%></td>
							<td class="bdr bdt ta_right"><%=FormatNumber(total, 0)%></td>
							<td class="bdr bdt">
							<%If o_state="결제대기" Or o_state="결제완료" Or o_state="발송준비" Then%>
								<input type="button" value="삭제" onclick="if(confirm('삭제하시겠습니까?')){ location.href='cart-ok.asp?mode=del&o_code=<%=o_code%>&idx=<%=ct_idx%>'}" class="AXButton">
							<%End If%></td>
						</tr>
						<%
						num=num+1
						Rs.MoveNext
					Loop
				End If
				Rs.Close
				Set Rs = Nothing%>
			</table>

			<br />

			<table>
				<tr>
					<th class="title bdr bdt">주문금액(원)</th>
					<th class="title bdr bdt">배송비(원)</th>
					<%If o_pay_point>0 Then%><th class="title bdr bdt">사용포인트(원)</th><%End If%>
					<%If o_coupon_amount>0 Then%><th class="title bdr bdt">쿠폰할인(원)</th><%End If%>
					<th class="title bdr bdt">최종 결제금액(원)</th>
				</tr>
				<tr>
					<td class="bdr bdt"><%=FormatNumber(all_total, 0)%></td>
					<td class="bdr bdt"><%=FormatNumber(o_deli_amount, 0)%></td>
					<%If o_pay_point>0 Then%><td class="bdr bdt">-<%=FormatNumber(o_pay_point, 0)%></td><%End If%>
					<%If o_coupon_amount>0 Then%><td class="bdr bdt">-<%=FormatNumber(o_coupon_amount, 0)%><br />
					<span class="txt_small">(<%=Mid(o_coupon_code, 1, 5) & "-" & Mid(o_coupon_code, 6, 5) & "-" & Mid(o_coupon_code, 11, 5) & "-" & Mid(o_coupon_code, 16, 5)%>)</span>
					</td><%End If%>
					<td class="bdr bdt"><%=FormatNumber(all_total+o_deli_amount-o_pay_point-o_coupon_amount, 0)%></td>
				</tr>
			</table>

		</div>

		<br />
		<br />

		<div class="tb_info">
			<h4>주문 관리</h4>
			<table >
				<colgroup>
					<col style="width:22%"><col style="">
					<col style="width:22%"><col style="">
				</colgroup>
				<tr>
					<th class="title bdr bdt">주문일</th>
					<td class="bdt bdr"><%=regdate%></td>
					<th class="title bdr bdt">주문코드</th>
					<td class="bdt"><%=o_code%></td>
				</tr>
				<tr>
				</tr>
				<tr>
					<th class="title bdr bdt">결제수단</th>
					<td class="bdr bdt"><%=o_pay_method%></td>
					<th class="title bdr bdt">진행상태</th>
					<td class="bdt">
					<%If o_state="주문취소" Or o_state="발송완료" Then%>
						<input type="text" name="o_state" value="<%=o_state%>" class="AXInput W80" readonly />
					<%Else%>
						<select name="o_state" id="o_state" class="AXSelect">
							<option value="결제대기" <%If o_state="결제대기" Then Response.Write "selected"%>>결제대기</option>
							<option value="결제완료" <%If o_state="결제완료" Then Response.Write "selected"%>>결제완료</option>
							<option value="발송준비" <%If o_state="발송준비" Then Response.Write "selected"%>>발송준비</option>
							<option value="발송완료" <%If o_state="발송완료" Then Response.Write "selected"%>>발송완료</option>
							<option value="주문취소" <%If o_state="주문취소" Then Response.Write "selected"%>>주문취소</option>
							<option value="교환" <%If o_state="교환" Then Response.Write "selected"%>>교환</option>
							<option value="반품" <%If o_state="반품" Then Response.Write "selected"%>>반품</option>
						</select>
					<%End If%></td>
				</tr>
				<%If o_pay_bank<>"" Then%>
				<tr>
					<th class="title bdr bdt">무통장 입금 계좌</th>
					<td class="bdt" colspan="3"><%=o_pay_bank%></td>
				</tr>
				<%End If%>
				<%If o_pay_bank_name<>"" Then%>
				<tr>
					<th class="title bdr bdt">입금자 명</th>
					<td class="bdt" colspan="3"><%=o_pay_bank_name%></td>
				</tr>
				<%End If%>
				<%If o_pay_log<>"" Then%>
				<tr>
					<th class="title bdr bdt">전자결제 로그</th>
					<td class="bdt" colspan="3"><%=TagText(o_pay_log)%></td>
				</tr>
				<%End If%>
				<tr>
					<th class="title bdr bdt">배송 및 송장번호</th>
					<td class="bdt" colspan="3">
					<select name="o_deli" class="AXSelect">
						<option value="자체배송" <%If o_deli="자체배송" Then Response.Write "selected"%>>자체배송</option>
						<option value="경동택배" <%If o_deli="경동택배" Then Response.Write "selected"%>>경동택배</option>
						<option value="대신택배" <%If o_deli="대신택배" Then Response.Write "selected"%>>대신택배</option>
						<option value="동부택배" <%If o_deli="동부택배" Then Response.Write "selected"%>>동부택배</option>
						<option value="로젠택배" <%If o_deli="로젠택배" Then Response.Write "selected"%>>로젠택배</option>
						<option value="우체국" <%If o_deli="우체국" Then Response.Write "selected"%>>우체국</option>
						<option value="이노지스택배" <%If o_deli="이노지스택배" Then Response.Write "selected"%>>이노지스택배</option>
						<option value="한진택배" <%If o_deli="한진택배" Then Response.Write "selected"%>>한진택배</option>
						<option value="롯데택배" <%If o_deli="롯데택배" Then Response.Write "selected"%>>롯데택배</option>
						<option value="CJ대한통운" <%If o_deli="CJ대한통운" Then Response.Write "selected"%>>CJ대한통운</option>
						<option value="CVSnet편의점택배" <%If o_deli="CVSnet편의점택배" Then Response.Write "selected"%>>CVSnet편의점택배</option>
						<option value="KG옐로우캡택배" <%If o_deli="KG옐로우캡택배" Then Response.Write "selected"%>>KG옐로우캡택배</option>
						<option value="KGB택배" <%If o_deli="KGB택배" Then Response.Write "selected"%>>KGB택배</option>
						<option value="KG로지스" <%If o_deli="KG로지스" Then Response.Write "selected"%>>KG로지스</option>
						<option value="건영택배" <%If o_deli="건영택배" Then Response.Write "selected"%>>건영택배</option>
						<option value="호남택배" <%If o_deli="호남택배" Then Response.Write "selected"%>>호남택배</option>
					</select>
					<!-- <input type="text" name="o_deli" value="<%=mc_deli%>" class="AXInput W80" placeholder="택배사" readonly /> -->
					<input type="text" name="o_deli_code" value="<%=o_deli_code%>" class="AXInput W150" placeholder="송장번호"/>
					<input type="text" name="o_deli_date" id="o_deli_date" value="<%=o_deli_date%>" class="AXInput W100" placeholder="배송날짜"/>
					<%If DeliveryTrace(o_deli, o_deli_code)<>"" Then%>
					<input type="button" value="배송추적" class="AXButton Classic" onclick="open('<%=DeliveryTrace(o_deli, o_deli_code)%>', 'pop', '')">
					<%End If%>
					</td>
				</tr>
				<%If mc_point_use=True And p_point_total>0 Then%>
				<tr>
					<th class="title bdr bdt">적립포인트</th>
					<td class="bdt" colspan="3"><%=FormatNumber(p_point_total, 0)%>p
					<span class="txt_small">(발송완료 처리시 적립됩니다.)</span></td>
				</tr>
				<%End If%>
				<tr>
					<th class="title bdr bdt">비고</th>
					<td class="bdt" colspan="3"><textarea cols="" rows="" name="o_memo" id="o_memo" class="AXInput" style="width:90%; height:80px"><%=o_memo%></textarea></td>
				</tr>
			</table>
		</div>

		<!-- btn_left_right -->
		<div class="btn_left_right">
			<p class="right">
				<span><input type="submit" value="   확인   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7"></span>
				<span><input type="button" value="   목록   " class="AXButton" style="color:#fff;background:#1e73e7;border:1px solid #1e73e7" onclick="location.href='index.asp'"></span>
			</p>
		</div>
		<!-- //btn_left_right -->

	</form>

	<!-- btn_left_right -->
	<div class="btn_left_right">
		<p class="left">
<!-- 			<span><input type="button" value=" 주문삭제 " class="AXButton" onclick="if(confirm('해당 주문건을 삭제하시겠습니까?')){ location.href='order-reg-ok.asp?mode=seldel_p&o_code=<%=o_code%>' }"></span> -->
		</p>
	</div>
	<!-- //btn_left_right -->

</div>
<!-- //contents -->

<!-- footer -->
<!-- #include virtual="/site/manage/inc/footer.asp" -->