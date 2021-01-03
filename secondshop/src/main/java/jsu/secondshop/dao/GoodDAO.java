package jsu.secondshop.dao;

import jsu.secondshop.models.Good;
import jsu.secondshop.utils.DBUtils;
import jsu.secondshop.utils.DateUtils;
import sun.security.krb5.internal.CredentialsUtil;

import java.util.Date;
import java.util.List;

public class GoodDAO {
    public static List<Good> getAllGood() {
        String sql="select id,name,photo_url photoUrl,first_type_id firstTypeId,description,upload_date uploadDate,price prise,status_id statusId,user_id userId,good_update goodUpdate from good";
        return DBUtils.getList(Good.class,sql,null);
    }

    public boolean deleteGood(int id) {
        String sql="delete from good where id=?";
        return DBUtils.delete(sql,id);
    }

    public boolean updateGoodStatus(int statusId, int goodId) {
        String sql="update good set status_id=? where id=?";
        return DBUtils.save(sql,statusId,goodId);
    }

    public boolean addGood(Good good) {
        String sql="insert into good(name,first_type_id,photo_url,description,upload_date,price,status_id,user_id) values(?,?,?,?,?,?,?,?)";
        Date date=new Date();
        String upload_date= DateUtils.format(date);
        return DBUtils.save(sql,good.getName(),good.getFirstTypeId(),good.getPhotoUrl(),good.getDescription(),upload_date,good.getPrise(),1,good.getUserId());
    }

    public boolean updateGood(Good update) {
        String sql="update good set name=?,first_type_id=?,description=?,price=?,good_update=? where id=?";
        Date date=new Date();
        String goodUpdate=DateUtils.format(date);
        return DBUtils.save(sql,update.getName(),update.getFirstTypeId(),update.getDescription(),update.getPrise(),goodUpdate,update.getId());
    }

    public List<Good> getGoodByUserId(int id) {
        String sql="select id,name,photo_url photoUrl,first_type_id firstTypeId,description,upload_date uploadDate,price prise,status_id statusId,user_id userId,good_update goodUpdate from good where user_id=?";
        return DBUtils.getList(Good.class,sql,id);
    }

    public List<Good> getGoodsByTypeId(int id) {
        String sql="select id,name,photo_url photoUrl,first_type_id firstTypeId,description,upload_date uploadDate,price prise,status_id statusId,user_id userId,good_update goodUpdate from good where first_type_id=?";
        return DBUtils.getList(Good.class,sql,id);
    }
}
