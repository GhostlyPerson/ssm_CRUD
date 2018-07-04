<%--
  Created by IntelliJ IDEA.
  User: hui
  Date: 2018/6/2
  Time: 23:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <title>员工列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <script type="text/javascript" src="${APP_PATH}/static/jquery-3.3.1/jquery-3.3.1.min.js"></script>
    <link href="${APP_PATH}static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="empAddModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="empAddModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="empAddModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_and_model_btn">增加</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">

        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
    <button id="mmm" class="btn btn-success">按钮</button>
</div>
<script type="text/javascript">

    //定义总记录数
    var totalRecod;
    //定义当前页
    var currentPage;

    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
        $("#mmm").click(function () {
            window.location.href = "${APP_PATH}/success";
        })
    });

    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn=" + pn,
            type: "get",
            success: function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                build_emps_table(result);
                //2.解析并显示分页信息
                bulid_page_info(result);
                bulid_page_nav(result);

            }
        });
    }


    function build_emps_table(result) {
        //清空table表格
        $("#emps_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            //alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑");
            //为编辑按钮加一个自定义的属性，来表示当前员工的id
            editBtn.attr("edit-id", item.empId);
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
            //为删除按钮添加一个自定义属性来表示当前删除的员工id
            delBtn.attr("del-id", item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        })
    }

    //解析显示分页信息
    function bulid_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" +
            result.extend.pageInfo.pageNum + " 页,总" +
            result.extend.pageInfo.pages + "页，总" +
            result.extend.pageInfo.total + "条记录数");

        totalRecod = result.extend.pageInfo.total;
        currentPage = result.extend.pageInfo.pageNum;


    }

    //解析显示分页条
    function bulid_page_nav(result) {

        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");

        //构建元素
        var firstPageLi = $("<li></li>")
            .append($("<a></a>")
                .append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>")
            .append($("<a></a>")
                .append("&laquo;"));

        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi = $("<li></li>")
            .append($("<a></a>")
                .append("&raquo;"));
        var lastPageLi = $("<li></li>")
            .append($("<a></a>")
                .append("末页").attr("href", "#"));

        if (result.extend.pageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        //构造首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //1,2,3遍历给ul添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>")
                .append($("<a></a>")
                    .append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);

        var navEle = $("<nav></nav>").append(ul);

        navEle.appendTo("#page_nav_area");
    }

    //清除表单
    function reset_form(ele) {
        //清除表单数据
        $(ele)[0].reset();
        //清除表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    $("#emp_and_model_btn").click(function () {
        //清除表单数据和样式
        reset_form("#empAddModal form");

        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#dept_add_select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop: "static"
        });
    });

    //查出所有的部门信息并显示在下拉列表中
    function getDepts(ele) {
        //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //console.log(result);
                //显示部门菜单
                $.each(result.extend.depts, function () {
                    var optionEle = $("<option></option>")
                        .append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
        //1.拿到要校验的数据，使用正则表达式
        var empName = $("#empName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(empName)) {
            // alert("用户名可以是2-5位或者6-16位英文和数字的组合");
            show_validate_msg("#empName_add_input", "error", "用户名可以是2-5位或者6-16位英文和数字的组合");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名可以是2-5位或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#empName_add_input", "success", "");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");
        }

        //2.获取邮箱信息
        var email = $("#email_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            // alert("邮箱格式不正确");
            show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_add_input", "success", "");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //检验用户名是否可用
    $("#empName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var empName = $("#empName_add_input").val();
        $.ajax({
            url: "${APP_PATH}/checkuse",
            data: "empName=" + empName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#empName_add_input", "success", "该用户名可用");
                    $("#emp_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    //点击保存，保存员工
    $("#emp_save_btn").click(function () {
        //1.模态框中填写的表单数据提交给服务器进行保存

        // 2.先对要提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }

        //3.判断之前的ajax用户名校验是否成功
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }

        //4.发送AJAX请求保存员工
        // alert($("#empAddModal form").serialize());
        $.ajax({
            url: "${APP_PATH}/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (result) {
                // alert(result.msg);
                if (result.code == 100) {
                    //1.关闭模态框
                    $("#empAddModal").modal('hide');
                    //2.到最后一页
                    to_page(totalRecod);
                } else {
                    //显示失败信息
                    //console.log(result);
                    if (undefined != result.extend.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#email_add_input", "error", result.extend.errorFields.email);
                    }
                    if (undefined != result.extend.errorFields.empName) {
                        //显示员工名字的错误信息
                        show_validate_msg("#empName_add_input", "error", result.extend.errorFields.empName);
                    }
                }
            }
        });
    });


    //1.我们是按钮创建之前就绑定了click，所以绑定不上
    //1).可以坐在创建按钮的时候绑定，2).绑定点击.live()
    //jquery新版没有live，使用on进行代替
    $(document).on("click", ".edit_btn", function () {
        //1.查出部门信息，并显示部门列表
        getDepts("#empUpdateModal select");
        //2.查出员工信息，显示员工信息
        getEmp($(this).attr("edit-id"));
        //把员工的id传递给模态框的更新按钮
        $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //弹出模态框
        $("#empUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getEmp(id) {
        $.ajax({
            url: "${APP_PATH}/emp/" + id,
            type: "GET",
            success: function (result) {
                // console.log(result);
                var empData = result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=gender]").val([empData.gender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //1.验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#email_update_input", "success", "");
        }
        //2.发送ajax保存更新的员工信息
        $.ajax({
            url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
            type: "POST",
            data: $("#empUpdateModal form").serialize() + "&_method=PUT",
            success: function (result) {
                //1.关闭对话框
                $("#empUpdateModal").modal("hide");
                //2.回到本页面
                to_page(currentPage);
            }
        })
    });

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //1.弹出是否删除确认框
        // alert($(this).parents("tr").find("td:eq(1)").text());
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        var empId = $(this).attr("del-id");
        if (confirm("确认删除【" + empName + "】吗？")) {
            //确认，发送ajax请求删除即可
            $.ajax({
                url: "${APP_PATH}/emp/" + empId,
                type: "DELETE",
                success: function (result) {
                    to_page(currentPage);
                }
            })
        }
    });

    //完成全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined
        //attr获取自定义属性
        //prop获取原生属性
        $(".check_item").prop("checked", $(this).prop("checked"));
    })
    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的原始是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })
    //点击全部删除，就批量删除
    $("#emp_delete_all_btn").click(function () {
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });

        // 取出empNames和del_idstr多余的.和-
        empNames = empNames.substring(0, empNames.length - 1);
        del_idstr = del_idstr.substring(0, empNames.length - 1);

        if (confirm("确认删除【" + empNames + "】吗？")) {
            //发送ajax请求
            $.ajax({
                url: "${APP_PATH}/emp/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    // alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
