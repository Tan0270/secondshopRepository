package jsu.secondshop.servlet;

import jsu.secondshop.dao.FirstTypeDAO;
import jsu.secondshop.dao.GoodDAO;
import jsu.secondshop.dao.OrderDAO;
import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.FirstType;
import jsu.secondshop.models.Good;
import jsu.secondshop.models.Order;
import jsu.secondshop.models.User;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

@WebServlet(urlPatterns = "/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=utf-8");
        HttpSession session = request.getSession();

        String method = request.getParameter("method");

        UserDAO dao = new UserDAO();
        PrintWriter out = response.getWriter();
        if (method.equals("delete")) {
            List<User> list = (List<User>) session.getAttribute("userList");
            Iterator<User> it = list.iterator();
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            boolean data = dao.daleteUser(id);
            while (it.hasNext()) {
                User delete = it.next();
                if (delete.getId() == id) {
                    it.remove();
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("enableUserStatus")){
            List<User> list = (List<User>) session.getAttribute("userList");
            Iterator<User> it = list.iterator();
            String userIdStr=request.getParameter("userId");
            int userId=Integer.parseInt(userIdStr);
            boolean data=dao.updateUserStatus(4,userId);
            while (it.hasNext()) {
                User setStatus = it.next();
                if (setStatus.getId() == userId) {
                    setStatus.setStatusId(4);
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("disableUserStatus")){
            List<User> list = (List<User>) session.getAttribute("userList");
            Iterator<User> it = list.iterator();
            String userIdStr=request.getParameter("userId");
            int userId=Integer.parseInt(userIdStr);
            boolean data=dao.updateUserStatus(5,userId);
            while (it.hasNext()) {
                User setStatus = it.next();
                if (setStatus.getId() == userId) {
                    setStatus.setStatusId(5);
                }
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("display")){
            User user=(User)session.getAttribute("user");
            GoodDAO goodDAO=new GoodDAO();
            List<Good> userGoods=goodDAO.getGoodByUserId(user.getId());
            session.setAttribute("userGoods",userGoods);

            OrderDAO orderDAO=new OrderDAO();
            List<Order> userOrders=orderDAO.getOrderByUserId(user.getId());
            session.setAttribute("userOrders",userOrders);
            response.sendRedirect("/secondshop/view/user/userProfile.jsp");
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
