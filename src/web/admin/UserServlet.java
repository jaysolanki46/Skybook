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
import bean.User;
import model.UserDAO;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/user")
public class UserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    HttpSession status;
    User user;
	
    public UserServlet() {
        userDAO = new UserDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			
			status = request.getSession();
			
			String id = request.getParameter("id");
			
			user = new User();
			user.setId(Integer.valueOf(id));
			
			ResultSet rs = userDAO.delete(user);
			
			if(rs != null) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Users.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Users.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Users.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String pass = request.getParameter("pass");
			String isAdmin = request.getParameter("isAdmin");
			String isSupport = request.getParameter("isSupport");
			
			user = new User();
			user.setName(name);
			user.setEmail(email);
			user.setPass(pass);
			if(isAdmin != null) user.setIs_admin(true);
			if(isSupport != null) user.setIs_support(true);
			
			ResultSet rs = userDAO.insert(user);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Users.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Users.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Users.jsp");
		}
	}
}
