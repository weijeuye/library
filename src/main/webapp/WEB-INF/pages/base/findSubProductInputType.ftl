<#macro displayHtml productId index bizCategoryProp >
 
        	<#assign required='' />
       		<#if bizCategoryProp.nullFlag == 'Y' && bizCategoryProp.cancelFlag=='Y'>
       			<#assign required='required' />
       		</#if>
       		
       		<#assign disabled='' />
       		<#if bizCategoryProp.cancelFlag=='N'>
       			<#assign disabled='disabled' />
       		</#if>
       		
       		<#assign maxlength='' />
       		<#if bizCategoryProp.maxLength &gt; 0>
        		<#assign maxlength="maxlength='${bizCategoryProp.maxLength}'" />
       		</#if>
       		
       		<#assign editFlag='' />
       		<#assign readonly='' />
       		<#if bizCategoryProp.editFlag ?? && bizCategoryProp.editFlag == 'Y'>
       			<#assign editFlag = bizCategoryProp.editFlag/>
        		<#assign readonly="readonly='readonly'" />
       		</#if>
       		
       		<#assign prodPropId='' />
       		<#assign propValue='' />
       		<#assign dictName='' />
       		<#assign propId=bizCategoryProp.propId />
       		<#if productId != '' && bizCategoryProp?? && bizCategoryProp.prodProductPropList[0]!=null>
        		<#if bizCategoryProp.prodProductPropList[0].propValue !=null >
         			<#assign propValue=bizCategoryProp.prodProductPropList[0].propValue />
        		</#if>
        		<#if bizCategoryProp.prodProductPropList[0].dictName !=null >
         			<#assign dictName=bizCategoryProp.prodProductPropList[0].dictName />
        		</#if>
       		</#if>
               <#if bizCategoryProp.inputType == "INPUT_TYPE_TEXT">
       		 		 <#if bizCategoryProp.propCode == "visa_country">
                		 	<input type="text" class="search" errorEle="errorEle${index}" name="countryName" id="countryName" placeholder="${bizCategoryProp.propDefault!''}" autoValue="true"
	                		 	propCode="${bizCategoryProp.propCode!''}" ${required } ${maxlength} />
	                		<input type="text"  style="position:absolute;left:-20000px" name="prodProductPropList[${index}].propValue" errorEle="errorEle${index}" id="countryId"  
	                			required=true ${maxlength} <#if productId != ''> value="${propValue}" ${readonly }</#if>/>
	                			
               		<#else>
                			<input type="text"  errorEle="errorEle${index}" class="w35 textWidth" name="prodProductPropList[${index}].propValue" 
		         		 		propCode="${bizCategoryProp.propCode!''}" ${required} ${maxlength} <#if productId != ''>${disabled} value="${propValue}" ${readonly }</#if>   
		         		 		<#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if> /> <#if 'packed_product_id'== bizCategoryProp.propCode>  说明:暂时只支持当地游、酒店套餐和自由行</#if>
               		</#if>
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_COORDINATE">
        		 	<input type="text" class="w35" id="coordinate" name="prodProductPropList[${index}].propValue"  
	         		 	${required} <#if productId != ''> ${disabled} value="${propValue}"  ${readonly }</#if>
	         		 	<#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if> readonly = "readonly"  />
         		 	
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_CHECKBOX">
        			<#if productId != ''><#assign addValueIndex=0 /></#if>
        			<#list bizCategoryProp.bizDictList as bizDict>
        				<#if productId != ''><#assign flag='N' /></#if>
    					<input type="checkbox" name="prodProductPropList[${index}].propValue" errorEle="errorEle${index}" value="${bizDict.dictId!''}" 
    					<#if productId != ''>
    						<#if editFlag?? && editFlag=='Y'> onclick="return false;" </#if>
    					</#if>
    					onclick="showAddFlagCheckBox(this,'${bizDict.addFlag!''}',${index});" 
    					<#if propId??&&propId==615> data = "propId_615" data2 = "${bizDict.dictName!''}"</#if>
    					${required}  
	    					<#if productId != ''>
	    						${disabled}
		    					<#list propValue?split(",") as dictId>
		   							<#if dictId == bizDict.dictId>checked<#assign flag='Y' />  </#if>
		   						</#list>
		   					<#else>
								<#if bizCategoryProp.propDefault??>
									<#list bizCategoryProp.propDefault?split(",") as dictId>
										<#if dictId == bizDict.dictId>checked</#if>
									</#list>
								</#if>
	   						</#if>
   						/><span>${bizDict.dictName!''}</span>
   						<#if productId != ''>
	    					<#if bizDict.addFlag?? && bizDict.addFlag=='Y' && flag=='Y'>
	    						<#if prodProduct.propValue??&&prodProduct.propValue[bizCategoryProp.propCode]??>
	    						<#list prodProduct.propValue[bizCategoryProp.propCode] as addValue>
	   								<#if addValue.id == bizDict.dictId>
	   									<input type="text" data="${bizDict.dictId}" style="width:120px" alias="prodProductPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
	   								</#if>
	    						</#list>
	    						</#if>
	    					</#if>
	    				</#if>
        			</#list>
        			
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_RICH">
        			<textarea class="w35 sensitiveVad textWidth" cols="70"  style="width: 800px;height: 450px;" errorEle="errorEle${index}"  data="${bizCategoryProp.nullFlag}${bizCategoryProp.cancelFlag}" id="prodProductPropList[${index}].propValue" mark='sensitiveVad${index}' name="prodProductPropList[${index}].propValue" 
         	   		 ${required}  ${maxlength}
         	   		 <#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if>
         	   		 <#if productId != ''> ${disabled}</#if>  ${readonly }
         	   		 ><#if productId != ''>${propValue}</#if></textarea>

				<#elseif bizCategoryProp.inputType == "INPUT_TYPE_TEXTAREA">
          			<textarea propCode="${bizCategoryProp.propCode!''}" class="w35 textWidth" style="width:700px; height:80px" errorEle="errorEle${index}" id="prodProductPropList[${index}].propValue" name="prodProductPropList[${index}].propValue"
         	    	${required} ${maxlength} <#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if>
         	    	<#if productId != ''> ${disabled}</#if>  ${readonly }
         	    	><#if productId != ''>${propValue}</#if></textarea>
         	    
         		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YYYYMM">
					<input type="text" class="Wdate" errorEle="errorEle${index}" name="prodProductPropList[${index}].propValue" ${required} 
						<#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if>
         				<#if productId != ''> ${disabled} value="${propValue}"  ${readonly }</#if>
         				onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM'})"/>
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YYYYMMDD">
        			<input type="text" class="Wdate" errorEle="errorEle${index}" name="prodProductPropList[${index}].propValue"
	         			${required}  onFocus="WdatePicker({readOnly:true, dateFmt:'yyyy-MM-dd'})" 
	         				<#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if>
	         				<#if productId != ''>${disabled} value="${propValue}"  ${readonly }</#if>/>
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_DDMM">
		           <input type="text" class="Wdate" name="prodProductPropList[${index}].propValue"  ${required}
		          	onFocus="WdatePicker({readOnly:true, dateFmt:'HH:mm'})" errorEle=ele${index}
		          	<#if productId != ''>${disabled} value="${propValue}"  ${readonly }</#if>
		          	<#if productId == ''> placeholder="${bizCategoryProp.propDefault!''}" autoValue="true" </#if>
		          	/>  
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_YESNO">
        			<label><input type="radio" <#if bizCategoryProp.propCode == "traffic_flag">traffic="traffic_flag" <#elseif bizCategoryProp.propCode == "auto_pack_traffic">autopack="auto_pack_traffic"</#if> errorEle="errorEle${index}" ${required} name="prodProductPropList[${index}].propValue" value="Y" 
	        			<#if productId != ''>${disabled} <#if "Y" == propValue>checked</#if> <#if editFlag?? && editFlag=='Y'> onclick="return false;"</#if> </#if>
	        			<#if productId == ''><#if bizCategoryProp.propDefault =='Y'>checked</#if> </#if>
        			/>是</label>
        			<label><input type="radio" <#if bizCategoryProp.propCode == "traffic_flag">traffic="traffic_flag" <#elseif bizCategoryProp.propCode == "auto_pack_traffic">autopack="auto_pack_traffic"</#if> errorEle="errorEle${index}" ${required} name="prodProductPropList[${index}].propValue" value="N" 
	        			<#if productId != ''>${disabled} <#if "N" == propValue>checked<#elseif null == propValue && bizCategoryProp.propCode == "auto_pack_traffic">checked </#if>  <#if editFlag?? && editFlag=='Y'> onclick="return false;"</#if></#if>
	        			<#if productId == ''><#if bizCategoryProp.propDefault =='N'>checked</#if></#if>
        			/>否</label>
        			
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_RADIO">
    				<#list bizCategoryProp.bizDictList as bizDict>
    					<#if productId != ''><#assign flag='N' /></#if>
    					<label>
    					<input type="radio" errorEle="errorEle${index}"
    						<#if productId != ''>
    							<#if editFlag?? && editFlag=='Y'> onclick="return false;" </#if> 
    						</#if>
    						onclick="showAddFlagRadioBox(this,'${bizDict.addFlag!''}',${index});"
	    					name="prodProductPropList[${index}].propValue" value="${bizDict.dictId!''}"  ${required}
	    					<#if productId != ''><#if bizDict.dictId == propValue>checked  <#assign flag='Y' /></#if> ${disabled}</#if>
    					/><span>${bizDict.dictName!''}</span></label>
    					<#if productId != ''>
	    					<#if bizDict.addFlag?? && bizDict.addFlag=='Y' && flag=='Y'>
	    						<#if prodProduct.propValue??&&prodProduct.propValue[bizCategoryProp.propCode]??>
	     						<#list prodProduct.propValue[bizCategoryProp.propCode] as addValue>
	    								<#if addValue.id == bizDict.dictId>
	    									<input type="text" data="${bizDict.dictId}" style="width:120px" alias="prodProductPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
	    								</#if>
	     						</#list>
	    						</#if>
	    					</#if>
	    				</#if>
    				</#list>
    				
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_SELECT">
        			<#if bizCategoryProp.propCode == "visa_type">
        				<select name="prodProductPropList[${index}].propValue" id="visaTypeName"  ${required} <#if productId != ''> ${disabled} </#if>errorEle="errorEle${index}" onchange="showAddFlagSelect(this,${index});">
						  	<option value="">请选择</option>
						  	<#if productId != ''><#assign flag='N' /></#if>
						  	<#list bizCategoryProp.bizDictList as bizDict>
			                    <option addFlag='${bizDict.addFlag!''}' value="${bizDict.dictId}"
			                    <#if productId != ''> <#if bizDict.dictId == propValue>selected<#if bizDict.addFlag=='Y'><#assign flag='Y' /> <#if editFlag?? && editFlag=='Y'> onclick="return false;" </#if></#if></#if></#if>
			                    >${bizDict.dictName}</option>
						  	</#list>
						  	<#if productId != ''>
						  		<#if flag=='Y'>
                				<#list bizCategoryProp.bizDictList as bizDict>
	                				<#if prodProduct.propValue??&&prodProduct.propValue[bizCategoryProp.propCode]??>
	            						<#list prodProduct.propValue[bizCategoryProp.propCode] as addValue>
	           								<#if addValue.id == bizDict.dictId>
	           									<input type="text" data="${bizDict.dictId}" style="width:120px" alias="prodProductPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
	           								</#if>
	            						</#list>
	           						</#if>
           						</#list>
            				</#if>
						  	</#if>
               			</select>
               			
        			<#elseif bizCategoryProp.propCode == "visa_city">
        				<select name="prodProductPropList[${index}].propValue" id="visaCityName" ${required} errorEle="errorEle${index}" <#if productId != ''> ${disabled} </#if> onchange="showAddFlagSelect(this,${index});">
						  	<option value="">请选择</option>
						  	<#if productId != ''><#assign flag='N' /></#if>
						  	<#list bizCategoryProp.bizDictList as bizDict>
			                    <option addFlag='${bizDict.addFlag!''}' value="${bizDict.dictId}"
			                    	<#if productId != ''> <#if bizDict.dictId == propValue>selected<#if bizDict.addFlag=='Y'><#assign flag='Y' /></#if> <#if editFlag?? && editFlag=='Y'> onclick="return false;" </#if></#if> </#if>
			                    >${bizDict.dictName}</option>
						  	</#list>
               			</select>
               			<#if productId != ''>
               				<#if flag=='Y'>
                				<#list bizCategoryProp.bizDictList as bizDict>
	                				<#if prodProduct.propValue??&&prodProduct.propValue[bizCategoryProp.propCode]??>
	            						<#list prodProduct.propValue[bizCategoryProp.propCode] as addValue>
	           								<#if addValue.id == bizDict.dictId>
	           									<input type="text" data="${bizDict.dictId}" style="width:120px" alias="prodProductPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
	           								</#if>
	            						</#list>
	           						</#if>
           						</#list>
            				</#if>
               			</#if>
		            				
        			<#else>
        				<#if bizCategoryProp.categoryBusiFlag>
	        				<input type="hidden" id="propValueHidden${propId}${index}"   name="prodProductPropList[${index}].propValue"  value="${propValue}" <#if productId==''>addFlag=""</#if>/>
	        				<input type="text" id="propValue${propId}${index}" class="w35 search" readonly = "readonly" name="prodProductPropListId[${index}].propValue" ${required} <#if productId!=''>${disabled} value="${dictName }"</#if> 
	        					onclick="showAddFlagInput('${propId}${index}','${bizCategoryProp.dataFrom!''}','${bizCategoryProp.propName!''}','${ propId}');" />
	        			<#else>
	        				<select name="prodProductPropList[${index}].propValue" ${required} onchange="showAddFlagSelect(this,${index});" <#if productId!=''>${disabled}</#if>>
								<option value="">请选择</option>
									<#if productId!=''><#assign flag='N' /></#if>
									<#list bizCategoryProp.bizDictList as bizDict>
									   	<option  addFlag='${bizDict.addFlag!''}' value="${bizDict.dictId}" 
									   	
									   		<#if productId!=''><#if bizDict.dictId == propValue>selected<#if bizDict.addFlag=='Y'><#assign flag='Y' /></#if></#if> </#if>
									   	/>${bizDict.dictName}</option>
									</#list>
							</select>
							<#if productId!=''>
								<#if flag=='Y'>
									<#list bizCategoryProp.bizDictList as bizDict>
										<#if prodProduct.propValue??&&prodProduct.propValue[bizCategoryProp.propCode]??>
											<#list prodProduct.propValue[bizCategoryProp.propCode] as addValue>
												<#if addValue.id == bizDict.dictId>
													<input type="text" data="${bizDict.dictId}" style="width:120px" alias="prodProductPropList[${index}].addValue" value='${addValue.addValue}' remark='remark'>
												</#if>
											</#list>
										</#if>
									</#list>
								</#if>
							</#if>
	        			</#if>
        			</#if>
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_NUMBER">
        			<input type="text" class="w35 textWidth" name="prodProductPropList[${index}].propValue" number="true" ${required} ${maxlength}
        				<#if productId!=''>value="${propValue}" ${disabled} ${readonly}</#if>
        				<#if productId==''>placeholder="${bizCategoryProp.propDefault!''}" autoValue="true"</#if>
        				/>
        		
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_IMG_L">
        			<input type="file" name="prodProductPropList[${index}].propValue" ${required} 
        				<#if productId!=''>value="${propValue}" ${disabled}</#if> />
	
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_IMG_M">
        			<input type="file" name="prodProductPropList[${index}].propValue" ${required} 
        			<#if productId!=''>value="${propValue}" ${disabled}</#if> />
        				
        		<#elseif bizCategoryProp.inputType == "INPUT_TYPE_IMG_S">
        			<input type="file" name="prodProductPropList[${index}].propValue" ${required} <#if productId!=''>value="${propValue}" ${disabled}</#if>/>		
        				
        		</#if>
