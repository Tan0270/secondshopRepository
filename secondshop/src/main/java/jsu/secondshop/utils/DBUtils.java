package jsu.secondshop.utils;

import org.apache.commons.beanutils.BeanUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBUtils {
    public static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/secondshop?serverTimezone=GMT%2B8&useUnicode=true&characterEncoding=UTF-8";
        String username = "root";
        String password = "123456";
        String driver = "com.mysql.cj.jdbc.Driver";
        Class.forName(driver);
        return DriverManager.getConnection(url, username, password);
    }

    public static void close(Connection conn, Statement ps, ResultSet rs) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public static boolean save(String sql, Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        Integer count = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            if (args != null && args.length > 0) {
                for (int i = 0; i < args.length; i++) {
                    //判断date是不是java.util.Date 转换成java.sql.Date
                    if (args[i] instanceof java.util.Date) {
                        java.util.Date date = (java.util.Date) args[i];
                        //转换成java.sql.Date
                        args[i] = new java.sql.Date(date.getTime());
                    }
                    ps.setObject(i + 1, args[i]);
                }
            }
            //返回更新的记录数
            count = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, null);
        }
        return count != null && count > 0 ? true : false;
    }


    public static int getCount(String sql, Object... args) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = -1;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            if (args != null && args.length > 0) {
                for (int i = 0; i < args.length; i++) {
                    ps.setObject(i + 1, args[i]);
                }
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return count;
    }

    public static <T> T getSingleObj(Class<T> clazz, String sql, Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        T bean = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            if (args != null && args.length > 0) {
                for (int i = 0; i < args.length; i++) {
                    ps.setObject(i + 1, args[i]);
                }
            }
            rs = ps.executeQuery();
            //获取结果集元数据
            ResultSetMetaData rsmd = rs.getMetaData();
            //获取当前结果的列数
            int colnum = rsmd.getColumnCount();

            while (rs.next()) {

                //key存放列名，value存放列值，for循环完成之后。rowMap存放了一条记录
                Map<String, Object> rowMap = new HashMap<String, Object>();
                for (int i = 1; i <= colnum; i++) {
                    String columnName = rsmd.getColumnLabel(i);
                    Object columnValue = rs.getObject(columnName);
                    rowMap.put(columnName, columnValue);
                }
                bean = clazz.newInstance();
                for (Map.Entry<String, Object> entry : rowMap.entrySet()) {
                    String propertyName = entry.getKey();
                    Object propertyValue = entry.getValue();
                    BeanUtils.setProperty(bean, propertyName, propertyValue);
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return bean;
    }

    public static <T> List<T> getList(Class<T> clazz, String sql, Object... args) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<T> userList = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);

            if (args != null && args.length > 0) {
                for (int i = 0; i < args.length; i++) {
                    ps.setObject(i + 1, args[i]);
                }
            }
            rs = ps.executeQuery();
            //获取结果集元数据
            ResultSetMetaData rsmd = rs.getMetaData();
            //获取当前结果的列数
            int colnum = rsmd.getColumnCount();
            while (rs.next()) {

                //key存放列名，value存放列值，for循环完成之后。rowMap存放了一条记录
                Map<String, Object> rowMap = new HashMap<String, Object>();
                for (int i = 1; i <= colnum; i++) {
                    String columnName = rsmd.getColumnLabel(i);
                    Object columnValue = rs.getObject(columnName);
                    rowMap.put(columnName, columnValue);
                }
                T bean = clazz.newInstance();

                //循环rowMap给User所有属性赋值，entry{key,value}
                for (Map.Entry<String, Object> entry : rowMap.entrySet()) {
                    String propertyName = entry.getKey();
                    Object propertyValue = entry.getValue();
                    BeanUtils.setProperty(bean, propertyName, propertyValue);
                }
                userList.add(bean);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, rs);
        }
        return userList;
    }

    public static int getID(String sql) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        int id = 0;
        try {
            conn = DBUtils.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            id = Integer.valueOf(rs.getString(1));
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, stmt, rs);
        }
        return id;
    }

    public static boolean delete(String sql, Object... args) {
        Connection conn = null;
        PreparedStatement ps = null;
        Integer count = null;
        try {
            conn = DBUtils.getConnection();
            ps = conn.prepareStatement(sql);
            if (args != null && args.length > 0) {
                for (int i = 0; i < args.length; i++) {
                    ps.setObject(i + 1, args[i]);
                }
            }
            //返回更新的记录数
            count = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            close(conn, ps, null);
        }
        return count != null && count > 0 ? true : false;
    }
}
