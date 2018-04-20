package com.weason.library.service.impl;

import com.weason.library.dao.BookUserDao;
import com.weason.library.po.BookUser;
import com.weason.library.service.BookUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
@Component
public class BookUserServiceImpl implements BookUserService {
    @Autowired
    private BookUserDao bookUserDao;
    @Override
    public ArrayList<BookUser> queryBookUsers() {
        ArrayList<BookUser> bookUsers=bookUserDao.queryBookUsers();
        return bookUsers;
    }

    @Override
    public Integer addBookUser(BookUser bookUser) {
        return null;
    }

    @Override
    public Integer updateBookUser(BookUser bookUser) {
        return null;
    }

    @Override
    public Integer deleteBookUser(BookUser bookUser) {
        return null;
    }
}
