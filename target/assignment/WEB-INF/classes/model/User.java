package model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

public class User {
	private String id;
	private String email;
	private String password;
	private String name;
	private Date birthday;
	private boolean gender;
	private boolean admin;
	private Set<Cart> carts = new HashSet<Cart>(0);

	public User() {

	}

	public User(String id, String email, String name, boolean gender) {
		super();
		this.id = id;
		this.email = email;
		this.name = name;
		this.gender = gender;
	}

	public User(String id, String email, String password, String name, Date birthday, boolean gender) {
		this.id = id;
		this.email = email;
		this.password = password;
		this.name = name;
		this.birthday = birthday;
		this.gender = gender;
		this.admin = false;
	}

	public User(String id, String email, String password, String name, Date birthday, boolean gender, boolean admin) {
		this.id = id;
		this.email = email;
		this.password = password;
		this.name = name;
		this.birthday = birthday;
		this.gender = gender;
		this.admin = admin;
	}

	public User(String id, String email, String password, String name, Date birthday, boolean gender, Set<Cart> carts) {
		this.id = id;
		this.email = email;
		this.password = password;
		this.name = name;
		this.birthday = birthday;
		this.gender = gender;
		this.carts = carts;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public boolean getGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public Set<Cart> getCarts() {
		return carts;
	}

	public void setCarts(Set<Cart> carts) {
		this.carts = carts;
	}

}
