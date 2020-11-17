package web.admin;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.Dealer;
import bean.IssueMaster;
import model.IssueMasterDAO;

/**
 * Servlet implementation class IssueMasterServlet
 */
@WebServlet("/issueMaster")
public class IssueMasterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private IssueMasterDAO issueMasterDAO;
	
    public IssueMasterServlet() {
        issueMasterDAO = new IssueMasterDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			
			IssueMaster issueMaster = new IssueMaster();
			issueMaster.setName(name);
			
			ResultSet rs = issueMasterDAO.insert(issueMaster);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Categories.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Categories.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Categories.jsp");
		}
	}

}
