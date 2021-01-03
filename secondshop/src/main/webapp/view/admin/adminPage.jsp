<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>后台管理页面</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/simpleAlert.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
    <script src="<c:url value="/statics/js/simpleAlert.js"/>"></script>
    <style>
        a {
            cursor: pointer
        }
    </style>
</head>
<body>
<nav class="navbar navbar-default navbar-fixed-top" role="navigation"
     style="background-color: #dcdcdc">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" style="font-size: 25px">校园二手交易系统后台管理</a>
        </div>

        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a>${sessionScope.admin.getName()}</a></li>
                <li><a href="/secondshop/AdminLogoutServlet?adminLogout=true">退出</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="col-md-12" style="height: 50px"></div>
<div class="container" style="width: 100%; padding: 0px">
    <div class="col-md-2"
         style="background-color: #d2d2d2; height: 92%; padding: 0px;">
        <div style="float: right; width: 100%;">
            <div id="menu1" onclick="menuBar('menu1')" class="admenu-b"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">物品分类管理</B>
                </p>
            </div>

            <div id="menu2" onclick="menuBar('menu2')" class="admenu"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">物品管理</B>
                </p>
            </div>

            <div id="menu3" onclick="menuBar('menu3')" class="admenu"
                 align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">订单管理</B>
                </p>
            </div>

            <div id="menu4" onclick="menuBar('menu4')" class="admenu" align="center">
                <p>
                    <B style="font-size: 20px; color: #5c5c5c; cursor: pointer">用户管理</B>
                </p>
            </div>
        </div>
    </div>

    <div id="menu-context" class="col-md-10"
         style="background-color: #f3f3f3; height: 92%; padding-left: 0px; padding-right: 30px; float: right;">
        <div id="menu1-context" class="col-md-12">
            <div class="col-md-12" align="center">
                <h3>物品分类管理</h3>
            </div>

            <div class="col-md-12 r" style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 15px" align="center">
                <div class="col-md-12" style="background-color: #f3f3f3; height: 100%; padding: 15px" align="center">
                    <div class="col-md-6" style="height: 100%;" align="center">
                        <div class="col-md-12" align="center" style="margin-bottom: 5px">
                            <h4>物品分类</h4>
                        </div>

                        <div class="col-md-12 r"
                             style="background-color: #ffffff; padding: 40px; height: 88%; overflow-y: auto;">
                            <div id="firstType-ba" class="col-md-12" style="padding: 0px">
                                <c:forEach var="firstType" items="${firstTypeList}">
                                    <div onclick="firstButton(${firstType.id})" id="${firstType.id}"
                                         class="col-md-9 adUlLi r">${firstType.name}</div>
                                    <div onclick="deleteFirstButton(${firstType.id})" class="col-md-1 delType">X</div>
                                </c:forEach>
                            </div>

                            <div id="fir" class="col-md-9 r"
                                 style="display: none; padding: 15px; background-color: #f3f3f3;">
                                <div class="form-group">
                                    <label for="addfirst">分类名称</label> <input id="addfirst"
                                                                                class="form-control" type="text">
                                </div>
                                <button onclick="addFirstType()" class="btn btn-success">添加</button>
                                <button onclick="closeAddbar('fir')" class="btn btn-primary pull-right">取消</button>
                            </div>

                            <div onclick="openAddbar('fir')" class="col-md-9 addFirstType r"
                                 id="addFirstBtn">
                                <B>+</B>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu2-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>物品管理</h3>
            </div>

            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-left: 15px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 8%">物品Id</th>
                                <th style="width: 14%">标题</th>
                                <th style="width: 10%">分类</th>
                                <th style="width: 15%">发布人</th>
                                <th style="width: 24%">发布时间</th>
                                <th style="width: 14%">状态</th>
                                <th style="width: 15%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="goodTable">
                            <c:forEach var="good" items="${goodList}">
                                <tr id="good${good.id}" style="color: #666666">
                                    <td style="width: 8%">${good.id}</td>
                                    <td style="width: 15%">${good.name}</td>
                                    <td style="width: 10%">${good.firstType.name}</td>
                                    <td style="width: 15%">${good.goodUser.name}</td>
                                    <td style="width: 24%">${good.uploadDate}</td>
                                    <td style="width: 13%">${good.statusId == 0 ? "已下架":"在售"}</td>
                                    <td style="width: 15%"><a id="${good.id}"
                                                              onclick="deleteGood(id)">删除</a>&nbsp;&nbsp;<a
                                            onclick="setGoodStatus(${good.id})">${good.statusId == 1 ? "下架":""}</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu3-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>订单管理</h3>
            </div>
            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-right: 34px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 10%">订单编号</th>
                                <th style="width: 15%">卖家</th>
                                <th style="width: 10%">物品ID</th>
                                <th style="width: 20%">物品名称</th>
                                <th style="width: 10%">金额</th>
                                <th style="width: 15%">提交时间</th>
                                <th style="width: 10%">订单状态</th>
                                <th style="width: 10%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="orderTable">
                            <c:forEach var="order" items="${orderList}">
                                <tr style="color: #666666">
                                    <td style="width: 10%">${order.id}</td>
                                    <td style="width: 15%">${order.seller}</td>
                                    <td style="width: 10%">${order.goodId}</td>
                                    <td style="width: 15%">${order.goodName}</td>
                                    <td style="width: 10%">${order.money}</td>
                                    <td style="width: 20%">${order.submitDate}</td>
                                    <td style="width: 10%">${order.statusId == 2 ? "交易中":"交易完成"}</td>
                                    <td style="width: 10%"><a
                                            onclick="deleteOrder(${order.id})">删除</a></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="menu4-context" class="col-md-12" style="display: none">
            <div class="col-md-12" align="center">
                <h3>用户管理</h3>
            </div>
            <div class="col-md-12"
                 style="background-color: #ffffff; height: 78%; margin: 15px; margin-top: 5px; padding: 20px">
                <div class="col-md-12 r" style="height: 100%; padding: 15px;">
                    <div class="col-md-12 column" style="padding-right: 34px;">
                        <table class="table" style="margin-bottom: 0px">
                            <thead>
                            <tr style="color: #666666">
                                <th style="width: 8%">用户ID</th>
                                <th style="width: 13%">用户昵称</th>
                                <th style="width: 14%">用户手机号</th>
                                <th style="width: 20%">用户邮箱</th>
                                <th style="width: 5%">性别</th>
                                <th style="width: 20%">注册时间</th>
                                <th style="width: 12%">用户状态</th>
                                <th style="width: 8%">操作</th>
                            </tr>
                            </thead>
                        </table>
                    </div>

                    <div class="col-md-12 column"
                         style="overflow-y: auto; height: 92%;">
                        <table class="table table-hover">
                            <tbody id="userTable">
                            <c:forEach var="user" items="${userList}">
                                <tr style="color: #666666">
                                    <td style="width: 8%">${user.id}</td>
                                    <td style="width: 13%">${user.name}</td>
                                    <td style="width: 14%">${user.mobile}</td>
                                    <td style="width: 20%">${user.email}</td>
                                    <td style="width: 5%">${user.gender}</td>
                                    <td style="width: 20%">${user.registerDate}</td>
                                    <td style="width: 10%">${user.statusId == 4 ? "正常":"失效"}</td>
                                    <td style="width: 10%"><a
                                            onclick="deleteUser(${user.id})">删除</a>&nbsp;&nbsp;<a
                                            onclick="enableUser(${user.id})">${user.statusId == 4 ? "":"激活"}</a>
                                        <a onclick="disableUser(${user.id})">${user.statusId == 4 ? "禁用":""}</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer1">
    <p>
        世界人民&nbsp;版权所有&nbsp;&nbsp;2019
    </p>
