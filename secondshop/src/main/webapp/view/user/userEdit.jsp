<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改用户信息</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
<jsp:include page="../home/header.jsp"/>

<div class="container" style="position: relative; transform: translate(0, 0)">
    <div class="col-md-9" style="float: left;">
        <div class="col-md-12 r1" style="background-color: #e4e4e4; height: 40px">
            <div class="col-md-6" style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px">修改信息</B>
            </div>
        </div>

        <div class="col-md-12 r2" style="background-color: #f9f9f9; padding: 30px; margin-bottom: 15px">
            <form action="/secondshop/UserEditServlet" method="post" enctype="multipart/form-data" onsubmit="return validate()">
                <div class="col-md-12" style="padding-left: 0px; padding-bottom: 10px">
                    <div class="col-md-8" style="padding-left: 0px; padding-top: 50px">
                        <label for="photo" cssClass="control-label">头像</label>
                        <input id="photo" style="margin-top: 10px" type="file" name="photo" onchange="change(event)">
                    </div>

                    <div class="col-md-4">
                        <img src="<c:url value="${user.photoUrl}"/>" id="img" height="120px" width="120px">
                    </div>
                </div>

                <div class="form-group">
                    <label class="control-label">姓名</label>
                    <input name="name" class="form-control" value="${user.name}">
                </div>

                <div class="form-group">
                    <label class="control-label">性别</label>
                    <select name="gender" id="gender" class="form-control">
                        <c:if test="${user.gender=='男'}">
                            <option value="男" selected>男</option>
                            <option value="女">女</option>
                        </c:if>
                        <c:if test="${user.gender=='女'}">
                            <option value="男">男</option>
                            <option value="女" selected>女</option>
                        </c:if>
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label">手机</label>
                    <input name="mobile" class="form-control" value="${user.mobile}">
                    <output itemid="status" style="color: red"></output>
                </div>

                <div class="form-group">
                    <label class="control-label">邮箱</label>
                    <input name="email" class="form-control" value="${user.email}">
                    <output itemid="status" style="color: red" value=""></output>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">确定</button>
                    <a class="btn btn-success pull-right" onClick="javascript :history.back(-1);">返回</a>
                </div>

                <output style="color: red">${status}</output>
            </form>
        </div>
    </div>
</div>
<jsp:include page="../home/footer.jsp"/>
<script>
    function validate() {
        var email = document.getElementById("email").value;
        var password = document.getElementById("p1").value;
        var moblie = document.getElementById("moblie").value;

        //验证手机格式
        var pattern2 = /^((13[0-9])|(15[^4,\D])|(18[0,5-9]))\d{8}$/;
        if (moblie == '') {
            alert("手机号码不能为空！");
        } else if (!pattern2.test(moblie)) {
            alert("手机号码格式不正确！");
        }

        //验证邮箱合法性
        var pattern = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;

        if (email == '') {
            alert("email不能为空!");
            return false;
        } else if (!pattern.test(email)) {
            alert("email格式不正确!");
            return false;
        }
        return true;
    }
</script>
<script>
    var bar_width = document.getElementById("re-bar").scrollWidth;
    $(function () {
        $(window).scroll(function () {
            if ($(document).scrollTop() >= 20) {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 50 + $(document).scrollTop() + "px",
                    "width": bar_width,
                    "right": 15
                });
            } else {
                $("#re-bar").css({
                    "position": "fixed",
                    "top": 70 + "px",
                    "width": bar_width,
                    "right": 15
                });
            }
        })
    });

    function change(ev) {
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById("img");
        myimg.src = URL.createObjectURL(files);
    }
</script>

<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>