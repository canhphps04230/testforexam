package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Cart;
import model.CartDAO;
import model.CartItem;
import model.Product;
import model.ProductDAO;
import model.ProductHibernateDAO;
import model.User;

/**
 * Servlet implementation class CartController
 */
@WebServlet("/CartController")
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartController() {
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
		response.setContentType("text/html; charset=UTf-8");
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		HttpSession session = request.getSession(true);
		List<CartItem> cartList = (ArrayList<CartItem>) session.getAttribute("cartList");
		if (cartList == null)
			cartList = new ArrayList<>();

		if (action.equals("Add")) {
			int quantity = 1;
			String msg = "Đặt hàng thành công";
			String id = request.getParameter("id");
			Product storedProduct = ProductHibernateDAO.getProductById(id);

			if (storedProduct.getQuantity() > 0) {
				String quantityStr = request.getParameter("quantity") != null ? request.getParameter("quantity") : "";
				if (!quantityStr.isEmpty())
					quantity = Integer.parseInt(quantityStr);
				if (quantity > storedProduct.getQuantity())
					quantity = storedProduct.getQuantity();

				CartItem newItem = new CartItem(storedProduct, quantity);
				boolean exist = false;
				for (CartItem item : cartList) {
					if (item.getProduct().getId().equals(newItem.getProduct().getId())) {
						exist = true;
						int sum = item.getQuantity() + newItem.getQuantity();
						if (sum > storedProduct.getQuantity()) {
							sum = storedProduct.getQuantity();
							msg = "Số lượng sản phẩm không đủ! Số lượng đặt hàng đã được chuyển thành " + sum;
						}
						item.setQuantity(sum);
						cartList.set(cartList.indexOf(item), item);
					}
				}
				if (!exist)
					cartList.add(newItem);
				session.setAttribute("cartList", cartList);
			} else
				msg = "Sản phẩm không còn hàng! Đặt hàng không thành công!";
			int total = getTotal(cartList);
			float sum = getSum(cartList);
			session.setAttribute("cartTotal", total);
			request.setAttribute("cartTotal", total);
			session.setAttribute("cartSum", sum);
			request.setAttribute("cartSum", sum);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("cartmanager.jsp").forward(request, response);
		} else if (action.equals("Update")) {
			int quantity = 1;
			String msg = "Cập nhật giỏ hàng thành công";
			String id = request.getParameter("id");
			Product storedProduct = ProductHibernateDAO.getProductById(id);
			String quantityStr = request.getParameter("quantity") != null ? request.getParameter("quantity") : "";
			if (!quantityStr.isEmpty())
				quantity = Integer.parseInt(quantityStr);
			if (quantity > storedProduct.getQuantity()) {
				quantity = storedProduct.getQuantity();
				msg = "Số lượng sản phẩm không đủ! Số lượng đặt hàng đã được chuyển thành " + quantity;
			}

			CartItem newItem = new CartItem(storedProduct, quantity);
			boolean exist = false;
			for (CartItem item : cartList) {
				if (item.getProduct().getId().equals(newItem.getProduct().getId())) {
					exist = true;
					item.setQuantity(quantity);
					cartList.set(cartList.indexOf(item), item);
				}
			}
			if (!exist) {
				msg = "Cập nhật giỏ hàng không thành công";
			}
			int total = getTotal(cartList);
			float sum = getSum(cartList);
			if (cartList.isEmpty())
				cartList = null;
			session.setAttribute("cartList", cartList);
			session.setAttribute("cartTotal", total);
			request.setAttribute("cartTotal", total);
			session.setAttribute("cartSum", sum);
			request.setAttribute("cartSum", sum);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("cartmanager.jsp").forward(request, response);
		} else if (action.equals("Delete")) {
			String msg = "Xóa sản phẩm trong giỏ hàng thành công";
			String id = request.getParameter("id");

			boolean exist = false;
			int pos = -1;
			for (CartItem item : cartList) {
				if (item.getProduct().getId().equals(id)) {
					exist = true;
					pos = cartList.indexOf(item);
				}
			}
			if (exist)
				cartList.remove(pos);
			if (pos == -1) {
				msg = "Sản phẩm không còn trong giỏ hàng! Xóa không thành công!";
			}
			int total = getTotal(cartList);
			float sum = getSum(cartList);
			if (cartList.isEmpty())
				cartList = null;
			session.setAttribute("cartList", cartList);
			session.setAttribute("cartTotal", total);
			request.setAttribute("cartTotal", total);
			session.setAttribute("cartSum", sum);
			request.setAttribute("cartSum", sum);
			request.setAttribute("msg", msg);
			request.getRequestDispatcher("cartmanager.jsp").forward(request, response);
		} else if (action.equals("Order")) {
			String msg = "Thanh toán giỏ hàng thành công";
			String css = "success";
			boolean flag = true;
			String url = "cart.jsp";

			User user = (User) session.getAttribute("user");
			if (user == null) {
				msg = "Vui lòng đăng nhập để thanh toán giỏ hàng";
				css = "warning";
				flag = false;
			} else {
				if (cartList == null || cartList.isEmpty()) {
					msg = "Giỏ hàng của bạn không có sản phẩm! Vui lòng đặt mua sản phẩm!";
					url = "index.jsp";
					css = "warning";
					flag = false;
				} else {
					for (CartItem item : cartList) {
						Product storedProduct = ProductHibernateDAO.getProductById(item.getProduct().getId());
						if (item.getQuantity() > storedProduct.getQuantity()) {
							msg = "Hiện không đủ số lượng sản phẩm" + storedProduct.getName()
									+ " đặt mua! Vui lòng thanh toán sau!";
							css = "warning";
							flag = false;
							break;
						} else {
							storedProduct.setQuantity(storedProduct.getQuantity() - item.getQuantity());
						}
					}
					if (flag) {
						Cart cart = CartDAO.insert(user, cartList);
						if (cart == null) {
							msg = "Có sự cố không thể thanh toán giỏ hàng, vui lòng thử lại";
							css = "danger";
							flag = false;
						} else {
							session.setAttribute("cartList", null);
							session.setAttribute("cartTotal", null);
							session.setAttribute("cartSum", null);
							request.setAttribute("orderId", cart.getId());
							url = "vieworder.jsp";
						}
					}
				}
			}

			session.setAttribute("homeMsg", msg);
			session.setAttribute("css", css);
			request.getRequestDispatcher(url).forward(request, response);
		} else if (action.equals("List")) {
			List<Cart> list = null;
			int pageNumber = 1;
			try {
				String page = request.getParameter("page");
				if (page != null)
					pageNumber = Integer.parseInt(page);

				request.setAttribute("pageNumber", CartDAO.getPage(CartDAO.ITEMSONPAGE));
				list = CartDAO.listByPage(pageNumber, CartDAO.ITEMSONPAGE);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				out.println(e);
			}
			request.setAttribute("list", list);
			request.setAttribute("page", pageNumber);
			request.getRequestDispatcher("admincart.jsp").forward(request, response);
		} else if (action.equals("DeleteCart")) {
			String[] idArray = request.getParameterValues("idCheck");
			List<Cart> list = new ArrayList<>();
			String msg = "Xóa giỏ hàng thành công!";
			String css = "success";
			boolean flag = true;
			for (String id : idArray) {
				Cart cart = CartDAO.getCart(id);
				if (!CartDAO.delete(cart)){
					flag = false;
					break;
				}
			}
			if (!flag) {
				msg = "Xóa giỏ hàng không thành công! Dữ liệu đã được phục hồi";
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

	private int getTotal(List<CartItem> list) {
		int total = 0;
		for (CartItem item : list)
			total += item.getQuantity();
		return total;
	}

	private float getSum(List<CartItem> list) {
		int sum = 0;
		for (CartItem item : list)
			sum += item.getQuantity() * item.getProduct().getPrice();
		return sum;
	}

	private void doList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		List<Cart> list = null;
		int pageNumber = 1;
		try {
			String page = request.getParameter("page");
			if (page != null)
				pageNumber = Integer.parseInt(page);

			request.setAttribute("pageNumber", CartDAO.getPage(CartDAO.ITEMSONPAGE));
			list = CartDAO.listByPage(pageNumber, CartDAO.ITEMSONPAGE);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			out.println(e);
		}
		request.setAttribute("list", list);
		request.setAttribute("page", pageNumber);
		request.getRequestDispatcher("admincart.jsp").forward(request, response);
	}
}