</#macro>

<script>
 
$(function(){

	//JQuery 自定义验证   
	jQuery.validator.addMethod("isChar", function(value, element) { 
	    var chars =  /^[^\\\*\&\#\$\%\@\\^\!\~\+>\<\|\'\"\/]+$/;//验证特殊字符  
	    return this.optional(element) || (chars.test(value));       
	 }, "不可输入特殊字符");
	
	$("#dataForm #productName").bind("change",function(){
		var py = vst_pet_util.convert2pinyin($(this).val());
		if($("input[propCode='product_pinyin']").size() > 0) {
			$("input[propCode='product_pinyin']").val(py);
		}
	});
	
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
		var placeName = $("#productName").val();
		var coordinateStr = $(this).val();
		coordinateSelectDialog = new xDialog("/vst_back/biz/districtSign/selectCoordinate.do?callback=onSelectCoordinate&placeName="+placeName+"&coordinateStr="+coordinateStr,{},{title:"选择经纬度",iframe:true,width:"1100",height:"600"});
	});
	
	//打开选择行政区窗口
	$("#district").click(function(){
		districtSelectDialog = new xDialog("/vst_back/biz/district/selectDistrictList.do",{},{title:"选择行政区",iframe:true,width:"1000",height:"600"});
	});
	
	$("#trafficNumFlag").click(function(){
		onSelectTrafficNum();
	});
	
	
});

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
	
	//处理航班原因
	if(!$("#trafficNumFlag").attr("checked")){
		$("#trafficNum").val("");
	}
}

