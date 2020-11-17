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
import model.DealerDAO;

/**
 * Servlet implementation class DealerServlet
 */
@WebServlet("/dealer")
public class DealerServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private DealerDAO dealerDAO;
    
    public DealerServlet() {
        dealerDAO = new DealerDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			
			Dealer dealer = new Dealer();
			dealer.setName(name);
			
			ResultSet rs = dealerDAO.insert(dealer);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Dealers.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Dealers.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Dealers.jsp");
		}
	}
}
