package com.weason.library.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @Author weilei
 * @date 2018/6/21 16:35
 */
@Controller
@RequestMapping("library/book")
public class BookAction {
    public Object findBookType(){
        return "";
    }
}
