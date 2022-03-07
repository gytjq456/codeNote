<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=379ee157dcaff3e567a839e2f7971a33"></script>

<div class="ntb-search-area">
	<!-- store -->
	<div class="store">
		<div id="map-canvas" style="height: 600px; margin:30px 0;"></div>
	</div>
	<!-- //store -->
</div>
<br />
<br />

<form name="delform" action="?<%=pLink%>&amp;mode=seldel_p" method="post" enctype="multipart/form-data">
<table class="ntb-tb" style="width:100%" cellpadding="0" cellspacing="0">
	<!--
	<colgroup>
		<col width="9%" />
		<col width="9%" />
		<col width="18%" />
		<col width="" />
		<col width="16%" />
		<col width="15%" />
	</colgroup>
	-->
	<thead>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">지역</th>
			<th scope="col">대리점명</th>
			<th scope="col">주소</th>
			<th scope="col" class="r_none">연락처</th>
		</tr>
	</thead>
	<tbody>
	<%If Rs.EOF Then%>
		<tr>
			<td colspan="5">대리점이 없습니다.</td>
		</tr>
	<%Else%>
		<%
		num = Rs.RecordCount-((page-1)*Rs.pagesize)-cnt
		Do Until Rs.EOF Or cnt>=Rs.pagesize
			b_idx = Rs("idx")
			b_board_idx = Rs("board_idx")
			b_cate = Rs("cate")
			b_e1_idx = Rs("e1_idx")
			b_e2_idx = Rs("e2_idx")
			b_num = Rs("num")
			b_p_num = Rs("p_num")
			b_r_num = Rs("r_num")
			b_d_num = Rs("d_num")
			b_mem_name = Rs("mem_name")
			b_mem_id = Rs("mem_id")
			b_mem_pw = Rs("mem_pw")
			b_mem_tel = Rs("mem_tel")
			b_mem_url = Rs("mem_url")
			b_mem_email = Rs("mem_email")
			b_addtext1 = Rs("addtext1")
			b_addtext2 = Rs("addtext2")
			b_addtext3 = Rs("addtext3")
			b_addtext4 = Rs("addtext4")
			b_addtext5 = Rs("addtext5")
			b_addtext6 = Rs("addtext6")
			b_addtext7 = Rs("addtext7")
			b_addtext8 = Rs("addtext8")
			b_addtext9 = Rs("addtext9")
			b_addtext10 = Rs("addtext10")
			b_addtext11 = Rs("addtext11")
			b_addtext12 = Rs("addtext12")
			b_addtext13 = Rs("addtext13")
			b_addtext14 = Rs("addtext14")
			b_addtext15 = Rs("addtext15")
			b_title = Rs("title")
			b_content = Rs("content")
			b_comment_count = Rs("comment_count")
			b_read_count = Rs("read_count")
			b_ip = Rs("ip")
			b_file1 = Rs("file1")
			b_file2 = Rs("file2")
			b_file3 = Rs("file3")
			b_file4 = Rs("file4")
			b_file5 = Rs("file5")
			b_html = Rs("html")
			b_notice = Rs("notice")
			b_repmail = Rs("repmail")
			b_lock = Rs("lock")
			b_popup = Rs("popup")
			b_regdate = Rs("regdate")
			%>
			<tr>
				<td>
					<%
					'게시물 아이콘
					If b_notice=True Then%>
						<img src="/site/images/board/icon_notice.gif" class="vmiddle" alt="notice" />
					<%Else%>
						<%=num%>
					<%End If%>
				</td>
				<td><%
				'카테고리
				If b_cate<>"" Then
					Response.Write b_cate
				End If%></td>
				<td>
				<%
				'비밀글 이미지
				If b_lock=True Then%>
					<img src="/site/images/board/lock.gif" class="vmiddle" alt="lock" />
				<%End If%>
				<span class='bold'>
				<%
				If b_lock=True Then
					If (W_ID<>"" And W_ID=b_mem_id) Or W_LEVEL="1" Or W_LEVEL="2" Then%>
						<a href="?mode=view&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
					<%Else%>
						<a href="?mode=view_l&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
					<%End If
				Else%>
					<a href="?mode=view&amp;<%=pLink%>&amp;idx=<%=b_idx%>&amp;page=<%=page%>">
				<%End If%>
				<%=TagText(b_title)%>
				</a></span>
				<%
				'덧글 갯수 출력
				If k_comment=true Then
					Set RsC = Server.CreateObject("ADODB.Recordset")
					Sql = "SELECT COUNT(*) FROM tbl_board_comment WHERE board_idx='" & bid & "' AND dat_idx='" & b_idx & "'"
					RsC.Open Sql, Dbcon, 1
					If RsC(0)<>0 Then Response.Write "<span class='font_comment'>[" & RsC(0) & "]</span>"
					RsC.Close
					Set RsC = Nothing
				End If

				'일정 이내에 작성한 글에는 new 표시
				If DateDiff("h", b_regdate, Now())<k_newicon Then%>
					<img src="/site/images/board/icon_new.gif" class="vmiddle" alt="new" />
				<%End If%>
				</td>
				<td class="left"><%=b_addtext1 & " " & b_addtext2%></td>
				<td><%=b_mem_tel%></td>
			</tr>
			<%
			map_addr = map_addr & "{" & Chr(13) & Chr(10)
			map_addr = map_addr & "	content: '<div class=""nameTag""><h3>" & b_title & "</h3><p class=info>" & b_addtext1 & " " & b_addtext2 & "</p><p class=info>" & b_mem_tel & "</p></div>', " & Chr(13) & Chr(10)
			map_addr = map_addr & "	latlng: new daum.maps.LatLng(" & b_addtext4 & ", " & b_addtext3 & ")" & Chr(13) & Chr(10)
			map_addr = map_addr & "}," & Chr(13) & Chr(10)

			num=num-1
			cnt=cnt+1
			Rs.MoveNext
		Loop
	End If
	%>
	</tbody>
</table>
</form>

<!--버튼-->
<div class="ntb-listbtn-area">
	<%If CInt(a_write)>=CInt(W_LEVEL) Then%>
		<input type="button" value=" 쓰기 " class="AXButton Classic" onclick="location.href='?<%=pLink%>&amp;mode=reg'">
	<%End If%>
</div>

<!--페이징-->
<%Call Pagelist("?mode=list&" & pLink, CInt(page), k_pagelist, 5, Rs_RecordCount)%>


<script>
var container = document.getElementById('map-canvas');
var options = {
	center: new daum.maps.LatLng(37.522535,126.977969),
	level: 9
};

var map = new daum.maps.Map(container, options);

var imageSrc = '/site/bbs/skin/resp_agent_map/images/point_b.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(26, 38), // 마커이미지의 크기입니다
    imageOption = {offset: new daum.maps.Point(13, 38)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption)

// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
var positions = [
<%=map_addr%>
];

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new daum.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커의 위치
		image: markerImage // 마커이미지 설정 
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new daum.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    daum.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
</script>
