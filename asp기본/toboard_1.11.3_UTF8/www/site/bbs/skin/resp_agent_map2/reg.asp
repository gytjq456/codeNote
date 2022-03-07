<!-- 다음 주소 검색 -->
<%If Request.ServerVariables("SERVER_PORT")=443 Then%>
<!-- https --><script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<%Else%>
<!-- http --><script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%End If%>
<script>
    function NewPostcode() {new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('m_zip1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('addtext1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addtext2').focus();
				SetLocation();
            }
        }).open();
    }
</script>
<!--쓰기 테이블-->
<form name="regform" action="?<%=pLink%>&amp;mode=<%=mode%>_p&amp;idx=<%=idx%>&amp;page=<%=page%>&amp;p_num=<%=p_num%>" method="post" enctype="multipart/form-data">
<input type="hidden" name="ssid" value="<%=Left(Session.SessionID,2)%>" />
<input type="hidden" name="html" value="<%=k_html%>" />
<!-- 추가필드 -->
<!--
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

<table class="ntb-tb-view" style="width:100%" cellpadding="0" cellspacing="0">
	<caption>게시판 내용</caption>
	<colgroup>
		<col width="18%" />
		<col width="82%" />
	</colgroup>
	<thead>
	</thead>
	<tbody>
	<tr>
		<th align="center">지역분류</th>
		<td class="left">
			<select name="cate" class="AXSelect">
				<%
				k_category = "서울|경기|부산|인천|대구|대전|광주|울산|강원|충북|충남|경북|경남|전북|전남|세종|제주"
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

	<tr>
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

	<%If u_tel=True Then%>
	<tr>
		<th>매장 연락처</th>
		<td class="left"><input type="text"  name="mem_tel" size="15" maxlength="15" value="<%=c_mem_tel%>" class="AXInput" /> 예) 02-123-4567</td>
	</tr>
	<%End If%>

	<%If u_fax=True Then%>
	<tr>
		<th>FAX</th>
		<td class="left"><input type="text"  name="mem_fax" size="15" maxlength="15" value="<%=c_mem_fax%>" class="AXInput" /> 예) 02-123-4568</td>
	</tr>
	<%End If%>

	<%If u_url=True Then%>
	<tr>
		<th>링크URL</th>
		<td class="left"><input type="text"  name="mem_url" size="35" maxlength="50" value="<%=c_mem_url%>" class="AXInput" /> 예) http://www.webmoa.co.kr</td>
	</tr>
	<%End If%>

	<tr style="display:none">
		<th>이메일</th>
		<td class="left"><input type="text"  name="email" size="35" maxlength="50" value="<%=c_mem_email%>" class="AXInput" /> 예) abc@webmoa.co.kr</td>
	</tr>

	<tr>
		<th>매장명</th>
		<td class="left"><input type="text"  name="title" style="width:50%" maxlength="200" value="<%=TagText(c_title)%>" class="AXInput" /></td>
	</tr>
	<tr>
		<th>매장주소</th>
		<td class="left" style="height:86px">
			<input type="text" name="m_zip1" id="m_zip1" value="<%=m_zip1%>" class="AXInput W40" readonly="readonly" style="display:none" />
			<input type="text" name="addtext1" id="addtext1" value="<%=c_addtext1%>" class="AXInput W400" readonly="readonly" /> <input type="button" value="주소 검색" class="AXButtonSmall Classic" onclick="NewPostcode();" /><br />
			<input type="text" name="addtext2" id="addtext2" value="<%=c_addtext2%>" class="AXInput W400" /> <input type="button" value="좌표 입력" class="AXButtonSmall Classic" id="setLocationBtn" onclick="SetLocation()" /><br /><br />
			<div id="mapposi">
				x : <input type="text"  name="addtext3" value="<%=c_addtext3%>" class="AXInput W130" readonly />&nbsp;&nbsp;
				y : <input type="text"  name="addtext4" value="<%=c_addtext4%>" class="AXInput W130" readonly />
			</div>
			<br />
			구글맵 연동을 위해 주소 검색 후 좌표를 입력하세요.
			<script type="text/javascript">
			 function SetLocation() {
				$("#mapposi").empty();
				$.ajax({
					type: "POST", url : "/site/bbs/skin/resp_agent_map2/set_location.asp", data: "addr1=" + $("#addtext1").val() + "&addr2=" + $("#addtext2").val(), success: function(resdata){
						$("#mapposi").append(resdata);
					}
				});
			}
			</script>
		</td>
	</tr>

	<%If k_counsel=False Then%>
	<tr>
		<th>옵션</th>
		<td class="left">
		<label><input type="checkbox" name="lock" value="1" <%If c_lock=True Then Response.Write "checked"%> class="vmiddle" />비공개글</label>
		<%If W_LEVEL="1" Or W_LEVEL="2" Then%>
		<label><input type="checkbox" name="notice" value="1" <%If c_notice=True Then Response.Write "checked"%> class="vmiddle" />최상단</label>
		<%End If%>
		</td>
	</tr>
	<%End If%>

	<tr>
		<td colspan="2"><textarea cols="" rows="" name="content" id="content" style="width:98%; height:250px"><%=c_content%></textarea></td>
	</tr>

	<!-- 파일첨부 -->
	<%For fc=0 To k_upload-1%>
	<tr>
		<th>파일첨부<%=fc+1%></th>
		<td class="left">
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
		<th>Head Title</th>
		<td class="left"><input type="text"  name="seo_title" style="width:98%" value="<%=c_seo_title%>" class="AXInput" /></td>
	</tr>
	<tr>
		<th>Meta Tag Keyword</th>
		<td class="left"><input type="text"  name="seo_keyword" style="width:98%" value="<%=c_seo_keyword%>" class="AXInput" /></td>
	</tr>
	<tr>
		<th>Meta Tag Description</th>
		<td class="left"><input type="text"  name="seo_description" style="width:98%" value="<%=c_seo_description%>" class="AXInput" /></td>
	</tr>
	<!-- //SEO 적용시 -->
	<%End If%>

	<%If k_spamcode=True Then%>
	<tr>
		<th>자동등록방지</th>
		<td class="left">
		<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /> <input type="button" value="새로고침" class="AXButton Classic" onclick="RefreshImage('imgCaptcha');" />
		<input type="text" name="txtCaptcha" id="txtCaptcha" value="" class="AXInput vmiddle" style="width:118px" maxlength="5" placeholder="코드를 입력하세요" /><br /></td>
	</tr>
	<%End If%>

	</tbody>