//选择行政区
function onSelectDistrict(params){
	if(params!=null){
		$("#district").val(params.districtName);
		$("#districtId").val(params.districtId);
	}
	districtSelectDialog.close();
	$("#districtError").hide();
}

function showAddFlagCheckBox(params,addFlag,index){
 	if($(params).attr('checked')=='checked' && addFlag=='Y'){
 		$(params).next().after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark' >");
 	}else if(addFlag=='Y'){
 		$(params).next().next().remove();
 	}
}

function showAddFlagRadioBox(params,addFlag,index){
 	if($(params).attr('checked')=='checked'){
 		var StrName = document.getElementsByName("prodProductPropList["+index+"].addValue");
 		$(StrName).each(function(){
				$(this).remove();
		});
		if(addFlag=='Y'){
			if(typeof($(params).attr('addValue')) == "undefined"){
				$(params).next().after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
			}else{
				$(params).next().after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' value='"+$(params).attr('addValue')+"' remark='remark'>");
			}
		}
 	}
}

function showAddFlagSelect(params,index){
	if($(params).find("option:selected").attr('addFlag') == 'Y'){
		var StrName = document.getElementsByName("prodProductPropList["+index+"].addValue")
		if($(StrName).size()==0){
			$(params).after("<input type='text' style='width:120px' data='"+$(params).val()+"' alias='prodProductPropList["+index+"].addValue' remark='remark'>");
		}
	}else{
		$(params).next().remove();
	}
}

