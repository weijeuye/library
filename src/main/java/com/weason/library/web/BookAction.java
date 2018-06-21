package com.weason.library.web;

import com.weason.util.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author weilei
 * @date 2018/6/21 16:35
 */
@Controller
@RequestMapping("library/book")
public class BookAction {

    public String findBookTypeList(Model model, Integer page, String categoryName, HttpServletRequest req)  {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("categoryName", categoryName);
        int count = 0;//categoryService.findCategoryCount(parameters);

        int pagenum = page == null ? 1 : page;
        Page pageParam = Page.page(count, 10, pagenum);
        pageParam.buildUrl(req);
        parameters.put("_start", pageParam.getStartRows());
        parameters.put("_end", pageParam.getEndRows());
        parameters.put("_orderby", "CATEGORY_ID");
        parameters.put("_order", "DESC");
       /* List<BizCategory> list = categoryService.findCategoryList(parameters);
        pageParam.setItems(list);*/

        model.addAttribute("pageParam", pageParam);
        model.addAttribute("categoryName", categoryName);
        model.addAttribute("page", pageParam.getPage().toString());

        return "/biz/category/findCategoryList";
    }
}
