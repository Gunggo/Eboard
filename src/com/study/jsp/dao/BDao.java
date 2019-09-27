package com.study.jsp.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.study.jsp.dto.BDto;
import com.study.jsp.dto.BPageInfo;
import com.study.jsp.dto.BCmtDto;

public class BDao {

    private static BDao instance = new BDao();
    DataSource dataSource = null;

    int listCount = 10;
    int pageCount = 10;

    public BDao() {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/Oracle11g");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static BDao getInstance() {
        return instance;
    }

    public void write(String bName, String bTitle, String bContent) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "insert into mvc_board " + " (bId, bName, bTitle, bContent, bHit, bGroup, bStep, bIndent) "
                    + " values " + " (mvc_board_seq.nextval, ?, ?, ?, 0, mvc_board_seq.currval, 0, 0 )";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, bName);
            pstmt.setString(2, bTitle);
            pstmt.setString(3, bContent);
            int rn = pstmt.executeUpdate();
            if (rn == 1) {
                System.out.println("입력");
            } else {
                System.out.println("실패");
            }
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

    public ArrayList<BDto> list(int curPage) {

        ArrayList<BDto> dtos = new ArrayList<BDto>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        int nStart = (curPage - 1) * listCount + 1;
        int nEnd = (curPage - 1) * listCount + listCount;

        try {
            con = dataSource.getConnection();


            String query = "select * " +
                    "  from ( " +
                    "         select rownum num, A.* " +
                    "           from ( " +
                    "                  select * " +
                    "                    from MVC_BOARD " +
                    "                    order by BGROUP desc, BSTEP asc ) A " +
                    "          where ROWNUM <= ? ) B " +
                    "where B.num >= ? ";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, nEnd);
            pstmt.setInt(2, nStart);
            resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                int bId = resultSet.getInt("bId");
                String bName = resultSet.getString("bName");
                String bTitle = resultSet.getString("bTitle");
                String bContent = resultSet.getString("bContent");
                Timestamp bDate = resultSet.getTimestamp("bDate");
                int bHit = resultSet.getInt("bHit");
                int bGroup = resultSet.getInt("bGroup");
                int bStep = resultSet.getInt("bStep");
                int bIndent = resultSet.getInt("bIndent");

                BDto dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);

                dtos.add(dto);

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
        return dtos;
    }

    public ArrayList<BDto> searchList(int curPage, String se, String keyWord) {

        // 0 제목 1 내용 2 작성자 3 제목+내용
        ArrayList<BDto> dtos = new ArrayList<BDto>();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        int nStart = (curPage - 1) * listCount + 1;
        int nEnd = (curPage - 1) * listCount + listCount;

        try {
            con = dataSource.getConnection();
            String query = null;
//			String query = "select * " +
//					"  from ( " +
//					"         select rownum num, A.* " +
//					"           from ( " +
//					"                  select * " +
//					"                    from MVC_BOARD " +
//					"                    order by BGROUP desc, BSTEP asc ) A " +
//					"          where ROWNUM <= ? ) B " +
//					"where B.num >= ? ";
//			pstmt = con.prepareStatement(query);
//			pstmt.setInt(1, nEnd);
//			pstmt.setInt(2, nStart);
//			resultSet = pstmt.executeQuery();
//			select * from MVC_BOARD
//			where BTITLE like '%' || '네이버' || '%';
            if (se.equals("0")) {
                query = "select * from mvc_board " +
                        "where btitle like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + keyWord + "%");
                resultSet = pstmt.executeQuery();
            } else if (se.equals("1")) {
                query = "select * from mvc_board " +
                        "where BCONTENT like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + keyWord + "%");
                resultSet = pstmt.executeQuery();
            } else if (se.equals("2")) {
                query = "select * from mvc_board " +
                        "where BNAME like ?";
                pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + keyWord + "%");
                resultSet = pstmt.executeQuery();
            } else {
                query = "select * from mvc_board " +
                        "where btitle like ? and " +
                        "bname like ?";

                pstmt = con.prepareStatement(query);
                pstmt.setString(1, "%" + keyWord + "%");
                pstmt.setString(2, "%" + keyWord + "%");
                resultSet = pstmt.executeQuery();
            }

            while (resultSet.next()) {
                int bId = resultSet.getInt("bId");
                String bName = resultSet.getString("bName");
                String bTitle = resultSet.getString("bTitle");
                String bContent = resultSet.getString("bContent");
                Timestamp bDate = resultSet.getTimestamp("bDate");
                int bHit = resultSet.getInt("bHit");
                int bGroup = resultSet.getInt("bGroup");
                int bStep = resultSet.getInt("bStep");
                int bIndent = resultSet.getInt("bIndent");

                BDto dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);

                dtos.add(dto);

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
        return dtos;
    }


    public BDto contentView(String strID) {
        upHit(strID);

        BDto dto = null;
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            con = dataSource.getConnection();

            String query = "select * from mvc_board where bId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(strID));
            resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                int bId = resultSet.getInt("bId");
                String bName = resultSet.getString("bName");
                String bTitle = resultSet.getString("bTitle");
                String bContent = resultSet.getString("bContent");
                Timestamp bDate = resultSet.getTimestamp("bDate");
                int bHit = resultSet.getInt("bHit");
                int bGroup = resultSet.getInt("bGroup");
                int bStep = resultSet.getInt("bStep");
                int bIndent = resultSet.getInt("bIndent");

                dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);

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

        return dto;

    }

    public void modify(String bId, String bName, String bTitle, String bContent) {

        Connection con = null;
        PreparedStatement pstmt = null;

        String query = "update mvc_board " + "   set bName = ?, " + "       bTitle = ?, " + "       bContent = ? "
                + "where bId = ?";

        try {
            con = dataSource.getConnection();
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, bName);
            pstmt.setString(2, bTitle);
            pstmt.setString(3, bContent);
            pstmt.setString(4, bId);
            int rn = pstmt.executeUpdate();
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

    private void upHit(String strID) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "update mvc_board set bHit = bHit + 1 where bId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setString(1, strID);

            int rn = pstmt.executeUpdate();
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

    public void delete(String bId) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "delete from mvc_board where bId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(bId));

            int rn = pstmt.executeUpdate();
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

    public BDto reply_view(String str) {
        BDto dto = null;

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            con = dataSource.getConnection();

            String query = "select * from mvc_board where bId = ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(str));
            resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                int bId = resultSet.getInt("bId");
                String bName = resultSet.getString("bName");
                String bTitle = resultSet.getString("bTitle");
                String bContent = resultSet.getString("bContent");
                Timestamp bDate = resultSet.getTimestamp("bDate");
                int bHit = resultSet.getInt("bHit");
                int bGroup = resultSet.getInt("bGroup");
                int bStep = resultSet.getInt("bStep");
                int bIndent = resultSet.getInt("bIndent");

                dto = new BDto(bId, bName, bTitle, bContent, bDate, bHit, bGroup, bStep, bIndent);

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

        return dto;
    }

    public void reply(String bId, String bName, String bTitle, String bContent, String bGroup, String bStep,
                      String bIndent) {

        replyShape(bGroup, bStep);

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "insert into mvc_board " + " (bId, bName, bTitle, bContent, bGroup, bStep, bIndent) "
                    + " values " + " (mvc_board_seq.nextval, ?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(query);

            pstmt.setString(1, bName);
            pstmt.setString(2, bTitle);
            pstmt.setString(3, bContent);
            pstmt.setInt(4, Integer.parseInt(bGroup));
            pstmt.setInt(5, Integer.parseInt(bStep) + 1);
            pstmt.setInt(6, Integer.parseInt(bIndent) + 1);

            int rn = pstmt.executeUpdate();
            System.out.println(rn);
            if (rn == 1) {
                System.out.println("입력");
            } else {
                System.out.println("실패");
            }
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

    private void replyShape(String strGroup, String strStep) {

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "update mvc_board " + "   set bStep = bStep + 1 " + " where bGroup = ? and bStep > ?";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(strGroup));
            pstmt.setInt(2, Integer.parseInt(strStep));

            int rn = pstmt.executeUpdate();
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

    public BPageInfo articlePage(int curPage) {

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        int listCount = 10;
        int pageCount = 10;

        int totalCount = 0;
        try {
            con = dataSource.getConnection();

            String query = "select count(*) as total from mvc_board";
            pstmt = con.prepareStatement(query);
            resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                totalCount = resultSet.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }

        int totalPage = totalCount / listCount;
        if (totalCount % listCount > 0)
            totalPage++;

        int myCurPage = curPage;
        if (myCurPage > totalPage)
            myCurPage = totalPage;
        if (myCurPage < 1)
            myCurPage = 1;

        int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;

        int endPage = startPage + pageCount - 1;
        if (endPage > totalPage)
            endPage = totalPage;

        BPageInfo pinfo = new BPageInfo();
        pinfo.setTotalPage(totalCount);
        pinfo.setListCount(listCount);
        pinfo.setTotalPage(totalPage);
        pinfo.setCurPage(curPage);
        pinfo.setPageCount(pageCount);
        pinfo.setStartPage(startPage);
        pinfo.setEndPage(endPage);

        return pinfo;
    }

    public void insertReply(BCmtDto dto) {
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            con = dataSource.getConnection();
            String query = "insert into REPLY_board " + " (cnum, bnum, bname, bcontent) " +
                    " values " + " (SEQ_REPLY_NO.nextval, ?, ?, ?)";
            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, dto.getbNum());
            pstmt.setString(2, dto.getbName());
            pstmt.setString(3, dto.getbContent());
            int rn = pstmt.executeUpdate();
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

    public List<BCmtDto> getReply(int bNum) {
        List<BCmtDto> list = new ArrayList<BCmtDto>();

        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet resultSet = null;

        try {
            con = dataSource.getConnection();

            String query = "select * from REPLY_BOARD " + " where BNUM = ? order by CNUM asc ";

            pstmt = con.prepareStatement(query);
            pstmt.setInt(1, bNum);
            resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                String bName = resultSet.getString("bName");
                Timestamp bDate = resultSet.getTimestamp("bDate");
                String bContent = resultSet.getString("bContent");
                int cNum = resultSet.getInt("cNum");
                bNum = resultSet.getInt("bNum");

                BCmtDto dto = new BCmtDto(cNum, bDate, bName, bContent, bNum);

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
}