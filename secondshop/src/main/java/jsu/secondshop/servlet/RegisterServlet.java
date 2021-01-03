package jsu.secondshop.servlet;

import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.User;
import jsu.secondshop.utils.DateUtils;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(urlPatterns = "/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取前台提交的email和密码
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String moblie = request.getParameter("moblie");
        String email = request.getParameter("email");
        String passwrod = request.getParameter("password");

        //插入到数据库中，对数据进行封装，自己封装成一个对象
        Date date=new Date();
        String register_date= DateUtils.format(date);
        User user = new User(name, gender, moblie, email, passwrod,register_date);
        UserDAO userDao = new UserDAO();
        boolean flag = userDao.selectUserEmailCount(email);


        //判断是否有相同的email
        if (flag) {
            //数据库已经有相同email的用户
            //通过response对象给客户端一个错误提示
            PrintWriter writer = response.getWriter();
            writer.write("<script>");
            writer.write("alert('申请注册的email已经被占用！');");
            writer.write("window.location.href = 'view/home/register.jsp'");
            writer.write("</script>");
            writer.flush();
            writer.close();
        } else {
            //flag标志是否注册成功
            boolean flag1 = userDao.saveUser(user);

            if (flag1) {
                //注册成功就跳转到登录页面 重定向
                response.sendRedirect("/secondshop/view/home/login.jsp");
            } else {
                //注册失败就返回注册页面 请求转发
                RequestDispatcher dispatcher = request.getRequestDispatcher("/register.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
