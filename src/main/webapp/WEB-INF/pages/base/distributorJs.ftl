<script>
//加载页面，渠道已选择分销(distributorId=4)
var distributorChecked = document.getElementById("distributorIds_4").checked;
if(!distributorChecked){
	//默认展示，未选中就隐藏
	$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
}else{
	$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
}

//渠道选择分销展示和隐藏下行分销商操作
function distributorIdsCheck(obj){
	if(obj.value == 4){
		if(!obj.checked){
			$("#distributorUserIdstr").find("input[type=checkbox]").attr("disabled","disabled");
		}else{
			$("input[name=distributorUserIds]").removeAttr("checked");
			$("#distributorUserIdstr").find("input[type=checkbox]").removeAttr("disabled");
		}
	}
	//驴妈妈前台选中，门店同时选中
	if(obj.value == 3){
		if(obj.checked){
			var distributorUserIds_107_Checked = "";
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
		}
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
 	});
});

</script>
