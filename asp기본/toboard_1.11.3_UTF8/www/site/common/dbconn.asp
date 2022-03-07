<%
DB_SERVER = "58.230.162.205"
DB_NAME = "bbs2"
DB_ID = "bbs2"
DB_PW = "bbs2!@#$"
Set Dbcon = Server.CreateObject("ADODB.Connection")
Dbcon.Open "Provider=SQLOLEDB.1;Password=" & DB_PW & ";Persist Security Info=True;User ID=" & DB_ID & ";Initial Catalog=" & DB_NAME & ";Data Source=" & DB_SERVER
%>