<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>${goodInfo.name}</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/swiper.min.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/simpleAlert.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
    <script src="<c:url value="/statics/js/simpleAlert.js"/>"></script>
    <script src="<c:url value="/statics/js/swiper.min.js"/>"></script>
    <script>
        $(function () {
            $(".swiper-slide img").mouseover(function () {
                var url = $(this).attr("src");
                $("#img-a").attr("src", url);
            })
        })
    </script>
</head>
<body>
<jsp:include page="../home/header.jsp"/>

<div class="container">
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-8" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">物品信息</B>
            </div>

        </div>

        <div class="col-md-12 r2" style="background-color: #f9f9f9; padding: 0px; padding-bottom: 15px">
            <div class="col-md-12" style="margin-top: 40px;">
                <div class="col-md-7" align="center;">
                    <div style="width: 100%" align="center">
                        <img src="<c:url value="${goodInfo.photoUrl}"/>" width="100%" id="img-a">
                    </div>
                </div>

                <div class="col-md-5">
                    <h3 style="margin-left: 15px">
                        <B>${goodInfo.name}</B>
                    </h3>
                    <div style="height: 50px"></div>
                    <div class="col-md-4" style="padding: 0px">
                        <p style="color: #666666; height: 40px">
                            <B>价格</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>卖家</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>物品分类</B>
                        </p>
                        <p style="color: #666666; height: 40px">
                            <B>发布时间</B>
                        </p>
                    </div>

                    <div class="col-md-8" style="padding: 0px">
                        <p style="color: red; height: 40px; font-size: 20px">￥${goodInfo.prise}</p>
                        <p style="color: #808080; height: 40px">${goodInfo.goodUser.name}</p>
                        <p style="color: #808080; height: 40px">${goodInfo.firstType.name}</p>
                        <p style="color: #808080; height: 40px">${goodInfo.uploadDate}</p>
                    </div>

                    <div class="col-md-12" style="padding: 0px">
                        <div onclick="connect()" class="col-md-5 r-c"
                             style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? 'none':''}">
                            <B style="font-size: 20px; color: #e2e2e2">联系卖家</B>
                        </div>

                        <c:choose>
                            <c:when test="${goodInfo.statusId == 1}">
                                <div onclick="buyButton()" class="col-md-5 r-b pull-right"
                                     style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? 'none':''}">
                                    <B style="font-size: 20px; color: #e2e2e2">购买</B>
                                </div>
                                <a style="display: ${sessionScope.user.id == goodInfo.goodUser.id ? '':'none'}"
                                   href="/secondshop/view/goods/userGoodEdit.jsp">
                                    <div class="col-md-5 r-b">
                                        <B style="font-size: 20px; color: #e2e2e2">编辑</B>
                                    </div>
                                </a>
                            </c:when>

                            <c:otherwise>
                                <div class="col-md-5 r-x pull-right">
                                    <B style="font-size: 20px; color: #bbbbbb">已下架</B>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px; margin-top: 20px;">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">物品描述</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; height: 150px">
            <div class="col-md-12" style="margin-top: 20px">
                <p style="color: #b0b0b0;">&emsp;&emsp;${goodInfo.description}</p>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../home/footer.jsp"/>

<script>
    var swiper = new Swiper('.swiper-container', {
        slidesPerView: 3,
        spaceBetween: 30,
        slidesPerGroup: 3,
        loop: true,
        loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination',
            clickable: true
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev'
        }
    });
</script>

<script>
    function connect() {
        alert("卖家联系方式：\n手机号：${goodInfo.goodUser.mobile}\n邮箱：${goodInfo.goodUser.email}\n请选择自己方便的联系方式与卖家沟通！");
    }
</script>

<script>
    function buyButton() {
        var dblChoseAlert = simpleAlert({
            "content": "您即将购买该物品!",
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    getBuy();
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function getBuy() {
        if (${sessionScope.user == null}) {
            alert("请先登录！");
            $(window).attr('location', '/secondshop/view/home/login.jsp');
        } else {
            alert("我们正在为您创建订单！");
            $(window).attr('location', '/secondshop/OrderServlet?method=add&goodName=${goodInfo.name}&seller=${goodInfo.goodUser.name}&sellerId=${goodInfo.goodUser.id}&customer=${sessionScope.user.name}&customerId=${sessionScope.user.id}&goodId=${goodInfo.id}&money=${goodInfo.prise}');
        }
    }
</script>
<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>