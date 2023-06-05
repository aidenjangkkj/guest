package guestbook;
 
import java.sql.*;
import java.util.*;
 
public class GuestBean {
    Connection conn = null;
    PreparedStatement pstmt = null;
   
    String jdbc_driver = "oracle.jdbc.driver.OracleDriver";
    String jdbc_url = "jdbc:oracle:thin:@127.0.0.1:1522";
   
    void connect() {
        try {
            Class.forName(jdbc_driver);
            conn = DriverManager.getConnection(jdbc_url, "db_id","1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    void disconnect() {
        if(pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
   
    public boolean insertDB(GuestBook g) {
        connect();
       
        String sql = "insert into guestbook" +
                "(gb_name, gb_email, gb_date, gb_tel, gb_passwd,                       gb_contents) "
                + "values(?, ?, sysdate, ?, ?, ?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, g.getGb_name());
            pstmt.setString(2, g.getGb_email());
            pstmt.setString(3, g.getGb_tel());
            pstmt.setString(4, g.getGb_passwd());
            pstmt.setString(5, g.getGb_contents());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }
   
    public boolean updateDB(GuestBook g) {
        connect();
       
        String sql = "update guestbook set gb_name=?, "
                + "gb_email=?, gb_date=sysdate, gb_tel=?,                                gb_passwd=?, "
                + "gb_contents=? where gb_id=?";   
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, g.getGb_name());
            pstmt.setString(2, g.getGb_email());
            pstmt.setString(3, g.getGb_tel());
            pstmt.setString(4, g.getGb_passwd());
            pstmt.setString(5, g.getGb_contents());
            pstmt.setInt(6, g.getGb_id());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }
   
    public boolean deleteDB(int gb_id) {
        connect();
       
        String sql = "delete from guestbook where gb_id=?";
       
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, gb_id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
        return true;
    }
   
    public GuestBook getDB(int gb_id) {
        connect();
       
        String sql = "select * from guestbook where gb_id=?";
        GuestBook guestbook = new GuestBook();
       
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, gb_id);
            ResultSet rs = pstmt.executeQuery();
           
            rs.next();
            guestbook.setGb_id(rs.getInt("gb_id"));
            guestbook.setGb_name(rs.getString("gb_name"));
            guestbook.setGb_email(rs.getString("gb_email"));
            guestbook.setGb_date(rs.getDate("gb_date"));
            guestbook.setGb_tel(rs.getString("gb_tel"));
            guestbook.setGb_contents(rs.getString("gb_contents"));
            guestbook.setGb_passwd(rs.getString("gb_passwd"));
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return guestbook;
    }
   
    public ArrayList<GuestBook> getDBList() {
        connect();
       
        ArrayList<GuestBook> data = new ArrayList<GuestBook>();
       
        String sql = "select * from guestbook order by gb_id";
       
        try {
            pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                GuestBook guestbook = new GuestBook();
               
                guestbook.setGb_id(rs.getInt("gb_id"));
                guestbook.setGb_name(rs.getString("gb_name"));
                guestbook.setGb_email(rs.getString("gb_email"));
                guestbook.setGb_date(rs.getDate("gb_date"));
                guestbook.setGb_tel(rs.getString("gb_tel"));
               guestbook.setGb_contents(rs.getString("gb_contents"));
                data.add(guestbook);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return data;
    }
}