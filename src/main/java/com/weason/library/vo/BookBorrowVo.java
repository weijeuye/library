package com.weason.library.vo;

import java.io.Serializable;
import java.util.Date;

/**
* Created by weason on 2018-07-18
*@Description book_borrow vo类
*/ 


public class BookBorrowVo implements Serializable{
	private long borrowId;
	private long userId;
	private long bookId;
	private Date borrowTime;
	private Date returnIme;
	private Date actReturnTime;
	private String isReturn;
	private long operatorId;

	private String userName;
	private String BookName;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBookName() {
		return BookName;
	}

	public void setBookName(String bookName) {
		BookName = bookName;
	}

	public void setBorrowId(long borrowId){
	this.borrowId=borrowId;
	}
	public long getBorrowId(){
		return borrowId;
	}
	public void setUserId(long userId){
	this.userId=userId;
	}
	public long getUserId(){
		return userId;
	}
	public void setBookId(long bookId){
	this.bookId=bookId;
	}
	public long getBookId(){
		return bookId;
	}
	public void setBorrowTime(Date borrowTime){
	this.borrowTime=borrowTime;
	}
	public Date getBorrowTime(){
		return borrowTime;
	}
	public void setReturnIme(Date returnIme){
	this.returnIme=returnIme;
	}
	public Date getReturnIme(){
		return returnIme;
	}
	public void setActReturnTime(Date actReturnTime){
	this.actReturnTime=actReturnTime;
	}
	public Date getActReturnTime(){
		return actReturnTime;
	}
	public void setIsReturn(String isReturn){
	this.isReturn=isReturn;
	}
	public String getIsReturn(){
		return isReturn;
	}
	public void setOperatorId(long operatorId){
	this.operatorId=operatorId;
	}
	public long getOperatorId(){
		return operatorId;
	}
}

