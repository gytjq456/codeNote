<%
'------------- 검색엔진 최적화 설정----------------
urlPath = Request.ServerVariables("PATH_INFO") 
urlQuery = Request.ServerVariables("QUERY_STRING")
If urlQuery<>"" Then 
	urlNow = urlPath & "?" & urlQuery
Else
	urlNow = urlPath
End If
urlNowFull = "http://" & Request.ServerVariables("SERVER_NAME") & urlNow

'페이지별 메타태그
Set RsInfo = Server.Createobject("ADODB.Recordset")
Sql = "SELECT * FROM tbl_site_seopage WHERE m_path='" & urlPath & "' "
RsInfo.Open Sql, Dbcon, 1
If RsInfo.EOF=False Then
	head_title = RsInfo("m_title")
	meta_keywords = RsInfo("m_keywords")
	meta_description = RsInfo("m_description")
End If
RsInfo.Close
Set RsInfo = Nothing

'게시판 메타태그
If bid<>"" Then
	If k_seo=True And mode="view" Then	'SEO적용시 뷰페이지
		head_title = c_seo_title & " - " & k_id & " - " & meta_subject
		meta_keywords = c_seo_keyword
		meta_description = strDescription(c_seo_description)
	ElseIf c_title<>"" Then
		head_title = c_title & " - " & k_id & " - " & head_title
		meta_keywords = ""
		meta_description = ""
	End If
End If

'제품소개 메타태그
If q="prod" Then
	If p_head_title<>"" Then head_title = p_head_title
	If p_meta_keywords<>"" Then meta_keywords = p_meta_keywords
	If p_meta_description<>"" Then meta_description = p_meta_description

'컨텐츠페이지 메타태그
ElseIf q="page" Then
	If pg_head_title<>"" Then head_title = pg_head_title
	If pg_meta_keywords<>"" Then meta_keywords = pg_meta_keywords
	If pg_meta_description<>"" Then meta_description = pg_meta_description
End If
%>

<title><%=head_title%></title>
<meta name="title" content="<%=head_title%>" /> 
<meta name="author" content="<%=meta_author%>" />
<meta name="keywords" content="<%=meta_keywords%>" />
<meta name="subject" content="<%=meta_subject%>"/>
<meta name="description" content="<%=meta_description%>" />
<meta name="copyright" content="<%=meta_copyright%>" />
<meta name="content-language" content="<%=meta_content_language%>" />
<meta property="og:type" content="website">
<meta property="og:title" content="<%=head_title%>">
<meta property="og:site_name" content="<%=head_title%>">
<meta property="og:description" content="<%=meta_description%>">

<%If favicon<>"" Then%>
<link rel="shortcut icon" type="image/x-icon" href="/upload/favicon/<%=favicon%>" />
<%End If%>

<!-- css block -->
<link rel="stylesheet" type="text/css" href="/site/css/axj.css" />
<link rel="stylesheet" type="text/css" href="/site/css/AXButton.css" />
<link rel="stylesheet" type="text/css" href="/site/css/site.css" />
<link rel="stylesheet" type="text/css" href="/site/css/shop.css" />
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<%If bid<>"" Then%>
<link rel="stylesheet" type="text/css" href="/site/bbs/skin/<%=k_mode%>/style.css" />
<%End If%>

<!-- js block -->
<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.13.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="/site/js/common.js"></script>
<script type="text/javascript" src="/site/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="/site/api/smarteditor2/js/HuskyEZCreator.js" charset="utf-8"></script>
<%=sc_analy%>