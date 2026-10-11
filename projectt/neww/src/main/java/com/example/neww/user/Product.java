package com.example.neww.user;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Lob;

@Entity
public class Product {
@Id
@Column(name="ProductId",nullable=false,unique=true)
private int id;
@Column(name="ProductName",nullable=false)
private String name;
private int price;
private String category;
@Lob
@Column(columnDefinition = "LONGBLOB")
private byte[] image;
public Product(){
	}
public Product(int id,String name,int price,byte[] image,String category) {
	
	this.id=id;
	this.name=name;
	this.price=price;
	this.image=image;
	this.category=category;
	
}
public void setId(int id) {
	this.id=id;
}
public int getId() {
	return id;
}
public void setName(String name) {
	this.name=name;
}
public String getName() {
	return name;
}
public void setPrice(int price) {
	this.price=price;
}
public int getPrice() {
	return price;
}
public void setCategory(String category) {
	this.category=category;
}
public String getCategory() {
	return category;
}
public void setImage(byte[] image) {
	this.image=image;
}
public byte[] getImage() {
	return image;
}
}