</footer>

<script>
    function menuBar(menuId) {
        var menubar = "#" + menuId + "";
        var menu_context = menubar + "-context";
        $(".admenu-b").removeClass("admenu-b").addClass("admenu");
        $(menubar).removeClass("admenu").addClass("admenu-b");
        $("#menu-context > div").slideUp();
        $(menu_context).slideDown();
    }
</script>

<script>
    // type function
    var first_type_id;

    function deleteFirstButton(first_id) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除这个分类？",
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    deleteFirst(first_id);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function closeAddbar(bar_id) {
        var barId = "#" + bar_id;
        $(barId).slideUp();
    }

    function openAddbar(bar_id) {
        var barId = "#" + bar_id;
        $(barId).slideDown();
    }

    function addFirstType() {
        var name = document.getElementById("addfirst").value;
        $.ajax({
            type: "POST",
            url: "/secondshop/FirstTypeServlet?method=add&name=" + name,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("由于未知原因，一级分类添加失败！");
                } else {
                    document.getElementById("firstType-ba").innerHTML = "";
                    location.reload();
                    alert("分类添加成功！");
                }
            }

        });
        $("#fir").slideUp();
    }

    function deleteFirst(first_id) {
        $.ajax({
            type: "POST",
            url: "/secondshop/FirstTypeServlet?method=delete&id=" + first_id,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("分类删除失败！");
                } else {
                    document.getElementById("firstType-ba").innerHTML = "";
                    location.reload();
                    alert("分类删除成功！");
                }
            }
        });
    }

