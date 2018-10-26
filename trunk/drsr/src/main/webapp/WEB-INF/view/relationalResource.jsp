<%--
  Created by IntelliJ IDEA.
  User: xiajl
  Date: 2018/09/19
  Time: 15:28
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>系统</title>
    <link href="${ctx}/resources/css/dataSource.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div class="source-head">
        <span>DataSync / 数据源</span>
    </div>
    <div class="source-title">
        <span>关系数据源信息管理</span>
    </div>
    <div class="alert alert-info" role="alert" style="margin:0  33px">
        <!--查询条件 -->
        <div class="row">
            <div class="col-md-12">
                <button type="button" class="btn  btn-sm green pull-right" id="addSqlSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加SQL数据源</button>
            </div>
            <%--<div class="col-md-2">
                <button type="button" class="btn  btn-sm green pull-right" id="addFileSource"><i class="glyphicon glyphicon-plus"></i>&nbsp;添加文件型数据源</button>
            </div>--%>
        </div>
    </div>
    <div class="source-table">
        <div class="table-message">列表加载中......</div>
        <table class="table table-bordered data-table" id="dataSourceList">
            <thead>
            <tr>
                <th>编号</th>
                <th>数据源名称</th>
                <th>数据库名称</th>
                <th>数据源类型</th>
                <th>创建时间</th>
                <th>状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="relationBody">
            </tbody>
        </table>
        <div class="page-message" style="float: left">

        </div>
        <div class="page-list" style="float: right"></div>
    </div>
</div>
<!-- validation add Mode -->
<div id="relationalSourceModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title" id="relationalSourceModalTitle">添加SQL数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="relationalSourceForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">数据源名称<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceName"
                                                   name="dataSourceName"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label  class="col-sm-3 control-label">数据库类型<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <select name="dataBaseType" id="dataBaseType" class="form-control">
                                                <option value="DB2">DB2</option>
                                                <option value="Oracle">Oracle</option>
                                                <option value="SqlServer">SqlServer</option>
                                                <option value="mysql">MySql</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="databaseName" class="col-sm-3 control-label">数据库名称<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="databaseName" name="databaseName">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="host" class="col-sm-3 control-label">主机<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="host" name="host">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="port" class="col-sm-3 control-label">端口<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="port" name="port">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="userName" class="col-sm-3 control-label">用户名<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="userName" name="userName">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="col-sm-3 control-label">密码<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="password" class="form-control" id="password" name="password">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- validation edit Mode -->
<div id="relationalSourceEditModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">编辑SQL数据源</h4>
            </div>
            <div class="form">
                <form class="form-horizontal" role="form" action="" method="post"
                      accept-charset="utf-8" id="relationalSourceEditForm">
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-body">
                                    <div class="form-group">
                                        <label class="col-md-3 control-label">数据源名称<span class="required">
													* </span></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" placeholder="请输入数据源名称"
                                                   id="dataSourceNameE"
                                                   name="dataSourceNameE"/>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label  class="col-sm-3 control-label">数据库类型<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <select name="dataBaseTypeE" id="dataBaseTypeE" class="form-control">
                                                <option value="DB2">DB2</option>
                                                <option value="Oracle">Oracle</option>
                                                <option value="SqlServer">SqlServer</option>
                                                <option value="mysql">MySql</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="databaseNameE" class="col-sm-3 control-label">数据库名称<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="databaseNameE" name="databaseNameE">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="hostE" class="col-sm-3 control-label">主机<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="hostE" name="hostE">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="portE" class="col-sm-3 control-label">端口<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="portE" name="portE">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="userNameE" class="col-sm-3 control-label">用户名<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="text" class="form-control" id="userNameE" name="userNameE">
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="passwordE" class="col-sm-3 control-label">密码<span class="required">
													* </span></label></label>
                                        <div class="col-md-9">
                                            <input type="password" class="form-control" id="passwordE" name="passwordE">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn green">
                            <i class="glyphicon glyphicon-ok"></i>保存</button>
                        <button type="button" data-dismiss="modal" class="btn btn-danger" onclick="cancelButton();">取消</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="idHidden" val=""/>
<script type="text/html" id="resourceTmp1">
    {{each list as value i}}
    <tr keyIdTr="{{value.id}}">
        <td>{{i + 1}}</td>
        <td>{{value.dataSourceName}}</td>
        <td>{{value.databaseName}}</td>
        <td>{{value.databaseType}}</td>
        <td>{{value.createTime}}</td>
        {{if value.stat == 1}}
        <td>正常</td>
        {{else if value.stat == 2}}
        <td>异常</td>
        {{else}}
        <td>异常</td>
        {{/if}}
        <td>
            <button type="button" class="btn btn-success btn-xs purple " onclick="editData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-edit"></i>&nbsp;编辑</button>
            <button type="button" class="btn btn-success btn-xs red" onclick="deleteData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>
        </td>
    </tr>
    {{/each}}
