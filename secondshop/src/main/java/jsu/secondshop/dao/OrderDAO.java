package jsu.secondshop.dao;

import jsu.secondshop.models.Order;
import jsu.secondshop.utils.DBUtils;
import jsu.secondshop.utils.DateUtils;

import java.util.Date;
import java.util.List;

public class OrderDAO {

    public static List<Order> getAllOrder() {
        String sql="select id,good_name goodName,seller,seller_id sellerId,customer,customer_id customerId,good_id goodId,money,submit_date submitDate,end_date endDate,status_id statusId from tb_order";
        return DBUtils.getList(Order.class,sql,null);
    }

    public boolean deleteOrder(int id) {
        String sql="delete from tb_order where id=?";
        return DBUtils.delete(sql,id);
    }

    public boolean addOrder(String goodName, String seller, int sellerID, String customer, int customerID, int goodID, float money, String submitDate, int statusId) {
        String sql="insert into tb_order(good_name,seller,seller_id,customer,customer_id,good_id,money,submit_date,status_id) values(?,?,?,?,?,?,?,?,?)";
        return DBUtils.save(sql,goodName,seller,sellerID,customer,customerID,goodID,money,submitDate,statusId);
    }

    public Order getOrder() {
        String sql1="select  max(id) from tb_order";
        int id=DBUtils.getID(sql1);
        Order order=null;
        if(id==0){
            String sql="select id,good_name goodName,seller,seller_id sellerId,customer,customer_id customerId,good_id goodId,money,submit_date submitDate,end_date endDate,status_id statusId from tb_order";
            order=DBUtils.getSingleObj(Order.class,sql,null);
        }else if(id>0){
            String sql="select id,good_name goodName,seller,seller_id sellerId,customer,customer_id customerId,good_id goodId,money,submit_date submitDate,end_date endDate,status_id statusId from tb_order where id=?";
            order=DBUtils.getSingleObj(Order.class,sql,id);
        }
        return order;
    }

    public Order getOrderByID(int id) {
        String sql="select id,good_name goodName,seller,seller_id sellerId,customer,customer_id customerId,good_id goodId,money,submit_date submitDate,end_date endDate,status_id statusId from tb_order where id=?";
        return DBUtils.getSingleObj(Order.class,sql,id);
    }

    public boolean updateStatus(int id) {
        String sql="update tb_order set end_date=?,status_id=? where id=?";
        Date date=new Date();
        String endDate= DateUtils.format(date);
        return DBUtils.save(sql,endDate,1,id);
    }

    public List<Order> getOrderByUserId(int id) {
        String sql="select id,good_name goodName,seller,seller_id sellerId,customer,customer_id customerId,good_id goodId,money,submit_date submitDate,end_date endDate,status_id statusId from tb_order where seller_id=? or customer_id=?";
        return DBUtils.getList(Order.class,sql,id,id);
    }
}
