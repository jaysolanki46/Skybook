package web;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.util.StringUtils;

import bean.Dealer;
import bean.FollowUp;
import bean.Issue;
import bean.IssueMaster;
import bean.Log;
import bean.Release;
import bean.Status;
import bean.Terminal;
import bean.User;
import config.SendFollowUpNotificationEmail;
import model.FollowUpDAO;
import model.LogDAO;

/**
 * Servlet implementation class BookServlet
 */
@WebServlet("/book")
public class BookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LogDAO logDao;
	private FollowUpDAO followUpDAO;
	
    public BookServlet() {
    	logDao = new LogDAO();
		followUpDAO = new FollowUpDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String logID = request.getParameter("hiddenLogID");
		
		if(logID == null) {
			insertLog(request, response);
		} else { 
			updateLog(request, response);
		}
		
	}
	
	private void insertLog(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession insertStatus = request.getSession();
		String userID =  request.getParameter("user");
		String userName =  request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		
		String date =  LocalDate.now().toString();
		String time =  request.getParameter("time");
		String[] isVoicemail = request.getParameterValues("isVoicemail");
		String[] isInstructed = request.getParameterValues("isInstructed");
		String dealerID =  request.getParameter("hiddenDealerID");
		String technician =  request.getParameter("technician");
		String serial =  request.getParameter("serial");
		String terminalID =  request.getParameter("terminal");
		String releaseID =  request.getParameter("release");
		String issueMasterID =  request.getParameter("hiddenIssueMasterID");
		String issueID =  request.getParameter("hiddenIssueID");
		String description =  request.getParameter("description");
		String newIssue =  request.getParameter("newIssue");
		String newSolution =  request.getParameter("newSolution");
		String statusID =  request.getParameter("status");
		String[] isFollowUp = request.getParameterValues("isFollowUp");
		
		String followUpDate = request.getParameter("followUpDate");
		String followUpTime = request.getParameter("followUpTime");
		String followUpContact = request.getParameter("followUpContact");
		String followUpNote = request.getParameter("followUpNote");
		
		User user = new User();
		user.setId(Integer.parseInt(userID));
		
		Dealer dealer = new Dealer();
		dealer.setId(Integer.parseInt(dealerID));
		
		IssueMaster issueMaster = new IssueMaster();
		issueMaster.setId(Integer.parseInt(issueMasterID));
		
		Issue issue = new Issue();
		issue.setId(Integer.parseInt(issueID));

		Status status = new Status();
		status.setId(Integer.parseInt(statusID));
		
		Log log = new Log();
		log.setUser(user);
		log.setLogDate(date);
		log.setLogTime(time);
		
		if(isVoicemail == null) {
			log.setIsVoicemail(false);
		} else {
			log.setIsVoicemail(true);
		}
		
		if(isInstructed == null) {
			log.setIsInstructed(false);
		} else {
			log.setIsInstructed(true);
		}
		
		log.setDealer(dealer);
		log.setTechnician(technician);
		log.setSerial(serial);
		
		if(!terminalID.equals("0")) {
			Terminal terminal = new Terminal();
			terminal.setId(Integer.parseInt(terminalID));
			log.setTerminal(terminal);
		}
		
		if(!releaseID.equals("0")) {
			Release release = new Release();
			release.setId(Integer.parseInt(releaseID));
			log.setCurrentRelease(release);
		}
		
		
		log.setIssueMaster(issueMaster);
		log.setIssue(issue);
		log.setDescription(description);
		log.setNewIssue(newIssue);
		log.setNewSolution(newSolution);
		log.setStatus(status);
		
		
		try {

			int last_inserted_id = 0;
			
			ResultSet logRS = logDao.insert(log);
			if(logRS != null && logRS.next()) {
				
                last_inserted_id = logRS.getInt(1);
                log.setId(last_inserted_id);
                
                
                if(isFollowUp != null) {
    				
    				FollowUp followUp = new FollowUp();
    				followUp.setFollowUpDate(followUpDate);
    				followUp.setFollowUpTime(followUpTime);
    				followUp.setFollowUpContact(followUpContact);
    				followUp.setNote(followUpNote);
    				followUp.setStatus(false);
    				followUp.setLog(log);
    				
    				ResultSet FollowRS = followUpDAO.insert(followUp);
    				
    				if(FollowRS != null && FollowRS.next())
    	            {
    					String last_follow_up_id = FollowRS.getString(1);
    					String followUpBody = "<html><body><h3>Contact: "+ followUpContact +"</h3><h4>"+ followUpNote +"</h4></body></html>";
    					new SendFollowUpNotificationEmail(userEmail, userEmail, userName, last_follow_up_id,  "Follow Up SBT - " + last_follow_up_id ,followUpDate.replace("-", ""), followUpTime.replace(":", ""), followUpBody);
        				
    					insertStatus.setAttribute("insertStatus", "success");
    		    		response.sendRedirect("View/Index.jsp");
    	            } else {
    	            	insertStatus.setAttribute("insertStatus", "error");
    	        		response.sendRedirect("View/Index.jsp");
    	            }
    			} else {
    				insertStatus.setAttribute("insertStatus", "success");
    	    		response.sendRedirect("View/Index.jsp");
    			}
                
            } else {
            	insertStatus.setAttribute("insertStatus", "error");
        		response.sendRedirect("View/Index.jsp");
            }
			
        } catch (Exception e) {
        	e.printStackTrace();
        	insertStatus.setAttribute("insertStatus", "error");
    		response.sendRedirect("View/Index.jsp");
        }
	}

	private void updateLog(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession updateStatus = request.getSession();
		String userID =  request.getParameter("user");
		String userName =  request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		
		String redirectPage = request.getParameter("hiddenRedirectPage");
		String logID = request.getParameter("hiddenLogID");
		String description =  request.getParameter("description");
		String newIssue =  request.getParameter("newIssue");
		String newSolution =  request.getParameter("newSolution");
		String statusID =  request.getParameter("status");
		String[] isFollowUp = request.getParameterValues("isFollowUp");
		String followUpID = request.getParameter("hiddenFollowUpID");
		String followUpDate = request.getParameter("followUpDate");
		String oldFollowUpTime = request.getParameter("hiddenFollowUpTime"); // Update in viuew
		String followUpTime = request.getParameter("followUpTime");
		String followUpContact = request.getParameter("followUpContact");
		String followUpNote = request.getParameter("followUpNote");
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");  
		LocalDateTime now = LocalDateTime.now();  
		
		try {
			Status status = new Status();
			status.setId(Integer.parseInt(statusID));
			
			User user = new User();
			user.setId(Integer.parseInt(userID));
			
			Log log = new Log();
			log.setId(Integer.parseInt(logID));
			log.setDescription(description);
			log.setNewIssue(newIssue);
			log.setNewSolution(newSolution);
			log.setStatus(status);
			Boolean isLogUpdated = logDao.update(log);
			
			FollowUp followUp = new FollowUp();
			if(!followUpID.equals("null") && followUpID != null) {
				followUp.setId(Integer.parseInt(followUpID));
			}
			
			followUp.setFollowUpDate(followUpDate);
			followUp.setFollowUpTime(followUpTime);
			followUp.setFollowUpContact(followUpContact);
			followUp.setNote(followUpNote);
			followUp.setUpdatedBy(user);
			followUp.setUpdatedOn(dtf.format(now));
			followUp.setLog(log);
			
			if(statusID.equals("1")) {
				followUp.setStatus(true);
			} else {
				followUp.setStatus(false);
			}
			if(followUp.getId() != null) {
				followUpDAO.update(followUp);
				
				if(oldFollowUpTime != null && oldFollowUpTime != "") {
					if(oldFollowUpTime != followUpTime && !oldFollowUpTime.equals(followUpTime)) {
						String followUpBody = "<html><body><h3>Contact: "+ followUpContact +"</h3><h4>"+ followUpNote +"</h4></body></html>";
						new SendFollowUpNotificationEmail(userEmail, userEmail, userName, followUpID,  "Follow Up SBT - " + followUpID ,followUpDate.replace("-", ""), followUpTime.replace(":", ""), followUpBody);
					}
					
				}
				
			} else if(isFollowUp != null) {
				ResultSet FollowRS = followUpDAO.insert(followUp);
				
				if(FollowRS != null && FollowRS.next())
	            {
					String last_follow_up_id = FollowRS.getString(1);
					String followUpBody = "<html><body><h3>Contact: "+ followUpContact +"</h3><h4>"+ followUpNote +"</h4></body></html>";
					new SendFollowUpNotificationEmail(userEmail, userEmail, userName, last_follow_up_id,  "Follow Up SBT - " + last_follow_up_id ,followUpDate.replace("-", ""), followUpTime.replace(":", ""), followUpBody);
	            }
			}
			
			if(isLogUpdated) {
				
				if(redirectPage != null) {
					updateStatus.setAttribute("updateStatus", "success");
		    		response.sendRedirect("View/" + redirectPage + "?log=" + log.getId());
				} else {
					if(statusID.equals("1")) {
						updateStatus.setAttribute("updateStatus", "success");
			    		response.sendRedirect("View/CompletedTickets.jsp");
					} else {
						updateStatus.setAttribute("updateStatus", "success");
			    		response.sendRedirect("View/AwaitingTickets.jsp");
					}
				}
			} else {
				updateStatus.setAttribute("updateStatus", "error");
	    		response.sendRedirect("View/TicketDetails.jsp?log=" + logID);
			}
    		
		} catch (Exception e) {
			e.printStackTrace();
			updateStatus.setAttribute("updateStatus", "error");
    		response.sendRedirect("View/TicketDetails.jsp?log=" + logID);
		}
		
	}
}
