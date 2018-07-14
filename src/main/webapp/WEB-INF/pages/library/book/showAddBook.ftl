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
                <input type="hidden"  id="userId" name="userId"   />
                <td><input type="text" id="userAccount" name="userAccount" required="true"</td>
                <td class="p_label"><i class="cc1">*</i>姓名：</td>
                <td>
                    <input type="text" class="searchInput" id="userName" name="userName" required="true" errorele="searchValidate" />
                </td>
            </tr>

            <#--<tr>
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
                   &lt;#&ndash; ${(user.birthday?string("yyyy-MM-dd"))!''}&ndash;&gt;
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
            </tr>-->

        </tbody>
    </table>
    <input type="hidden" id="cancelFlag" name="cancelFlag" value="N"/>

</form>
<button class="pbtn pbtn-small btn-ok" style="float: right; margin-top: 20px;" id="saveButton">保存</button>

<script type="text/javascript" src="/library/js/My97DatePicker/WdatePicker.js"</script>
<script type="text/javascript" src="/library/bootstrap/js/jquery-1.7.2.min.js" </script>
<script type="text/javascript" src="/library/js/jquery.barcode.js" </script>

<script>
    var barcode = {
        listenerObj: null,
        oneKeyTime : '', /* 一次按键时间间隔 */
        twoKeyTime : '', /* 两次按键时间间隔 */
        keyDownTime: '', /* 键按下的时间    */
        barcodeLen : 8 , /* 条形码长度      */
        spanTime   : 70, /* 一次按键按下到释放的时间间隔 */

        on_key_down : function (){
            var that = this;
            this.listenerObj.keydown(function(e){

                if(e.which !== 13 && !(that.in_range(e.which))){
                    $(that.listenerObj).val('');
                    return ;
                }
                var d = new Date();
                var curTime = parseInt(d.getTime());
                if(that.keyDownTime !== '' && that.keyDownTime !== NaN){
                    that.twoKeyTime = curTime - that.keyDownTime;
                }
                that.keyDownTime = curTime;
            });
        },
        on_key_up : function(){
            var that = this;
            this.listenerObj.keyup(function(e){
                var d = new Date();
                var keyUpTime = d.getTime();

                that.oneKeyTime = parseInt(keyUpTime) - parseInt(that.keyDownTime);

                var isHand = that.checkHandInput();

                if(isHand && that.in_range(e.which)){
                    layer.msg('禁止手动输入');
                    $(that.listenerObj).val("");
                }
            })
        },
        on_key_press : function(){
            var that = this;
            this.listenerObj.keypress(function(e){
                if(e.which == 13 && that.check_barcode()){
                    that.createListEl();
                }
            });
        },
        checkHandInput : function(){
            if((this.oneKeyTime > this.spanTime) || this.twoKeyTime > this.spanTime){
                return true;
            }else{
                return false;
            }
        },
    }

    $("#userAccount").startListen({
        barcodeLen : 10,
        letter : true,
        number : true,
        show : function(code){
            layer.msg(code);
        }
    });
    /*//监听isbn input值变化事件
    $('#userAccount').bind('input onKeyPress', function() {
        if($(this).val() && $(this).val()!=""){
            alert($(this).val());
        }
    });*/

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