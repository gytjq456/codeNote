<!--#include file="common/dbconn.asp" -->
<!--#include file="common/aes.asp" -->
<!--#include file="common/json.asp" -->
<!--#include file="common/function.asp" -->
<%
'Response.CacheControl = "no-cache" 
'Response.AddHeader "Set-Cookie", CStr(Request.ServerVariables("HTTP_COOKIE"))&";path=/;HttpOnly;Secure"
'Response.AddHeader "Cache-Control","no-store, no-cache" 
'Response.AddHeader "Pragma", "no-cache"
'Response.Expires = -1

'https 리다이렉트
'If Request.ServerVariables("SERVER_PORT")=80 Then
'	strSecureURL = "https://"
'	strSecureURL = strSecureURL & Request.ServerVariables("SERVER_NAME")
'	strSecureURL = strSecureURL & Request.ServerVariables("URL")
'	Response.Redirect strSecureURL
'End If

'사이트 기본 정보 취득
Set RsA = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_site_config "
RsA.Open Sql, Dbcon, 1
If RsA.EOF=False Then
	sc_name = RsA("sc_name")
	sc_lang = RsA("sc_lang")
	head_title = sc_name
	sc_url = RsA("sc_url")
	sc_email = RsA("sc_email")
	sc_tel = RsA("sc_tel")
	sc_agree1 = RsA("sc_agree1")
	sc_agree2 = RsA("sc_agree2")
	sc_analy = RsA("sc_analy")
	sc_regno1=RsA("sc_regno1")
	sc_regno2=RsA("sc_regno2")
	sc_regno3=RsA("sc_regno3")
	sc_address=RsA("sc_address")
	sc_addtext1=RsA("sc_addtext1")
	sc_addtext2=RsA("sc_addtext2")
	sc_addtext3=RsA("sc_addtext3")
	sc_addtext4=RsA("sc_addtext4")
	sc_addtext5=RsA("sc_addtext5")
	meta_keywords = RsA("meta_keywords")
	meta_description = RsA("meta_description")
	meta_author = RsA("meta_author")
	meta_subject = RsA("meta_subject")
	meta_copyright = RsA("meta_copyright")
	meta_content_language = RsA("meta_content_language")
	favicon = RsA("favicon")
End If
RsA.Close

'쇼핑몰 기본 정보 취득
Set RsA = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_mall_config "
RsA.Open Sql, Dbcon, 1
If RsA.EOF=False Then
	mc_use = RsA("mc_use")
	mc_shop_url = RsA("mc_shop_url")
	mc_point_use = RsA("mc_point_use")
	mc_point_join = RsA("mc_point_join")
	mc_bank_flag = RsA("mc_bank_flag")
	mc_bank_no = RsA("mc_bank_no")
	mc_deli = RsA("mc_deli")
	mc_deli_charge = RsA("mc_deli_charge")
	mc_deli_free = RsA("mc_deli_free")
	mc_deli_content = RsA("mc_deli_content")
	mc_chng_content = RsA("mc_chng_content")
	mc_order_lev = RsA("mc_order_lev")	'구매가능 회원등급
	mc_coupon = RsA("mc_coupon")
End If
RsA.Close

'모바일 여부 체크
If(Len(Request.ServerVariables("HTTP_USER_AGENT"))=0) Then
  gStrAgent = "NONE"
Else
  gStrAgent = Request.ServerVariables("HTTP_USER_AGENT")
End if
gmobilePhones = Array("iPhone", "ipad", "BlackBerry", "Android", "Windows CE", "LG", "MOT", "SAMSUNG", "SonyEricsson", "nokia", "webos", "opera mini", "sonyericsson", "opera mobi", "iemobile")

sc_mobile=False
For mn= 0 to uBound(gMobilePhones)
	If (InStr(LCase(gStrAgent), LCase(gMobilePhones(mn))) > 0) Then
		gUserAgent = LCase(gMobilePhones(mn))
		sc_mobile = True
		Exit For
	End If
Next

'회원 쿠키 변수
W_ID = Request.Cookies("W_ID")
W_NAME = Request.Cookies("W_NAME")
W_PW = Request.Cookies("W_PW")
W_EMAIL = Request.Cookies("W_EMAIL")
W_LEVEL = Request.Cookies("W_LEVEL")

'세션아이디 쿠키 저장
If Request.Cookies("W_SID")="" Then
	Response.Cookies("W_SID") = Session.SessionID
End If
W_SID = Request.Cookies("W_SID")

'비회원 등급
If W_LEVEL="" Then W_LEVEL = 100

'관리자 메뉴 권한 취득
Sql = "SELECT * FROM tbl_member WHERE m_id='" & W_ID & "' "
RsA.Open Sql, Dbcon, 1
If RsA.EOF=False Then
	admin_a_auth =RsA("a_auth")
End If
RsA.Close

'쇼핑몰 장바구니 카운트
If mc_use=True Then
	Sql = "SELECT COUNT(*) FROM tbl_mall_cart WHERE idx!='' AND o_code='' "
	If W_ID<>"" Then
		Sql = Sql & " AND m_id='" & W_ID & "' "
	Else
		Sql = Sql & " AND session_id='" & W_SID & "' "
	End If
	RsA.Open Sql, Dbcon, 1
	If RsA.EOF=False Then
		sc_cart_count =RsA(0)
	End If
	RsA.Close
End If
Set RsA = Nothing

%>

<%If q="" Then q=Request("q")%>
<%If bid="" Then bid=Request("bid")%>

<%
'게시판
If bid<>"" Then%>
<!--#include file="bbs/include/inc_setting.asp" -->
<!--#include file="bbs/include/inc_content_top.asp" -->

<%
'제품소개
ElseIf q="prod" Then%>
<!--#include file="prod/setting.asp" -->

<%
'쇼핑몰
ElseIf q="shop" Then%>
<!--#include file="shop/setting.asp" -->

<%
'컨텐츠페이지
ElseIf q="page" Then%>
<!--#include file="page/setting.asp" -->

<%End If%>

<!--#include file="common/head.asp" -->
