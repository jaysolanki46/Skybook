package bean;


public class Log {

	private Integer id;
	private User user;
	private String logDate;
	private String logTime;
	private Boolean isVoicemail;
	private Boolean isInstructed;
	private Dealer dealer;
	private String technician;
	private String serial;
	private Terminal terminal;
	private Release currentRelease;
	private IssueMaster issueMaster;
	private Issue issue;
	private String description;
	private String newIssue;
	private String newSolution;
	private String duration;
	private Status status;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getLogDate() {
		return logDate;
	}
	public void setLogDate(String logDate) {
		this.logDate = logDate;
	}
	public String getLogTime() {
		return logTime;
	}
	public void setLogTime(String logTime) {
		this.logTime = logTime;
	}
	public Boolean getIsVoicemail() {
		return isVoicemail;
	}
	public void setIsVoicemail(Boolean isVoicemail) {
		this.isVoicemail = isVoicemail;
	}
	public Boolean getIsInstructed() {
		return isInstructed;
	}
	public void setIsInstructed(Boolean isInstructed) {
		this.isInstructed = isInstructed;
	}
	public Dealer getDealer() {
		return dealer;
	}
	public void setDealer(Dealer dealer) {
		this.dealer = dealer;
	}
	public String getTechnician() {
		return technician;
	}
	public void setTechnician(String technician) {
		this.technician = technician;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	public Terminal getTerminal() {
		return terminal;
	}
	public void setTerminal(Terminal terminal) {
		this.terminal = terminal;
	}
	
	public Release getCurrentRelease() {
		return currentRelease;
	}
	public void setCurrentRelease(Release currentRelease) {
		this.currentRelease = currentRelease;
	}
	public IssueMaster getIssueMaster() {
		return issueMaster;
	}
	public void setIssueMaster(IssueMaster issueMaster) {
		this.issueMaster = issueMaster;
	}
	public Issue getIssue() {
		return issue;
	}
	public void setIssue(Issue issue) {
		this.issue = issue;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getNewIssue() {
		return newIssue;
	}
	public void setNewIssue(String newIssue) {
		this.newIssue = newIssue;
	}
	public String getNewSolution() {
		return newSolution;
	}
	public void setNewSolution(String newSolution) {
		this.newSolution = newSolution;
	}
	public String getDuration() {
		return duration;
	}
	public void setDuration(String duration) {
		this.duration = duration;
	}
	public Status getStatus() {
		return status;
	}
	public void setStatus(Status status) {
		this.status = status;
	}
}
