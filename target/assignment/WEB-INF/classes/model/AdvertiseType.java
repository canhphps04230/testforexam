package model;

import java.util.HashSet;
import java.util.Set;

public class AdvertiseType {
	private String id, name;
	private Set<Advertise> advertises = new HashSet<Advertise>(0);
	
	public AdvertiseType() {
		// TODO Auto-generated constructor stub
	}

	public AdvertiseType(String id, String name) {
		this.id = id;
		this.name = name;
	}

	public AdvertiseType(String id, String name, Set<Advertise> advertises) {
		this.id = id;
		this.name = name;
		this.advertises = advertises;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<Advertise> getAdvertises() {
		return advertises;
	}

	public void setAdvertises(Set<Advertise> advertises) {
		this.advertises = advertises;
	}
	
	
}
