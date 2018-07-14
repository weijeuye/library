<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
</head>
<body>
<form id="dataForm">
    <table class="p_table form-inline">
        <tbody>
            <tr>
             
                <td class="p_label"><i class="cc1">*</i>账号：</td>
                <input type="hidden"  id="userId" name="userId"  value="${user.userId}" />
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
                   <#-- ${(user.birthday?string("yyyy-MM-dd"))!''}-->
                    <input type="text" id="birthday" name="birthday" errorele="searchValidate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${user.birthday!''}"/>
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
                    <input type="text" id="webchatAccount" name="webchatAccount" value="${user.webchatAccount!''}" >
                </td>
                <td class="p_label">QQ号：</td>
                <td>
                    <input type="text" id="qqAccount" name="qqAccount" value="${user.qqAccount!''}">
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>邮箱：</td>
                <td>
                    <input type="text"  id="email" name="email" errorele="searchValidate" email="true" value="${user.email!''}">
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
    <input type="hidden" id="cancelFlag" name="cancelFlag" value="N"/>

</form>
<button class="pbtn pbtn-small btn-ok" style="float: right; margin-top: 20px;" id="saveButton">保存</button>

<script type="text/javascript" src="/library/js/My97DatePicker/WdatePicker.js"</script>
<script type="text/javascript" src="/library/bootstrap/js/jquery-1.7.2.min.js" </script>
<script>
    
    $("#dataForm").validate({
      rules: {
        airline: "required"
      }
    });
    
    //保存
    $("#saveButton").on("click", function() {
        debugger;
        if(!$("#dataForm").validate().form()){
            return false;
        }
        $.ajax({
            url : "/library/user/saveUser.do",
            type : "post",
            dataType : "json",
            //async : false,
            data : $("#dataForm").serialize(),
            success : function(result) {
                if (result.code == "success") {
                    alert(result.message);
                    updateDialog.close();
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