package jsu.secondshop.models;

import java.util.List;

/**
 * 一级分类表
 * 
 * @author WEN
 *
 */
public class FirstType {
	private int id;
	private String name;

	public FirstType() {
	}

	public FirstType(int id, String name) {
		this.id = id;
		this.name = name;
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

}