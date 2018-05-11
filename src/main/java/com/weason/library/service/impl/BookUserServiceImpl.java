package com.weason.library.service.impl;

import com.weason.library.dao.BookUserDao;
import com.weason.library.po.BookUser;
import com.weason.library.service.BookUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Map;

@Component
public class BookUserServiceImpl implements BookUserService {
    @Autowired
    private BookUserDao bookUserDao;

    @Override
    public ArrayList<BookUser> queryBookUsers(Map<String, Object> param) {
        ArrayList<BookUser> bookUsers = bookUserDao.queryBookUsers(param);
        return bookUsers;
    }

    @Override
    public BookUser findBookUser(Map<String, Object> param) {
        BookUser bookUser = bookUserDao.findBookUserByPassword(param);
        return bookUser;
    }

    @Override
    public Integer findBookUsersCount(Map<String, Object> param) {
        Integer count = bookUserDao.findBookUsersCount(param);
        return count;
    }

    @Override
    public Integer addBookUser(BookUser bookUser) {
        return null;
    }

    @Override
    public Integer updateBookUser(BookUser bookUser) {

        Integer count = bookUserDao.updateBookUserById(bookUser);
        return count;
    }


    @Override
    public Integer deleteBookUser(Long userId) {

        Integer count = bookUserDao.deleteBookUserById(userId);
        return count;
    }
}
