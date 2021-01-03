<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>首页</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
    <script>
        $(function () {
            var width = $("#type-bar").width();
            $(window).scroll(function () {
                if ($(document).scrollTop() >= $("#search-bar").height()) {
                    $("#type-bar").css({
                        "position": "fixed",
                        "top": 150 - $("#search-bar").height() + "px",
                        "width": width
                    });
                } else {
                    $("#type-bar").css({
                        "position": "fixed",
                        "top": 150 - $(document).scrollTop() + "px",
                        "width": width
                    });
                }
            })
        })
    </script>
</head>
<body>

<jsp:include page="header.jsp"/>

<div class="container">
    <div class="main-content">
        <div class="col-md-2" style="padding-left: 0px; padding-right: 0px;"
             id="type-bar">
            <div class="col-md-12" align="center"
                 style="padding-left: 0px; padding-right: 0px;" id="type-button">
                <c:forEach var="firstType" items="${firstTypes}">
                    <a href="<c:url value="/FirstTypeServlet?method=display&typeId=${firstType.id}"/>">
                        <div style="height: 50px; width: 100%; background-color: #eaeaea; margin-top: 15px;"
                             class="btn-type" align="center;" id="type${firstType.id}">
                            <p><h4>${firstType.name}</h4></p>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>

        <div class="col-md-10" style="margin-top: 10px; float: right;">
            <div class="col-md-12">
                <c:if test="${sessionScope.text != '' && sessionScope.text != null}">
                    <p></p>
                    <p>为您搜索到“${sessionScope.text}”相关物品${search.size()}条记录</p>
                </c:if>
            </div>
            <c:choose>
                <c:when test="${search.size() == 0}">
                    <div align="center">
                        <img style="width: 500px; height: 350px"
                             src="<c:url value="/statics/image/photos/default/shouqing.png"/>">
                        <h2>抱歉，暂无此类物品！</h2>
                    </div>
                </c:when>
            </c:choose>
            <c:forEach var="good" items="${search}">
                <a target="_blank" href="/secondshop/GoodServlet?method=display&goodId=${good.id}">
                    <div class="c col-md-3">
                        <div class="a col-md-12" style="max-height: 300px;">
                            <img src="<c:url value="${good.photoUrl}"/>" height="190px">
                            <p style="height: 25px; margin-top: 20px">${good.name}</p>
                            <p style="color: red; text-align: right">
                                <B>价格：${good.prise}￥</B>
                            </p>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>