package com.weason.library.web;

import com.weason.library.po.ReaderInfo;
import com.weason.library.service.ReaderService;
import com.weason.util.HttpUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;


@Controller
public class ReaderAction {

    @Autowired
    ReaderService readerService;

    @RequestMapping("/queryReaders")
    public Object queryReaders(Model model, HttpServletRequest request, HttpServletResponse response){
        ArrayList<ReaderInfo> readerInfoArrayList= readerService.queryReaders();
        model.addAttribute("test","test");
        model.addAttribute("readers",readerInfoArrayList);
        String basePath = HttpUtils.getBasePath(request);
        model.addAttribute("basePath",basePath);
        return "index";
    }

}
