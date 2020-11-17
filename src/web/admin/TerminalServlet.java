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
import bean.Terminal;
import model.TerminalDAO;

/**
 * Servlet implementation class TerminalServlet
 */
@WebServlet("/terminal")
public class TerminalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private TerminalDAO terminalDAO;   
	
    public TerminalServlet() {
    	terminalDAO = new TerminalDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession status = request.getSession();
		
		try {
			
			String name = request.getParameter("name");
			
			Terminal terminal = new Terminal();
			terminal.setName(name);
			
			ResultSet rs = terminalDAO.insert(terminal);
			
			if(rs != null && rs.next()) {
				status.setAttribute("status", "success");
	    		response.sendRedirect("View/Admin/Terminals.jsp");
			} else {
				status.setAttribute("status", "error");
	    		response.sendRedirect("View/Admin/Terminals.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			status.setAttribute("status", "error");
    		response.sendRedirect("View/Admin/Terminals.jsp");
		}
	}
}
