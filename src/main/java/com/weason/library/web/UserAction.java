package com.weason.library.web;

import com.weason.library.po.BookUser;
import com.weason.library.service.BookUserService;
import com.weason.util.HttpUtils;
import com.weason.util.Page;
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

@Controller
@RequestMapping("/user")
public class UserAction {

    @Autowired
    BookUserService bookUserService;

    @RequestMapping("/findUsers")
    public Object queryReaders(Model model, HttpServletRequest request, HttpServletResponse response,Integer page){

        Map<String,Object> parameters=new HashMap<String,Object>();
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

}
