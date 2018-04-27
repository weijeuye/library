<tr  id="distributorIdstr">
	<td class="p_label"><i class="cc1">*</i>销售渠道：</td>
	<td colspan=2>
		<#list distributorList as list>
			<#assign distributorId=0 />
			<#if  suppGoods?? && suppGoods.distDistributorGoods?? && suppGoods.distDistributorGoods?size &gt; 0>
				<#list suppGoods.distDistributorGoods as distDistributorGood>
					<#if list.distributorId==distDistributorGood.distributorId>
						
							<label><input type="checkbox" errorEle="code" checked="checked" name="distributorIds" onclick="distributorIdsCheck(this)" id="distributorIds_${list.distributorId!''}" value="${list.distributorId!''}"  required/>
							${list.distributorName!''}</label>
							<#assign distributorId=list.distributorId />
						
					</#if>
				</#list>
			</#if>
			<#if distributorId!=list.distributorId>
				
					<label><input type="checkbox" errorEle="code" name="distributorIds" value="${list.distributorId!''}" id="distributorIds_${list.distributorId!''}" onclick="distributorIdsCheck(this)" required/>
					${list.distributorName!''}</label>
				
			</#if>
        </#list>
        <div id="codeError" style="display:inline"></div>
        <#if suppGoods?? && (suppGoods.categoryId==11 || suppGoods.categoryId==12 || suppGoods.categoryId==13)>
        <br/><font color=red>（驴妈妈门店商品佣金提取规则为“前台售价-商品结算价”，故以获取高额毛利为目的的商品（如免票、特殊结算价门票等）请谨慎勾选“门店”“门店APP”，避免毛利损失。）</font><br/>
        </#if>
	</td>
	
</tr>
<#if tntGoodsChannelVo?? && tntGoodsChannelVo.channels?? && tntGoodsChannelVo.channels?size &gt; 0>
<tr id="distributorUserIdstr">
	<td class="e_label">super系统分销商</td>
	<td >
			<!--渠道遍历-->
			<#list tntGoodsChannelVo.channels as tntChannelVo>
				<!--分销商遍历-->
				<#if  tntChannelVo.users?? && tntChannelVo.users?size &gt; 0>
					<#list tntChannelVo.users as tntUserVo>
							<label><input type="checkbox" errorEle="code"  name="distributorUserIds" id="distributorUserIds_${tntUserVo.userId}" 
							 data="${tntChannelVo.channelId}"
							 	<#if userIdLongStr != null && userIdLongStr?index_of(",${tntUserVo.userId},") != -1>checked="checked"</#if>
								value="${tntChannelVo.channelId + "-" + tntUserVo.userId!''}"  /> ${tntUserVo.userName!''}</label>
					</#list>
				<#elseif tntChannelVo.channelId?? && tntChannelVo.channelIdStr == "0">
					<label><input type="checkbox" errorEle="code"  name="distributorUserIds"
						<#if userIdLongStr != null && userIdLongStr?index_of("0-0") != -1>checked="checked"</#if> value="0-0"/>其他</label>
				</#if>
			</#list>
	</td>
</tr>
<#if suppGoods?? && (suppGoods.categoryId==11 || suppGoods.categoryId==12 || suppGoods.categoryId==13)>
	<tr id="distributorSmsChannelTR">
		<td class="e_label">分销独立短信通道</td>
		<td>
			<label><input type="checkbox"  name="onlyLvmamaFlagCB" id="onlyLvmamaFlag" 
							 	<#if suppGoods?? && suppGoods.onlyLvmamaFlag!='N'>checked="checked" value="Y"</#if>
								/> 只认驴妈妈短信标识</label>
			<input type="hidden" name="onlyLvmamaFlag" value="${suppGoods.onlyLvmamaFlag}"/>
		</td>
	</tr>
</#if>
</#if>

<script>

