package web.admin;

import java.io.IOException;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bean.User;
import model.LoginDAO;

/**
 * Servlet implementation class admin
 */
@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDao;
	
	public void init() {
        loginDao = new LoginDAO();
    }
	
    public AdminServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User();
        user.setName(username);
        user.setPass(password);
        
        
        try {
        	
        	ResultSet rs = loginDao.validateAdmin(user);
        	
            if (rs.next()) {
            	session.setAttribute("adminUserID",rs.getString("id"));
                session.setAttribute("adminUserName",rs.getString("name"));
                session.setAttribute("adminUserEmail",rs.getString("email"));
                
                response.sendRedirect("View/Admin/Dashboard.jsp");
            } else {
            	
            	response.getWriter().write("<html><body><script>alert('Invalid username or password!')</script></body></html>");
            	RequestDispatcher rd = request.getRequestDispatcher("View/login.jsp");
            	rd.include(request, response);
            	
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}

}
