
<tr>
	<th class="title bdr bdt">시중가격</th>
	<td colspan="3" class="bdt"><input type="text" name="p_o_price" class="AXInput W100" value="<%=p_o_price%>" numberOnly />원</td>
</tr>
<tr>
	<th class="title bdr bdt">판매가격</th>
	<td colspan="3" class="bdt"><input type="text" name="p_price" class="AXInput W100" value="<%=p_price%>" numberOnly />원<br />
	<span class="txt_small">- 금액은 숫자로만 입력하세요.</span><br />	
	<span class="txt_small">- 0원으로 입력하면 구매가 불가능 하며 '별도 문의'로 표시합니다.</span>
	</td>
</tr>
<tr>
	<th class="title bdr bdt">적립포인트</th>
	<td colspan="3" class="bdt"><input type="text" name="p_point" class="AXInput W100" value="<%=p_point%>" numberOnly />p<br />
	<span class="txt_small">- 금액은 숫자로만 입력하세요.</span>
	</td>
</tr>

<%
For o=1 To 4
%>
<tr>
	<th class="title bdr bdt">옵션<%=o%></th>
	<td colspan="3" class="bdt">
		<input type="text" name="p_option<%=o%>" class="AXInput W200" value="<%=p_option(o-1)%>" placeholder="옵션명" />
		<div style="margin-top:5px">		
			<select name="p_option_val<%=o%>" id="p_option_val<%=o%>" class="AXSelect" style="width:100%; height:130px" size="9" onclick="DelOption<%=o%>()" multiple>
				<%
				If p_option_val(o-1)<>"" Then
					arr_option = Split(p_option_val(o-1), ", ")
					For Each itm In arr_option
					%>
					<option value="<%=itm%>"><%=Replace(itm, "§", " : ") & "원"%></option>
					<%
					Next
				End If
				%>
			</select>
		</div>
		<div style="margin-top:5px">		
			<input type="text" name="p_option<%=o%>_1" id="p_option<%=o%>_1" class="AXInput W200" placeholder="옵션 항목"/>		
			<select name="p_option<%=o%>_2" class="AXSelect">
				<option value="">+</option>
				<option value="-">-</option>
			</select>
			<input type="text" name="p_option<%=o%>_3" id="p_option<%=o%>_3" class="AXInput W100" placeholder="옵션 금액" numberOnly />원
			<button type="button" class="AXButton Blue" onclick="AddOption<%=o%>()">추가</button>
		</div>

		<script type="text/javascript">
		function AddOption<%=o%>(){
			if(!$("input[name=p_option<%=o%>_1]").val()){
				alert('옵션 항목을 입력하세요.');
				$("input[name=p_option<%=o%>_1]").focus();
				return;
			}
			if(!$("input[name=p_option<%=o%>_3]").val()){
				alert('옵션 추가 금액을 입력하세요.');
				$("input[name=p_option<%=o%>_3]").focus();
				return;
			}
			var s_data_str = "<option value='" + $("input[name=p_option<%=o%>_1]").val() + "§" + $("select[name=p_option<%=o%>_2] option:selected").val() + $("input[name=p_option<%=o%>_3]").val() + "'>";
			s_data_str += $("input[name=p_option<%=o%>_1]").val();
			s_data_str += " : " + $("select[name=p_option<%=o%>_2] option:selected").val() + $("input[name=p_option<%=o%>_3]").val() + "원";
			s_data_str += "</option>";

			$("#p_option_val<%=o%>").append(s_data_str);

			$("input[name=p_option<%=o%>_1]").val("");
			$("input[name=p_option<%=o%>_3]").val("");
		}

		function DelOption<%=o%>(){
			if(confirm("선택한 항목을 삭제하시겠습니까?")){
				$("#p_option_val<%=o%> option:selected").remove();
			}
		}
		</script>
	</td>
</tr>
<%
Next
%>
