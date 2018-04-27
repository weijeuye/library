<!DOCTYPE html>
<html>
<head>

<#include "/pages/base/head_meta.ftl"/>
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
                <td class="s_label">字典名称：</td>
                <td class="w18"><input type="text" name="dictName" value="${dictName!''}"></td>
                <td class="s_label">字典定义名称：</td>
                <td class="w18"><input type="text" name="dictDefName" value="${dictDefName!''}"></td>
                <td class="s_label">字典类型：</td>
                <#--<td class="w18">
                	<select name="dictType">
					  	<option value="" <#if dictType == ''>selected</#if> >不限</option>
	                    <option value="DICT_TYPE_STATIC" <#if dictType == 'DICT_TYPE_STATIC'>selected</#if> >静态字典</option>
	                    <option value="DICT_TYPE_BUSINESS" <#if dictType == 'DICT_TYPE_BUSINESS'>selected</#if> >业务字典</option>
	                </select>
                </td>-->
            	<td class="s_label"></td>
              </tr>
              <tr>
              	<td class="s_label">字典状态：</td>
                <#--<td class="w18">
	                <select name="cancelFlag">
					  	<option value="" <#if cancelFlag == ''>selected</#if> >不限</option>
	                    <option value="Y" <#if cancelFlag == 'Y'>selected</#if> >有效</option>
	                    <option value="N" <#if cancelFlag == 'N'>selected</#if> >无效</option>
	                </select>
                </td>-->
                <td class="s_label">字典定义名称ID：</td>
               <#-- <td class="w18"><input type="text" name="dictDefId" value="${dictDefId!''}"></td>-->
                <td class="s_label"><a class="btn btn_cc1" id="search_button">查询</a></td>
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
            	<th>字典定义名称ID</th>
                <th>字典定义名称</th>
            	<th>字典名称ID</th>
                <th>字典名称</th>
                <th>是否可补充</th>
                <th>字典类型</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
			<#list pageParam.items as bookUserArrayList>
				<tr>
					<td>${bookUserArrayList.userId!''} </td>
					<td>${bookUserArrayList.userAccount!''} </td>
					<td>${bookUserArrayList.userName!''} </td>
					<td>${bookUserArrayList.gender!''} </td>

					<td>
						<#if bookUserArrayList.gender == 'm'>
							<span style="color:green" class="cancelProp">男</span>
						<#else>
							<span style="color:red" class="cancelProp">女</span>
						</#if> 
					</td>
					<#--<td class="oper">
						<a class="editDict" href="javascript:;" data="${bizDictExtend.dictId!''}" data2="${bizDictExtend.dictDefName!''}" >编辑</a>
						<#if bizDictExtend.dictType == 'DICT_TYPE_BUSINESS' >
							<a href="javascript:void(0);" class="showLogDialog" param='parentId=${bizDictExtend.dictDefId}&objectId=${bizDictExtend.dictId}&parentType=DICT_BUSINESS&sysName=VST'>操作日志</a>
						</#if>
						
						<a href="javascript:;"  class="editFlag" data1="${bizDictExtend.dictId!''}" data2="${bizDictExtend.dictCancelFlag}">${(bizDictExtend.dictCancelFlag=='N')?string("设为有效", "设为无效")}</a>
						<#if bizDictExtend.dictType == 'DICT_TYPE_BUSINESS' >
							<a href="javascript:void(0);" class="showPhoto" data=${bizDictExtend.dictId}>图片</a>	
						</#if>				
                    </td>-->
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
	
	//修改字典
	$("a.editDict").bind("click",function(){
	    var dictId=$(this).attr("data");
	    var url = "/vst_back/biz/dict/showUpdateDict.do";
	    var dictName =$(this).attr("data2");
	    updateDialog = new xDialog(url,{"dictId":dictId,"requestSource":"dict"}, {title:"修改" + dictName,width:800,height:700});
	});
	
	//设置状态
	$("a.editFlag").bind("click",function(){
		 var dictId=$(this).attr("data1");
		 var dictCancelFlag=$(this).attr("data2") == "N" ? "Y": "N";
		 var url = "/vst_back/biz/dict/editDictFlag.do?dictId="+dictId+"&cancelFlag="+dictCancelFlag+"&newDate="+new Date();
		 msg = dictCancelFlag === "N" ? "确认设为无效  ？" : "确认设为有效  ？";
	 	 $.confirm(msg, function () {
			 $.get(url, function(data){
			    alert("设置成功");
				$("#searchForm").submit();
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

