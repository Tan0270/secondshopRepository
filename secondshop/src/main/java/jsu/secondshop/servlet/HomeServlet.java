package jsu.secondshop.servlet;

import jsu.secondshop.dao.FirstTypeDAO;
import jsu.secondshop.dao.GoodDAO;
import jsu.secondshop.dao.OrderDAO;
import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.FirstType;
import jsu.secondshop.models.Good;
import jsu.secondshop.models.Order;
import jsu.secondshop.models.User;

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

@WebServlet(urlPatterns = "/HomeServlet")
public class HomeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        //获取前台提交的email和密码
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User admin = userDAO.getUserByEamilAndPass(email, password);
        PrintWriter writer = response.getWriter();
        List<FirstType> firstTypes = FirstTypeDAO.getAllFirst();
        session.setAttribute("firstTypes", firstTypes);

        List<User> userList = userDAO.getAllUser();
        session.setAttribute("userList", userList);

        OrderDAO orderDAO=new OrderDAO();
        List<Order> orders=orderDAO.getAllOrder();
        session.setAttribute("orders",orders);

        List<Good> goods = GoodDAO.getAllGood();
        Iterator<FirstType> firstTypeIterator = firstTypes.iterator();
        Iterator<User> userIterator = userList.iterator();
        while (userIterator.hasNext()) {
            User user = userIterator.next();
            Iterator<Good> goodIterator = goods.iterator();
            while (goodIterator.hasNext()){
                Good good = goodIterator.next();
                if (good.getUserId() == user.getId()) {
                    good.setGoodUser(user);
                }
            }

        }
        while (firstTypeIterator.hasNext()) {
            FirstType firstType = firstTypeIterator.next();
            Iterator<Good> goodIterator = goods.iterator();
            while (goodIterator.hasNext()){
                Good good = goodIterator.next();
                if (good.getFirstTypeId() == firstType.getId()) {
                    good.setFirstType(firstType);
                }
            }

        }

        session.setAttribute("goods", goods);

        Good good = new Good();
        session.setAttribute("good", good);

        response.sendRedirect("/secondshop/view/home/homeGoods.jsp");


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
