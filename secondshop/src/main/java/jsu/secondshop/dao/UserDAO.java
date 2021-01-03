package jsu.secondshop.dao;

import jsu.secondshop.models.User;
import jsu.secondshop.utils.DBUtils;
import jsu.secondshop.utils.DateUtils;

import java.util.Date;
import java.util.List;

public class UserDAO {
    public static List<User> getAllUser() {
        String sql="select id,name,mobile,email,password,photo_url photoUrl,role_id roleId,gender,register_date registerDate,status_id statusId from user where role_id=?";
        return DBUtils.getList(User.class,sql,102);
    }

    public boolean selectUserEmailCount(String email) {
        String sql="select * from user where email = ?";
        int count = DBUtils.getCount(sql,email);
        return count>0?true:false;
    }

    public boolean saveUser(User user) {
        String sql="insert into user(name, mobile, email, password, photo_url, role_id, gender, register_date, status_id) values(?,?,?,?,?,?,?,?,?)";
        Date date=new Date();
        String register_date= DateUtils.format(date);
        return DBUtils.save(sql,user.getName(),user.getMobile(),user.getEmail(),user.getPassword(),"/statics/image/photos/default/default.png",102,user.getGender(),register_date,4);
    }

    public User getUserByEamilAndPass(String email, String password) {
        String sql="select id,name,mobile,email,password,photo_url photoUrl,role_id roleId,gender,register_date registerDate,status_id statusId from user where email=? and password=?";
        return DBUtils.getSingleObj(User.class,sql,email,password);
    }

    public boolean daleteUser(int id) {
        String sql="delete from user where id=?";
        return DBUtils.delete(sql,id);
    }

    public boolean updateUserStatus(int statusId, int userId) {
        String sql="update user set status_id=? where id=?";
        return  DBUtils.save(sql,statusId,userId);
    }

    public boolean updateUserInfo(User user) {
        String sql="update user set name=?,mobile=?,email=?,photo_url=?,gender=? where id=?";
        return DBUtils.save(sql,user.getName(),user.getMobile(),user.getEmail(),user.getPhotoUrl(),user.getGender(),user.getId());
    }
}
