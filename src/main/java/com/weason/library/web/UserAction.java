package com.weason.library.web;

import com.weason.library.po.BookUser;
import com.weason.library.service.BookUserService;
import com.weason.util.HttpUtils;
import com.weason.util.Page;
import com.weason.util.ResultMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Queue;

@Controller
@RequestMapping("/user")
public class UserAction {

    @Autowired
    BookUserService bookUserService;

    @RequestMapping("/findUsers")
    public Object queryReaders(Model model, HttpServletRequest request, HttpServletResponse response,Integer page,BookUser queryParam){

        Map<String,Object> parameters=new HashMap<String,Object>();
        if(queryParam!=null ){
            parameters.put("userAccount",queryParam.getUserAccount());
            parameters.put("userName",queryParam.getUserName());
            parameters.put("telephone",queryParam.getTelephone());
            parameters.put("gender",queryParam.getGender());
        }
        model.addAttribute("queryParam",queryParam);
        parameters.put("isvalid","y");
        int count =bookUserService.findBookUsersCount(parameters);
        // 分页
        int pagenum = page == null ? 1 : page;
        Page pageParam = Page.page(count, 10, pagenum);
        pageParam.buildUrl(request);
        parameters.put("_start", pageParam.getStartRows());
        parameters.put("_end", pageParam.getEndRows());

        ArrayList<BookUser> bookUserArrayList= bookUserService.queryBookUsers(parameters);
        pageParam.setParam(bookUserArrayList);
        model.addAttribute("page",pagenum);
        model.addAttribute("pageParam",pageParam);
        model.addAttribute("bookUsers",bookUserArrayList);
        String basePath = HttpUtils.getBasePath(request);
        model.addAttribute("basePath",basePath);
        return "/pages/library/user/findUserList";
    }

    @RequestMapping("/updateUser")
    public Object updateUser(Model model,HttpServletRequest request,BookUser user){
        Map<String,Object> resultMap=new HashMap<String,Object>();
        if(user ==null ){
            resultMap.put("message","参数为空！");
            resultMap.put("status","1");
            return resultMap;
        }

        return "";
    }
    @RequestMapping("/addUser")
    public Object addUser(Model model,HttpServletRequest request,BookUser user){

        model.addAttribute("user",user);
        return "/pages/library/user/showAddUser";
    }
    @RequestMapping("/showUpdateUser")
    public Object showUpdateUser(Model model,HttpServletRequest request,Long userId){
        BookUser user=null;
        if(userId ==null){
            model.addAttribute("user",user);
            return "/pages/library/user/showAddUser";
        }
        Map<String,Object> param=new HashMap<String,Object>();
        param.put("userId",userId);
        user=bookUserService.findBookUser(param);
        model.addAttribute("user",user);
        return "/pages/library/user/showAddUser";
    }

    @RequestMapping("/saveUser")
    @ResponseBody
    public Object saveUser(Model model,BookUser user,HttpServletRequest request){
        Map<String,Object> result=new HashMap<String,Object>();
        if(user ==null){
            result.put("code","error");
            result.put("message","保存失败，参数异常!");
            return result;
        }
        if(user.getUserId() == 0){
           int resultcount= bookUserService.addBookUser(user);
            if(resultcount > 0){
                result.put("code","success");
                result.put("message","新增成功!");
            }else {
                result.put("code","fail");
                result.put("message","修改失败!");
            }
        }else {
            int count=bookUserService.updateBookUser(user);
            if( count > 0){
                result.put("code","success");
                result.put("message","修改成功!");
            }else {
                result.put("code","fail");
                result.put("message","修改失败!");
            }
        }
        return result;
    }
    @RequestMapping("/updateStatus")
    @ResponseBody
    public Object updateStatus(long userId ,String status){
        Map<String,Object> result=new HashMap<String,Object>();
        if(userId ==0 || status== null ){
            return ResultMessage.PARAM_EXCEPTION_RESULT;
        }
        BookUser user=new BookUser();
        user.setUserId(userId);
        user.setIsValid(status);
        int count =bookUserService.updateBookUser(user);
        if( count > 0){
            return ResultMessage.UPDATE_SUCCESS_RESULT;
        }else {
            return ResultMessage.UPDATE_FAIL_RESULT;
        }
    }
}
