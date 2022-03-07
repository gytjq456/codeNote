<!--쓰기 테이블-->
<form name="regform" action="?<%=pLink%>&amp;mode=<%=mode%>_p&amp;idx=<%=idx%>&amp;page=<%=page%>&amp;p_num=<%=p_num%>" method="post" enctype="multipart/form-data">
<input type="hidden" name="ssid" value="<%=Left(Session.SessionID,2)%>" />
<input type="hidden" name="html" value="0" />
<input type="hidden" name="pw" value="11111" />
<!-- 추가필드 -->
<!--
<input type="hidden"  name="addtext2" value="<%=c_addtext2%>" />
<input type="hidden"  name="addtext3" value="<%=c_addtext3%>" />
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

	<article id="product_inquiry" class="mb_150 inquiry_com">
		<div class="con_wrap">
			<!--div class="tit">
				<p>ONLINE INQUIRY</p>
			</div-->
			<div class="formBox">
				<section class="section1">
				<%If k_category<>"" Then%>
					<div class="box">
						<div class="type">
							<p class="type_tit">카테고리 <em>*</em></p>
							<select name="cate" class="AXSelect" required>
								<%
								a_category = Split(k_category, "|")
								For Each cate_item In a_category
								%>
									<option value="<%=cate_item%>" <%If Trim(c_cate)=Trim(cate_item) Then Response.Write "selected"%>><%=cate_item%></option>
								<%
								Next
								%>
							</select>
						</div>
					</div>
				<%End If%>
					<div class="box">
						<div class="type">
							<p class="type_tit">회사명 <em>*</em></p>
							<input type="text" name="addtext1" value="<%=c_addtext1%>" placeholder="회사명을 입력하세요." required>
						</div>
						<div class="type">
							<p class="type_tit">이름 <em>*</em></p>
							<input type="text" name="name" value="<%=c_mem_name%>" placeholder="성함을 입력하세요." required>
						</div>
					</div>
					<div class="box">
						<div class="type">
							<p class="type_tit">연락처 <em>*</em></p>
							<input type="text" name="mem_tel" value="<%=c_mem_tel%>" placeholder="연락처를 입력하세요." required>
						</div>
						<div class="type">
							<p class="type_tit">이메일 <em>*</em></p>
							<input type="text" name="email" value="<%=c_mem_email%>" placeholder="이메일을 입력하세요." required>
						</div>
					</div>
					<div class="box">
						<div class="type w_max">
							<p class="type_tit">제목 <em>*</em></p>
							<input type="text" name="title" maxlength="200" value="<%=TagText(c_title)%>" placeholder="제목을 입력하세요." required />
						</div>
					</div>
				</section>
				<section class="section2">
					<div class="box">
						<div class="type">
							<p class="type_tit">내용 <em>*</em></p>
							<textarea name="content" id="" cols="30" rows="10" placeholder="내용을 입력하세요." required><%=c_content%></textarea>
						</div>
					</div>
				</section>
				<%If u_privacy=True Then%>
				<section class="section3">
					<div class="box">
						<div class="type">
							<p class="type_tit">개인정보처리방침 <em>*</em></p>
							<textarea name="" id="" cols="30" rows="10" readonly="readonly"><%=u_privacy_txt%></textarea>
							<div class="checkBox">
								<input type="checkbox" name="privacy" id="agree" required>
								<label for="agree">개인정보처리방침 동의 <em>*</em></label>
							</div>
						</div>
					</div>
				</section>
				<%End If%>
				<section class="section4">
					<%For fc=0 To k_upload-1%>
						<div class="box box1">
							<div class="type">
								<p class="type_tit">첨부#<%=fc+1%></p>
								<div class="content">
									<input type="text" class="upload-name" disabled="disabled">
									<label for="ex_filename<%=fc+1%>">파일선택</label>
									<input type="file" name="file<%=fc+1%>" id="ex_filename<%=fc+1%>" class="upload-hidden">
								</div>
							</div>
						</div>
					<%Next%>
					<%If k_spamcode=True Then%>
						<div class="box box2">
							<div class="type">
								<p class="type_tit">자동등록방지</p>
								<div class="content">
									<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /><button type="button" onclick="RefreshImage('imgCaptcha');">새로고침</button><input type="text" name="txtCaptcha" id="txtCaptcha" maxlength="5" placeholder="코드를 입력하세요" autocomplete="off" required />
								</div>
							</div>
						</div>
					<%End If%>
				</section>
			</div>
		</div>
		<div class="btn_com">
			<input type="submit" value="문의하기">
		</div>
	</article>
</form>

<script type="text/javascript">
$(document).ready(function(){
	$('.content .upload-hidden').on('change', function(){ //값이 변경되면 
		if(window.FileReader){ // modern browser 
			var filename = $(this)[0].files[0].name; 
		}else{ // old IE 
			var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
		} 
		$(this).siblings('.upload-name').val(filename);
	});
});
</script>