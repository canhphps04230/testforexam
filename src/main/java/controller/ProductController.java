package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import model.Product;
import model.ProductDAO;
import model.ProductHibernateDAO;
import model.ProductTypeDAO;

/**
 * Servlet implementation class ProductController
 */
@WebServlet("/ProductController")
@MultipartConfig
public class ProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductController() {
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTf-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();

		String action = request.getParameter("action");
		if (action.equals("List")) {
			List<Product> list = null;
			int pageNumber = 1;
			try {
				String page = request.getParameter("page");
				if (page != null)
					pageNumber = Integer.parseInt(page);
				String clause = request.getParameter("txtClause") != null ? request.getParameter("txtClause") : "";
				String type = request.getParameter("txtType") != null ? request.getParameter("txtType") : "";

				request.setAttribute("pageNumber",
						ProductHibernateDAO.getPage(clause, type, ProductHibernateDAO.ITEMSONPAGE));
				list = ProductHibernateDAO.listByPage(clause, type, pageNumber, ProductHibernateDAO.ITEMSONPAGE);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}
			request.setAttribute("list", list);
			request.setAttribute("page", pageNumber);
			request.getRequestDispatcher("adminproduct.jsp").forward(request, response);
		} else if (action.equals("DeleteProduct")) {
			String[] idArray = request.getParameterValues("idCheck");
			String msg = "Xóa sản phẩm không thành công!";
			String css = "warning";
			if (idArray != null) {
				boolean flag = true;
				List<Product> list = new ArrayList<>();
				for (String id : idArray) {
					ProductHibernateDAO.delete(id);
					flag = false;
					break;
				}
				if (flag) {
					msg = "Xóa sản phẩm thành công!";
					css = "success";
				}

				request.setAttribute("msg", msg);
				request.setAttribute("css", css);
			}
			doList(request, response);
		} else if (action.equals("Update")) {
			String id = request.getParameter("id");
			Product product = null;
			product = ProductHibernateDAO.getProductById(id);
			request.setAttribute("msg", null);
			request.setAttribute("product", product);
			request.setAttribute("isNew", "false");
			request.setAttribute("action", "Update Product");
			request.getRequestDispatcher("adminupdateproduct.jsp").forward(request, response);
		} else if (action.equals("Update Product")) {
			String id = request.getParameter("id");

			Product oldProduct = ProductHibernateDAO.getProductById(id);
			String name = request.getParameter("name");
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String image = request.getParameter("image");
			if (image.isEmpty())
				image = oldProduct.getImage();
			String type = request.getParameter("type");
			Product product = new Product(id, name, price, quantity, image, type);
			doUpload(request, response);
			boolean result = true;
			String msg, css;
			result = ProductHibernateDAO.update(product);
			if (result) {
				msg = "Cập nhật sản phẩm thành công!";
				css = "success";
			} else {
				msg = "Cập nhật sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
		} else if (action.equals("New")) {
			String id = request.getParameter("id");
			Product product = new Product();
			product.setId(ProductHibernateDAO.getNewId());

			request.setAttribute("msg", null);
			request.setAttribute("product", product);
			request.setAttribute("isNew", "true");
			request.setAttribute("action", "New Product");
			request.getRequestDispatcher("adminupdateproduct.jsp").forward(request, response);
		} else if (action.equals("New Product")) {
			String id = request.getParameter("pid");
			String name = request.getParameter("name");
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String image = request.getParameter("image");
			String type = request.getParameter("type");
			Product product = new Product(id, name, price, quantity, image, type);
			boolean result = true;

			result = ProductHibernateDAO.insert(product);
			String msg, css;
			if (result) {
				msg = "Thêm sản phẩm thành công!";
				css = "success";
			} else {
				msg = "Thêm sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
		} else if (action.equals("View")) {
			String id = request.getParameter("id");
			request.setAttribute("product", ProductHibernateDAO.getProductById(id));
			request.getRequestDispatcher("productdetail.jsp").forward(request, response);
		} else if (action.equals("Fetch")) {
			request.getRequestDispatcher("fetchproduct.jsp").forward(request, response);
		} else if (action.equals("Upload")) {
			doUpload(request, response);
		}
	}

	private void process(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTf-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		if (action.equals("List")) {
			List<Product> list = null;
			int pageNumber = 1;
			try {
				String page = request.getParameter("page");
				if (page != null)
					pageNumber = Integer.parseInt(page);
				String clause = request.getParameter("txtClause") != null ? request.getParameter("txtClause") : "";
				String type = request.getParameter("txtType") != null ? request.getParameter("txtType") : "";

				request.setAttribute("pageNumber",
						ProductHibernateDAO.getPage(clause, type, ProductHibernateDAO.ITEMSONPAGE));
				list = ProductHibernateDAO.listByPage(clause, type, pageNumber, ProductHibernateDAO.ITEMSONPAGE);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}
			request.setAttribute("list", list);
			request.setAttribute("page", pageNumber);
			request.getRequestDispatcher("adminproduct.jsp").forward(request, response);
		} else if (action.equals("DeleteProduct")) {
			String[] idArray = request.getParameterValues("idCheck");
			if (idArray != null) {
				ProductDAO dao = new ProductDAO();
				for (String id : idArray) {
					try {
						dao.delete(id);
					} catch (ClassNotFoundException | SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				String msg = "Xóa sản phẩm thành công!";
				request.setAttribute("msg", msg);
				request.setAttribute("css", "success");
			}
			doList(request, response);
		} else if (action.equals("Update")) {
			String id = request.getParameter("id");
			Product product = null;
			product = ProductHibernateDAO.getProductById(id);
			request.setAttribute("msg", null);
			request.setAttribute("product", product);
			request.setAttribute("isNew", "false");
			request.setAttribute("action", "Update Product");
			request.getRequestDispatcher("adminupdateproduct.jsp").forward(request, response);
		} else if (action.equals("Update Product")) {
			String id = request.getParameter("id");

			Product oldProduct = ProductHibernateDAO.getProductById(id);
			String name = request.getParameter("name");
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String image = request.getParameter("image");
			if (image.isEmpty())
				image = oldProduct.getImage();
			String type = request.getParameter("type");
			Product product = new Product(id, name, price, quantity, image, type);
			doUpload(request, response);
			boolean result = true;
			String msg, css;
			result = ProductHibernateDAO.update(product);
			if (result) {
				msg = "Cập nhật sản phẩm thành công!";
				css = "success";
			} else {
				msg = "Cập nhật sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
		} else if (action.equals("New")) {
			String id = request.getParameter("id");
			Product product = new Product();
			product.setId(ProductHibernateDAO.getNewId());

			request.setAttribute("msg", null);
			request.setAttribute("product", product);
			request.setAttribute("isNew", "true");
			request.setAttribute("action", "New Product");
			request.getRequestDispatcher("adminupdateproduct.jsp").forward(request, response);
		} else if (action.equals("New Product")) {
			String id = request.getParameter("pid");
			String name = request.getParameter("name");
			float price = Float.parseFloat(request.getParameter("price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			String image = request.getParameter("image");
			String type = request.getParameter("type");
			Product product = new Product(id, name, price, quantity, image, type);
			boolean result = true;

			result = ProductHibernateDAO.insert(product);
			String msg, css;
			if (result) {
				msg = "Thêm sản phẩm thành công!";
				css = "success";
			} else {
				msg = "Thêm sản phẩm không thành công! Dữ liệu đã được phục hồi!";
				css = "warning";
			}
			request.setAttribute("msg", msg);
			request.setAttribute("css", css);
			doList(request, response);
		} else if (action.equals("View")) {
			String id = request.getParameter("id");
			request.setAttribute("product", ProductHibernateDAO.getProductById(id));
			request.getRequestDispatcher("productdetail.jsp").forward(request, response);
		} else if (action.equals("Fetch")) {
			request.getRequestDispatcher("fetchproduct.jsp").forward(request, response);
		} else if (action.equals("Upload")) {
			doUpload(request, response);
		}
	}

	private void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		List<Product> list = null;
		int pageNumber = 1;
		try {
			String page = request.getParameter("page");
			if (page != null)
				pageNumber = Integer.parseInt(page);
			String clause = request.getParameter("txtClause") != null ? request.getParameter("txtClause") : "";
			String type = request.getParameter("txtType") != null ? request.getParameter("txtType") : "";

			request.setAttribute("pageNumber",
					ProductHibernateDAO.getPage(clause, type, ProductHibernateDAO.ITEMSONPAGE));
			list = ProductHibernateDAO.listByPage(clause, type, pageNumber, ProductHibernateDAO.ITEMSONPAGE);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("list", list);
		request.setAttribute("page", pageNumber);
		request.getRequestDispatcher("adminproduct.jsp").forward(request, response);
	}

	private void doUpload(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		PrintWriter out = response.getWriter();

		if (isMultipart) {
			FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);

			try {
				List items = upload.parseRequest(request);
				Iterator iterator = items.iterator();
				while (iterator.hasNext()) {
					FileItem item = (FileItem) iterator.next();
					if (!item.isFormField()) {
						String filename = item.getName();
						String root = getServletContext().getRealPath("/");
						File path = new File(root + "/image");
						if (!path.exists()) {
							boolean status = path.mkdirs();
						}

						File uploadFile = new File("D:" + "/" + filename);
						System.out.println(uploadFile.getAbsolutePath());
						item.write(uploadFile);
					}
				}
			} catch (FileUploadException e) {
				// TODO: handle exception
				e.printStackTrace();
				out.println(e);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}
		}
	}

}