//如果super分销商有选择，就选中分销商
function isDistributorUserIdstrChecked(){
    var isChecked = false;
    $("#distributorUserIdstr").find("input[type=checkbox]").each(function(){
        if($(this).attr("checked")=="checked"){
            isChecked = true;
        }
    });
	return isChecked;
}
//加载页面，渠道已选择分销(distributorId=4)
//if(isDistributorUserIdstrChecked()){
//    $("#distributorIds_4").attr("checked","checked");
//}else {
//    $("#distributorIds_4").removeAttr("checked");
//}
//如果选中了驴妈妈前台，门店自动选中；特卖会则取消选中；
if($("input[name=distributorIds][value=3]:checked").size()>0){
    $("input[name=distributorUserIds][data=107]").removeAttr("checked");
}
//如果分销商没有选中，则取消下面的选择
if($("input[name=distributorIds][value=4]:checked").size()==0){
    $("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("checked");
    clickOtherDist();
}



$("#distributorUserIdstr").find("input[type=checkbox]").click(function(){
    if(isDistributorUserIdstrChecked()){
        $("#distributorIds_4").attr("checked","checked");
    }else {
        $("#distributorIds_4").removeAttr("checked");
	}
});

//var distributorChecked = document.getElementById("distributorIds_4").checked;
//if(!distributorChecked){
//	//默认展示，未选中就隐藏
//	$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
//}else{
//	$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
//}




//渠道选择分销展示和隐藏下行分销商操作
function distributorIdsCheck(obj){
	if(obj.value == 4){
		if(!obj.checked){
			$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("checked");
		}else{
			//$("input[name=distributorUserIds]").removeAttr("checked");
			//$("#distributorUserIdstr").find("input[type=checkbox]").attr("checked","checked");
		}
		clickOtherDist();
	}
	//驴妈妈前台选中
	if(obj.value == 3){
		if(obj.checked){
			var distributorUserIds_107_Checked = "";
			$("#distributorIds_10").attr('checked','checked');
			$("input[name=distributorUserIds]").each(function(){
				var data = $(this).attr("data");
				var thisChecked = $(this).attr('checked');
				if(data == "107" && thisChecked =='checked'){
					distributorUserIds_107_Checked = "checked";
				}else{
				}
			});
			if(distributorUserIds_107_Checked =='checked'){
				alert("销售渠道互斥：驴妈妈前台与特卖会渠道不能同时选中");
				obj.checked=false;
				return;
			}
            //勾选门店app
            $("#distributorIds_20").attr("checked","checked");
		}
	}

    //门店渠道勾选后勾选门店app
    if (obj.value == 10 && obj.checked) {
        $("#distributorIds_20").attr("checked","checked");
    }
		if(obj.value == 6){
			if(obj.checked){
				$("#distributorIdstr").find("input[type=checkbox]").removeAttr("checked");
				$("#distributorIdstr").find("input[type=checkbox]").attr("disabled","disabled");
				$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
				$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("checked");
				$("#distributorIds_6").attr('checked','checked');
				$("#distributorIds_6").removeAttr('disabled');
			}else{
				$("#distributorIdstr").find("input[type=checkbox]").removeAttr('disabled');
				$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
			}
	}else {
		if(obj.checked){
			$("#distributorIds_6").removeAttr('checked');
			$("#distributorIdstr").find("input[type=checkbox]").removeAttr('disabled');
			$("#distributorIds_6").attr('disabled','disabled');
		}
		if($("#distributorIds_2").attr('checked')!='checked'&&$("#distributorIds_2").attr('checked')!='checked'&&$("#distributorIds_3").attr('checked')!='checked'&&$("#distributorIds_4").attr('checked')!='checked'&&$("#distributorIds_5").attr('checked')!='checked'){
				$("#distributorIdstr").find("input[type=checkbox]").removeAttr('disabled');
		}
		$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
	}
}

$("input[name=distributorUserIds]").each(function(index){
	$(this).click(function(){
		var data = $(this).attr("data");
		var thisChecked = $(this).attr('checked');
		if(data == "107" && thisChecked =='checked'){
			var distributorIds_3_Checked = $("#distributorIds_3").attr('checked');
			if(distributorIds_3_Checked =='checked'){
				alert("销售渠道互斥：驴妈妈前台与特卖会渠道不能同时选中");
				$(this).removeAttr('checked');
				return;
			}
		}
		//如果点击特卖就弹出确认框
		if(data == "107"){
            var isChecked = $(this).is(':checked');
            if(confirm("特卖会渠道勾选与取消需通知特卖会运营操作及排查，否则产品不能正常售卖!是否继续操作？")){
                $(this).attr('checked',isChecked);
            }else{
                $(this).attr('checked',!isChecked);
            }
            
            if(isDistributorUserIdstrChecked()){
                $("#distributorIds_4").attr("checked","checked");
            }else {
                $("#distributorIds_4").removeAttr("checked");
            }
        }
 	});
});

$("#distributorUserIds_0").click(function() {
	clickOtherDist();
});

clickOtherDist();
function clickOtherDist() {
	if($("#distributorUserIds_0").attr("checked")=="checked"){
		$("#onlyLvmamaFlag").removeAttr("disabled");
	}else{
		$("#onlyLvmamaFlag").attr("checked", "checked");
		$("#onlyLvmamaFlag").attr("disabled","disabled");
	}
	
	setOnlyLvmamaFlag();
}

$("#onlyLvmamaFlag").click(function(){
	setOnlyLvmamaFlag();
});

function setOnlyLvmamaFlag() {
	if($("#onlyLvmamaFlag").attr("checked")=="checked"){
		$("input[name='onlyLvmamaFlag']").val("Y");
	}else{
		$("input[name='onlyLvmamaFlag']").val("N");
	}
}

</script>
