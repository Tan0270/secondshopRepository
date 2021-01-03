package jsu.secondshop.utils;

import java.sql.*;

public class test {
    public static void main(String[] args) throws Exception {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String sql="select * from role";
        conn = DBUtils.getConnection();
        stmt=conn.createStatement();
        rs=stmt.executeQuery(sql);
        ResultSetMetaData rsmd = rs.getMetaData();
        //获取当前结果的列数
        int colnum = rsmd.getColumnCount();
        while (rs.next()) {
            for(int i=1;i<=colnum;i++){
                System.out.println(rs.getString(i));
            }
        }

    }
}
