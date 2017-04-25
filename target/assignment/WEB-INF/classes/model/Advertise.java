package model;

import java.io.Serializable;
import java.util.Date;

public class Advertise implements Serializable {
	private String id, prodTypeId, image;
	private Date dateAdd;
	private AdvertiseType advertiseType; 

	public Advertise() {
		// TODO Auto-generated constructor stub
	}

	public Advertise(String id, String prodTypeId, String image, Date dateAdd) {
		this.id = id;
		this.prodTypeId = prodTypeId;
		this.image = image;
		this.dateAdd = dateAdd;
	}

	public Advertise(String id, String prodTypeId, String image, Date dateAdd, AdvertiseType advertiseType) {
		this.id = id;
		this.prodTypeId = prodTypeId;
		this.image = image;
		this.dateAdd = dateAdd;
		this.advertiseType = advertiseType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProdTypeId() {
		return prodTypeId;
	}

	public void setProdTypeId(String prodTypeId) {
		this.prodTypeId = prodTypeId;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Date getDateAdd() {
		return dateAdd;
	}

	public void setDateAdd(Date dateAdd) {
		this.dateAdd = dateAdd;
	}

	public AdvertiseType getAdvertiseType() {
		return advertiseType;
	}

	public void setAdvertiseType(AdvertiseType advertiseType) {
		this.advertiseType = advertiseType;
	}

}
