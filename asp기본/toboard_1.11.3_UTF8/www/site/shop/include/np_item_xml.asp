<%@CodePage = 65001%><% Response.ContentType = "application/xml;charset=UTF-8" %><!--#include virtual="/site/common/dbconn.asp"--><!--#include virtual="/site/common/function.asp"--><?xml version="1.0" encoding="UTF-8"?>
<response>
<%
For i=1 to Request.QueryString("ITEM_ID").Count
	If itemId="" Then
		itemId = Request.QueryString("ITEM_ID")(i)
	Else
		itemId = itemId & ", " & Request.QueryString("ITEM_ID")(i)
	End If
Next

ReDim p_option(4), p_option_val(4)

Set Rs = Server.Createobject("ADODB.Recordset")
Sql = "SELECT A.* FROM tbl_prod A "
Sql = Sql & " INNER JOIN tbl_cate B ON A.p_cate=B.c_code AND B.c_lang='한국어' "
Sql = Sql & " WHERE A.p_hide='0' "
If itemId<>"" Then Sql = Sql & " AND A.idx IN (" & itemId & ") "
Sql = Sql & " ORDER BY A.p_lev DESC"
Rs.Open Sql, Dbcon, 1

If Rs.EOF=False Then
	Do Until Rs.EOF
		idx = Rs("idx")
		p_name = Rs("p_name")
		p_memo = Rs("p_memo")
		p_cate = Rs("p_cate")
		p_code = Rs("p_code")
		p_price = Rs("p_price")
		p_image1 = Rs("p_image1")
		p_image1_fn = Left(p_image1, InStrRev(p_image1, ".")-1)
		p_image1_ext = Mid(p_image1, InStrRev(p_image1, ".")+1)
		p_option(0) = Rs("p_option1")
		p_option_val(0) = Rs("p_option_val1")
		p_option(1) = Rs("p_option2")
		p_option_val(1) = Rs("p_option_val2")
		p_option(2) = Rs("p_option3")
		p_option_val(2) = Rs("p_option_val3")
		p_option(3) = Rs("p_option4")
		p_option_val(3) = Rs("p_option_val4")
		p_memo = Rs("p_memo")
		p_url = Replace("http://" & Request.ServerVariables("SERVER_NAME") & "/kr/sub/shop/list.asp?q=prod&mode=view&idx=" & idx, "&", "&amp;")
		%>
		<item id="<%=idx%>"> <!-- 상품 ID -->
			<name><![CDATA[<%=p_name%>]]></name>
			<url><%=p_url%></url> <!-- 상품 설명 페이지 url -->
			<description><![CDATA[<%=p_memo%>]]></description>
			<image>http://<%=Request.ServerVariables("SERVER_NAME")%>/upload/prod/<%=Server.URLEncode(p_image1_fn) & "." & p_image1_ext%></image> <!-- 상품 image url -->
			<thumb>http://<%=Request.ServerVariables("SERVER_NAME")%>/upload/prod/thumb_l/<%=Server.URLEncode(p_image1_fn) & "." & p_image1_ext%></thumb> <!-- 상품 썸네일 image url -->
			<price><%=p_price%></price> <!-- 정상 가격 -->
			<quantity>99</quantity> <!-- 재고량 -->
			<options><%
			For o_num=1 To 4
				If p_option(o_num-1)<>"" Then%>
				<option name="<%=p_option(o_num-1)%>"> <!-- 옵션 종류 이름 -->
					<%
					If p_option_val(o_num-1)<>"" Then
						arr_option = Split(p_option_val(o_num-1), ", ")
						For Each itm In arr_option
							arr_itm = Split(itm, "§")%>
							<select><![CDATA[<%=arr_itm(0)%>]]></select>
						<%
						Next
					End If
					%>
				</option>
				<%
				End If
			Next
			%>
			</options>
			<category> <!-- 카테고리 -->
				<first>Make up</first> <!-- 최상위 카테고리 이름 -->
			</category>
		</item>
		<%
		num=num-1
		cnt=cnt+1
		Rs.MoveNext
	Loop
End If
Rs.Close
Set Rs = Nothing
%>
</response>