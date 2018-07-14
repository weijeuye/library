package com.weason.library.web;

import com.weason.library.po.Book;
import com.weason.library.po.BookType;
import com.weason.library.po.BookUser;
import com.weason.library.service.BookService;
import com.weason.library.service.BookTypeService;
import com.weason.library.vo.ZTreeNode;
import com.weason.util.GsonUtils;
import com.weason.util.HttpUtils;
import com.weason.util.Page;
import com.weason.util.ResultMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author weilei
 * @date 2018/6/21 16:35
 */
@Controller
@RequestMapping("/book")
public class BookAction {
    @Autowired
    private BookTypeService bookTypeService;
    @Autowired
    private BookService bookService;

    /**
     * 查询书籍分类列表
     * @param model
     * @param page
     * @param bookTypeName
     * @param req
     * @return
     */
    @RequestMapping("/findBookTypeList")
    public String findBookTypeList(Model model, Integer page, String bookTypeName, HttpServletRequest req)  {
        Map<String, Object> parameters = new HashMap<String, Object>();
        parameters.put("bookTypeName", bookTypeName);
        int count = bookTypeService.findBookTypeCount(parameters);

        int pagenum = page == null ? 1 : page;
        Page pageParam = Page.page(count, 10, pagenum);
        pageParam.buildUrl(req);
        parameters.put("_start", pageParam.getStartRows());
        parameters.put("_end", pageParam.getEndRows());
        parameters.put("_orderby", "book_type_id");
        parameters.put("_order", "DESC");
        List<BookType> list = bookTypeService.findBookTypeList(parameters);
        pageParam.setItems(list);

        model.addAttribute("pageParam", pageParam);
        model.addAttribute("categoryName", bookTypeName);
        model.addAttribute("page", pageParam.getPage().toString());

        return "/pages/library/bookType/findbookTyeList";
    }
    @RequestMapping(value = "/showAddBookType")
    public String showAddBookType(Model model, Long bookTypeId) throws Exception {
        Map<String, Object> parameters = new HashMap<String, Object>();
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        parameters.put("bookTypeId", bookTypeId);
        BookType bookType=new BookType();
        if(bookTypeId !=null ){
            List<BookType> list =bookTypeService.findBookTypeList(parameters);
            if(!CollectionUtils.isEmpty(list)){
                bookType=list.get(0);
            }
        }
        model.addAttribute("bookType",bookType);
        nodeList=findBookTypeNodeList();
        model.addAttribute("nodeList",GsonUtils.toJson(nodeList));
        return "/pages/library/bookType/showAddBookType";
    }

    /**
     * 修改书籍分类
     * @param bookType
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateBookType")
    @ResponseBody
    public Object addCategory(BookType bookType) throws Exception {
        if(bookType==null || bookType.getBookTypeId()==null){
            return ResultMessage.PARAM_EXCEPTION_RESULT;
        }
        if(bookType.getBookTypeParentId()==null ){
            bookType.setLevelCode(0L);
        }
        int count=bookTypeService.updateBookType(bookType);
        if(count == 0){
            return ResultMessage.UPDATE_FAIL_RESULT;
        }
        return ResultMessage.UPDATE_SUCCESS_RESULT;

    }
    @RequestMapping("/findBooks")
    public Object queryReaders(Model model, HttpServletRequest request, HttpServletResponse response, Integer page, Book queryParam){

        Map<String,Object> parameters=new HashMap<String,Object>();
        if(queryParam!=null ){
            parameters.put("bookName",queryParam.getBookName());
            parameters.put("bookTypeName",queryParam.getBookTypeName());
            parameters.put("bookTypeId",queryParam.getBookTypeId());
            parameters.put("bookAuthor",queryParam.getBookAuthor());
            parameters.put("bookPub",queryParam.getBookPub());
            parameters.put("bookPrice",queryParam.getBookPrice());
            parameters.put("isbn",queryParam.getIsbn());
            parameters.put("bookState",queryParam.getBookState());

        }
        model.addAttribute("queryParam",queryParam);
        int count =bookService.findBooksCountByParam(parameters);
        // 分页
        int pagenum = page == null ? 1 : page;
        Page pageParam = Page.page(count, 10, pagenum);
        pageParam.buildUrl(request);
        parameters.put("_start", pageParam.getStartRows());
        parameters.put("_end", pageParam.getEndRows());

        List<Book> bookArrayList= bookService.findBooksByParam(parameters);
        pageParam.setParam(bookArrayList);
        model.addAttribute("page",pagenum);
        model.addAttribute("pageParam",pageParam);
        model.addAttribute("books",bookArrayList);
        String basePath = HttpUtils.getBasePath(request);
        model.addAttribute("basePath",basePath);
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        nodeList=findBookTypeNodeList();
        model.addAttribute("nodeList",GsonUtils.toJson(nodeList));
        return "/pages/library/book/findBookList";
    }
    @RequestMapping(value = "/showAddBook")
    public String showAddBook(Model model,HttpServletRequest  request,HttpServletResponse response) throws Exception {
        Map<String, Object> parameters = new HashMap<String, Object>();
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        nodeList = findBookTypeNodeList();
        model.addAttribute("nodeList", GsonUtils.toJson(nodeList));
        return "/pages/library/book/showAddBook";
    }
    /**
     * 查询并封装图书分类树形结构
     * @return
     */
    private List<ZTreeNode> findBookTypeNodeList(){
        Map<String, Object> parameters = new HashMap<String, Object>();
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        List<BookType> list = bookTypeService.findBookTypeList(parameters);
        for(BookType item : list){
            ZTreeNode node = new ZTreeNode();
            node.setId(Long.toString(item.getBookTypeId()));
            if(item.getBookTypeParentId() !=null){

                node.setpId(Long.toString(item.getBookTypeParentId()));
            }
            node.setName(item.getBookTypeName());
            nodeList.add(node);
        }
        return nodeList;
    }
}
