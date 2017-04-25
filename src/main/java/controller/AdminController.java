package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductDAO;

/**
 * Servlet implementation class AdminController
 */
@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @throws IOException
	 * @throws ServletException
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		try {
			String action = request.getParameter("action");
			String url = "admin.jsp";
			if (action.equals("product")) {
				RequestDispatcher rd = request.getRequestDispatcher(url);
				rd.forward(request, response);
//			} else if (action.equals("DeleteProduct")) {
//				String[] idList = request.getParameterValues("idCheck");
//				if (idList != null) {
//					ProductDAO dao = new ProductDAO();
//					try {
//						for (String id : idList) {
//							dao.delete(id);
//						}
//					} catch (SQLException | ClassNotFoundException e) {
//						out.println(e);
//					}
//				}
//				url = "AdminController?action=Product";
//				RequestDispatcher rd = request.getRequestDispatcher(url);
//				rd.forward(request, response);
			}
		} catch (Exception e) {
			out.println(e);
		}
	}

	/**
	 * @throws IOException
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// TODO Auto-generated method stub
		try {
			String action = request.getParameter("action");
			String url = "admin.jsp";
			if (action.equals("product")) {
				response.sendRedirect(url+"?action=" +action);
//			} else if (action.equals("DeleteProduct")) {
//				String[] idList = request.getParameterValues("idCheck");
//				if (idList != null) {
//					ProductDAO dao = new ProductDAO();
//					try {
//						for (String id : idList) {
//							dao.delete(id);
//						}
//					} catch (SQLException | ClassNotFoundException e) {
//						out.println(e);
//					}
//				}
//				request.setAttribute("idCheck", null);
//				url = "AdminController?action=Product";
//				RequestDispatcher rd = request.getRequestDispatcher(url);
//				rd.forward(request, response);
			}
		} catch (Exception e) {
			//out.println(e);
		}
	}

}
