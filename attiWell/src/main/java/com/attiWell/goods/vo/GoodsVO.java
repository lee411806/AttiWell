package com.attiWell.goods.vo;

import java.sql.Date;
import java.util.ArrayList;

public class GoodsVO {
	private int goods_id;
	private String goods_title;
	private int    goods_price;
	private String goods_sort;
	private int    goods_sales_price;
	private String goods_delivery_price;
	private String goods_fileName;
	private String goods_status;
	private String goods_intro;
	private Date   goods_credate;
	
	public GoodsVO() {
	}

	



	public int getGoods_id() {
		return goods_id;
	}





	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}





	public String getGoods_title() {
		return goods_title;
	}



	public void setGoods_title(String goods_title) {
		this.goods_title = goods_title;
	}


	public int getGoods_price() {
		return goods_price;
	}



	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}


	public String getGoods_sort() {
		return goods_sort;
	}

	public void setGoods_sort(String goods_sort) {
		this.goods_sort = goods_sort;
	}
	public int getGoods_sales_price() {
		return goods_sales_price;
	}

	public void setGoods_sales_price(int goods_sales_price) {
		this.goods_sales_price = goods_sales_price;
	}


	public String getGoods_delivery_price() {
		return goods_delivery_price;
	}



	public void setGoods_delivery_price(String goods_delivery_price) {
		this.goods_delivery_price = goods_delivery_price;
	}

	public String getGoods_fileName() {
		return goods_fileName;
	}

	public void setGoods_fileName(String goods_fileName) {
		this.goods_fileName = goods_fileName;
	}

	public String getGoods_status() {
		return goods_status;
	}

	public void setGoods_status(String goods_status) {
		this.goods_status = goods_status;
	}

	public String getGoods_intro() {
		return goods_intro;
	}
	public void setGoods_intro(String goods_intro) {
		this.goods_intro = goods_intro;
	}

	public Date getGoods_credate() {
		return goods_credate;
	}

	public void setGoods_credate(Date goods_credate) {
		this.goods_credate = goods_credate;
	}
	

}
