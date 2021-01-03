package jsu.secondshop.servlet;

import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session=request.getSession();
        //获取前台提交的email和密码
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByEamilAndPass(email, password);

        if (user != null) {
            session.setAttribute("user",user);
            response.sendRedirect("/secondshop/view/home/homeGoods.jsp");
        } else {
            PrintWriter writer = response.getWriter();
            writer.write("<script>");
            writer.write("alert('邮箱或密码错误！');");
            writer.write("window.location.href = 'view/home/login.jsp'");
            writer.write("</script>");
            writer.flush();
            writer.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
