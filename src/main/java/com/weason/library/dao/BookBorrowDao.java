package com.weason.library.dao;

import com.weason.library.po.BookBorrow;
import com.weason.library.vo.BookBorrowVo;
import com.weason.util.mybaties.MyBatisDao;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * @Author weilei
 * @date 2018/7/18 17:33
 */
@ResponseBody
public class BookBorrowDao extends MyBatisDao {
    public  BookBorrowDao(){
        super("book_borrow");
    }
    public Integer addBookBorrow(BookBorrow bookBorrow) {
        return super.insert("addBookBorrow",bookBorrow);
    }

    public Integer updateBookBorrow(Map<String, Object> param) {
        return super.update("updateBookBorrow",param);
    }

    public List<BookBorrowVo> findBookBorrowListByParam(Map<String, Object> param) {
        return super.queryForList("findBookBorrowListByParam",param);
    }
    public Integer findBookBorrowCounttByParam(Map<String, Object> param) {
        return super.get("findBookBorrowCounttByParam",param);
    }

    public BookBorrowVo findBookBorrowParam(Map<String, Object> param) {
        return super.get("findBookBorrowParam",param);
    }
}
