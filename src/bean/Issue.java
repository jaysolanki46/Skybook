package bean;

public class Issue {

	private Integer id;
	private String name;
	private String solution;
	private IssueMaster issueMaster;
	
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
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
	public IssueMaster getIssueMaster() {
		return issueMaster;
	}
	public void setIssueMaster(IssueMaster issueMaster) {
		this.issueMaster = issueMaster;
	}
}
