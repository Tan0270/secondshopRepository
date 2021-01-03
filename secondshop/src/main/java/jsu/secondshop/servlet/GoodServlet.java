package jsu.secondshop.servlet;

import jsu.secondshop.dao.FirstTypeDAO;
import jsu.secondshop.dao.GoodDAO;
import jsu.secondshop.dao.OrderDAO;
import jsu.secondshop.dao.UserDAO;
import jsu.secondshop.models.FirstType;
import jsu.secondshop.models.Good;
import jsu.secondshop.models.Order;
import jsu.secondshop.models.User;
import jsu.secondshop.utils.FileCheck;
import org.apache.commons.beanutils.BeanUtils;
import org.json.JSONObject;

import javax.persistence.criteria.CriteriaBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet(urlPatterns = "/GoodServlet")
@MultipartConfig
public class GoodServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String method = request.getParameter("method");
        GoodDAO dao = new GoodDAO();
        if (method.equals("add")) {
            String name = request.getParameter("name");
            String goodType = request.getParameter("goodType");
            int typeID = Integer.parseInt(goodType);
            String priseStr = request.getParameter("prise");
            float prise = Float.parseFloat(priseStr);
            String description = request.getParameter("description");

            Part part = request.getPart("goodPhoto");
            String cd = part.getHeader("Content-Disposition");
            //截取不同类型的文件需要自行判断
            String fileName = cd.substring(cd.lastIndexOf("=") + 2, cd.length() - 1);

            Good good = (Good) session.getAttribute("good");
            User user = (User) session.getAttribute("user");
            good.setName(name);
            good.setFirstTypeId(typeID);
            good.setPrise(prise);
            good.setDescription(description);
            good.setUserId(user.getId());

            if (fileName != "") {
                FileCheck fileCheck = new FileCheck();
                String filePath = "/statics/image/goods/" + user.getId();
                String pathRoot = fileCheck.checkGoodFolderExist(filePath);
                File file = new File(pathRoot + fileName);
                if (!file.exists()) {
                    file.mkdirs();
                }
                String path = file.getAbsolutePath();
                part.write(path);
                String photoUrl = filePath + "/" + fileName;
                good.setPhotoUrl(photoUrl);
            } else {
                good.setPhotoUrl("/statics/image/goods/default/nophoto.png");
            }

            boolean flag = dao.addGood(good);
            if (flag) {
                session.setAttribute("user", user);
                session.setAttribute("good", good);
                List<Good> goods = dao.getAllGood();

                List<FirstType> firstTypes = FirstTypeDAO.getAllFirst();
                session.setAttribute("firstTypes", firstTypes);

                List<User> userList = UserDAO.getAllUser();
                session.setAttribute("userList", userList);

                OrderDAO orderDAO=new OrderDAO();
                List<Order> orders=orderDAO.getAllOrder();
                session.setAttribute("orders",orders);

                Iterator<FirstType> firstTypeIterator = firstTypes.iterator();
                Iterator<User> userIterator = userList.iterator();
                while (userIterator.hasNext()) {
                    User user1 = userIterator.next();
                    Iterator<Good> goodIterator = goods.iterator();
                    while (goodIterator.hasNext()){
                        Good good1 = goodIterator.next();
                        if (good1.getUserId() == user1.getId()) {
                            good1.setGoodUser(user1);
                        }
                    }

                }
                while (firstTypeIterator.hasNext()) {
                    FirstType firstType = firstTypeIterator.next();
                    Iterator<Good> goodIterator = goods.iterator();
                    while (goodIterator.hasNext()){
                        Good good1 = goodIterator.next();
                        if (good1.getFirstTypeId() == firstType.getId()) {
                            good1.setFirstType(firstType);
                        }
                    }

                }
                session.setAttribute("goods", goods);
                response.sendRedirect("/secondshop/UserServlet?method=display");
            } else {
                PrintWriter writer = response.getWriter();
                writer.print("<script>");
                writer.print("alert('上传物品失败！');");
                writer.print("window.location.href = 'view/goods/publishGood.jsp'");
                writer.print("</script>");
                writer.flush();
                writer.close();
            }
        }
        if (method.equals("delete")) {
            List<Good> list = (List<Good>) session.getAttribute("goodList");
            Iterator<Good> it = list.iterator();
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            boolean data = dao.deleteGood(id);
            while (it.hasNext()) {
                Good delete = it.next();
                if (delete.getId() == id) {
                    it.remove();
                }
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if (method.equals("setStatus")) {
            List<Good> list = (List<Good>) session.getAttribute("goodList");
            Iterator<Good> it = list.iterator();
            String idStr = request.getParameter("id");
            int id = Integer.parseInt(idStr);
            boolean data = dao.updateGoodStatus(0, id);
            while (it.hasNext()) {
                Good setStatus = it.next();
                if (setStatus.getId() == id) {
                    setStatus.setStatusId(0);
                }
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if (method.equals("display")) {
            String goodIdStr = request.getParameter("goodId");
            int goodId = Integer.parseInt(goodIdStr);
            List<Good> list = (List<Good>) session.getAttribute("goods");
            Iterator<Good> it = list.iterator();
            while (it.hasNext()) {
                Good goodInfo = it.next();
                if (goodInfo.getId() == goodId) {
                    session.setAttribute("goodInfo", goodInfo);
                    break;
                }
            }
            response.sendRedirect("/secondshop/view/goods/goodInfo.jsp");
        }

        if(method.equals("update")){
            Good update=(Good) session.getAttribute("goodInfo");
            String name=request.getParameter("name");
            String goodTypeStr=request.getParameter("goodType");
            int typeId=Integer.parseInt(goodTypeStr);
            String priseStr=request.getParameter("prise");
            float prise=Float.parseFloat(priseStr);
            String description=request.getParameter("description");

            update.setName(name);
            update.setFirstTypeId(typeId);
            update.setPrise(prise);
            update.setDescription(description);

            boolean flag=dao.updateGood(update);
            if(flag){
                session.setAttribute("goodInfo",update);
                PrintWriter writer = response.getWriter();
                writer.print("<script>");
                writer.print("alert('物品信息修改成功！');");
                writer.print("window.location.href = 'view/goods/goodInfo.jsp'");
                writer.print("</script>");
                writer.flush();
                writer.close();
            }else {
                PrintWriter writer = response.getWriter();
                writer.print("<script>");
                writer.print("alert('物品信息修改失败！');");
                writer.print("</script>");
                writer.flush();
                writer.close();
            }
        }
        if(method.equals("search")){
            String text=request.getParameter("searchText");
            List<Good> list=(List<Good>)session.getAttribute("goods");
            List<Good> search=new ArrayList<>();
            Iterator<Good> it = list.iterator();
            while (it.hasNext()) {
                Good goodInfo = it.next();
                if (goodInfo.getName().indexOf(text)!=-1) {
                    search.add(goodInfo);
                    break;
                }
            }
            session.setAttribute("search",search);
            session.setAttribute("text",text);
            response.sendRedirect("/secondshop/view/home/search.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
