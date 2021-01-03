package jsu.secondshop.models;

import java.text.SimpleDateFormat;

/**
 * 物品表
 *
 * @author WEN
 */
public class Good {
    private int id;
    private String name;
    private String photoUrl;
    private int firstTypeId;
    private FirstType firstType;
    private String description;
    private String uploadDate;
    private float prise;
    private int statusId;
    private int userId;
    private User goodUser;
    private String goodUpdate;

    public Good() {    }

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

    public String getPhotoUrl() {
        return photoUrl;
    }

    public void setPhotoUrl(String photoUrl) {
        this.photoUrl = photoUrl;
    }

    public int getFirstTypeId() {
        return firstTypeId;
    }

    public void setFirstTypeId(int firstTypeId) {
        this.firstTypeId = firstTypeId;
    }

    public FirstType getFirstType() {
        return firstType;
    }

    public void setFirstType(FirstType firstType) {
        this.firstType = firstType;
    }

    public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(String uploadDate) {
        this.uploadDate = uploadDate;
    }

    public float getPrise() {
        return prise;
    }

    public void setPrise(float prise) {
        this.prise = prise;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public User getGoodUser() {
        return goodUser;
    }

    public void setGoodUser(User goodUser) {
        this.goodUser = goodUser;
    }

	public String getGoodUpdate() {
		return goodUpdate;
	}

	public void setGoodUpdate(String goodUpdate) {
		this.goodUpdate = goodUpdate;
	}
}
