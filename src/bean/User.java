package bean;

public class User {

	private Integer id;
	private String name;
	private String pass;
	private String email;
	private boolean is_admin;
	private boolean is_support;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public boolean isIs_admin() {
		return is_admin;
	}
	public void setIs_admin(boolean is_admin) {
		this.is_admin = is_admin;
	}
	public boolean isIs_support() {
		return is_support;
	}
	public void setIs_support(boolean is_support) {
		this.is_support = is_support;
	}
}
