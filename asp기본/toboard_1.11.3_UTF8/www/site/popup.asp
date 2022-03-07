<script language="javascript">
function GetCookie(name){
	var nameOfCookie = name + "=";
	var x = 0;
	while(x<=document.cookie.length){
		var y = (x+nameOfCookie.length);
		if(document.cookie.substring(x, y) == nameOfCookie){
		if((endOfCookie=document.cookie.indexOf(";", y))==-1)
			endOfCookie = document.cookie.length;
			return unescape( document.cookie.substring( y, endOfCookie ) );
		}
		x = document.cookie.indexOf( " ", x ) + 1;
		if ( x == 0 ) break;
	}
	return "";
}

function SetCookie(name, value, expiredays){
	var todayDate = new Date();
	todayDate.setDate(todayDate.getDate() + expiredays);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}
 
function PopClose(idx, mode){
	if (mode=="1"){
		SetCookie("NT-POPUP-"+idx, "done", 1);
	}
	document.getElementById("pop"+idx).style.display="none";
}
</script>

<%
Set RsP = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_popup WHERE p_hide='0' AND p_lang='" & pop_lang & "' "
Sql = Sql & " AND p_sdate<='" & Date() & "' AND p_edate>='" & Date() & "' "
'Response.write sql
RsP.Open Sql, Dbcon, 1
Do Until RsP.EOF	
	p_idx = RsP("idx")
	p_title = RsP("p_title")
	p_left = RsP("p_left")
	p_top = RsP("p_top")
	p_width = RsP("p_width")
	p_height = RsP("p_height")
	p_content = RsP("p_content")
	p_site = RsP("p_site")
	p_hide = RsP("p_hide")
	p_sdate = RsP("p_sdate")
	p_edate = RsP("p_edate")
	p_link = RsP("p_link")	
	%>

	<div class="pop-wrap" id="pop<%=p_idx%>" style="left:<%=p_left%>px; top:<%=p_top%>px; z-index:<%=1000+p_idx%>;">
		<div class="pop-content" style="width:<%=p_width%>px; height:<%=p_height%>px; overflow:hidden;"><%=p_content%></div>
		<ul class="pop-bottom">
			<li class="pb-left" onclick="PopClose(<%=p_idx%>, 1)" style="cursor:pointer">
			<%If pop_lang="한국어" Then%>
				오늘 하루 표시하지 않습니다.
			<%Else%>
				Do not show this again today.
			<%End If%></li>
			<li class="pb-right" onclick="PopClose(<%=p_idx%>, 0)" style="cursor:pointer"><img src="/site/images/board/x.gif" class="vmiddle" alt="close"></li>
		</ul>
	</div>

	<script type="text/javascript">
	$(function() {
		$( "#pop<%=p_idx%>" ).draggable();
	});
	if(GetCookie("NT-POPUP-<%=p_idx%>")!="done" ) {
		document.getElementById("pop<%=p_idx%>").style.display = "block";
	}
	</script>

	<%
RsP.Movenext
Loop
Set RsP = Nothing
%>

<script type="text/javascript">
// 팝업 이미지 영역 자동맞춤
window.onload = function(){
	pop_size();
};
$(window).resize(function(){
	pop_size();
});
function pop_size(){
	$(".pop-content img").each(function(){
		var img_h = $(this).height();
		$(this).closest(".pop-content").css({
			height:img_h
		});
	});
};

</script>