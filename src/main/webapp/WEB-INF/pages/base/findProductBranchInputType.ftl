<#macro displayHtml productBranchId  index branchProp>

		<#assign required='' />
   		<#if branchProp.nullFlag == 'Y' && branchProp.cancelFlag=='Y'>
   			<#assign required='required' />
   		</#if>
   		<#assign disabled='' />
   		<#if branchProp.cancelFlag=='N'>
   			<#assign disabled='disabled' />
   		</#if>
   		<#assign maxlength='' />
   		<#if branchProp.maxLength &gt; 0>
    		<#assign maxlength="maxlength='${branchProp.maxLength}'" />
   		</#if>
   		<#assign productBranchPropId='' />
   		<#assign productBranchId='' />
   		<#assign propValue='' />
   		<#if branchProp?? && branchProp.prodProductBranchProp!=null >
    		<#assign productBranchPropId=branchProp.prodProductBranchProp.productBranchPropId />
    		<#assign productBranchId=branchProp.prodProductBranchProp.productBranchId />
    		<#if branchProp.prodProductBranchProp.prodValue !=null >
     		<#assign propValue=branchProp.prodProductBranchProp.prodValue />
    		</#if>
   		</#if>
<span id="${branchProp.propCode}">
         <#if branchProp.inputType == "INPUT_TYPE_TEXT">
          	<input class="w35 textWidth" type="text" name="productBranchPropList[${index}].prodValue" errorEle=ele${index}
           	${required} ${maxlength} <#if productBranchId != ''>value="${propValue}" </#if> <#if branchProp.propId == 9>id='areaId1'</#if> />
          		
           <#elseif branchProp.inputType == "INPUT_TYPE_COORDINATE">
        		<input type="text" class="w35" id="coordinate" name="productBranchPropList[${index}].prodValue" 
     					<#if productBranchId == ''>placeholder="${branchProp.propDefault!''}" autoValue="true"</#if>
     					<#if productBranchId != ''>value="${propValue}" ${disabled}</#if>
         			   ${required}  readonly = "readonly"  > 
            		
          <#elseif branchProp.inputType == "INPUT_TYPE_CHECKBOX">
   			<#list branchProp.dictList as bizDict>
   				<#if  productBranchId != ''><#assign flag='N' /></#if>
				<label><input class="w35" type="checkbox" errorEle=ele${index} index="${index}" name="productBranchPropList[${index}].prodValue" value="${bizDict.dictId!''}" addFlag="${bizDict.addFlag!''}" ${required}  
					<#if  productBranchId != ''>
						<#list propValue?split(",") as dictId>
							<#if dictId == bizDict.dictId>checked<#assign flag='Y' /></#if>	
						</#list>
					</#if>
				/>
				<span>${bizDict.dictName!''}</span></label>
				<#if  productBranchId != ''>
					<#if bizDict.addFlag?? && bizDict.addFlag=='Y' && flag=='Y'>
							<#if productBranch.propValue??&&productBranch.propValue[branchProp.propCode]??>
								<#list productBranch.propValue[branchProp.propCode] as addValue>
									<#if addValue.id == bizDict.dictId>
										<input type="text" data="${bizDict.dictId}"  style='width:120px' name="productBranchPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'/>
									</#if>
								</#list>
							</#if>
					</#if>
				</#if>
   			</#list>

          <#elseif branchProp.inputType == "INPUT_TYPE_RICH">
          		<textarea name="productBranchPropList[${index}].prodValue"  class="w35 ckeditor" errorEle=ele${index} required="true" data="${branchProp.nullFlag}"
          		${required} style="width:1px;height:1px;"<#if  productBranchId != ''>${disabled} </#if>><#if  productBranchId != ''>${propValue}</#if></textarea>
          	
		<#elseif branchProp.inputType == "INPUT_TYPE_TEXTAREA">
      			<textarea class="w35 textWidth" name="productBranchPropList[${index}].prodValue" errorEle=ele${index}
       	    		${required} ${maxlength} <#if  productBranchId != ''>${disabled} </#if> ><#if productBranchId != ''>${propValue}</#if></textarea>
       	    
  		<#elseif branchProp.inputType == "INPUT_TYPE_YYYYMM">
  			<input class="w35 Wdate" type="text" name="productBranchPropList[${index}].prodValue"  errorEle=ele${index}
	  			class="Wdate"  onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM'})"
	   			${required} onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM'})" <#if productBranchId != ''>${disabled} value="${propValue}"></#if> />
   			
  		<#elseif branchProp.inputType == "INPUT_TYPE_YYYYMMDD">
  			<input class="w35 Wdate" type="text" name="productBranchPropList[${index}].prodValue" errorEle=ele${index}
	  			class="Wdate"  onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd'})"
	   			${required} onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd'})" <#if productBranchId != ''>${disabled} value="${propValue}"></#if>/>
	   			
       	<#elseif branchProp.inputType == "INPUT_TYPE_DDMM">
       		<input type="text" name="productBranchPropList[${index}].prodValue" <#if productBranchId == ''> placeholder="${branchProp.propDefault!''}" </#if> errorEle=ele${index}
      			class="Wdate"  onFocus="WdatePicker({readOnly:true, dateFmt:'HH:mm'})"
       			${required} <#if productBranchId != ''>${disabled} value="${propValue}"></#if>/>
       			
   		<#elseif branchProp.inputType == "INPUT_TYPE_YESNO">
   			<input type="radio" errorEle=ele${index} name="productBranchPropList[${index}].prodValue" value="Y" ${required} <#if productBranchId != ''>${disabled} <#if propValue== "Y">checked="true"</#if></#if> />是 
   			<input type="radio" errorEle=ele${index} name="productBranchPropList[${index}].prodValue" value="N" ${required} <#if productBranchId != ''> ${disabled} <#if propValue=="N">checked="true"</#if> </#if> />否
   			
   		<#elseif branchProp.inputType == "INPUT_TYPE_RADIO">
			<#list branchProp.dictList as bizDict>
				<#if  productBranchId != ''><#assign flag='N' /></#if>
				<label><input class="w35" errorEle=ele${index}  type="radio" index="${index}" name="productBranchPropList[${index}].prodValue" value="${bizDict.dictId!''}" addFlag="${bizDict.addFlag!''}" ${required} 
					<#if  productBranchId != ''>
						<#list propValue?split(",") as dictId> 
							<#if dictId == bizDict.dictId>checked="true" <#assign flag='Y' /></#if>
						</#list>
						${disabled}
					</#if>
				/ >
				<span>${bizDict.dictName!''}</span></label>
				<#if  productBranchId != ''>
					<#if bizDict.addFlag?? && bizDict.addFlag=='Y' && flag=='Y'>
						<#list branchProp.dictList as bizDict>
							<#if productBranch.propValue??&&productBranch.propValue[branchProp.propCode]??>
								<#list productBranch.propValue[branchProp.propCode] as addValue>
									<#if addValue.id == bizDict.dictId>
										<input type="text" data="${bizDict.dictId}"  style='width:120px' name="productBranchPropList[${index}].addValue" value='${addValue.addValue}' remark='remark' <#if "529" == bizDict.dictId>required="true"</#if> />
									</#if>
								</#list>
							</#if>
					 	</#list>
					</#if>
				</#if>
			</#list>
			
   		<#elseif branchProp.inputType == "INPUT_TYPE_SELECT">
   			<select name="productBranchPropList[${index}].prodValue" index="${index}" ${required} errorEle=ele${index} <#if branchProp.propCode == "single_item_category">onchange="fillbranchName(this);"</#if> <#if branchProp.propCode == "visa_type">visa_type="visa_type"</#if> <#if  productBranchId != ''>${disabled}</#if> >
	  			<option value="">请选择</option>
		  			<#if  productBranchId != ''><#assign flag='N' /></#if> 
				  	<#list branchProp.dictList as bizDict>
		                  <option value="${bizDict.dictId}" addFlag="${bizDict.addFlag!''}" 
		                  	<#if  productBranchId != ''>
			                  <#list propValue?split(",") as dictId>
								<#if dictId == bizDict.dictId>selected<#if bizDict.addFlag=='Y'><#assign flag='Y' /></#if></#if> 
							  </#list> 
		                   </#if>
		                  >${bizDict.dictName}</option>
				  	</#list>
   			</select>
	   			<#if  productBranchId != ''>
					<#list branchProp.dictList as bizDict>
						<#if productBranch.propValue??&&productBranch.propValue[branchProp.propCode]??>
							<#list productBranch.propValue[branchProp.propCode] as addValue>
								<#if addValue.id == bizDict.dictId && bizDict.addFlag == 'Y'>
									<input type="text" data="${bizDict.dictId}"  style='width:120px' name="productBranchPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
								</#if>
							</#list>
						</#if>
					</#list>
				</#if>
   		<#elseif branchProp.inputType == "INPUT_TYPE_NUMBER">
   			<input class="w35 textWidth" type="text" name="productBranchPropList[${index}].prodValue" number=true errorEle=ele${index}
   				${required} ${maxlength} <#if  productBranchId != ''>value="${propValue}" ${disabled} </#if>/>
   		
   		<#elseif branchProp.inputType == "INPUT_TYPE_IMG_L">
   			<input class="w35" type="file" name="productBranchPropList[${index}].prodValue" ${required} <#if  productBranchId != ''>value="${propValue}" ${disabled} </#if>/>
   		
   		<#elseif branchProp.inputType == "INPUT_TYPE_IMG_M">
			<input type="file" name="productBranchPropList[${index}].prodValue"  ${required} <#if  productBranchId != ''>value="${propValue}" ${disabled} </#if> />
 				
		<#elseif branchProp.inputType == "INPUT_TYPE_IMG_S">
			<input type="file" name="productBranchPropList[${index}].prodValue" ${required} <#if  productBranchId != ''>value="${propValue}" ${disabled} </#if>/>
   			
   		</#if>
