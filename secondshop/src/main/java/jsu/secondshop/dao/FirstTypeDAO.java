package jsu.secondshop.dao;

import jsu.secondshop.models.FirstType;
import jsu.secondshop.utils.DBUtils;

import java.util.List;

public class FirstTypeDAO {

    public static List<FirstType> getAllFirst() {
        String sql = "select id,name from first_type";
        return DBUtils.getList(FirstType.class, sql, null);
    }

    public boolean updateFirstType(int id, String name) {
        String sql = "insert into first_type(id,name) values(?,?)";
        return DBUtils.save(sql, id, name);
    }

    public boolean daleteFirstType(int id) {
        String sql="delete from first_type where id=?";
        return DBUtils.delete(sql,id);
    }
}
