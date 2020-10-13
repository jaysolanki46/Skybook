package web;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sun.org.apache.xalan.internal.xsltc.compiler.sym;

import bean.Dealer;
import bean.DealerTechnician;
import bean.FollowUp;
import bean.Issue;
import bean.IssueMaster;
import bean.Log;
import bean.Status;
import bean.Terminal;
import bean.User;
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
    	try {
    		logDao = new LogDAO();
    		followUpDAO = new FollowUpDAO();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession insertStatus = request.getSession();
		String userID =  request.getParameter("user");
		String date =  LocalDate.now().toString();
		String time =  request.getParameter("time");
		String[] isVoicemail = request.getParameterValues("isVoicemail");
		String[] isInstructed = request.getParameterValues("isInstructed");
		String dealerID =  request.getParameter("hiddenDealerID");
		String dealerTechnicianID =  request.getParameter("hiddenDealerTechnicianID");
		String serial =  request.getParameter("serial");
		String terminalID =  request.getParameter("terminal");
		String issueMasterID =  request.getParameter("hiddenIssueMasterID");
		String issueID =  request.getParameter("hiddenIssueID");
		String description =  request.getParameter("description");
		String newIssue =  request.getParameter("newIssue");
		String newSolution =  request.getParameter("newSolution");
		String statusID =  request.getParameter("status");
		String[] isFollowUp = request.getParameterValues("isFollowUp");
		
		String followUpDate = request.getParameter("followUpDate");
		String followUpTime = request.getParameter("followUpTime");
		String followUpNote = request.getParameter("followUpNote");
		
		User user = new User();
		user.setId(Integer.parseInt(userID));
		
		Dealer dealer = new Dealer();
		dealer.setId(Integer.parseInt(dealerID));
		
		DealerTechnician dealerTechnician = new DealerTechnician();
		dealerTechnician.setId(Integer.parseInt(dealerTechnicianID));
		
		Terminal terminal = new Terminal();
		terminal.setId(Integer.parseInt(terminalID));
		
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
		log.setDealerTechnician(dealerTechnician);
		log.setSerial(serial);
		log.setTerminal(terminal);
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
    				followUp.setNote(followUpNote);
    				followUp.setStatus(false);
    				followUp.setLog(log);
    				
    				ResultSet FollowRS = followUpDAO.insert(followUp);
    				if(FollowRS != null && FollowRS.next())
    	            {
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
}
