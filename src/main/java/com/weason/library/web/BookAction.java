package com.weason.library.web;

import com.weason.library.po.Book;
import com.weason.library.po.BookType;
import com.weason.library.service.BookService;
import com.weason.library.service.BookTypeService;
import com.weason.library.vo.ZTreeNode;
import com.weason.util.*;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.*;

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
     * form表单提交 Date类型数据绑定
     * <功能详细描述>
     * @param binder
     * @see [类、类#方法、类#成员]
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }


    /**
     * 查询书籍分类列表
     *
     * @param model
     * @param page
     * @param bookTypeName
     * @param req
     * @return
     */
    @RequestMapping("/findBookTypeList")
    public String findBookTypeList(Model model, Integer page, String bookTypeName, HttpServletRequest req) {
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
        BookType bookType = new BookType();
        if (bookTypeId != null) {
            List<BookType> list = bookTypeService.findBookTypeList(parameters);
            if (!CollectionUtils.isEmpty(list)) {
                bookType = list.get(0);
            }
        }
        model.addAttribute("bookType", bookType);
        nodeList = findBookTypeNodeList();
        model.addAttribute("nodeList", GsonUtils.toJson(nodeList));
        return "/pages/library/bookType/showAddBookType";
    }

    /**
     * 修改书籍分类
     *
     * @param bookType
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/updateBookType")
    @ResponseBody
    public Object addCategory(BookType bookType) throws Exception {
        if (bookType == null || bookType.getBookTypeId() == null) {
            return ResultMessage.PARAM_EXCEPTION_RESULT;
        }
        if (bookType.getBookTypeParentId() == null) {
            bookType.setLevelCode(0L);
        }
        int count = bookTypeService.updateBookType(bookType);
        if (count == 0) {
            return ResultMessage.UPDATE_FAIL_RESULT;
        }
        return ResultMessage.UPDATE_SUCCESS_RESULT;

    }

    @RequestMapping("/findBooks")
    public Object queryReaders(Model model, HttpServletRequest request, HttpServletResponse response, Integer page, Book queryParam) {

        Map<String, Object> parameters = new HashMap<String, Object>();
        if (queryParam != null) {
            parameters.put("bookName", queryParam.getBookName());
            parameters.put("bookTypeName", queryParam.getBookTypeName());
            parameters.put("bookTypeId", queryParam.getBookTypeId());
            parameters.put("bookAuthor", queryParam.getBookAuthor());
            parameters.put("bookPub", queryParam.getBookPub());
            parameters.put("bookPrice", queryParam.getBookPrice());
            parameters.put("isbn", queryParam.getIsbn());
            parameters.put("bookState", queryParam.getBookState());

        }
        model.addAttribute("queryParam", queryParam);
        int count = bookService.findBooksCountByParam(parameters);
        // 分页
        int pagenum = page == null ? 1 : page;
        Page pageParam = Page.page(count, 10, pagenum);
        pageParam.buildUrl(request);
        parameters.put("_start", pageParam.getStartRows());
        parameters.put("_end", pageParam.getEndRows());

        List<Book> bookArrayList = bookService.findBooksByParam(parameters);
        pageParam.setParam(bookArrayList);
        model.addAttribute("page", pagenum);
        model.addAttribute("pageParam", pageParam);
        model.addAttribute("books", bookArrayList);
        String basePath = HttpUtils.getBasePath(request);
        model.addAttribute("basePath", basePath);
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        nodeList = findBookTypeNodeList();
        model.addAttribute("nodeList", GsonUtils.toJson(nodeList));
        return "/pages/library/book/findBookList";
    }

    @RequestMapping(value = "/showAddBook")
    public String showAddBook(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String, Object> parameters = new HashMap<String, Object>();
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        nodeList = findBookTypeNodeList();
        model.addAttribute("nodeList", GsonUtils.toJson(nodeList));
        return "/pages/library/book/showAddBook";
    }
    @RequestMapping(value = "/saveBook")
    @ResponseBody
    public Object saveBook(Book book){
        if(book ==null){
            return ResultMessage.PARAM_EXCEPTION_RESULT;
        }
        Integer count=bookService.addBook(book);
        if(count > 0){
            return  ResultMessage.ADD_SUCCESS_RESULT;
        }
       return  ResultMessage.ADD_FAIL_RESULT;
    }

    /**
     * 查询并封装图书分类树形结构
     *
     * @return
     */
    private List<ZTreeNode> findBookTypeNodeList() {
        Map<String, Object> parameters = new HashMap<String, Object>();
        List<ZTreeNode> nodeList = new ArrayList<ZTreeNode>();
        List<BookType> list = bookTypeService.findBookTypeList(parameters);
        for (BookType item : list) {
            ZTreeNode node = new ZTreeNode();
            node.setId(Long.toString(item.getBookTypeId()));
            if (item.getBookTypeParentId() != null) {

                node.setpId(Long.toString(item.getBookTypeParentId()));
            }
            node.setName(item.getBookTypeName());
            nodeList.add(node);
        }
        return nodeList;
    }

    @RequestMapping(value = "/findIsbnInfo")
    @ResponseBody
    public Object findIsbnInfo(Model model, Long isbn) throws Exception {
        Map<String, Object> map = new HashMap<String, Object>();
        String str = "";
        if (isbn != null) {
            str = isbnApi(isbn).toString();
        }
        Book book = toBook(str);
        map.put("book", book);
        map.put("isbn", str);
        return map;
    }

    public StringBuffer isbnApi(Long isbn) {
        String path = "https://api.douban.com/v2/book/isbn/:" + isbn;
        StringBuffer sb = new StringBuffer();
        try {
            //创建一个URL对象
            URL url = new URL(path);
            //创建一个URLConnection连接对象
            URLConnection conn = url.openConnection();
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
            //创建一个输入流来接收网页
            InputStream in = conn.getInputStream();
            //字节流——>字符流
            InputStreamReader isr = new InputStreamReader(in, "utf-8");
            //从字符输入流中读取文本，缓冲各个字符，从而实现字符、数组和行的高效读取。
            BufferedReader br = new BufferedReader(isr);

            String line = null;
            // StringBuffer sb=new StringBuffer();

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
            System.out.println(sb);
            return sb;

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sb;
    }

    private Book toBook(String sb) {
        Book book = new Book();
        if (sb != null && sb != "") {
            JSONObject jsonObject = JSONObject.fromObject(sb);
            //提取所需要的字段
            String bname = jsonObject.getString("title");
            String isbn13 = jsonObject.getString("isbn13");
            String press = jsonObject.getString("publisher");
            List<String> authors = (List<String>) jsonObject.get("author");
            String author = this.listToString(authors);
            String summary = jsonObject.getString("summary");
            String price=jsonObject.getString("price");

            if(jsonObject.get("pubdate") !=null ){
                String dateStr=jsonObject.get("pubdate").toString();
                Integer num=judgeNum(dateStr);
                Date publishTime=null;
                if(num ==1){
                    publishTime=  DateUtil.toDate(dateStr,"yyyy-MM");
                }else if(num ==2){
                    publishTime=  DateUtil.toDate(dateStr,"yyyy-MM-dd");
                }

                book.setBookPubTime(publishTime);
            }
            Object imgs = jsonObject.get("images");
            String image = this.getPic(imgs);


            book.setBookAuthor(author);
            book.setBookName(bname);
            book.setIsbn(isbn13);
            book.setBookPub(press);
            book.setBookIntroduction(summary);
            book.setBookImg(image);
            return book;

        }
        return book;
    }

    /**
     * 将List集合返回成字符串形式
     *
     * @return
     */
    private static String listToString(List<String> list) {
        String str = list.toString();
        str = str.replace("\"", "");
        str = str.replace("[", "");
        str = str.replace("]", "");
        str = str.replace(" ", "");
        return str;
    }

    /**
     * 从json里的子对象获取他的内容
     *
     * @param obj
     * @return
     */
    private static String getPic(Object obj) {
        JSONObject json = JSONObject.fromObject(obj.toString());
        String img = json.getString("large");
        return img;

    }
    private Integer judgeNum(String str){
        Integer num=0;
        if(str ==null || str ==""){
            return num;
        }
        char[] strArray=str.toCharArray();
        for(int i=0;i<strArray.length;i++){
            if('-'==strArray[i]){
                num++;
            }
        }
        return num;
    }
}