<%
mode = Request("mode")
If mode="" Then mode="cart"
o_code = Request("o_code")

pLink = "o_code=" & o_code
%>