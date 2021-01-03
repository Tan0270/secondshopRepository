package jsu.secondshop.servlet;

import jsu.secondshop.dao.GoodDAO;
import jsu.secondshop.dao.OrderDAO;
import jsu.secondshop.models.FirstType;
import jsu.secondshop.models.Good;
import jsu.secondshop.models.Order;
import jsu.secondshop.utils.DateUtils;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@WebServlet(urlPatterns = "/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String method = request.getParameter("method");
        OrderDAO dao=new OrderDAO();
        if(method.equals("delete")){
            List<Order> list=(List<Order>)session.getAttribute("orderList");
            String idStr=request.getParameter("id");
            int id=Integer.parseInt(idStr);
            boolean data=dao.deleteOrder(id);
            Iterator<Order> it=list.iterator();
            while (it.hasNext()){
                Order delete=it.next();
                if(delete.getId()==id){
                    it.remove();
                }
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("add")){
            String goodName=request.getParameter("goodName");
            String seller=request.getParameter("seller");
            String sellerId=request.getParameter("sellerId");
            int sellerID=Integer.parseInt(sellerId);
            String customer=request.getParameter("customer");
            String customerId=request.getParameter("customerId");
            int customerID=Integer.parseInt(customerId);
            String goodId=request.getParameter("goodId");
            int goodID=Integer.parseInt(goodId);
            String moneyStr=request.getParameter("money");
            float money=Float.parseFloat(moneyStr);

            Date date=new Date();
            String submitDate= DateUtils.format(date);
            boolean flag=dao.addOrder(goodName,seller, sellerID, customer, customerID,goodID,  money, submitDate, 2);
            Order orderInfo=dao.getOrder();
            if(flag){
                session.setAttribute("orderInfo",orderInfo);
                List<Order> orders=(List<Order>)session.getAttribute("orders");
                orders.add(orderInfo);
                session.setAttribute("orders",orders);
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('订单创建成功！');");
                writer.write("window.location.href = 'view/user/orderInfo.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }else {
                PrintWriter writer = response.getWriter();
                writer.write("<script>");
                writer.write("alert('订单创建失败！');");
                writer.write("window.location.href = 'view/goods/goodInfo.jsp'");
                writer.write("</script>");
                writer.flush();
                writer.close();
            }
        }
        if(method.equals("display")){
            String orderIdStr = request.getParameter("orderId");
            int orderId = Integer.parseInt(orderIdStr);
            List<Order> list = (List<Order>) session.getAttribute("orders");
            Iterator<Order> it = list.iterator();
            while (it.hasNext()) {
                Order orderInfo = it.next();
                if (orderInfo.getId() == orderId) {
                    session.setAttribute("orderInfo", orderInfo);
                    break;
                }
            }
            response.sendRedirect("/secondshop/view/user/orderInfo.jsp");
        }
        if(method.equals("userDelete")){
            List<Order> list=(List<Order>)session.getAttribute("orders");
            String idStr=request.getParameter("id");
            int id=Integer.parseInt(idStr);
            boolean data=dao.deleteOrder(id);
            Iterator<Order> it=list.iterator();
            while (it.hasNext()){
                Order delete=it.next();
                if(delete.getId()==id){
                    it.remove();
                }
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("setStatus")){
            Order status=(Order)session.getAttribute("orderInfo");
            boolean flag=dao.updateStatus(status.getId());
            if(flag){
                Order orderInfo=dao.getOrderByID(status.getId());
                session.setAttribute("orderInfo",orderInfo);
                List<Order> list=(List<Order>)session.getAttribute("orders");
                Iterator<Order> it=list.iterator();
                while (it.hasNext()) {
                    Order setStatus = it.next();
                    if (setStatus.getId() == orderInfo.getId()) {
                        setStatus.setEndDate(orderInfo.getEndDate());
                        setStatus.setStatusId(orderInfo.getStatusId());
                    }
                }
                GoodDAO goodDAO=new GoodDAO();
                boolean flag1=goodDAO.updateGoodStatus(0,orderInfo.getGoodId());
                List<Good> goodList=(List<Good>)session.getAttribute("goods");
                Iterator<Good> goodIterator=goodList.iterator();
                while (goodIterator.hasNext()){
                    Good good=goodIterator.next();
                    if(good.getId()==orderInfo.getGoodId()){
                        good.setStatusId(0);
                        good.setGoodUpdate(orderInfo.getEndDate());
                    }
                }
                boolean data=true;
                PrintWriter out = response.getWriter();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("data", data);
                response.getWriter().write(jsonObject.toString());
            }else {
                boolean data=false;
                PrintWriter out = response.getWriter();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("data", data);
                response.getWriter().write(jsonObject.toString());
            }

        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