function showSelectDictDialog(dataFrom,propName,propId){
	//打开下拉列表并且为动态业务字典窗口
	var url = "/vst_back/biz/dict/findSelectDictList.do?dictDefId=" + dataFrom +"&propId=" + propId;
	
	dictSelectDialog = new xDialog(url, {}, {
			title : propName,
			iframe : true,
			width : "600",
			height : "600"
		});
	}

	function showAddFlagInput(propIdIndex, dataFrom, propName, propId) {
		busiSelectIndex = propIdIndex;
		//打开下拉列表并且为动态业务字典窗口
		showSelectDictDialog(dataFrom, propName, propId);
	}

	//input_text_select选择业务字典
	function onSelectDict(params) {
		$("input[name='prodProductPropListId[" + params.index + "].propValue']")
				.val(params.dictName);
		$("input[name='prodProductPropList[" + params.index + "].propValue']")
				.val(params.dictId);

		$("#propValueHidden" + busiSelectIndex).val(params.dictId);
		$("#propValue" + busiSelectIndex).val(params.dictName);

		if (params.addFlag == 'Y') {
			var StrName = document.getElementsByName("prodProductPropList["
					+ params.index + "].addValue");
			var selectObj = $("input[name='prodProductPropListId["
					+ params.index + "].propValue']");

			if ($(StrName).size() == 0) {

				$(selectObj)
						.after(
								"<input type='text' style='width:120px' data='"+ params.dictId +"' alias='prodProductPropList["+params.index+"].addValue' remark='remark'>");
			} else {
				$(selectObj).next().remove();
			}
		}

		dictSelectDialog.close();
	}

	//选择经纬度
	function onSelectCoordinate(params) {
		if (params != null) {
			$("#coordinate").val(params);
		}
		coordinateSelectDialog.close();
	}
	
	//选择航班原因必须选择天数
	function onSelectTrafficNum(){
		if($("#trafficNumFlag").attr("checked")){
			$("#trafficNum").removeAttr("disabled");
		}else{
			$("#trafficNum").attr("disabled","disabled");
		}
	}
	
	//自由行品类属性是否有大交通 选择是必填 选择否 则置灰不维护
	function onChangeTrafficFlag(){
		if($("input[name='bizCategoryId']").val()==18){
			var trafficFlag = $("input[traffic=traffic_flag]:checked").val();
			if(trafficFlag == 'N'){
				$("#districtFlag").hide();
				$("#district").removeAttr("required");
				$("#district").attr("disabled","disabled");
			}else{
				$("#districtFlag").show();
				$("#district").removeAttr("disabled");
				$("#district").attr("required","required");
			}
		}	
	}
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