</table>

<div class="ntb-listbtn-area" style="width:<%=T_WIDTH%>">
		<input type="button" value=" 확인 " class="AXButton Classic" onclick="RegChk('<%=u_privacy%>', '<%=k_spamcode%>')">
		<input type="button" value=" 취소 " class="AXButton" onclick="history.back();">
</div>

</form>


<script type="text/javascript">
//게시물 쓰기 유효성 체크
function RegChk(privacy, spamcode) {
	var obj = document.regform;
	if(obj.name.value==""){ alert('이름을 입력하세요'); obj.name.focus(); return; }
	if(obj.pw.value==""){ alert('비밀번호를 입력하세요'); obj.pw.focus(); return; }
	if(obj.title.value==""){ alert('매장명을 입력하세요'); obj.title.focus(); return; }
	if(obj.addtext1.value==""){ alert('매장 주소를 입력하세요'); obj.addtext1.focus(); return; }
	if(obj.email.value!=""){
		if(obj.email.value.search("@") == -1 || obj.email.value.indexOf(".")<3) {
			alert("이메일의 형식이 잘못되었습니다.")
			obj.email.focus();
			return;
		}
	}
	if(spamcode=="True"){
		if(obj.txtCaptcha.value==""){ alert('자동등록방지 코드를 입력하세요'); obj.txtCaptcha.focus(); return; }
	}
	<%If k_editor="smarteditor2" Then%>oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);<%End If%>
	obj.submit();
}

var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "content",
	sSkinURI: "/site/api/smarteditor2/SmartEditor2Skin.html",
	fCreator: "createSEditor2"
});
</script>