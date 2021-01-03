<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>物品编辑</title>
    <link rel="stylesheet" href="<c:url value="/statics/bootstrap-3.3.0/css/bootstrap.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.theme.css"/>">
    <link rel="stylesheet" href="<c:url value="/statics/css/style.css"/>">
    <script src="<c:url value="/statics/jquery-1.12.4/jquery-1.12.4.js"/>"></script>
</head>
<body>
<jsp:include page="../home/header.jsp"/>

<div class="container">
    <div class="col-md-9">
        <div class="col-md-12 r1"
             style="background-color: #e4e4e4; height: 40px;">
            <div style="margin-top: 5px">
                <B style="color: #c4c4c4; font-size: 20px;">修改物品信息</B>
            </div>
        </div>

        <div class="col-md-12 r2"
             style="background-color: #f9f9f9; padding-top: 15px; padding-bottom: 15px;">
            <div class="col-md-12">
                <form action="/secondshop/GoodServlet?method=update" method="post" items="${goodInfo}">
                    <div class="form-group">
                        <label class="control-label">物品标题</label>
                        <input name="name" class="form-control" value="${goodInfo.name}">
                    </div>
                    <div class="form-group">
                        <label class="control-label">分类</label>
                        <select name="goodType" id="goodType" class="form-control">
                            <c:forEach items="${firstTypes}" var="type">
                                <c:choose>
                                    <c:when test="${type.id eq goodInfo.firstTypeId}">
                                        <option value="${type.id}" selected>${type.name}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${type.id}">${type.name}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label class="control-label">物品价格</label>
                        <input name="prise" id="prise" class="form-control" onblur="checkNum(this)" value="${goodInfo.prise}">
                        <output id="priseError" style="color: red"></output>
                    </div>

                    <div class="form-group">
                        <label class="control-label">物品描述</label>
                        <textarea name="description" class="form-control" cssStyle="height: 160px">${goodInfo.description}</textarea>
                    </div>

                    <div class="form-group">
                        <a onclick="delGood(${good.id})" class="btn" style="background-color: #e5e5e5">删除物品</a>
                        <button type="submit" class="btn pull-right" style="background-color: #e5e5e5">提交信息</button>
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

    function delGood(goodId) {
        $.ajax({
            type: "POST",
            url: "/secondshop/GoodServlet?method=delete&id=" + goodId,
            contentType: "application/json",
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

    function deleteGood() {

        $.get("/secondshop/goods/userGoodEdit/delete/" + ${good.id}, function (data) {
            if (data == true) {
                alert("物品删除成功！");
                $(window).attr('location', '/secondshop/user/userProfile');
            } else {
                alert("物品删除失败！");
            }
        })
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
            $("#goodImg").slideUp();
            $("#addImg").slideDown();
            document.getElementById("addBtn").innerHTML = "取消重新上传图片";
        } else {
            $("#goodImg").slideDown();
            $("#addImg").slideUp();
            document.getElementById("addBtn").innerHTML = "重新上传图片";
        }
    }
</script>

<script src="<c:url value="/statics/bootstrap-3.3.0/js/bootstrap.js"/>"></script>
<script src="<c:url value="/statics/jquery-ui-1.12.1/jquery-ui.js"/>"></script>
<script
        src="<c:url value="/statics/jquery-ui-1.12.1/datepicker-zh-CN.js"/>"></script>
</body>
</html>