package bean;

public class FollowUp {

	private Integer id;
	private String followUpDate;
	private String followUpTime;
	private String followUpContact;
	private String note;
	private Boolean status;
	private Log log;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getFollowUpDate() {
		return followUpDate;
	}
	public void setFollowUpDate(String followUpDate) {
		this.followUpDate = followUpDate;
	}
	public String getFollowUpTime() {
		return followUpTime;
	}
	public void setFollowUpTime(String followUpTime) {
		this.followUpTime = followUpTime;
	}
	public String getFollowUpContact() {
		return followUpContact;
	}
	public void setFollowUpContact(String followUpContact) {
		this.followUpContact = followUpContact;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Boolean getStatus() {
		return status;
	}
	public void setStatus(Boolean status) {
		this.status = status;
	}
	public Log getLog() {
		return log;
	}
	public void setLog(Log log) {
		this.log = log;
	}
}
