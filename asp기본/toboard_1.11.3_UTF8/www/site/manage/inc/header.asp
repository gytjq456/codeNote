<body>
<%
If Len(W_LEVEL)<>1 Then
	Response.Write "<script>alert('접속 권한이 없습니다.'); location.href='/site/manage'</script>"
	Response.End
End If
%>

<!-- topmenu -->
<div class="topmenu">
	<ul>
		<li><span><%=W_NAME%>(<%=W_ID%>)</span>님이 로그인 하셨습니다.&nbsp;&nbsp;</li>
		<li><a href="/" target="_blank"><img src="/site/manage/images/btn/btn_topmenu01.gif" alt="website" /></a></li>
		<li><a href="/site/manage/login_ok.asp?mode=out"><img src="/site/manage/images/btn/btn_topmenu02.gif" alt="logout" /></a></li>
	</ul>
</div>
<!-- //topmenu -->

<!-- wrap -->
<div class="wrap">
	
	<div class="version">v.1.11.3</div>

	<!-- headline -->
	<div class="headline">
		<h1><a href="/site/manage/main.asp"><img src="/site/manage/images/icon/logo.gif" alt="Administrator" /></a></h1>
		<!--form name="tsform" method="post" action="/site/manage/sub-bbs/bbs-search.asp" onsubmit="return TSChk(this)">
		<p>
			<input type="text" name="bbs_keyword" value="<%=bbs_keyword%>" class="AXInput Round" placeholder="BBS Search" style="height:18px" />&nbsp;&nbsp;</span>
			<input type="image" src="/site/manage/images/btn/btn_search.gif" alt="search"/>
		</p>
		</form-->
	</div>
	<!-- //headline -->

	<script type="text/javascript">
	function TSChk(obj){
		if(!obj.bbs_keyword.value){ alert("검색어를 입력하세요"); obj.bbs_keyword.focus(); return false}
	}
	</script>
	<!-- container -->
	<div class="container">

		<!-- lnb -->
		<div class="lnb">

			<ul id="menu">
			<%
			'기본 설정
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-basic")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-basic")>0 Then Response.Write "class='on'"%>>
					<a href="#">기본 설정</a>
					<ul>
						<li <%If InStr(urlPath, "sub-basic")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-basic/admin-info.asp">관리자 정보</a></li>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-site-info")>0 Then%>
						<li><a href="/site/manage/sub-basic/site-info.asp">사이트 설정</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-mall-info")>0 Then%>
						<li><a href="/site/manage/sub-basic/mall-info.asp">쇼핑몰 설정</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-base-info")>0 Then%>
						<li><a href="/site/manage/sub-basic/base-info.asp">기본 정보 설정</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-account-admin")>0 Then%>
						<li><a href="/site/manage/sub-basic/account-admin.asp">관리자 계정 설정</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-site-favi")>0 Then%>
						<li><a href="/site/manage/sub-basic/favicon.asp">파비콘 설정</a></li>
						<%End If%>
						<!--
						<li><a href="">Naver Syndication</a></li>
						-->
					</ul>
				</li>
			<%
			End If

			'회원 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-member")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-member")>0 Then Response.Write "class='on'"%>>
					<a href="#">회원 관리</a>
					<ul>
						<%
						Set RsMem = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT COUNT(*) FROM tbl_member WHERE m_lev NOT IN ('1', '2', '3')"
						RsMem.Open Sql, Dbcon, 1
							member_count = RsMem(0)
						RsMem.Close
						Set RsMem = Nothing
						%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-member-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-member")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-member/member.asp">회원 관리
						<span class="count"><%=member_count%></span>
						</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-member-reg")>0 Then%>
						<li><a href="/site/manage/sub-member/member-reg.asp?mode=reg">회원 등록</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-member-level")>0 Then%>
						<li><a href="/site/manage/sub-member/member-level.asp">회원 등급 관리</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-member-mail")>0 Then%>
						<li><a href="/site/manage/sub-member/group-mail-send.asp">단체 메일 발송</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'제품 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-recruit")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-recruit")>0 Then Response.Write "class='on'"%>>
					<a href="#">채용 관리</a>
					<ul>
					<%
						Set Rsrecruit = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT COUNT(*) FROM tbl_recruit "
						Rsrecruit.Open Sql, Dbcon, 1
							recruit_count = Rsrecruit(0)
						Rsrecruit.Close
						Set Rsrecruit = Nothing
					%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-recruit-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-recruit")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-recruit/recruit.asp">채용 관리
						<span class="count"><%=recruit_count%></span></a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-recruit-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-recruit")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-recruit/recruit_e.asp">마감된 채용리스트
						</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-recruit-reg")>0 Then%>
						<li><a href="/site/manage/sub-recruit/recruit-reg.asp?mode=reg">채용 등록</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-application-list")>0 Then%>
						<li><a href="/site/manage/sub-recruit/application-list.asp">지원자 관리</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'제품 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-product")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-product")>0 Then Response.Write "class='on'"%>>
					<a href="#">제품 관리</a>
					<ul>
						<%
						Set RsProd = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT COUNT(*) FROM tbl_prod "
						RsProd.Open Sql, Dbcon, 1
							product_count = RsProd(0)
						RsProd.Close
						Set RsProd = Nothing
						%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-prod-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-product")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-product/prod.asp">제품 관리
						<span class="count"><%=product_count%></span></a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-prod-reg")>0 Then%>
						<li><a href="/site/manage/sub-product/prod-reg.asp?mode=reg">제품 등록</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-xlsreg")>0 Then%>
						<li><a href="/site/manage/sub-product/prod-excel-upload.asp">엑셀 일괄등록</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-prod-cate")>0 Then%>
						<li><a href="/site/manage/sub-product/cate.asp">제품 카테고리 관리</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'주문 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-order")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-order")>0 Then Response.Write "class='on'"%>>
					<a href="#">주문 관리</a>
					<ul>
						<%
						Set RsOrd = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT COUNT(*), ISNULL(SUM(o_amount), 0) FROM tbl_mall_order WHERE o_state='결제대기'"
						RsOrd.Open Sql, Dbcon, 1
							order_count1 = RsOrd(0)
							order_amount1 = RsOrd(1)
						RsOrd.Close
						Sql = "SELECT COUNT(*), ISNULL(SUM(o_amount), 0) FROM tbl_mall_order WHERE o_state='결제완료'"
						RsOrd.Open Sql, Dbcon, 1
							order_count2 = RsOrd(0)
							order_amount2 = RsOrd(1)
						RsOrd.Close
						Sql = "SELECT COUNT(*), ISNULL(SUM(o_amount), 0) FROM tbl_mall_order WHERE o_state='발송준비'"
						RsOrd.Open Sql, Dbcon, 1
							order_count3 = RsOrd(0)
							order_amount3 = RsOrd(1)
						RsOrd.Close
						Sql = "SELECT COUNT(*), ISNULL(SUM(o_amount), 0) FROM tbl_mall_order WHERE o_state='발송완료'"
						RsOrd.Open Sql, Dbcon, 1
							order_count4 = RsOrd(0)
							order_amount4 = RsOrd(1)
						RsOrd.Close
						Set RsOrd = Nothing
						%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-order-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-order")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-order/order.asp">주문 관리</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=결제대기">결제대기
							<%If order_count1>0 Then%><span class="count"><%=order_count1%></span><%End If%></a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=결제완료">결제완료
							<%If order_count2>0 Then%><span class="count"><%=order_count2%></span><%End If%></a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=발송준비">발송준비
							<%If order_count3>0 Then%><span class="count"><%=order_count3%></span><%End If%></a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=발송완료">발송완료
							<%If order_count4>0 Then%><span class="count"><%=order_count4%></span><%End If%></a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=주문취소">주문취소</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=교환">교환</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=반품">반품</a></li>
							<!--<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order.asp?s_state=-1">(미주문)</a></li> -->
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-order-stat")>0 Then%>
						<li <%If InStr(urlPath, "sub-order")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-order/order-stat-day.asp">주문 통계</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order-stat-day.asp">일별 주문현황</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order-stat-month.asp">월별 주문현황</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/order-stat-prod.asp">제품별 주문현황</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-order-coupon")>0 Then%>
						<li><a href="/site/manage/sub-order/coupon.asp">쿠폰 관리</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/coupon.asp">쿠폰 관리</a></li>
							<li class="<%If InStr(urlPath, "sub-order")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-order/coupon-dl.asp">발급된 쿠폰 관리</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'컨텐츠 페이지 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-page")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-page")>0 Then Response.Write "class='on'"%>>
					<a href="#">페이지 관리</a>
					<ul>
						<%
						Set RsPg = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT idx, p_page1, p_page2, p_page3 FROM tbl_page ORDER BY p_lev ASC "
						RsPg.Open Sql, Dbcon, 1
						page_count = RsPg.RecordCount
						%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-page-setting")>0 Then%>
						<li <%If InStr(urlPath, "sub-page")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-page/">컨텐츠 페이지 관리
						<span class="count"><%=page_count%></span></a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-page-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-page")>0 Then Response.Write "class='current'"%>><a href="#">컨텐츠 페이지 목록</a></li>
						<%
						Do Until RsPg.EOF
							pg_idx = RsPg("idx")
							pg_page1 = RsPg("p_page1")
							pg_page2 = RsPg("p_page2")
							pg_page3 = RsPg("p_page3")
							%>
							<li class="<%If InStr(urlPath, "sub-page")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-page/page.asp?mode=mod&idx=<%=pg_idx%>">
							<%=pg_page1%>
							<%If pg_page2<>"" Then Response.Write " > " & pg_page2%>
							<%If pg_page3<>"" Then Response.Write " > " & pg_page3%></a></li>
							<%
							RsPg.Movenext
						Loop
						RsPg.Close
						Set RsPg = Nothing
						%>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-page-cate")>0 Then%>
						<li><a href="/site/manage/sub-page/cate.asp">페이지 카테고리 관리</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-popup")>0 Then%>
						<li <%If InStr(urlPath, "sub-page")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-page/popup.asp">팝업 관리</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-banner")>0 Then%>
						<li <%If InStr(urlPath, "sub-page")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-page/banner.asp">배너 관리</a></li>
						<%
						Set RsBn = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT bc_name FROM tbl_banner_config ORDER BY bc_lev DESC, bc_name ASC "
						RsBn.Open Sql, Dbcon, 1
						Do Until RsBn.EOF
							bn_bc_name = RsBn("bc_name")
							%>
							<li class="<%If InStr(urlPath, "sub-page")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-page/banner.asp?s_bc_name=<%=Server.URLEncode(bn_bc_name)%>"><%=bn_bc_name%></a></li>
							<%
							RsBn.Movenext
						Loop
						RsBn.Close
						Set RsBn = Nothing
						%>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'게시판 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-bbs")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-bbs")>0 Then Response.Write "class='on'"%>>
					<a href="/site/manage/sub-bbs/bbs-setting.asp">게시판 관리</a>
					<ul>
						<%
						Set RsB = Server.CreateObject("ADODB.Recordset")
						Sql = "SELECT idx, k_group, k_id FROM tbl_board_id ORDER BY p_lev, idx"
						RsB.Open Sql, Dbcon, 1
						bbs_count = RsB.RecordCount
						%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-bbs-setting")>0 Then%>
						<li <%If InStr(urlPath, "sub-bbs")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-bbs/bbs-setting.asp">게시판 관리
						<span class="count"><%=bbs_count%></span></a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-bbs-list")>0 Then%>
						<li <%If InStr(urlPath, "sub-bbs")>0 Then Response.Write "class='current'"%>><a href="#">게시판 목록</a></li>
						<%
						Do Until RsB.EOF
							bi_idx = RsB("idx")
							bi_k_group = RsB("k_group")
							bi_k_id = RsB("k_id")
							%>
							<li class="<%If InStr(urlPath, "sub-bbs")>0 Then Response.Write "current"%> sublist"><a href="/site/manage/sub-bbs/?bid=<%=bi_idx%>&mode=list">
							<%If bi_k_group<>"" Then Response.Write bi_k_group & " > "%>
							<%=bi_k_id%></a></li>
							<%
							RsB.Movenext
						Loop
						RsB.Close
						Set RsB = Nothing
						%>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'E-Book 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-ebook")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-ebook")>0 Then Response.Write "class='on'"%>>
					<a href="#">E-Book 관리</a>
					<ul>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-ebook")>0 Then%>
						<li><a href="/site/manage/sub-ebook/ebook.asp">E-Book 관리</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'접속자 통계
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-stats")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-stats")>0 Then Response.Write "class='on'"%>>
					<a href="/site/manage/sub-stats/">접속자 통계</a>
					<ul>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-stats-d")>0 Then%>
						<li <%If InStr(urlPath, "sub-stats")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-stats/?s_type=d">일별 통계</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-stats-w")>0 Then%>
						<li <%If InStr(urlPath, "sub-stats")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-stats/?s_type=w">요일별 통계</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-stats-m")>0 Then%>
						<li <%If InStr(urlPath, "sub-stats")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-stats/?s_type=m">월별 통계</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-stats-detail")>0 Then%>
						<li <%If InStr(urlPath, "sub-stats")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-stats/detail.asp">세부 접속 로그</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If

			'기타 관리
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-other")>0 Then
			%>
				<li <%If InStr(urlPath, "sub-other")>0 Then Response.Write "class='on'"%>>
					<a href="#">기타 설정</a>
					<ul>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-seo")>0 Then%>
						<li <%If InStr(urlPath, "sub-other")>0 Then Response.Write "class='current'"%>><a href="/site/manage/sub-other/seo.asp">검색엔진 최적화 설정</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-smtp")>0 Then%>
						<li><a href="/site/manage/sub-other/smtp.asp">메일 발송 서버 설정</a></li>
						<%End If%>
						<!--li><a href="/site/manage/sub/google-analytics.asp">Google Analytics</a></li-->
					</ul>
				</li>
			<%
			End If

			'고객센터
			If W_LEVEL="1" Or InStr(admin_a_auth, "0-customer")>0 Then
			%>
				<li>
					<a href="#">고객센터</a>
					<ul>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-wims")>0 Then%>
						<li><a href="http://wims.webmoa.co.kr" target="_blank">통합관리 시스템 (WIMS)</a></li>
						<%End If%>
						<%If W_LEVEL="1" Or InStr(admin_a_auth, "1-webmoa")>0 Then%>
						<li><a href="http://webmoa.co.kr" target="_blank">(주)웹모아 홈페이지</a></li>
						<%End If%>
					</ul>
				</li>
			<%
			End If
			%>
			</ul>
		</div>
		<!-- //lnb -->

		<!-- contents_box -->
		<div class="contents_box">