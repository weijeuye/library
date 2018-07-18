package com.weason.library.service.impl;

import com.weason.library.po.BookBorrow;
import com.weason.library.service.BookBorrowService;
import com.weason.library.vo.BookBorrowVo;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * @Author weilei
 * @date 2018/7/18 17:31
 */
@Component
public class BookBorrowServiceImpl implements BookBorrowService {
    @Override
    public Integer addBookBorrow(BookBorrow bookBorrow) {
        return null;
    }

    @Override
    public Integer updateBookBorrow(Map<String, Object> param) {
        return null;
    }

    @Override
    public List<BookBorrowVo> findBookBorrowListByParam(Map<String, Object> param) {
        return null;
    }

    @Override
    public BookBorrowVo findBookBorrowParam(Map<String, Object> param) {
        return null;
    }
}
