<!--쓰기 테이블-->
<form name="regform" action="?<%=pLink%>&amp;mode=<%=mode%>_p&amp;idx=<%=idx%>&amp;page=<%=page%>&amp;p_num=<%=p_num%>" method="post" enctype="multipart/form-data">
<input type="hidden" name="ssid" value="<%=Left(Session.SessionID,2)%>" />

<!-- 추가필드 -->
<!--
<input type="hidden"  name="addtext4" value="<%=c_addtext4%>" />
<input type="hidden"  name="addtext5" value="<%=c_addtext5%>" />
<input type="hidden"  name="addtext6" value="<%=c_addtext6%>" />
<input type="hidden"  name="addtext7" value="<%=c_addtext7%>" />
<input type="hidden"  name="addtext8" value="<%=c_addtext8%>" />
<input type="hidden"  name="addtext9" value="<%=c_addtext9%>" />
<input type="hidden"  name="addtext10" value="<%=c_addtext10%>" />
<input type="hidden"  name="addtext11" value="<%=c_addtext11%>" />
<input type="hidden"  name="addtext12" value="<%=c_addtext12%>" />
<input type="hidden"  name="addtext13" value="<%=c_addtext13%>" />
<input type="hidden"  name="addtext14" value="<%=c_addtext14%>" />
<input type="hidden"  name="addtext15" value="<%=c_addtext15%>" />
-->

<%
'제품 문의
If mode="reg" And Request("p_name")<>"" Then c_title=Request("p_name") & " 문의드립니다"
%>

<table class="ntb-tb-view" style="width:100%" cellpadding="0" cellspacing="0">
	<caption>게시판 내용</caption>
	<colgroup>
		<col width="18%" />
		<col width="82%" />
	</colgroup>
	<thead>
	</thead>
	<tbody>
	<%If k_category<>"" Then%>
	<tr>
		<th align="center">카테고리</th>
		<td class="left">
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

	<tr style="display:none">
		<th>이름</th>
		<td class="left"><input type="text"  name="name" size="15" maxlength="8" value="<%=c_mem_name%>" class="AXInput" /></td>
	</tr>

	<%If k_counsel=True Then%>
		<input type="hidden"  name="pw" value="1111" />
	<%Else%>
		<%If (W_ID="" And mode="reg") Or (W_ID="" And mode="rep") Then%>
		<tr>
			<th>비밀번호</th>
			<td class="left"><input type="password"  name="pw" size="15" maxlength="8" value="<%If mode="rep" Then Response.Write c_mem_pw%>" class="AXInput" /></td>
		</tr>
		<%Else%>
		<input type="hidden"  name="pw" value="<%=c_mem_pw%>">
		<%End If%>
	<%End If%>
	<tr style="display:none">
		<th>이메일</th>
		<td class="left"><input type="text"  name="email" size="35" maxlength="50" value="<%=c_mem_email%>" class="AXInput" /> 예) abc@webmoa.co.kr</td>
	</tr>

	<tr>
		<th>연도</th>
		<td class="left"><input type="text"  name="addtext1" maxlength="4" value="<%=c_addtext1%>" class="AXInput W60" />년</td>
	</tr>
	<tr>
		<th>월</th>
		<td class="left"><input type="text"  name="addtext2" maxlength="2" value="<%=c_addtext2%>" class="AXInput W40" />월</td>
	</tr>
	<tr>
		<th>일</th>
		<td class="left"><input type="text"  name="addtext3" maxlength="2" value="<%=c_addtext3%>" class="AXInput W40" />일</td>
	</tr>
	<tr>
		<th>내용</th>
		<td class="left"><input type="text"  name="title" style="width:98%" maxlength="200" value="<%=TagText(c_title)%>" class="AXInput" /></td>
	</tr>

	<%If k_counsel=False Then%>
	<tr style="display:none">
		<th>옵션</th>
		<td class="left">
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

	</tbody>
</table>

<div class="ntb-listbtn-area" style="width:<%=T_WIDTH%>">
		<input type="button" value="   확인   " class="AXButton Classic" onclick="RegChk('<%=u_privacy%>', '<%=k_spamcode%>')">
		<input type="button" value="   취소   " class="AXButton" onclick="history.back();">
</div>

</form>


<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(privacy, spamcode) {
	var obj = document.regform;
	if(obj.name.value==""){ alert('이름을 입력하세요'); obj.name.focus(); return; }
	if(obj.pw.value==""){ alert('비밀번호를 입력하세요'); obj.pw.focus(); return; }
	if(obj.addtext1.value==""){ alert('연도를 입력하세요'); obj.addtext1.focus(); return; }
	if(obj.title.value==""){ alert('내용을 입력하세요'); obj.title.focus(); return; }
	if(obj.email.value!=""){
		if(obj.email.value.search("@") == -1 || obj.email.value.indexOf(".")<3) {
			alert("이메일의 형식이 잘못되었습니다.")
			obj.email.focus();
			return;
		}
	}
	obj.submit();
}
</script>