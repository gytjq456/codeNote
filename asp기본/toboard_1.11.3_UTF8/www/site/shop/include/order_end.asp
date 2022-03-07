<script type="text/javascript">
alert('주문이 완료 되었습니다. 감사합니다.');
<%If W_ID<>"" Then%>
location.href="?mode=order_info_list";
<%Else%>
location.href="/";
<%End If%>

history.pushState(null, null, location.href);
window.onpopstate = function(event) {
	history.go(1);
};
</script>