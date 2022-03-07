<link rel="stylesheet" type="text/css" href="/site/css/prod.css" />

<%
'새로고침시 조회수 증가 방지용 쿠키
If Request.Cookies("PROD_HIT_" & idx)="" Then
	Dbcon.Execute "UPDATE tbl_prod SET p_hit=p_hit+1 WHERE idx='" & idx & "'"
	Response.Cookies("PROD_HIT_" & idx) = "yes"
End If

'오늘본상품
If Request.Cookies("TODAY_PROD")="" Then
	Response.Cookies("TODAY_PROD") = idx
Else
	Response.Cookies("TODAY_PROD") = Request.Cookies("TODAY_PROD") & "," & idx
End If
%>

<div class="pd_view">
	<div class="info_wrap">
		<div class="top_box clear">
			<div class="txt_box">
				<div class="route">
					<%If p_display<>"" Then%>
						<span class="tag"><%=p_display%></span>
					<%End If%>
					<p><%=cate_name1%></p>
					<%If cate_name2<>"" Then%>
						<img src="/site/images/shop/view_route_arrow.png" alt="화살표" />
						<p><%=cate_name2%></p>
					<%End If%>
					<%If cate_name3<>"" Then%>
						<img src="/site/images/shop/view_route_arrow.png" alt="화살표" />
						<p><%=cate_name3%></p>
					<%End If%>
				</div>
				<h5><%=p_name%><span><%=p_memo%></span></h5>
			</div>
			<!-- 링크 퍼가기 -->
			<a href="javascript:ProdCopy();" class="link">
				<input type="text" id="urlnowx" name="urlnowx" value="<%=urlNowFull%>" style="position:absolute; opacity:0;"/>
				<img src="/site/images/shop/link_img.png" alt="아이콘" />
				링크 퍼가기
			</a>
			<script type="text/javascript">
			function ProdCopy(){
				$('#urlnowx').select();
				document.execCommand('copy');
				alert('클립보드에 복사 되었습니다.');
			}
			</script>
			<!--// 링크 퍼가기 -->
		</div>

		<div class="info_box quick_start">
			<ul class="slide">
				<%
				For i=1 To 8
					If p_image(i-1)<>"" Then%>
					<li>
						<div class="img_box">
							<img src="/upload/prod/<%=p_image(i-1)%>" alt="이미지" />
						</div>
					</li>
					<%End If
				Next
				%>
			</ul>
			<div class="info">
				<ul class="info_txt">
					<li>
					<%	
					'추가항목
					For i=1 To 10
						If p_item(i-1)<>"" Then%>
						<div class="box">
							<div class="left">
								<p><%=p_item(i-1)%></p>
							</div>
							<div class="right">
								<p><%=p_item_text(i-1)%></p>
							</div>
						</div>
						<%End If
					Next

					'첨부파일
					For i=1 To 6
						If p_file(i-1)<>"" Then%>
						<div class="box">
							<div class="left">
								<p>다운로드 <%=i%></p>
							</div>
							<div class="right">
								<p><button type="button" onclick="location.href='/site/prod/include/download.asp?file=<%=Server.UrlEncode(p_file(i-1))%>'" class="AXButton"><%=p_file(i-1)%></button></p>
							</div>
						</div>
						<%End If
					Next%>
					</li>
				</ul>
				<%'쇼핑몰 이용시
				If mc_use=True Then%>
					<!-- #include virtual="/site/shop/include/inc_view_shop.asp" -->
				<%End If%>
			</div>
		</div>
	</div>
	<div class="tab_wrap">
		<ul class="tab_btn">
			<li class="on"><a href="javascript:;">상품설명</a></li>
			<li><a href="javascript:;">배송 정보</a></li>
			<li><a href="javascript:;">교환/반품정보</a></li>
		</ul>
		<div class="tab_box">
			<div class="tab">
				<%=p_content(0)%>
			</div>
			<div class="tab">
				<%=mc_deli_content%>
			</div>
			<div class="tab">
				<%=mc_chng_content%>
			</div>
		</div>
		<script>
			$('.tab_box .tab').hide();
			$('.tab_box .tab').eq(0).show();
			$('.tab_btn li a').click(function(){
				var idx  = $(this).parent().index();
				$('.tab_btn li').removeClass('on');
				$(this).parent().addClass('on');
				$('.tab_box .tab').hide();
				$('.tab_box .tab').eq(idx).show();
			});
		</script>
	</div>
</div>

<script>
	$('.pd_view .slide').slick({
		dots: false,
		arrows : true,
		infinite: true,
		speed: 500,
		slidesToShow: 1
	});
</script>