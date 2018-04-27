<#macro displayHtml index dictPropDef >
		<#assign maxlength='' />
		<#if dictPropDef.maxLength &gt; 0>
			<#assign maxlength="maxlength='${dictPropDef.maxLength}'" />
		</#if>
		
		<#assign required='' />
		<#if dictPropDef.nullFlag == 'Y' && dictPropDef.cancelFlag=='Y' >
			<#assign required='required=true' />
		</#if>
		
		<#if dictPropDef.inputType == "INPUT_TYPE_TEXT">
  		 	<input type="text" class="w35 textWidth" name="dictPropList[${index}].dictPropValue" 
      		 	value="${dictPropDef.bizDictProp.dictPropValue!''}"  placeholder="${dictPropDef.propDefault!''}" autoValue="true"
      		 	${required} ${maxlength} />
  		
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_COORDINATE">
  		 	<input type="text" class="w35" name="dictPropList[${index}].dictPropValue" 
      		 	value="${dictPropDef.bizDictProp.dictPropValue!''}"  placeholder="${dictPropDef.propDefault!''}" autoValue="true"
      		 	${required} ${maxlength} >
      		 	
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_CHECKBOX">
  			<#list dictPropDef.bizDictList as bizDict>
					<input type="checkbox"  class="w35 textWidth" name="dictPropList[${index}].dictPropValue" 	value="${bizDict.dictId!''}"  placeholder="${dictPropDef.propDefault!''}" autoValue="true"
						<#if dictPropDef.bizDictProp.dictPropValue??>
							<#list dictPropDef.bizDictProp.dictPropValue?split(",") as dictId>
								<#if dictId == bizDict.dictId>checked</#if>
							</#list>
						</#if>
					/>
					<span>${bizDict.dictName!''}</span>
  			</#list>
  			
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_RICH">
  			<textarea class="w35 sensitiveVad textWidth" style="width:800px; height:200px;" id="dictPropList[${index}].dictPropValue" mark='sensitiveVad${index}' name="dictPropList[${index}].dictPropValue" 
      			${required} ${maxlength} placeholder="${dictPropDef.propDefault!''}" autoValue="true" >${dictPropDef.bizDictProp.dictPropValue!''}</textarea>
           			
		<#elseif dictPropDef.inputType == "INPUT_TYPE_TEXTAREA">
       		<textarea class="w35 textWidth"  id="dictPropList[${index}].dictPropValue" name="dictPropList[${index}].dictPropValue" 
      			${required} ${maxlength} placeholder="${dictPropDef.propDefault!''}" autoValue="true">${dictPropDef.bizDictProp.dictPropValue!''}</textarea>
      			
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_YYYYMM">
  			<input type="text" class="w35 Wdate" name="dictPropList[${index}].dictPropValue" value="${dictPropDef.bizDictProp.dictPropValue!''}"
      			 ${required} placeholder="${dictPropDef.propDefault!''}" autoValue="true" onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM'})"/>
      			
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_YYYYMMDD">
  			<input type="text"  class="w35 Wdate" name="dictPropList[${index}].dictPropValue" value="${dictPropDef.bizDictProp.dictPropValue!''}"
      			${required}  onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd'})" placeholder="${dictPropDef.propDefault!''}" autoValue="true"/>
      			
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_YESNO">
  			<input type="radio" name="dictPropList[${index}].dictPropValue" ${required} value="Y" 
  				<#if dictPropDef.bizDictProp.dictPropValue == 'Y'>checked="checked" </#if> >是 &nbsp;&nbsp;
  			<input type="radio" name="dictPropList[${index}].dictPropValue" value="N" 
  				<#if dictPropDef.bizDictProp.dictPropValue == 'N'>checked="checked" </#if> >否
  				
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_RADIO">
			<#list dictPropDef.bizDictList as bizDict>
				<input type="radio" name="dictPropList[${index}].dictPropValue"  value="${bizDict.dictId!''}" placeholder="${dictPropDef.propDefault!''}" autoValue="true"
					<#if dictPropDef.bizDictProp.dictPropValue??>
						<#list dictPropDef.bizDictProp.dictPropValue?split(",") as dictId>
							<#if dictId == bizDict.dictId>checked</#if>
						</#list>
					</#if>
				/>
	  		    <span>${bizDict.dictName!''}</span>
			</#list>
  		
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_SELECT">
  			<select name="dictPropList[${index}].dictPropValue" placeholder="${dictPropDef.propDefault!''}" ${required} autoValue="true">
				<option value="">请选择</option>
					<#list dictPropDef.bizDictList as bizDict>
			             <option value="${bizDict.dictId}"  
			             	<#if dictPropDef.bizDictProp.dictPropValue??>
								<#list dictPropDef.bizDictProp.dictPropValue?split(",") as dictId>
									<#if dictId == bizDict.dictId> selected </#if>
								</#list>
							</#if>
			             >${bizDict.dictName}</option>
				</#list>
   			</select>
   	
   		<#elseif dictPropDef.inputType == "INPUT_TYPE_NUMBER">
   			<input type="text" class="w35 textWidth" name="dictPropList[${index}].dictPropValue" number="true" value="${dictPropDef.bizDictProp.dictPropValue!''}" 
  				${required} placeholder="${dictPropDef.propDefault!''}" autoValue="true"/>
  				
  		<#elseif dictPropDef.inputType == "INPUT_TYPE_IMG_L">
  			<input type="file" name="dictPropList[${index}].dictPropValue" value="${dictPropDef.bizDictProp.dictPropValue!''}"/>
  		</#if>
        
</#macro>

<script type="text/javascript">

//JQuery 自定义验证   
jQuery.validator.addMethod("isChar", function(value, element) { 
    var chars =  /^[^\\\*\&\#\$\%\@\\^\!\~\+>\<\|\'\"\/]+$/;//验证特殊字符  
    return this.optional(element) || (chars.test(value));       
 }, "不可输入特殊字符");
 
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
	}
	$(this).keyup(function() {
		vst_util.countLenth($(this));
	});
});

	function photoCallback(photoJson, extJson){
		if(photoJson != null && photoJson !=''){
			if(photoJson.photos) {
				for(var ps in photoJson.photos) {
					lvmamaEditor.uploadImageCallback("http://pic.lvmama.com"+photoJson.photos[ps].photoUpdateUrl);
				}
			} else if(photoJson.photo) {
				lvmamaEditor.uploadImageCallback("http://pic.lvmama.com"+photoJson.photo.photoUpdateUrl);
			}
		}else{
			alert("保存图片失败");
		}
	}
</script>