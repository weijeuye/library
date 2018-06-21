<!DOCTYPE html>
<html>
<head>

<#include "/base/head_meta.ftl"/>
</head>
<body>
<div class="iframe_header">
 <i class="icon-home ihome"></i>
    <ul class="iframe_nav">
        <li><a href="#">首页</a> &gt;</li>
        <li><a href="#">品类管理</a> &gt;</li>
        <li class="active">品类列表</li>
    </ul>
</div>

<div class="iframe_search">
	<form method="post" action='/vst_admin/biz/category/findCategoryList.do' id="searchForm">
    <table class="s_table">
        <tbody>
            <tr>
                <td class="s_label">名称：</td>
                <td class="w18"><input type="text" name="categoryName" value="${categoryName!''}"></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="search_button">查询</a></td>
                <td class=" operate mt10"><a class="btn btn_cc1" id="new_button">新增</a></td>
                <input type="hidden" name="page" value="${page}">
            </tr>
        </tbody>
    </table>	
	</form>
</div>
	
<!-- 主要内容显示区域\\ -->
<div class="iframe_content">   
    <div class="p_box">
	<table class="p_table table_center">
        <thead>
            <tr>
        	<th>编号</th>
            <th>品类名称</th>
            <th>品类代码</th>
            <th>状态</th>
			<th>排序值</th>
            <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bizCategory> 
			<tr>
			<td>${bizCategory.categoryId!''} </td>
			<td>&nbsp;&nbsp;${bizCategory.categoryName!''} </td>
			<td>&nbsp;&nbsp;${bizCategory.categoryCode!''} </td>
			<td>
				<#if bizCategory.cancelFlag == 'Y'>
					<span style="color:green" class="cancelProp">有效</span>
				<#else>
					<span style="color:red" class="cancelProp">无效</span>
				</#if> 
			</td>
			<td>${bizCategory.seq!''} </td>
			<td class="oper">
                    <a class="editCate" href="javascript:void(0);" data="${bizCategory.categoryId!''}" >编辑基本信息</a>
                    <a class="editCateGroup" href="javascript:void(0);" data="${bizCategory.categoryId!''}" data2="${bizCategory.categoryName!''}">编辑属性分组</a>
                    <a class="editCateProp" href="javascript:void(0);" data="${bizCategory.categoryId!''}"
					data2="${bizCategory.categoryName!''}"
					>编辑属性</a>
                    <a class="editBranch" href="javascript:void(0);" data="${bizCategory.categoryId!''}" data2="${bizCategory.categoryName!''}">编辑规格</a>
                    <a href="javascript:void(0);"  class="editCategoryFlag" data="${bizCategory.categoryId!''}" data2="${bizCategory.cancelFlag}">${(bizCategory.cancelFlag=='N')?string("设为有效", "设为无效")}</a>					
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
<#include "/base/foot.ftl"/>
</body>
</html>

<script>
var categoryPropListDialog,categoryPropGroupsDialog,branchListDialog;
$(function(){

$("searchForm input[name='categoryName']").focus();
	$("#search_button").bind("click",function(){
		$("#searchForm").submit();
});
	
//新增品类
$("#new_button").bind("click",function(){
   dialog("/vst_admin/biz/category/showAddCategory.do", "新增品类", 800,"auto",function(){
		if(!$("#dataForm").validate().form()){
			return false;
		}
		var resultCode; 
		$.ajax({
				url : "/vst_admin/biz/category/addCategory.do",
				type : "post",
				async: false,
				data : $(".dialog #dataForm").serialize(),
				dataType:'JSON',
				success : function(result) {
				    resultCode=result.code;
					confirmAndRefresh(result);
				}
			});
		},"保存");
});

//编辑基本属性
$("a.editCate").bind("click",function(){
    var categoryId=$(this).attr("data");
    var url = "/vst_admin/biz/category/showAddCategory.do?categoryId="+categoryId;
	dialog(url, "编辑基本属性", 800, "auto",function(){
	    if(!$("#dataForm").validate().form()){
			return false;
		}
	    var resultCode; 
	    $.confirm("确认修改吗 ？", function () {
		$.ajax({
			url : "/vst_admin/biz/category/updateCategory.do",
			type : "post",
			async: false,
			data : $(".dialog #dataForm").serialize(),
			dataType:'JSON',
			success : function(result) {
			    resultCode=result.code;
				confirmAndRefresh(result);
			}
		});
	},"保存");
	return false;
	});
});
	
//编辑属性分组
$("a.editCateGroup").bind("click",function(){
    var categoryId=$(this).attr("data");
	var categoryName=$(this).attr("data2");
	var url = "/vst_admin/biz/categoryPropGroup/findCategoryPropGroup.do?categoryId="+categoryId;
	categoryPropGroupsDialog = new xDialog(url,{},{title:"编辑属性分组---"+categoryName,iframe:true,width:800,height:550}); 
	return false;	
});

//编辑属性
$("a.editCateProp").bind("click",function(){
    var categoryId=$(this).attr("data");
	var categoryName=$(this).attr("data2");
	var url = "/vst_admin/biz/categoryProp/findCategoryPropList.do?categoryId="+categoryId;
	categoryPropListDialog = new xDialog(url,{},{title:"编辑属性---"+categoryName,iframe:true,width:1300,height:800});	
	return false;
});

//编辑规格
$("a.editBranch").bind("click",function(){
    var categoryId=$(this).attr("data");	
	var categoryName=$(this).attr("data2")
	var url = "/vst_admin/biz/branch/findBranchList.do?categoryId="+categoryId;
	branchListDialog =new xDialog(url,{},{title:"编辑规格---"+categoryName,width:800,height:600});
	return false;
});

$("a.editCategoryFlag").bind("click",function(){
	 var categoryId=$(this).attr("data");
	 var cancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
	 var url = "/vst_admin/biz/category/editFlag.do?categoryId="+categoryId+"&cancelFlag="+cancelFlag+"&newDate="+new Date();
	 msg = cancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 $.confirm(msg, function () {
		 $.get(url, function(result){
	         confirmAndRefresh(result);
	     });
     });
	 return false;
});

function confirmAndRefresh(result){
	if (result.code == "success") {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			$("#searchForm").submit();
		}});
	}else {
		pandora.dialog({wrapClass: "dialog-mini", content:result.message, okValue:"确定",ok:function(){
			//$.alert(result.message);
		}});
	}
}
});

</script>

