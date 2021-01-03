package jsu.secondshop.servlet;

import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.User;
import jsu.secondshop.utils.FileCheck;
import jsu.secondshop.utils.RandomString;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = "/UserEditServlet")
@MultipartConfig
public class UserEditServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String Name = request.getParameter("name");
        String gender = request.getParameter("gender");
        String moblie = request.getParameter("mobile");
        String email = request.getParameter("email");
        Part part = request.getPart("photo");
        String cd = part.getHeader("Content-Disposition");
        //截取不同类型的文件需要自行判断
        String fileName = cd.substring(cd.lastIndexOf("=") + 2, cd.length() - 1);
        User user = (User) session.getAttribute("user");
        user.setName(Name);
        user.setGender(gender);
        user.setMobile(moblie);
        user.setEmail(email);

        if (fileName != "") {
            FileCheck fileCheck = new FileCheck();
            String filePath = "/statics/image/photos/" + user.getId();
            String pathRoot = fileCheck.checkGoodFolderExist(filePath);
            File file=new File(pathRoot + fileName);
            if(!file.exists()){
                file.mkdirs();
            }
            String path=file.getAbsolutePath();
            part.write(path);
            String photoUrl = filePath + "/" + fileName;
            user.setPhotoUrl(photoUrl);
        }

        UserDAO dao = new UserDAO();
        boolean flag = dao.updateUserInfo(user);
        if (flag) {
            session.setAttribute("user", user);
            PrintWriter writer = response.getWriter();
            writer.write("<script>");
            writer.write("alert('个人信息修改成功！');");
            writer.write("window.location.href = 'view/user/userProfile.jsp'");
            writer.write("</script>");
            writer.flush();
            writer.close();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
