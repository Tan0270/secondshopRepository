<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户注册</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
</head>
<body style="background-image: url(<c:url value="/statics/image/background/background1.jpg"/>); background-size: cover">
<div class="container" style="margin-top: 30px;">
    <div class="row">
        <div style="margin: 20px auto; color: #ffffff">
            <h1 align="center" ; style="color: #292b33">新用户注册</h1>
        </div>

        <div class="col-xs-5 r"
             style="position: absolute; left: 50%; transform: translateX(-50%); padding: 30px; background-color: #ffffff">
            <form action="/secondshop/RegisterServlet" method="get" onsubmit="return validate()">
                <div class="form-group">
                    <label class="control-label">姓名</label>
                    <input class="form-control" placeholder="请输入姓名" name="name">
                </div>

                <div class="form-group">
                    <label class="control-label">性别</label>
                    <select id="gender" class="form-control" name="gender">
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="control-label">手机</label>
                    <input id="moblie" class="form-control" placeholder="请输入手机号码" name="moblie"></input>
                    <output itemid="status" style="color: red"></output>
                </div>

                <div class="form-group">
                    <label class="control-label">邮箱</label>
                    <input id="email" class="form-control" placeholder="请输入邮箱" name="email"></input>
                    <output itemid="status" style="color: red" value=""></output>
                </div>

                <div class="form-group">
                    <label class="control-label">密码</label>
                    <input id="p1" class="form-control" placeholder="请输入密码" type="password" name="password"></input>
                </div>

                <div class="form-group">
                    <label class="control-label">确认密码</label>
                    <input id="p2" class="form-control" placeholder="请再次输入密码" type="password" name="password2"
                           onblur="checkpass(this)"></input>
                    <output id="passError" style="color: red"></output>
                </div>

                <div class="form-group">
                    <button type="submit" class="btn btn-primary">注册</button>
                    <a class="btn btn-success pull-right"
                       onClick="javascript :history.back(-1);">返回</a>
                </div>
            </form>
        </div>
    </div>
</div>
</div>
<script>
    function validate() {
        var email = document.getElementById("email").value;
        var password = document.getElementById("p1").value;
        var moblie=document.getElementById("moblie").value;

        //验证手机格式
        var pattern2=/^((13[0-9])|(15[^4,\D])|(18[0,5-9]))\d{8}$/;
        if(moblie==''){
            alert("手机号码不能为空！");
        }else if(!pattern2.test(moblie)){
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

        //验证密码合法性
        if (password == '') {
            alert("密码不能为空!");
            return false;
        } else if (password.length < 6 || password.length > 12) {
            alert("密码长度在6-8个字符之间");
            return false;
        }
        return true;
    }
</script>
<script>
    function checkpass() {
        var password = document.getElementById("p1");
        var passwordConfirm = document.getElementById("p2");
        if (password == '')
            document.getElementById("passError").innerHTML = "密码不能为空！";
        if (password.value != passwordConfirm.value) {
            document.getElementById("passError").innerHTML = "对不起，您2次输入的密码不一致";
        } else {
            document.getElementById("passError").innerHTML = "";
        }
    }
</script>

<script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>
