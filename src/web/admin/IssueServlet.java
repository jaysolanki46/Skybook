package web.admin;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.Issue;
import bean.IssueMaster;
import model.IssueDAO;

@WebServlet("/issueSolution")
public class IssueServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private IssueDAO issueDAO;
	
    public IssueServlet() {
        issueDAO = new IssueDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			String solution = request.getParameter("solution");
			String category = request.getParameter("hiddenIssueMasterID");
			
			Issue issue = new Issue();
			issue.setName(name);
			issue.setSolution(solution);

			IssueMaster master = new IssueMaster();
			master.setId(Integer.valueOf(category));
			issue.setIssueMaster(master);
			
			ResultSet rs = issueDAO.insert(issue);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/IssuesSolutions.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/IssuesSolutions.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/IssuesSolutions.jsp");
		}
	}

}
