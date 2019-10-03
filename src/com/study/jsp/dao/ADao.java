package com.study.jsp.dao;

import com.study.jsp.dto.BDto;
import com.study.jsp.dto.MDto;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ADao {
    DataSource dataSource;
    private static ADao instance = new ADao();

    public static ADao getInstance() {
        return instance;
    }

    public ADao() {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<MDto> getMember(String keyword, String se) {
        List<MDto> list = new ArrayList<MDto>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            con = dataSource.getConnection();
            if (keyword.equals("") && se.equals("")) {
                pstmt = con.prepareStatement("select * from MEMBERS");
                resultSet = pstmt.executeQuery();
            } else if (se.equals("0")) {
                String query = "select * from members where id like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, keyword);
                resultSet = pstmt.executeQuery();
            } else if (se.equals("1")) {
                String query = "select * from members where bname like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString( 1, keyword);
                resultSet = pstmt.executeQuery();
            } else {
                String query = "select * from members where EMAIL like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1,keyword);
                resultSet = pstmt.executeQuery();
            }

            while (resultSet.next()) {
                String id = resultSet.getString("id");
                String pw = resultSet.getString("pw");
                String name = resultSet.getString("bname");
                String eMail = resultSet.getString("eMail");
                Timestamp rDate = resultSet.getTimestamp("rDate");
                String address = resultSet.getString("address");
                int block = resultSet.getInt("block");


                MDto dto = new MDto(id, pw, name, eMail, rDate, address, block);

                list.add(dto);

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return list;
    }

    public List<MDto> getActKing(String searchType, String startDate, String endDate) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;
        List<MDto> list = new ArrayList<MDto>();

        //        select id, BNAME, EMAIL, RDATE,(select count(*) from MVC_BOARD where BNAME = MEMBERS.BNAME) count from MEMBERS

        try {
            con = dataSource.getConnection();
            // 선택날짜 없음
            if (startDate.equals("") || endDate.equals("")) {
                if (searchType.equals("0")) {
                    pstmt = con.prepareStatement("select id, BNAME, EMAIL, RDATE,(select count(*) from MVC_BOARD where BNAME = MEMBERS.BNAME) count from MEMBERS");
                    resultSet = pstmt.executeQuery();
                } else if(searchType.equals("1")) {
                    pstmt = con.prepareStatement("select id, BNAME, EMAIL, RDATE,(select count(*) from REPLY_BOARD where BNAME = MEMBERS.BNAME) count from MEMBERS " +
                            "order by count desc");
                    resultSet = pstmt.executeQuery();
                }
            }

            if (!startDate.equals("") && !endDate.equals("")) {
                if (searchType.equals("0")) {
                    pstmt = con.prepareStatement("select id, BNAME, EMAIL, RDATE,(select count(*) from MVC_BOARD where BNAME = MEMBERS.BNAME" +
                            " and BDATE between to_date(?,'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd') + 1) count from MEMBERS");
                    pstmt.setString( 1, startDate);
                    pstmt.setString( 2, endDate);
                    resultSet = pstmt.executeQuery();
                } else if(searchType.equals("1")) {
                    pstmt = con.prepareStatement("select id, BNAME, EMAIL, RDATE,(select count(*) from REPLY_BOARD where BNAME = MEMBERS.BNAME" +
                            " and BDATE between to_date(?,'yyyy-mm-dd') and to_date(?, 'yyyy-mm-dd') + 1) count from MEMBERS");
                    pstmt.setString( 1, startDate);
                    pstmt.setString( 2, endDate);
                    resultSet = pstmt.executeQuery();
                }
            }


            while (resultSet.next()) {
                String id = resultSet.getString("id");
                String name = resultSet.getString("bname");
                String email = resultSet.getString("email");
                Timestamp date = resultSet.getTimestamp("rdate");
                int count = resultSet.getInt("count");

                MDto dto = new MDto(id, name, email, date, count);
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null)
                    resultSet.close();
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return list;
    }


    public void delUser(String userId) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "delete from MEMBERS where ID = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    public void blkUser(String userId, String block) {
        Connection con = null;
        PreparedStatement pstmt = null;
        String query = "";
        if (block.equals("O")) {
            query = "update MEMBERS set BLOCK = 0 where ID = ?";
        } else {
            query = "update MEMBERS set BLOCK = 1 where ID = ?";
        }
        try {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, userId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null)
                    pstmt.close();
                if (con != null)
                    con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
