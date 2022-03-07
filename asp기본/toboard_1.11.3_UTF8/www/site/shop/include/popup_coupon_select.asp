<!DOCTYPE HTML>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<!--#include virtual="/site/setting.asp" -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />
</head>

<%
o_code = Request("o_code")

If W_ID="" Then
	Response.Write "<script>alert('회원 로그인이 필요합니다.'); history.back();</script>"
	Response.End
End If
%>

<body>


<div class="couponbox">
	<div class="title">쿠폰적용</div>
	<div class="tit_s">사용 가능한 쿠폰</div>
	<div class="c_tit">
		<span class="col col_1">쿠폰명</span>
		<span class="col col_2">유효기간</span>
		<span class="col col_3">할인율</span>
		<span class="col col_4"></span>
	</div>
	<ul class="list">

<%

'주문 정보 취득
Set RsO = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_order "
Sql = Sql & " WHERE o_code='" & o_code & "' "
RsO.Open Sql, Dbcon, 1
If RsO.EOF=False Then
	idx = RsO("idx")
	o_amount = RsO("o_amount")	'주문 총액
	o_deli_amount = RsO("o_deli_amount")	'배송비
Else
	Response.Write "<script>alert('잘못된 접근입니다.'); history.back();</script>"
	Response.End
End If
RsO.Close
Set RsO = Nothing

Set RsCp = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_coupon_dl WHERE m_id='" & W_ID & "' AND cd_enddate>getdate() AND c_used=0 "
RsCp.Open Sql, Dbcon, 1
If RsCp.EOF=False Then
	Do Until RsCp.EOF
		idx = RsCp("idx")
		cd_code=RsCp("cd_code")
		cd_name=RsCp("cd_name")
		cd_enddate=RsCp("cd_enddate")
		cd_dc_type=RsCp("cd_dc_type")
		cd_dc_amount=RsCp("cd_dc_amount")

		'할인 금액이 주문 금액을 초과하지 않는 쿠폰만 표시
		If ((o_amount+o_deli_amount)>cd_dc_amount And cd_dc_type="원") Or cd_dc_type="%" Then
		%>
		<!-- <label><a href="#;" onclick="SetCoupon('<%=cd_code%>', '<%=cd_dc_amount%>', '<%=cd_dc_type%>')"><%=cd_name%> / <%=cd_enddate%> / <%=cd_dc_amount & cd_dc_type%></a></label><br /> -->
			<li>
				<span class="col col_1"><%=cd_name%></span>
				<span class="col col_2"><%=cd_enddate%></span> 
				<span class="col col_3"><%=cd_dc_amount & cd_dc_type%></span>
				<span class="col col_4"><a href="javascript:void(0);" onclick="SetCoupon('<%=cd_code%>', '<%=cd_dc_amount%>', '<%=cd_dc_type%>')">선택</a></span>
			</li>
		<%
		End If
		RsCp.MoveNext
	Loop
End If
RsCp.Close
Set RsCp = Nothing
%>
<!-- <label><a href="#;" onclick="SetCoupon('', '', '')">적용하지 않음</a></label> -->
	<li>
		<span class="col col_5_1">적용하지 않음</span>
		<span class="col col_5_2"><a href="javascript:void(0);" onclick="SetCoupon('', '', '')">선택</a></span>
	</li>

	</ul>
<form name="popform" action="<%=mc_shop_url%>?mode=pay&o_code=<%=o_code%>" method="post">
	<input type="hidden" name="cd_code" />
	<input type="hidden" name="cd_dc_amount" />
	<input type="hidden" name="cd_dc_type" />
</form>
</div>
</body>

<script type="text/javascript">
function SetCoupon(cd_code, cd_dc_amount, cd_dc_type){
	var f = document.popform;
	f.cd_code.value = cd_code;
	f.cd_dc_amount.value = cd_dc_amount;
	f.cd_dc_type.value = cd_dc_type;
	f.target = opener;
	f.submit();
	self.close();
}
</script>
</html>