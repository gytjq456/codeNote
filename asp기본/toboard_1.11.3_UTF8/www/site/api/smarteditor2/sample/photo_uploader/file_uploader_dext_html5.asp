<%@CodePage = 65001%>
<%
Set UploadForm = Server.CreateObject("DEXT.FileUpload")
UploadForm.CodePage = 65001
UploadForm.AutoMakeFolder = True
UploadForm.DefaultPath=Server.MapPath("/upload/smartupload/")

callback_func = UploadForm("callback_func")

Response.Write UploadForm("uploadInputBox").FileName
Set UploadForm = Nothing

%> 