<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
</head>
<body>
<form id="uatoAddBookDialogDataForm">
    <table class="p_table form-inline">
        <tbody>
            <tr>
             
                <td class="p_label"><i class="cc1">*</i>账号：</td>
                <input type="hidden"  id="userId" name="userId"   />
                <td><input type="text" id="isbn" name="isbn" required="true"  class="searchInput"></td>
                <td class="p_label"><i class="cc1">*</i>书籍名称：</td>
                <td>
                    <input type="text" class="searchInput" id="bookName" name="bookName" required="true" errorele="searchValidate" />
                </td>
            </tr>

           <tr>
               <td class="p_label"><i class="cc1">*</i>出版社：</td>
               <td>
                   <input type="text"  id="bookPub" name="bookPub" errorele="searchValidate" required="true" ">
               </td>
                <td class="p_label">出生日期：</td>
                <td>
                   <#--&lt;#&ndash; ${(user.birthday?string("yyyy-MM-dd"))!''}&ndash;&gt;-->
                    <input type="text" id="birthday" name="birthday" errorele="searchValidate" class="Wdate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
                </td>
            </tr>

            <tr>
                <td class="p_label"><i class="cc1">*</i>作者：</td>
                <td>
                    <input type="text"  id="bookAuthor" name="bookAuthor" errorele="searchValidate" required="true" >
                </td>
                <td class="p_label"><i class="cc1">*</i>价格：</td>
                <td>
                    <input type="text"  id="bookPrice" name="bookPrice" errorele="searchValidate" required="true" >
                </td>
            </tr>
            <tr>
                <td class="p_label">语言：</td>
                <td>
                    <input type="text" id="bookLanguage" name="bookLanguage"  >
                </td>
                <td class="p_label">简介：</td>
                <td>
                    <input type="textarea" id="bookIntroduction" name="bookIntroduction" >
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>数量：</td>
                <td>
                    <input type="text"  id="bookNum" name="bookNum" errorele="searchValidate" email="true" >
                </td>
                <td class="p_label"><i class="cc1">*</i>图片：</td>
                <td>
                    <input type="text"  id="bookImg" name="bookImg" errorele="searchValidate" >
                </td>
            </tr>
            <tr>
                <td class="p_label"><i class="cc1">*</i>备注：</td>
                <td>
                    <input type="text"  id="memo" name="memo" errorele="searchValidate" >
                </td>
            </tr>

        </tbody>
    </table>
    <input type="hidden" id="cancelFlag" name="cancelFlag" value="N"/>

</form>
<button class="pbtn pbtn-small btn-ok" style="float: right; margin-top: 20px;" id="saveButton">保存</button>

<script type="text/javascript" src="/library/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="/library/bootstrap/js/jquery-1.7.2.min.js"> </script>
<script type="text/javascript" src="/library/js/jquery.barcode.js"> </script>

<script>


    $("#isbn").startListen({
        barcodeLen : 13,
        letter : false,
        number : true,
        show : function(code){
            $("#isbn").val(code);
            findIsbnInfo(code);
        }
    });
    function findIsbnInfo(code){
        $.ajax({
            url : "/library/book/findIsbnInfo.do?isbn="+code,
            type : "get",
            dataType : "json",
            //async : false,
           // data : $("#uatoAddBookDialogDataForm").serialize(),
            success : function(result) {
                if (result && result.book ) {
                    var $dialogHtml=$("#uatoAddBookDialogDataForm");
                    var book=result.book;
                    $dialogHtml.find("#bookName").val(book.bookName);
                    $dialogHtml.find("#bookAuthor").val(book.bookAuthor);
                    $dialogHtml.find("#bookPub").val(book.bookPub);
                    $dialogHtml.find("#bookPubTime").val(book.bookPubTime);
                    $dialogHtml.find("#bookIntroduction").val(book.bookIntroduction);
                    $dialogHtml.find("#bookPrice").val(book.bookPrice);
                    $dialogHtml.find("#bookImg").val(book.bookImg);


                } else {
                    alert(result.isbn);
                }
            }
        });
    }

    /*//监听isbn input值变化事件
    $('#isbn').bind('input onKeyPress', function() {
        if($(this).val() && $(this).val()!=""){
            alert($(this).val());
        }
    });*/

    $("#uatoAddBookDialogDataForm").validate({
      rules: {
        airline: "required"
      }
    });
    
    //保存
    $("#saveButton").on("click", function() {
        debugger;
        if(!$("#uatoAddBookDialogDataForm").validate().form()){
            return false;
        }
        $.ajax({
            url : "/library/user/saveUser.do",
            type : "post",
            dataType : "json",
            //async : false,
            data : $("#uatoAddBookDialogDataForm").serialize(),
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