package com.weason.library.service;

import com.weason.library.po.BookUser;

import java.util.ArrayList;

public interface BookUserService {
    public ArrayList<BookUser> queryBookUsers();
    public Integer addBookUser(BookUser bookUser);
    public Integer updateBookUser(BookUser bookUser);
    public Integer deleteBookUser(BookUser bookUser);
}
