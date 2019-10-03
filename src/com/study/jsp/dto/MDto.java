package com.study.jsp.dto;

import java.sql.Timestamp;

public class MDto {
    private String id;
    private String pw;
    private String name;
    private String eMail;
    private Timestamp rDate;
    private String address;
    private int block;
    private int countCon;
    private int count;

    public MDto(String id, String name, String eMail, Timestamp rDate, int count) {
        this.id = id;
        this.name = name;
        this.eMail = eMail;
        this.rDate = rDate;
        this.count = count;
    }

    public int getCountCon() {
        return countCon;
    }

    public void setCountCon(int countCon) {
        this.countCon = countCon;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public MDto(String id, String pw, String name, String eMail, Timestamp rDate, String address) {
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.eMail = eMail;
        this.rDate = rDate;
        this.address = address;
    }

    public MDto() {
    }

    public MDto(String id, String pw, String name, String eMail, Timestamp rDate, String address, int block) {
        this.id = id;
        this.pw = pw;
        this.name = name;
        this.eMail = eMail;
        this.rDate = rDate;
        this.address = address;
        this.block = block;
    }

    public int getBlock() {
        return block;
    }

    public void setBlock(int block) {
        this.block = block;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPw() {
        return pw;
    }

    public void setPw(String pw) {
        this.pw = pw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String geteMail() {
        return eMail;
    }

    public void seteMail(String eMail) {
        this.eMail = eMail;
    }

    public Timestamp getrDate() {
        return rDate;
    }

    public void setrDate(Timestamp rDate) {
        this.rDate = rDate;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}