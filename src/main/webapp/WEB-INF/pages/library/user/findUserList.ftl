<!DOCTYPE html>
<html>
<head>

<#include "/pages/base/head_meta.ftl"/>
	<link type="text/css" href="library/js/My97DatePicker/skin/WdatePicker.css">
</head>
<body>
<div class="iframe_header">
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">图书管理</a> &gt;</li>
        <li class="active">图书信息管理</li>
    </ul>
</div>

<div class="iframe_search">
<form method="post" action='/library/user/findUsers.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">账号</td>
                <td class="w18"><input type="text" name="userAccount" value="${queryParam.userAccount!''}"></td>
                <td class="s_label">用户名称</td>
                <td class="w18"><input type="text" name="userName" value="${queryParam.userName!''}"></td>
                <td class="s_label">电话：</td>
                <td class="w18"><input type="text" name="telephone" value="${queryParam.telephone!''}"></td>
            	<td class="s_label"></td>
              </tr>
              <tr>
              	<td class="s_label">性别：</td>
                <td class="w18">
	                <select name="gender">
						<#if queryParam.gender??>

                            <option value="" <#if queryParam.gender == "" >selected</#if> >不限</option>
                            <option value="m" <#if queryParam.gender == "m">selected</#if> >男</option>
                            <option value="f" <#if queryParam.gender == "f">selected</#if> >女</option>
							<#else >
                                <option value="" selected>不限</option>
                                <option value="m"  >男</option>
                                <option value="f" >女</option>
						</#if>
	                </select>
                </td>
                <td class="s_label"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class="s_label"><a class="btn btn_cc1" id="addUser_button">新增</a></td>
                <td></td>
                <td></td>
                <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<div class="iframe-content mt20">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
            	<th>用户ID</th>
                <th>账号</th>
            	<th>姓名</th>
                <th>性别</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>地址</th>
                <th>出生日期</th>
                <th>qq号</th>
                <th>微信号</th>
                <th>身份证</th>
                <th>推荐人</th>
                <th>是否有效</th>
                <th>图片</th>
                <th>编辑</th>
            </tr>
        </thead>
        <tbody>
			<#list bookUsers as bookUser>
				<tr>
					<td>${bookUser.userId!''} </td>
					<td>${bookUser.userAccount!''} </td>
					<td>${bookUser.userName!''} </td>
					<td>
						<#if bookUser.gender == 'm'>
							<span style="color:green" class="cancelProp">男</span>
						<#else>
							<span style="color:red" class="cancelProp">女</span>
						</#if> 
					</td>
                    <td>${bookUser.telephone!''} </td>
                    <td>${bookUser.email!''} </td>
                    <td>${bookUser.address!''} </td>
                    <td>${bookUser.birthday!''} </td>
                    <td>${bookUser.qqAccount!''} </td>
                    <td>${bookUser.webchatAccount!''} </td>
                    <td>${bookUser.idNumber!''} </td>
                    <td>${bookUser.recommendUserId!''} </td>
                    <td>
						<#if bookUser.isValid == 'y'>
                            <span style="color:green" class="cancelProp">有效</span>
						<#else>
                            <span style="color:red" class="cancelProp">无效</span>
						</#if>
					</td>
                    <td><img src="https://img1.doubanio.com\/view\/subject\/s\/public\/s3272509.jpg"></td>
					<td class="oper">
						<a class="editDict" href="javascript:;" data="${bookUser.userId!''}" data2="" >编辑</a>

						<a href="javascript:void(0);" class="showLogDialog" param='parentId=${bookUser.userId}&objectId=${bookUser.userId}&parentType=DICT_BUSINESS&sysName=VST'>操作日志</a>

						
						<a href="javascript:;"  class="editFlag" data1="${bookUser.userId!''}" data2="${bookUser.isValid}">${(bookUser.isValid=='y')?string("设为无效", "设为有效")}</a>

						<a href="javascript:void(0);" class="showPhoto" data=${bookUser.userId}>删除</a>
                    </td>
				</tr>
			</#list>
        </tbody>
    </table>

	<#if pageParam.items?exists> 
		<div class="paging" > 
			${pageParam.getPagination()}
		</div> 
	</#if>
        
</div><!-- div p_box -->
	
</div><!-- //主要内容显示区域 -->
<#include "/pages/base/foot.ftl"/>
</body>
</html>

<script>
//属性列表弹出框对象，不要有重名的
var dictPropDefListDialog, dictPropListDialog, updateDialog,updateDictPropDialog;

$(function(){

	$("#search_button").bind("click",function(){
		$("#searchForm").submit();
	});
    //新增
    $("#addUser_button").on('click',function(){
        var url = "/library/user/addUser.do";
        updateDialog = new xDialog(url, {}, {title:"新增用户信息",width:900});
    });

    //修改
    $("a.editDict").on('click',function(){
        var userId = $(this).attr("data");
        var url = "/library/user/showUpdateUser.do?userId="+userId;
        updateDialog = new xDialog(url, {}, {title:"修改用户信息",width:900});
    });



	
	//设置状态
	$("a.editFlag").bind("click",function(){
		 var userId=$(this).attr("data1");
		 var isValid=$(this).attr("data2") == "N" ? "Y": "N";
		 var url = "/library/user/showUpdateUser.do?userId="+userId+"&isValid="+isValid;
		 msg = isValid === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 	 $.confirm(msg, function () {
			 $.get(url, function(data){
                 if(data && data.code=='SUCCESS'){
                     $.alert(data.message);
                     $("#searchForm").submit();
                 }else {
                     $.alert(data.message);
                 }
		     });
	     });
	});
	
	// Comphoto
	$("a.showPhoto").bind("click",function(){
		var url="/vst_back/pub/comphoto/findComPhotoList.do?objectId="+$(this).attr("data")+"&objectType=DICT_ID";
		new xDialog(url,{},{title:"图片列表",iframe:true,width:1000});
	});

	function confirmAndRefresh(result){
		if (result.code == "success") {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}else {
			pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
				$("#searchForm").submit();
			}});
		}
	} 
});

</script>