</span>
</#macro>

<script>

$(function(){
	$(".textWidth[maxlength]").each(function(){
		var	maxlen = $(this).attr("maxlength");
		if(maxlen != null && maxlen != ''){
			var l = maxlen*12;
			if(l >= 700) {
				l = 700;
			} else if (l <= 200){
				l = 200;
			} else {
				l = 400;
			}
			$(this).width(l);
		}
		$(this).keyup(function() {
				vst_util.countLenth($(this));
		});
	});
	
	//打开选择经纬度窗口
	$("#coordinate").click(function(){
		var placeName = $("#branchName").val();
		coordinateSelectDialog = new xDialog("/vst_back/biz/districtSign/selectCoordinate.do?callback=onSelectCoordinate&placeName="+placeName,{},{title:"选择经纬度",iframe:true,width:"1100",height:"600"});
	});
	
	$('.ckeditor').each(function(){ 
		CKEDITOR.replace($(this).attr('name')); 
	}); 
});

$(function(){

    $(".INPUT_TYPE_DDMM").each(function(){
       var obj = $(this);
	    $(this).find('.dd').bind("change",function(){
		obj.find('.hourMinute').val(obj.find("select[name='hour']").val() +":"+obj.find("select[name='minute']").val());
	   });
	  }); 
});	