</script>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <%--<script src="${ctx}/resources/bundles/amcharts/amcharts/amcharts.js"></script>--%>
        <script src="${ctx}/resources/bundles/jquery/jquery.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/jquery/jquery.form.min.js" type="text/javascript"></script>
        <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.js"></script>
        <script src="${ctx}/resources/bundles/jquery-validation/js/localization/messages_zh.min.js"></script>
        <script src="${ctx}/resources/bundles/jquery-bootpag/jquery.bootpag.js"></script>
    <script>
        $(function(){
            tableConfiguration();
        });
        /*get data table*/
        function tableConfiguration(num) {
/*
            data.pageNum=num;
*/
        /*    var conData = data;*/
            $.ajax({
                url:"${ctx}/relationship/indexPages",
                type:"GET",
                data:{"num":num},
                success:function (data) {
                    var DataList = JSON.parse(data)
                    var relationData = {
                        list:DataList.relationDataOfThisPage
                    }
                    console.log(DataList.list)
                    var tabCon = template("resourceTmp1", relationData);
                    $("#relationBody").html("");
                    $("#relationBody").append(tabCon);
                    if(DataList.relationDataOfThisPage=="{}"||DataList.relationDataOfThisPage==null){
                        $(".table-message").html("暂时没有数据");
                        $(".page-message").html("");
                        $(".page-list").html("");
                        return
                    }
                    $(".table-message").hide();
                    /*
                     * 创建table
                     * */
                    if ($(".page-list .bootpag").length != 0) {
                        $(".page-list").off();
                        $('.page-list').empty();
                    }
                    $(".page-message").html("当前第"+DataList.currentPage +"页,共"+DataList.totalPage +"页,共"+DataList.totalNum+"条数据");
                    $('.page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.currentPage,
                        maxVisible: 6,
                        leaps: true,
                        firstLastUse: true,
                        first: '首页',
                        last: '尾页',
                        wrapClass: 'pagination',
                        activeClass: 'active',
                        disabledClass: 'disabled',
                        nextClass: 'next',
                        prevClass: 'prev',
                        lastClass: 'last',
                        firstClass: 'first'
                    }).on('page', function (event, num) {
                        tableConfiguration(num);
                    });
                },
                error:function () {
                    $(".table-message").html("请求失败");
                }
            })
        }
        function confirmDeleteNode(){
            $(".form-horizontal [type='text']").val("")
            alert("ok")
        }
        function confirmAddNode(){

        }
        $("#addSqlSource").click(function () {
            $("#relationalSourceModal").modal('show');
            var $sqlFrom =$('#relationalSourceForm')
            handleValidation($sqlFrom);
        })

        //编辑关系数据源
       function editData(dataId) {
            $.ajax({
                type:'post',
                url: "${ctx}/relationship/queryData",
                data:{"dataId":dataId},
                success: function(result) {
                    var jsonData = JSON.parse(result);
                    //var Data = jsonData.substring(1,jsonData.length-1);
                    var dataSourceName = jsonData.dataSourceName;
                    for (var index in jsonData) {
                        for (var key in jsonData[index]) {
                            if (key == 'dataSourceName') {
                                $("#dataSourceNameE").val(jsonData[index][key]);
                            }
                            if (key == 'dataSourceType') {
                                $("#dataSourceTypeE").val(jsonData[index][key]);
                            }
                            if (key == 'databaseName') {
                                $("#databaseNameE").val(jsonData[index][key]);
                            }
                            if (key == 'databaseType') {
                                $("#dataBaseTypeE").val(jsonData[index][key]);
                            }
                            if (key == 'host') {
                                $("#hostE").val(jsonData[index][key]);
                            }
                            if (key == 'port') {
                                $("#portE").val(jsonData[index][key]);
                            }
                            if (key == 'userName') {
                                $("#userNameE").val(jsonData[index][key]);
                            }
                            if (key == 'password') {
                                $("#passwordE").val(jsonData[index][key]);
                            }
                            if (key == 'dataSourceId'){
                                $("#idHidden").val(jsonData[index][key]);
                            }
                        }
                    }
                }
            })
            $("#relationalSourceEditModal").modal('show');
            var $fileFrom =$('#relationalSourceEditForm')
            handleValidation($fileFrom);
        }

        //删除关系数据源
        function deleteData(dataId) {
            bootbox.confirm("确认删除",function (r) {
                if(r){
                    $.ajax({
                        type:'post',
                        url: "${ctx}/relationship/deleteData",
                        data:{"dataId":dataId},
                        success: function(result){
                            var res = JSON.parse(result);
                            if(res=='1'){
                                toastr["success"]("删除成功");
                                tableConfiguration();
                            }else{
                                toastr["error"]("删除失败");
                            }
                        }
                    })
                }else{

                }
            })
        }


        function handleValidation(element) {
            // for more info visit the official plugin documentation:
            // http://docs.jquery.com/Plugins/Validation
            var formValid;
            formValid = element.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "", // validate all fields including form hidden input
                rules: {
                    dataSourceName: {
                        required: true
                    },
                    dataSourceType: {
                        required: true
                    },
                    databaseName: {
                        required: true
                    },
                    host: {
                        required: true
                    },
                    port: {
                        required: true
                    },
                    userName: {
                        required: true
                    },
                    password: {
                        required: true
                    },
                    dataSourceNameE: {
                        required: true
                    },
                    dataSourceTypeE: {
                        required: true
                    },
                    databaseNameE: {
                        required: true
                    },
                    hostE: {
                        required: true
                    },
                    portE: {
                        required: true
                    },
                    userNameE: {
                        required: true
                    },
                    passwordE: {
                        required: true
                    }
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                            .closest('.form-group').addClass('has-error'); // set error class to the control group
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    $(element)
                            .closest('.form-group').removeClass('has-error'); // set error class to the control group
                },

                success: function (label) {
                    label
                            .closest('.form-group').removeClass('has-error'); // set success class to the control group
                },

                submitHandler: function (form) {
                    var formName = $(form).attr('id');
                    if (formName == 'relationalSourceEditForm') {
                        var dataSourceName = $("#dataSourceNameE").val();
                        var dataBaseName = $("#databaseNameE").val();
                        var dataBaseType = $("#dataBaseTypeE").val();
                        var host = $("#hostE").val();
                        var port = $("#portE").val();
                        var userName = $("#userNameE").val();
                        var password = $("#passwordE").val();
                        var dataSourceId = $("#idHidden").val();
                        $.ajax({
                            type: 'post',
                            async: false,
                            url: "${ctx}/relationship/edit",
                            data: {
                                "dataSourceName": dataSourceName,
                                "dataSourceType" : 'db',
                                "dataBaseName": dataBaseName,
                                "dataBaseType": dataBaseType,
                                "host": host,
                                "port": port,
                                "userName": userName,
                                "password": password,
                                "dataSourceId": dataSourceId,
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("编辑成功");
                                    $('#relationalSourceEditModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                }else if(jsonData == '2') {
                                    toastr["error"]("数据库连接失败");
                                }else {
                                    toastr["error"]("编辑失败");
                                }
                            }
                        })
                    } else {
                        var dataSourceName = $("#dataSourceName").val();
                        var dataSourceType = 'db';
                        var dataBaseName = $("#databaseName").val();
                        var dataBaseType = $("#dataBaseType option:selected").val();
                        var host = $("#host").val();
                        var port = $("#port").val();
                        var userName = $("#userName").val();
                        var password = $("#password").val();
                        $.ajax({
                            type: 'post',
                            url: "${ctx}/relationship/add",
                            async: false,
                            data: {
                                "dataSourceName": dataSourceName,
                                "dataSourceType": dataSourceType,
                                "dataBaseName": dataBaseName,
                                "dataBaseType": dataBaseType,
                                "host": host,
                                "port": port,
                                "userName": userName,
                                "password": password
                            },
                            success: function (result) {
                                var jsonData = JSON.parse(result);
                                if (jsonData == '1') {
                                    toastr["success"]("新增成功");
                                    $('#relationalSourceModal').modal('hide');
                                    formValid.resetForm();
                                    tableConfiguration();
                                }else if(jsonData == '2') {
                                    toastr["error"]("数据库连接失败");
                                }else {
                                    toastr["error"]("新增失败");
                                }
                            }
                        })
                    }
                }

            });

            function cancelButton() {
                formValid.resetForm();
            }


        };
        /*jQuery.validator.addMethod("isFilePath", function (value, element) {
         var winPath = /^[a-zA-Z]:(((\/(?! )[^/:*?<>\""|\/]+)+\/?)|(\/)?)\s*$/g;
         var lnxPath = /^([\/][\w-]+)*$/;
         return this.optional(element) || winPath.test(value) || lnxPath.test(value);
         }, "请正确填写路径");*/
    </script>
</div>

</html>