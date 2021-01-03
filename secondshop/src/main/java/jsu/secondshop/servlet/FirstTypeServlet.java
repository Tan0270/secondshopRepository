package jsu.secondshop.servlet;

import jsu.secondshop.dao.FirstTypeDAO;
import jsu.secondshop.dao.GoodDAO;
import jsu.secondshop.models.FirstType;
import jsu.secondshop.models.Good;
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

@WebServlet(urlPatterns = "/FirstTypeServlet")
public class FirstTypeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String method = request.getParameter("method");
        FirstTypeDAO dao = new FirstTypeDAO();
        if (method.equals("add")) {
            String name = request.getParameter("name");
            String idStr=request.getParameter("id");
            List<FirstType> list = (List<FirstType>) session.getAttribute("firstTypeList");
            FirstType last = list.get(list.size() - 1);
            int id = last.getId() + 1;
            FirstType add = new FirstType(id, name);
            list.add(add);
            session.setAttribute("firstTypeList", list);
            boolean data = dao.updateFirstType(id, name);
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("delete")){
            String idStr=request.getParameter("id");
            int id=Integer.parseInt(idStr);
            List<FirstType> list = (List<FirstType>) session.getAttribute("firstTypeList");
            boolean data=dao.daleteFirstType(id);
            Iterator<FirstType> it=list.iterator();
            while (it.hasNext()){
                FirstType delete=it.next();
                if(delete.getId()==id){
                    it.remove();
                }
            }
            PrintWriter out = response.getWriter();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("data", data);
            response.getWriter().write(jsonObject.toString());
        }
        if(method.equals("display")){
            String idStr=request.getParameter("typeId");
            int id=Integer.parseInt(idStr);
            GoodDAO goodDAO=new GoodDAO();
            List<Good> goods=goodDAO.getGoodsByTypeId(id);
            session.setAttribute("goods",goods);
            response.sendRedirect("/secondshop/view/home/homeGoods.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
}
