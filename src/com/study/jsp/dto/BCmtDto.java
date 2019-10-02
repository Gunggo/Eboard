package com.study.jsp.dto;

import java.sql.Timestamp;

public class BCmtDto {
    private int bNum;
    private int cNum;
    private Timestamp bDate;
    private String bName;
    private String bContent;
    private int recnt;

    public int getRecnt() {
        return recnt;
    }

    public void setRecnt(int recnt) {
        this.recnt = recnt;
    }

    public BCmtDto() {
    }

    public BCmtDto(int cNum, Timestamp bDate, String bName, String bContent, int bNum) {
        this.bNum = bNum;
        this.cNum = cNum;
        this.bDate = bDate;
        this.bName = bName;
        this.bContent = bContent;
    }

    public int getcNum() {
        return cNum;
    }

    public void setcNum(int cNum) {
        this.cNum = cNum;
    }


    public int getbNum() {
        return bNum;
    }

    public void setbNum(int bNum) {
        this.bNum = bNum;
    }

    public Timestamp getbDate() {
        return bDate;
    }

    public void setbDate(Timestamp bDate) {
        this.bDate = bDate;
    }

    public String getbName() {
        return bName;
    }

    public void setbName(String bName) {
        this.bName = bName;
    }

    public String getbContent() {
        return bContent;
    }

    public void setbContent(String bContent) {
        this.bContent = bContent;
    }
}
