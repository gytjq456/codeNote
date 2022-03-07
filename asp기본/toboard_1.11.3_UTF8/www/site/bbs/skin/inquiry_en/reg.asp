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
							<p class="type_tit">Category <em>*</em></p>
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
							<p class="type_tit">Company <em>*</em></p>
							<input type="text" name="addtext1" value="<%=c_addtext1%>" required>
						</div>
						<div class="type">
							<p class="type_tit">Name <em>*</em></p>
							<input type="text" name="name" value="<%=c_mem_name%>" required>
						</div>
					</div>
					<div class="box">
						<div class="type">
							<p class="type_tit">Phone <em>*</em></p>
							<input type="text" name="mem_tel" value="<%=c_mem_tel%>" required>
						</div>
						<div class="type">
							<p class="type_tit">E-mail <em>*</em></p>
							<input type="text" name="email" value="<%=c_mem_email%>" required>
						</div>
					</div>
					<div class="box">
						<div class="type w_max">
							<p class="type_tit">Title <em>*</em></p>
							<input type="text" name="title" maxlength="200" value="<%=TagText(c_title)%>" required />
						</div>
					</div>
				</section>
				<section class="section2">
					<div class="box">
						<div class="type">
							<p class="type_tit">Content <em>*</em></p>
							<textarea name="content" id="" cols="30" rows="10" required><%=c_content%></textarea>
						</div>
					</div>
				</section>
				<%If u_privacy=True Then%>
				<section class="section3">
					<div class="box">
						<div class="type">
							<p class="type_tit">Privacy policy <em>*</em></p>
							<textarea name="" id="" cols="30" rows="10" readonly="readonly">1. Personal information item to collect
    This site collects personal information like below in order to inquire about the homepage and apply for service.
    Collection item : Name, Phone Number, E-mail 
    Personal information collection method :  Inquiry and report on homepage , consultation

2. The purpose of personal information collection and usage 
    This site uses the personal information collected for the following purposes:
    Member management
    Complaint handling such as personal identification and dissatisfaction processing, and notice delivery, etc.

3. The period for retention and usage of personal information.
    In principle, once the purpose of personal information collection and usage has been achieved, personal information shall be destroyed immediately. 
    However, the following information will be retained for the period specified for the following reasons:
    Retention item: Name, Phone Number, E-mail 
    Criteria for preservation: Documents management regulations
    Retention period : 3 years</textarea>
							<div class="checkBox">
								<input type="checkbox" name="privacy" id="agree" required>
								<label for="agree">I agree to privacy policy <em>*</em></label>
							</div>
						</div>
					</div>
				</section>
				<%End If%>
				<section class="section4">
					<%For fc=0 To k_upload-1%>
						<div class="box box1">
							<div class="type">
								<p class="type_tit">File#<%=fc+1%></p>
								<div class="content">
									<input type="text" class="upload-name" disabled="disabled">
									<label for="ex_filename<%=fc+1%>">Select</label>
									<input type="file" name="file<%=fc+1%>" id="ex_filename<%=fc+1%>" class="upload-hidden">
								</div>
							</div>
						</div>
					<%Next%>
					<%If k_spamcode=True Then%>
						<div class="box box2">
							<div class="type">
								<p class="type_tit">Captcha</p>
								<div class="content">
									<img src="/site/api/captcha/captcha.asp" id="imgCaptcha" class="vmiddle" /><button type="button" onclick="RefreshImage('imgCaptcha');">Refresh</button><input type="text" name="txtCaptcha" id="txtCaptcha" maxlength="5" autocomplete="off" required />
								</div>
							</div>
						</div>
					<%End If%>
				</section>
			</div>
		</div>
		<div class="btn_com">
			<input type="submit" value="Send">
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