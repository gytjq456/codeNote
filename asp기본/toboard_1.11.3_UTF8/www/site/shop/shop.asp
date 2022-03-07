<%
'장바구니
If mode="cart" Then 
%>
<!--#include file="include/inc_cart.asp"-->
<%
'장바구니 DB처리
ElseIf mode="cart_reg" Or mode="order_dir" Or mode="cart_mod" Or mode="cart_del" Or mode="cart_alldel" Then 
%>
<!--#include file="include/cart_ok.asp"-->
<%
'관심상품
ElseIf mode="wish" Then
%>
<!--#include file="include/inc_wish.asp"-->
<%
'주문 로그인
ElseIf mode="order_login" Then 
%>
<!--#include file="include/inc_login.asp"-->
<%
'주문
ElseIf mode="order" Then
%>
<!--#include file="include/inc_order.asp"-->
<%
'주문 DB처리
ElseIf mode="order_ok" Then
%>
<!--#include file="include/order_ok.asp"-->
<%
'결제(PC)
ElseIf mode="pay" And sc_mobile=False Then
%>
<!--#include file="include/inc_pay.asp"-->
<%
'결제(M)
ElseIf mode="pay" And sc_mobile=True Then
%>
<!--#include file="include/inc_pay.inicis_m.asp"-->
<%
'무통장입금 DB처리
ElseIf mode="pay_bank_ok" Then
%>
<!--#include file="include/pay_bank_ok.asp"-->
<%
'주문 완료
ElseIf mode="order_end" Then
%>
<!--#include file="include/order_end.asp"-->
<%
'주문내역 조회
ElseIf mode="order_info" Then
%>
<!--#include file="include/order_info.asp"-->
<%
'주문내역 리스트
ElseIf mode="order_info_list" Then
%>
<!--#include file="include/order_info_list.asp"-->
<%
'주문내역 상세
ElseIf mode="order_info_view" Then
%>
<!--#include file="include/order_info_view.asp"-->
<%
End If
%>