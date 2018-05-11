package com.weason.library.dao;

import com.weason.library.po.BookUser;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;

@Repository
public interface BookUserDao {

    public ArrayList<BookUser> queryBookUsers(Map<String,Object> param);
    public BookUser findBookUserByPassword(Map<String,Object> param);
    public Integer findBookUsersCount(Map<String,Object> param);
    public Integer addBookUser(BookUser bookUser);
    public Integer updateBookUserById(BookUser bookUser);
    public Integer deleteBookUserById(Long userId);
}
