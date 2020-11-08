package web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import bean.User;
import model.LoginDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private LoginDAO loginDao;
	
	public void init() {
        loginDao = new LoginDAO();
    }

    public LoginServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User();
        user.setName(username);
        user.setPass(password);
        
        
        try {
        	
        	ResultSet rs = loginDao.validate(user);
        	
            if (rs.next()) {
            	session.setAttribute("userID",rs.getString("id"));
                session.setAttribute("username",username);
                
                response.sendRedirect("View/Index.jsp");
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
