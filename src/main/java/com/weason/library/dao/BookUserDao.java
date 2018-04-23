package com.weason.library.dao;

import com.weason.library.po.BookUser;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;

@Repository
public interface BookUserDao {

    public ArrayList<BookUser> queryBookUsers();
    public BookUser findBookUser(Map<String,Object> param);
    public Integer addBookUser(BookUser bookUser);
    public Integer updateBookUser(BookUser bookUser);
    public Integer deleteBookUser(BookUser bookUser);
}
