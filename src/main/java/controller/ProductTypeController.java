package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductType;
import model.ProductTypeDAO;

/**
 * Servlet implementation class UserController
 */
@WebServlet("/ProductTypeController")
public class ProductTypeController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductTypeController() {
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
		if (action.equals("List")) {
			List<ProductType> list = null;
			int pageNumber = 1;
			try {
				String page = request.getParameter("page");
				if (page != null)
					pageNumber = Integer.parseInt(page);
				String clause = request.getParameter("txtClause") != null ? request.getParameter("txtClause") : "";

				request.setAttribute("pageNumber", ProductTypeDAO.getPage(clause, ProductTypeDAO.ITEMSONPAGE));
				list = ProductTypeDAO.listByPage(clause, pageNumber, ProductTypeDAO.ITEMSONPAGE);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}

			request.setAttribute("list", list);
			request.setAttribute("page", pageNumber);
			request.getRequestDispatcher("adminproducttype.jsp").forward(request, response);
		} else if (action.equals("Delete")) {
			String[] idArray = request.getParameterValues("idCheck");
			String msg = "Xóa loại sản phẩm thành công!";
			String css = "success";
			if (idArray != null) {
				for (String id : idArray) {
					if (!ProductTypeDAO.delete(id)) {
						msg = "Xóa loại sản phẩm không thành công! Dữ liệu đã được phục hồi!";
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
			ProductType productType = null;
			productType = ProductTypeDAO.getProductTypeById(id);

			request.setAttribute("msg", null);
			request.setAttribute("productType", productType);
			request.setAttribute("isNew", "false");
			request.setAttribute("action", "Update Product Type");
			request.getRequestDispatcher("adminupdateproducttype.jsp").forward(request, response);
		} else if (action.equals("Update Product Type")) {
			String id = request.getParameter("id");

			String name = request.getParameter("name");
			ProductType productType = new ProductType(id, name);
			boolean result = true;
			String msg, css;
			result = ProductTypeDAO.update(productType);
			if (result) {
				msg = "Cập nhật loại sản phẩm thành công!!";
				css = "success";
			} else {
				msg = "Cập nhật loại sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
		} else if (action.equals("New")) {
			ProductType productType = new ProductType();
			productType.setId(ProductTypeDAO.getNewId());

			request.setAttribute("msg", null);
			request.setAttribute("productType", productType);
			request.setAttribute("isNew", "true");
			request.setAttribute("action", "New Product Type");
			request.getRequestDispatcher("adminupdateproducttype.jsp").forward(request, response);
		} else if (action.equals("New Product Type")) {
			String id = request.getParameter("uid");
			String name = request.getParameter("name");
			ProductType productType = new ProductType(id, name);
			boolean result = true;

			result = ProductTypeDAO.insert(productType);
			String msg, css;
			if (result) {
				msg = "Thêm loại sản phẩm thành công!!";
				css = "success";
			} else {
				msg = "Thêm loại sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
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
		List<ProductType> list = null;
		int pageNumber = 1;
		try {
			String page = request.getParameter("page");
			if (page != null)
				pageNumber = Integer.parseInt(page);
			String clause = request.getParameter("txtClause") != null ? request.getParameter("txtClause") : "";

			request.setAttribute("pageNumber", ProductTypeDAO.getPage(clause, ProductTypeDAO.ITEMSONPAGE));
			list = ProductTypeDAO.listByPage(clause, pageNumber, ProductTypeDAO.ITEMSONPAGE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		request.setAttribute("list", list);
		request.setAttribute("page", pageNumber);
		request.getRequestDispatcher("adminproducttype.jsp").forward(request, response);
	}

}
