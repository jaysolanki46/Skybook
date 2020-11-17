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
import bean.Release;
import model.ReleaseDAO;

/**
 * Servlet implementation class ReleaseServlet
 */
@WebServlet("/version")
public class ReleaseServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private ReleaseDAO releaseDAO;
	
    public ReleaseServlet() {
    	releaseDAO = new ReleaseDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			
			Release release = new Release();
			release.setName(name);
			
			ResultSet rs = releaseDAO.insert(release);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Versions.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Versions.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Versions.jsp");
		}
	}

}