</script>

<script>
    //user function
    function enableUser(userId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认激活用户？ 用户id:" + userId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    enableUserStatus(userId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function disableUser(userId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认禁用用户？ 用户id:" + userId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    disableUserStatus(userId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function deleteUser(userId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除用户？ 用户id:" + userId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    delUser(userId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function enableUserStatus(userId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/UserServlet?method=enableUserStatus&userId=" + userId,
            traditional: true,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("用户激活失败！");
                } else {
                    document.getElementById("userTable").innerHTML = "";
                    location.reload();
                    alert("用户激活成功！");
                }
            }
        });
    }

    function disableUserStatus(userId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/UserServlet?method=disableUserStatus&userId=" + userId,
            traditional: true,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("用户禁用失败！");
                } else {
                    document.getElementById("userTable").innerHTML = "";
                    location.reload();
                    alert("用户禁用成功！");
                }
            }
        });
    }

    function delUser(userId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/UserServlet?method=delete&id=" + userId,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("用户删除失败！");
                } else {
                    document.getElementById("userTable").innerHTML = "";
                    location.reload();
                    alert("用户删除成功！");
                }
            }
        });
    }

</script>

<script>
    // order function
    function deleteOrder(orderId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除订单？ 订单id:" + orderId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    delOrder(orderId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function delOrder(orderId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/OrderServlet?method=delete&id=" + orderId,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("订单删除失败！");
                } else {
					document.getElementById("orderTable").innerHTML = "";
                    location.reload();
                    alert("订单删除成功！");
                }
            }
        });
    }
</script>

<script>
    // good function
    function deleteGood(goodId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认删除物品？ 物品id:" + goodId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    delGood(goodId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function setGoodStatus(goodId) {
        var dblChoseAlert = simpleAlert({
            "content": "确认下架物品？ 物品id:" + goodId,
            "buttons": {
                "确定": function () {
                    dblChoseAlert.close();
                    setStatus(goodId);
                },
                "取消": function () {
                    dblChoseAlert.close();
                }
            }
        })
    }

    function delGood(goodId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/GoodServlet?method=delete&id=" + goodId,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("物品删除失败！");
                } else {
                    document.getElementById("goodTable").innerHTML = "";
                    location.reload();
                    alert("物品删除成功！");
                }
            }
        });
    }

    function setStatus(goodId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/GoodServlet?method=setStatus&id=" + goodId,
            traditional: true,
            contentType: "application/json", //必须这样写
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data === false) {
                    alert("物品下架失败！");
                } else {
                    document.getElementById("goodTable").innerHTML = "";
                    location.reload();
                    alert("物品下架成功！");
                }
            }
        });
    }
</script>

<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>

</body>
</html>