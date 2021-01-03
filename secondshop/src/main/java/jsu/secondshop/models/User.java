package jsu.secondshop.models;

import jsu.secondshop.utils.DateUtils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 用户表
 *
 * @author WEN
 */
public class User {
    private int id;
    private String name;
    private String mobile;
    private String email;
    private String password;
    private String photoUrl;
    private int roleId;
    private String gender;
    private String registerDate;
    private int statusId;

    public User() {
    }

    public User(String name, String gender, String mobile, String email, String password, String registerDate) {
        this.name = name;
        this.mobile = mobile;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.registerDate = registerDate;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getRegisterDate() {
        return registerDate;
    }

    public void setRegisterDate(String registerDate) {
        this.registerDate = registerDate;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", mobile='" + mobile + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", photoUrl='" + photoUrl + '\'' +
                ", roleId=" + roleId +
                ", gender='" + gender + '\'' +
                ", registerDate='" + registerDate + '\'' +
                ", statusId=" + statusId +
                '}';
    }
}
