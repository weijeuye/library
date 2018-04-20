package com.weason.library.web;

import com.weason.library.po.BookUser;
import com.weason.library.po.ReaderInfo;
import com.weason.library.service.BookUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Controller
public class Login {
    @Autowired
    private BookUserService bookUserService;
    @RequestMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response, Model model,ReaderInfo reader) {

        HttpSession session=request.getSession(true);
        ArrayList<BookUser> bookUsers=bookUserService.queryBookUsers();

         session.setAttribute("library_user_session",bookUsers.get(0));
        BookUser readerInfoSession =(BookUser) session.getAttribute("library_user_session");

        //session无效设置
        //session.invalidate();
        return "";
    }
}
