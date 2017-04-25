package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Product;
import model.ProductDAO;
import model.ProductHibernateDAO;
import model.ProductType;
import model.ProductTypeDAO;
import model.User;
import model.UserDAO;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action.equals("Login")) {
			String email = request.getParameter("txtEmail");
			String password = request.getParameter("txtPassword");

			try {
				String msg = "Đăng nhập thành công";
				String css = "success";
				HttpSession session = request.getSession(true);
				String url = "index.jsp";
				boolean admin= false;
				if (UserDAO.isUser(email, password)) {
					User user = UserDAO.getUser(email);
					session.setAttribute("user", user);
					if (user.getAdmin()){
						url = "admin.jsp";
						msg = "Đăng nhập quản trị thành công";
						session.setAttribute("msg", msg);
						admin = true;
					}
				} else {
					msg = "Email hoặc mật khẩu không đúng!";
					css = "warning";
				}
				if (!admin)
					session.setAttribute("homeMsg", msg);
				session.setAttribute("css", css);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				out.println(e);
			}
		}
		if (action.equals("LoginAdmin")) {
			String email = request.getParameter("txtEmail");
			String password = request.getParameter("txtPassword");
			String msg = "Đăng nhập quản trị thành công!";
			String css = "success";
			try {
				if (UserDAO.isUser(email, password)) {
					User user = UserDAO.getUser(email);
					HttpSession session = request.getSession(true);
					if (user.getAdmin()) {
						session.setAttribute("user", user);
					} else {
						msg = "Không phải tài khoản quản trị!";
						css = "warning";
					}
				} else {
					msg = "Email hoặc mật khẩu không đúng!";
					css = "warning";
				}
				HttpSession session = request.getSession();
				session.setAttribute("msg", msg);
				session.setAttribute("css", css);
				request.getRequestDispatcher("admin.jsp").forward(request, response);
			} catch (Exception e) {
				out.println(e);
			}
		} else if (action.equals("Register")) {
			try {
				String id = UserDAO.getNewId();
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String name = request.getParameter("name");
				boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
				Date birthday = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("birthday"));
				User user = new User(id, email, password, name, birthday, gender);
				boolean result = true;

				result = UserDAO.insert(user);
				String msg, css;
				if (result) {
					msg = "Đăng ký người dùng thành công!";
					css = "success";
				} else {
					msg = "Đăng ký người dùng không thành công!";
					css = "warning";
				}
				String url = "index.jsp";
				HttpSession session = request.getSession();
				session.setAttribute("homeMsg", msg);
				session.setAttribute("css", css);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (ParseException e) {
				out.println(e);
			}
		} else if (action.equals("Logout")) {
			HttpSession session = request.getSession();
			User user = (User) session.getAttribute("user");
			if (user != null) {
				session.setAttribute("user", null);
			}
			session.setAttribute("homeMsg", "Đã đăng xuất tài khoản");
			session.setAttribute("css", "info");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		} else if (action.equals("List")) {
			List<User> list = null;
			int pageNumber = 1;
			try {
				String page = request.getParameter("page");
				if (page != null)
					pageNumber = Integer.parseInt(page);
				String clause = request.getParameter("txtClause");

				list = UserDAO.listByPage(clause, pageNumber, UserDAO.ITEMSONPAGE);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}
			request.setAttribute("list", list);
			request.setAttribute("page", pageNumber);
			request.getRequestDispatcher("adminuser.jsp").forward(request, response);
		} else if (action.equals("DeleteUser")) {
			String[] idArray = request.getParameterValues("idCheck");
			String msg = "Xóa người dùng thành công!";
			String css = "success";
			if (idArray != null) {
				UserDAO dao = new UserDAO();
				for (String id : idArray) {
					if (!UserDAO.delete(id)) {
						msg = "Xóa người dùng không thành công! Dữ liệu đã được phục hồi!";
						css = "warning";
						break;
					}
				}

				request.setAttribute("msg", msg);
				request.setAttribute("css", css);
			}
			doList(request, response);
		} else if (action.equals("Update")) {
			String id = request.getParameter("id");
			User user = null;
			user = UserDAO.getUserById(id);
			request.setAttribute("user", user);
			request.setAttribute("isNew", "false");
			request.setAttribute("action", "Update User");
			request.getRequestDispatcher("adminupdateuser.jsp").forward(request, response);
		} else if (action.equals("Update User")) {
			String id = request.getParameter("id");

			try {
				// User user = UserDAO.getUserById(id);
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String name = request.getParameter("name");
				boolean gender = request.getParameter("gender").equals("true") ? true : false;
				Date birthday = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("birthday"));
				boolean admin = request.getParameter("admin").equals("true") ? true : false;

				User user = new User(id, email, password, name, birthday, gender, admin);
				boolean result = true;
				String msg, css;
				result = UserDAO.update(user);
				if (result) {
					msg = "Cập nhật người dùng thành công!";
					css = "success";
				} else {
					msg = "Cập nhật người dùng không thành công! Dữ liệu đã được phục hồi";
					css = "warning";
				}
				request.setAttribute("msg", msg);
				request.setAttribute("css", css);
				doList(request, response);
			} catch (ParseException e) {
				out.println(e);
				e.printStackTrace();
			}
		} else if (action.equals("New")) {
			User user = new User();
			user.setId(UserDAO.getNewId());
			request.setAttribute("user", user);
			request.setAttribute("isNew", "true");
			request.setAttribute("action", "New User");
			request.getRequestDispatcher("adminupdateuser.jsp").forward(request, response);
		} else if (action.equals("New User")) {
			try {
				String id = request.getParameter("uid");
				String email = request.getParameter("email");
				String password = request.getParameter("password");
				String name = request.getParameter("name");
				boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
				Date birthday = new SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("birthday"));
				boolean admin = Boolean.parseBoolean(request.getParameter("admin"));
				User user = new User(id, email, password, name, birthday, gender, admin);
				boolean result = true;

				result = UserDAO.insert(user);
				String msg, css;
				if (result) {
					msg = "Thêm người dùng thành công!";
					css = "success";
				} else {
					msg = "Thêm người dùng không thành công!";
					css = "warning";
				}
				request.setAttribute("msg", msg);
				request.setAttribute("css", css);
				doList(request, response);
			} catch (ParseException e) {
				out.println(e);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		List<User> list = null;
		int pageNumber = 1;

		try {
			String page = request.getParameter("page");
			if (page != null)
				pageNumber = Integer.parseInt(page);
			String clause = request.getParameter("txtClause");

			request.setAttribute("pageNumber", UserDAO.getPage(clause, UserDAO.ITEMSONPAGE));
			list = UserDAO.listByPage(clause, pageNumber, UserDAO.ITEMSONPAGE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("list", list);
		request.setAttribute("page", pageNumber);
		request.getRequestDispatcher("adminuser.jsp").forward(request, response);
	}

}
