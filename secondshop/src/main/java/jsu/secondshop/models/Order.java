package jsu.secondshop.models;

import java.text.SimpleDateFormat;

/**
 * 订单表
 * 
 * @author WEN
 *
 */
public class Order {
	private int id;
	private String goodName;
	private String seller;
	private int sellerId;
	private String customer;
	private int customerId;
	private int goodId;
	private float money;
	private String submitDate;
	private String endDate;
	private int statusId;

	public Order() {
	}

	public Order(String goodName, String seller, int sellerId, String customer, int customerId, int goodId, float money, String submitDate, int statusId) {
		this.goodName = goodName;
		this.seller = seller;
		this.sellerId = sellerId;
		this.customer = customer;
		this.customerId = customerId;
		this.goodId = goodId;
		this.money = money;
		this.submitDate = submitDate;
		this.statusId = statusId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getGoodName() {
		return goodName;
	}

	public void setGoodName(String goodName) {
		this.goodName = goodName;
	}

	public String getSeller() {
		return seller;
	}

	public void setSeller(String seller) {
		this.seller = seller;
	}

	public int getSellerId() {
		return sellerId;
	}

	public void setSellerId(int sellerId) {
		this.sellerId = sellerId;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public int getGoodId() {
		return goodId;
	}

	public void setGoodId(int goodId) {
		this.goodId = goodId;
	}

	public float getMoney() {
		return money;
	}

	public void setMoney(float money) {
		this.money = money;
	}

	public String getSubmitDate() {
		return submitDate;
	}

	public void setSubmitDate(String submitDate) {
		this.submitDate = submitDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getStatusId() {
		return statusId;
	}

	public void setStatusId(int statusId) {
		this.statusId = statusId;
	}

	@Override
	public String toString() {
		return "Order{" +
				"id=" + id +
				", goodName='" + goodName + '\'' +
				", seller='" + seller + '\'' +
				", sellerId=" + sellerId +
				", customer='" + customer + '\'' +
				", customerId=" + customerId +
				", goodId=" + goodId +
				", money=" + money +
				", submitDate='" + submitDate + '\'' +
				", endDate='" + endDate + '\'' +
				", statusId=" + statusId +
				'}';
	}
}
