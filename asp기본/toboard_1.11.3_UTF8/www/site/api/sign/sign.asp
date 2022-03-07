<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>jQuery Signature Pad Examples</title>
<link href="/site/api/sign/assets/jquery.signaturepad.css" rel="stylesheet">
<!--[if lt IE 9]><script src="../assets/flashcanvas.js"></script><![endif]-->
</head>
<body>

<form name="regform" method="post" action="sign_ok.asp" enctype="multipart/form-data">
	<div class="sigPad" id="linear" style="width:304px;">
		<ul class="sigNav">
			<li class="clearButton"><a href="#clear">Clear</a></li>
		</ul>
		<div class="sig sigWrapper" style="height:auto;">
		<div class="typed"></div>
		<canvas id="pad" class="pad" width="300" height="190"></canvas>
		<input type="hidden" name="output" class="output">
	</div>
	<input type="button" onclick="RegChk()" value=" submit ">
</form>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="/site/api/sign/assets/numeric-1.2.6.min.js"></script> 
<script src="/site/api/sign/assets/bezier.js"></script> 
<script src="/site/api/sign/jquery.signaturepad.js"></script> 
<script>
$(document).ready(function() {
	$('#linear').signaturePad({drawOnly:true, lineTop:200});
});
 </script> 
<script src="/site/api/sign/assets/json2.min.js"></script>
<script type="text/javascript">
function RegChk(){
	var obj = document.regform;
	var drawCanvas = document.getElementById('pad');
	obj.output.value = drawCanvas.toDataURL('image/png', 1.0);
	document.write("<img src='"+obj.output.value+"'>");
	//obj.submit();	
}

</script>

</body>