//选择经纬度
function onSelectCoordinate(params){
	if(params!=null){
		$("#coordinate").val(params);
	}
	coordinateSelectDialog.close();
} 	

//为checkbox 设置addValue
function setCheckBoxAddValue(){
	$("input[type=checkbox]").bind("click",function(){
		var that = $(this);
		//如果没有addValue 则直接返回
		if(that.attr("addFlag")!="Y")
			return;
		if(that.attr("checked")=="checked"){
			//当前元素有addValue
			if(that.next().next("input[remark=remark]").size()>0)
			return;
			//为当前元素添加addValue
			var index = that.attr("index");
			that.next().after("<input type='text'  style='width:120px' data='"+that.val()+"' alias='productBranchPropList["+index+"].addValue'  remark='remark'>");
		}else {
			//删除
			that.next().next("input[remark='remark']").remove();
		}
	});
}

////为radio 设置addValue
function setRadioAddValue(){
	$("input[type=radio]").bind("change",function(){
		var that = $(this);
		//如果没有addValue 则直接返回
		if(that.attr("addFlag")!="Y"){
			that.parents("td").find("input[remark=remark]").remove();
			return;
		}
		if(that.attr("checked")=="checked"){
			//当前元素有addValue
			if(that.next().next("input[remark=remark]").size()>0)
			return;
			//去掉其它已经选中的radio所填写的addValue
			that.parents("td").find("input[remark=remark]").remove();
			//为当前元素添加addValue
			var index = that.attr("index");
			that.next().after("<input type='text'  style='width:120px' data='"+that.val()+"'  alias='productBranchPropList["+index+"].addValue'  remark='remark'>");
		}else {
			//删除
			that.next().next("input[remark='remark']").remove();
		}
	});
}

/**
 * 为select 设置addValue
 * type : Y update 
 */
function setSelectAddValue(type){
	$("select").bind("change",function(){
		var that = $(this);
		//判断是否可以添加addFlag
		if(that.find("option:selected").attr("addFlag")!="Y"){
			if(type == "Y"){
				that.next("input[remark='remark']").remove();
			}
		   return;
	    }
		//删除原有的addValue
		that.next("input[remark=remark]").remove();   
		//为当前元素添加addValue
		var index = that.attr("index");
		that.after("<input type='text'  style='width:120px' data='"+that.val()+"'  alias='productBranchPropList["+index+"].addValue'  remark='remark'>");  
	});
}

//重新设置附加属性的值
function refreshAddValue(){
	//清除所有的addValue隐含域
	$("input[addValueHiddenInput='Y']").remove();
	$("input[remark='remark']").each(function(){
     	if($(this).val()!=""){
     		//克隆当前元素
     		var hiddenInput = $(this).clone();
     		//设置隐藏域属性
     		hiddenInput.val('${addValueTitle}'+hiddenInput.attr("data")+'='+hiddenInput.val());
     		hiddenInput.attr("type","hidden");
     		hiddenInput.attr("name",hiddenInput.attr("alias"));
     		hiddenInput.removeAttr("alias");
     		hiddenInput.removeAttr("class");
     		hiddenInput.removeAttr("style");
     		hiddenInput.attr("addValueHiddenInput","Y");
     		$(this).after(hiddenInput);
     	}
	});	
}
</script>