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
			<th scope="col">지역분류</th>
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
			map_addr = map_addr & "<div class=""nameTag""><h3>" & b_title & "</h3><p class=info>" & b_addtext1 & " " & b_addtext2 & "</p><p class=info>" & b_mem_tel & "</p></div>|"
			map_xy = map_xy & b_addtext4 & ", " & b_addtext3 & "|"

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


<!-- google map api -->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDl5nNv45o4Xnn7OOWgGlFd1aHeOhGbUaA"></script>
<script type="text/javascript">
var Addr ='<%=map_addr%>';
var Addr_total =Addr.split("|");

var reg_int ='<%=map_xy%>';
var Reg_Total = reg_int.split("|");

var str_addr='<%=map_addr%>';
Reg_Addr_Sell = str_addr.split("|");

///// 현재위치
var seoul = new google.maps.LatLng(37.522535,126.977969);

if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(successCallback,errorCallback,{timeout:10000});
} else {
	seoul = new google.maps.LatLng(37.522535,126.977969); 
}

function successCallback(position) {	
	seoul = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
}

function errorCallback(msg) {
	seoul = new google.maps.LatLng(37.522535,126.977969); 
}

var neighborhoods = [] ;
var map_tit = [] ;
var map_level =[];
var  Total_xy;

for(i=0;i<Reg_Total.length;i++){
	Reg_Sell = Reg_Total[i].split(",");
	neighborhoods[i] = new google.maps.LatLng(Reg_Sell[0],Reg_Sell[1]);
	map_tit[i] = Reg_Addr_Sell[i];
}

var markers = [];
var iterator = 0;
var map;

function initialize() {	 
	var mapOptions = {
		zoom: 10,
		center: seoul
	};
	map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
}

function drop() {
	for (var i = 1; i < neighborhoods.length+1; i++) {
		setTimeout(function() {
			addMarker();
		}, i * 200);
	}
}

var prev_infowindow =false; 

function addMarker() {
	var image = "/site/bbs/skin/resp_agent_map/images/point_b.png"; //무료,베이직
	var marker = new google.maps.Marker({
		position: neighborhoods[iterator],
		map: map,
		info: map_tit[iterator],
		draggable: false,
		icon: image,
		animation: google.maps.Animation.DROP 
	});

	var contentString = marker.info;
	var infowindow = new google.maps.InfoWindow({ 
		content: contentString,
		maxWidth: 300
	});

	google.maps.event.addListener(marker, "click", function() {
        if( prev_infowindow ) {
           prev_infowindow.close();
        }
        prev_infowindow = infowindow;
        infowindow.open(map, marker);
	});
	iterator++;
}

google.maps.event.addDomListener(window, 'load', initialize);
drop();
</script>