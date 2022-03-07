<!--#include virtual="/site/common/function.asp" -->
<%
addr = Trim(Request("addr1") & " " & Request("addr2"))
coord = Addr2Coord(addr)
arr_coord = Split(coord, ",")
%>
x : <input type="text"  name="addtext3" value="<%=arr_coord(0)%>" class="AXInput W150" readonly />&nbsp;&nbsp;
y : <input type="text"  name="addtext4" value="<%=arr_coord(1)%>" class="AXInput W150" readonly />
