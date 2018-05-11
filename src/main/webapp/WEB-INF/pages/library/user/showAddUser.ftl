<!DOCTYPE html>
<html>
<head>
</head>
<body>
<form id="dataForm">
    <table class="p_table form-inline">
        <tbody>
            <tr>
             
                <td class="p_label"><i class="cc1">*</i>账号：</td>
                <td><input type="text" id="userAccount" name="userAccount" required="true" value="${user.userAccount!''}" <#if user.userAccount?? >readonly </#if>></td>
                <td class="p_label"><i class="cc1">*</i>姓名：</td>
                <td>
                    <input type="text" class="searchInput" id="userName" name="userName" required="true" errorele="searchValidate" value="${user.userName!''}"/>
                </td>
            </tr>

            <tr>
                <td class="p_label">性别：</td>
                <td>
                    <select id="gender" name="gender">
                        <#if user.userName??>
                            <option value="m" <#if user.userName=='m'>selected</#if>>男</option>
                            <option value="f" <#if user.userName=='f'>selected</#if>>女</option>

                        <#else>
                            <option value="m" selected>男</option>
                            <option value="f" >女</option>
                        </#if>
                    </select>
                </td>
                <td class="p_label">出生日期：</td>
                <td>
                    <input type="text" id="birthday" name="birthday" errorele="searchValidate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${(user.birthday?string("yyyy-MM-dd"))!''}"/>
                </td>
            </tr>

            <tr>
                <td class="p_label"><i class="cc1">*</i>电话：</td>
                <td>
                    <input type="text"  id="telephone" name="telephone" errorele="searchValidate" required="true" value="${user.telephone!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>地址：</td>
                <td>
                    <input type="text"  id="address" name="address" errorele="searchValidate" required="true" value="${user.address!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label">微信号：</td>
                <td>
                    <input type="text" id="webchatAccount" name="webchatAccount" value="${user.webchatAccount!''}">
                </td>
                <td class="p_label">QQ号：</td>
                <td>
                    <input type="text" id="qqAccount" name="qqAccount" value="${user.qqAccount!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>邮箱：</td>
                <td>
                    <input type="text"  id="email" name="email" errorele="searchValidate" value="${user.email!''}">
                </td>
                <td class="p_label"><i class="cc1">*</i>身份证号：</td>
                <td>
                    <input type="text"  id="idNumber" name="idNumber" errorele="searchValidate" value="${user.idNumber!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>备注：</td>
                <td>
                    <input type="text"  id="memo" name="memo" errorele="searchValidate" value="${user.memo!''}">
                </td>
            </tr>

        </tbody>
    </table>
    <input type="hidden" id="cancelFlag" name="cancelFlag" value="N">
</form>
<button class="pbtn pbtn-small btn-ok" style="float: right; margin-top: 20px;" id="saveButton">保存</button>

<script type="text/javascript" src="/library/js/My97DatePicker/WdatePicker.js"
<script>
    
    var districtSelectDialog;

    //选择出发城市
    $("#startDistrictString").on('click', function(){
        districtSelectDialog = new xDialog("/vst_admin/biz/district/selectDistrictList.do",{id:"startDistrict"},{title:"选择出发城市",iframe:true,width:"1000",height:"600"});
    });
    
    //选择抵达城市
    $("#arriveDistrictString").on('click', function(){
        districtSelectDialog = new xDialog("/vst_admin/biz/district/selectDistrictList.do",{id:"arriveDistrict"},{title:"选择抵达城市",iframe:true,width:"1000",height:"600"});
    });
    
    //选择城市
    function onSelectDistrict(params){
        if(params != null){
            var districtName = params.districtName;
            var districtId = params.districtId;
            if(districtSelectDialog.data.id === "startDistrict"){
                $("#startDistrictString").val(districtName);
                $("#startDistrict").val(districtId);
            } else {
                $("#arriveDistrictString").val(districtName);
                $("#arriveDistrict").val(districtId);
            }
        }
        districtSelectDialog.close();
    }
    
    //自动补全机场信息
    vst_pet_util.commListSuggest($("#startAirportString"),$("#startAirport"),'/vst_admin/prod/traffic/searchAirportList.do','');
    vst_pet_util.commListSuggest($("#arriveAirportString"),$("#arriveAirport"),'/vst_admin/prod/traffic/searchAirportList.do','');
    vst_pet_util.commListSuggest($("#airlineString"),$("#airline"),'/vst_admin/biz/flight/searchAirlineList.do','');
    vst_pet_util.commListSuggest($("#airplaneString"),$("#airplane"),'/vst_admin/biz/flight/searchAirplanetypeList.do','');
    
    $("#dataForm").validate({
      rules: {
        airline: "required"
      }
    });
    
    //保存
    $("#saveButton").on("click", function() {
        if(!$("#dataForm").validate().form()){
            return false;
        }

        var arriveTime = $("input[name='arriveTime']").val();
        var startTime = $("input[name='startTime']").val();

        if(startTime==null || startTime==""){
            var errorhtml = '<i for="airlineString" class="error">请输入正确的起飞时间</i>';
            if($("input[name='startTime']").siblings("i").size()<1){
                $("input[name='startTime']").after(errorhtml);
            }
            return;
        }
        if(arriveTime==null || arriveTime==""){
            var errorhtml = '<i for="airlineString" class="error">请输入正确的降落时间</i>';
            if($("input[name='arriveTime']").siblings("i").size()<1){
                $("input[name='arriveTime']").after(errorhtml);
            }
            return;
        }

        var startTerminal = $("#startTerminal").val();
        var arriveTerminal = $("#arriveTerminal").val();
        if(startTerminal.length > 20){
           $.alert("始发机场航站楼不能超过20个字符。");
           return;
        }
        if(arriveTerminal.length > 20){
           $.alert("到达机场航站楼不能超过20个字符。");
           return;
        }
        
        var errorhtml = '<i for="airlineString" class="error">请输入正确的航空公司</i>';
		if($("#airline").val() == "" && $("#airlineString").val()!= "" ){
		if($("#airlineString").siblings("i").size()<1){
			$("#airlineString").after(errorhtml);
		}
		return;
		}
		
		var startAirportErrorhtml = '<i for="startAirportString" class="error">请输入正确的始发机场</i>';
		if($("#startAirport").val() == "" && $("#startAirportString").val()!= ""){
		if($("#startAirportString").siblings("i").size()<1){
			$("#startAirportString").after(startAirportErrorhtml);
		}
		return;
		}
		var arriveAirportErrorhtml = '<i for="arriveAirportString" class="error">请输入正确的到达机场</i>';
		if($("#arriveAirport").val() == "" && $("#arriveAirportString").val()!= ""){
		if($("#arriveAirportString").siblings("i").size()<1){
			$("#arriveAirportString").after(arriveAirportErrorhtml);
		}
		return;
		}
		
        $.ajax({
            url : "/vst_admin/biz/flight/addFlight.do",
            type : "post",
            dataType : "json",
            async : false,
            data : $("#dataForm").serialize(),
            success : function(result) {
                if (result.code == "success") {
                    alert(result.message);
                    addDialog.close();
                    window.location.reload();
                } else {
                    alert(result.message);
                }
            }
        });
    });
    
    
</script>
</body>
</html>