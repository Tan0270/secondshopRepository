<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
<jsp:include page="../home/header.jsp"/>

<div class="container"
     style="position: relative; transform: translate(0, 0)">
    <div class="col-md-9" style="float: left">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px">
            <div class="col-md-2" style="padding-left: 0px; padding-right: 0px;">
                <img src="<c:url value="${sessionScope.user.getPhotoUrl()}"/>" width="128px" height="128px">
            </div>

            <div class="col-md-10">
                <div class="col-md-12" style="height: 60px;">
                    <h3>
                        <B>${sessionScope.user.getName()}</B>
                    </h3>
                </div>

                <div class="col-md-2" style="padding-right: 0px">
                    <p style="color: #666666; height: 20px">
                        <B>昵称：</B>
                    </p>
                    <p style="color: #666666; height: 20px">
                        <B>性别：</B>
                    </p>
                </div>

                <div class="col-md-2" style="padding-left: 0px">
                    <p style="color: #666666; height: 20px">${sessionScope.user.getName()}</p>
                    <p style="color: #666666; height: 20px">${sessionScope.user.getGender()}</p>
                </div>

                <div class="col-md-2" style="padding-right: 0px">
                    <p style="color: #666666; height: 20px">
                        <B>手机号：</B>
                    </p>
                    <p style="color: #666666; height: 20px">
                        <B>邮箱：</B>
                    </p>
                </div>

                <div class="col-md-3" style="padding-left: 0px">
                    <p style="color: #666666; height: 20px">${sessionScope.user.getMobile()}</p>
                    <p style="color: #666666; height: 20px">${sessionScope.user.getEmail()}</p>
                </div>

                <div class="col-md-3">
                    <a href="/secondshop/view/user/userEdit.jsp">修改个人资料</a>
                </div>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的物品</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
            <div class="col-md-12 r" style="background-color: #ffffff;">
                <p></p>
                <p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
                   align="center">
                    <B>我发布的物品</B>
                </p>

                <c:choose>
                    <c:when test="${userGoods.size() == 0}">
                        <div class="col-md-12" style="margin-top: 50px;" align="center">
                            <p></p>
                            <img src="<c:url value="/statics/image/logo/yihan.png"/>"
                                 width="40%" ; height="222px;">
                            <p style="color: #c4c4c4; font-size: 20px">你还没有发布物品哦！</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="col-md-12 column" style="padding-left: 15px;">
                            <table class="table" style="margin-bottom: 0px">
                                <thead>
                                <tr style="color: #666666">
                                    <th style="width: 102px">编号</th>
                                    <th style="width: 227px">标题</th>
                                    <th style="width: 260px">发布时间</th>
                                    <th>状态</th>
                                </tr>
                                </thead>
                            </table>
                        </div>

                        <div class="col-md-12 column"
                             style="overflow-y: auto; height: 280px;">
                            <table class="table table-hover">
                                <tbody>
                                <c:forEach var="good" items="${userGoods}">
                                    <tr style="color: #666666">
                                        <td style="width: 102px">
                                            <a target="_blank" href="/secondshop/GoodServlet?method=display&goodId=${good.id}">${good.id}</a>
                                        </td>
                                        <td style="width: 227px">${good.name}</td>
                                        <td style="width: 260px">${good.uploadDate}</td>
                                        <td>${good.statusId == 0 ? "已下架":"在售"}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">我的订单</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px; margin-bottom: 20px;">
            <div class="col-md-12 r" style="background-color: #ffffff;">
                <p></p>
                <p style="color: #c4c4c4; font-size: 20px; margin-bottom: 0px;"
                   align="center">
                    <B>我所有的订单</B>
                </p>

                <c:choose>
                    <c:when test="${userOrders.size() == 0}">
                        <div class="col-md-12" style="margin-top: 50px;" align="center">
                            <p></p>
                            <img src="<c:url value="/statics/image/logo/yihan.png"/>"
                                 width="40%" ; height="200px;">
                            <p style="color: #c4c4c4; font-size: 20px">你还没有订单哦！</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="col-md-12 column" style="padding-left: 15px;">
                            <table class="table" style="margin-bottom: 0px">
                                <thead>
                                <tr style="color: #666666">
                                    <th style="width: 90px">订单编号</th>
                                    <th style="width: 100px">卖家</th>
                                    <th style="width: 140px">物品名称</th>
                                    <th style="width: 70px">金额</th>
                                    <th style="width: 200px">提交时间</th>
                                    <th>订单状态</th>
                                </tr>
                                </thead>
                            </table>
                        </div>

                        <div class="col-md-12 column"
                             style="overflow-y: auto; height: 280px;">
                            <table class="table table-hover">
                                <tbody>
                                <c:forEach var="order" items="${userOrders}">
                                    <tr style="color: #666666">
                                        <td style="width: 90px"><a target="_blank" href="/secondshop/OrderServlet?method=display&orderId=${order.id}">${order.id}</a>
                                        </td>
                                        <td style="width: 100px">${order.seller}</td>
                                        <td style="width: 140px">${order.goodName}</td>
                                        <td style="width: 70px">${order.money}</td>
                                        <td style="width: 200px">${order.submitDate}</td>
                                        <td>${order.statusId == 2 ? "交易中":"交易完成"}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
</div>

<jsp:include page="../home/footer.jsp"/>
<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>