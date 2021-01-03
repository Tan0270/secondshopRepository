package jsu.secondshop.servlet;

import jsu.secondshop.dao.*;
import jsu.secondshop.models.*;

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

@WebServlet(urlPatterns = "/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");*/
        HttpSession session = request.getSession();
        //获取前台提交的email和密码
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User admin = userDAO.getUserByEamilAndPass(email, password);
        PrintWriter writer = response.getWriter();

        List<FirstType> firstTypeList = FirstTypeDAO.getAllFirst();
        session.setAttribute("firstTypeList", firstTypeList);

        List<User> userList = UserDAO.getAllUser();
        session.setAttribute("userList", userList);

        List<Good> goodList = GoodDAO.getAllGood();
        Iterator<FirstType> firstTypeIterator = firstTypeList.iterator();
        Iterator<User> userIterator = userList.iterator();
        while (userIterator.hasNext()) {
            User user = userIterator.next();
            Iterator<Good> goodIterator = goodList.iterator();
            while (goodIterator.hasNext()){
                Good good = goodIterator.next();
                if (good.getUserId() == user.getId()) {
                    good.setGoodUser(user);
                }
            }

        }
        while (firstTypeIterator.hasNext()) {
            FirstType firstType = firstTypeIterator.next();
            Iterator<Good> goodIterator = goodList.iterator();
            while (goodIterator.hasNext()){
                Good good = goodIterator.next();
                if (good.getFirstTypeId() == firstType.getId()) {
                    good.setFirstType(firstType);
                }
            }

        }
        session.setAttribute("goodList", goodList);

        List<Order> orderList = OrderDAO.getAllOrder();
        session.setAttribute("orderList", orderList);

        if (admin != null) {
            if (admin.getRoleId() == 101) {
                session.setAttribute("admin", admin);
                response.sendRedirect("/secondshop/view/admin/adminPage.jsp");
            } else if (admin.getRoleId() == 102) {
                writer.write("<script>");
                writer.write("alert('用户没有权限访问！');");
                writer.write("window.location.href = 'view/admin/adminLogin.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        } else {
            writer.write("<script>");
            writer.write("alert('邮箱或密码错误！');");
            writer.write("window.location.href = 'view/admin/adminLogin.jsp'");
            writer.write("</script>");
            writer.flush();
            writer.close();
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
