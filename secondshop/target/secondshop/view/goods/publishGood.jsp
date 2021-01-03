<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>物品发布</title>
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
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">物品详细信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12">
                <form action="/secondshop/GoodServlet?method=add" method="post" items="${good}" id="register"
                      enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="control-label">物品标题</label>
                        <input name="name" class="form-control">
                    </div>

                    <div class="form-group">
                        <label class="control-label">分类</label>

                        <select name="goodType" id="goodType" class="form-control">
                            <c:forEach items="${firstTypes}" var="type">
                                <option value="${type.id}">${type.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="control-label">物品价格</label>
                        <input name="prise" id="prise" class="form-control" onblur="checkNum(this)">
                        <output id="priseError" style="color: red"></output>
                    </div>

                    <div class="form-group">
                        <label class="control-label">物品描述</label>
                        <textarea name="description" class="form-control" cssStyle="height: 160px"></textarea>
                    </div>

                    <div class="form-group">
                        <label class="control-label">添加图片</label>
                    </div>
                    <div class="col-md-4" style="padding: 15px" align="center">
                        <div style="width: 100%; height: 230px;">
                            <img src="" id="img" height="100%" width="100%">
                        </div>
                        <input id="goodPhoto" style="width: 100%" type="file" name="goodPhoto" onchange="change(event)"
                               onclick="changeImgId('img')">
                    </div>
                    <div class="col-md-12" style="padding: 15px">
                        <div class="col-md-6" align="right" style="padding: 0px">
                            <button type="submit" class="btn" style=" background-color:  #0197c3">提交
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../home/footer.jsp"/>

<script>
    function checkNum() {
        var prise = document.getElementById("prise").value;
        var reg = /^[-+]?[0-9]*\.?[0-9]+$/;
        if (!reg.test(prise)) {
            document.getElementById("priseError").innerHTML = "对不起，请输入数字！";
        } else {
            document.getElementById("priseError").innerHTML = "";
        }
    }
</script>

<script>
    var imgId = "img1";

    function changeImgId(img) {
        imgId = img;
    }

    function change(ev) {
        var event = window.event || ev;
        var files = event.target.files[0];
        var myimg = document.getElementById(imgId);
        myimg.src = URL.createObjectURL(files);
    }

    function addImg() {
        if (document.getElementById("addImg").style.display === "none") {
            document.getElementById("addImg").style.display = "";
            document.getElementById("addBtn").innerHTML = "取消添加";
        } else {
            document.getElementById("addImg").style.display = "none";
            document.getElementById("addBtn").innerHTML = "添加图片";
        }
    }
</script>

<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>