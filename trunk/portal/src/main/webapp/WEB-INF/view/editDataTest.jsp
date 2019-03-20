<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2019/3/7
  Time: 16:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>
<html>
<head>
    <title>数据编辑关于替换页面</title>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
    <link rel="Stylesheet" href="${ctx}/resources/css/common.css"/>
    <link rel="Stylesheet" href="${ctx}/resources/css/jquery.jerichotab.css"/>
    <link href="${ctx}/resources/bundles/bootstrap-fileinput/css/bootstrap.min.css"/>
    <style type="text/css">
        table tr td {
            text-align: center;
            border: 1px solid #cad9ea;
            color: #666;
            height: 39px;
            width: 200px;
            white-space: nowrap;
            text-overflow: ellipsis;
            overflow: hidden;
        }

        table thead th {
            background-color: rgb(164, 205, 250);
            /*width: 100px;*/
        }
    </style>

</head>
<body>
<div class="page-content">
    <h3>数据记录管理</h3>
    <hr>
    <div style="">
        <%--显示table表名--%>
        <%--<div style="height: 5%;"><span >数据记录管理</span>
        </div>
        <div style="height: 5%;border: 1px gainsboro solid;">
            <div id="div_tablecol" style="float: left;" class="col-md-12 col-xs-12">
               &lt;%&ndash; <ul id="ul_id" class="nav nav-tabs tabs" role="tablist">

                </ul>&ndash;%&gt;
            </div>
            <div id="add_data" style="float: right;">增加</div>
        </div>--%>
        <%--<div>--%>
        <%--<table>--%>
        <%--<tbody id="tableBodyData"></tbody>--%>
        <%--</table>--%>
        <%--</div>--%>

        <%--<div id="tableDatil" style="margin-top:2px;">
            <div class="portlet-title" style="max-width:98%;margin-left: 1%;margin-right: 1%; max-height:800px;overflow-x: auto">
                <div id="nodata" style="display:none;margin-left: 25%;margin-top: 8%;">
                    <span id="span1" style="font-size: 25px">该表暂时没有数据</span>
                    <span id="span2" style="margin-left: 5%"></span>
                </div>
                <table border="1" id="table1" class="table table-bordered data-table" style="width:100%;">
                    <thead id="thead_id">
                    </thead>

                    <tbody id="fileBody">
                    </tbody>
                </table>
                <div class="review-item clearfix">

                    <div id="page_div" style="padding-top: 25px; float: left; display: none;">
                        当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span
                            style="color:blue;"
                            id="totalPages"></span>页,<span
                            style="color:blue;" id="totalCount"></span>条数据
                    </div>
                    <div style="float: right;">
                        <div id="pagination"></div>
                    </div>

                </div>
            </div>
        </div>--%>

        <!-- 此处是相关代码 -->
        <div style="float: left; width: 90%;overflow: hidden;">
            <ul id="ul_div111" class="nav nav-tabs activeTabs" role="tablist">
            </ul>
        </div>
        <div style="float:left;width:5%;margin-right: 5%;">l
            <button><a href="#" onclick="add_function()">+增加</a></button>
        </div>

        <div id="content_id" class="tab-content activeTabs" style="width:100%;min-height:500px;">

        </div>
        <%--<div class="review-item clearfix">--%>

        <%--<div id="page_div" style="padding-top: 25px; float: left; display: none;">--%>
        <%--当前第<span style="color:blue;" id="currentPageNo"></span>页,共<span--%>
        <%--style="color:blue;"--%>
        <%--id="totalPages"></span>页,<span--%>
        <%--style="color:blue;" id="totalCount"></span>条数据--%>
        <%--</div>--%>
        <%--<div style="float: right;" >--%>
        <%--<div id="pagination"></div>--%>
        <%--</div>--%>

        <%--</div>--%>
        <!-- 相关代码结束 -->
        <%--</div>--%>

        <%--新增表数据--%>
        <div id="staticAddData" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="addTableData"></button>
                        <h4 class="modal-title" id="adddata1">新增数据</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;">
                        <div class="tab-content"
                             style="background-color: white;min-height:300px;max-height:60%;padding-top: 20px ;">
                            <div class="tab-pane active" id="adddata" style=" ">
                                <table id="addTable" class="table table-bordered data-table">
                                    <thead>
                                    <th style="width:20%;">字段名</th>
                                    <th style="width:20%;">字段类型</th>
                                    <th style="width:20%;">注释</th>
                                    <th style="width:40%;">字段值</th>
                                    </thead>
                                    <tbody id="addtbody">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div id="add_div" class="modal-footer">

                    </div>
                </div>
            </div>
        </div>

        <%--修改数据--%>
        <div id="staticUpdateData" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="editTableFieldComsCloseId11"></button>
                        <h4 class="modal-title" id="title_id1">表数据编辑</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;">

                        <div class="tab-content"
                             style="background-color: white;min-height:300px;max-height:50%;padding-top: 20px ;">
                            <div style="margin-left: 1%;margin-right: 1%;width:98%;">
                                <%--style="margin-left: 5%;"--%>
                                <%--<div id="div_head">--%>

                                <%--</div>--%>
                                <%--<div>--%>
                                    <%--<form id="form_id" action="#" method="post" name="form_id">--%>

                                    <%--</form>--%>
                                <%--</div>--%>
                                    <table class="table table-bordered data-table" border="0">
                                        <thead>
                                        <tr>
                                        <th>字段名</th>
                                        <th>字段类型</th>
                                        <th>注释</th>
                                        <th>字段值</th>
                                        </tr>
                                        </thead>
                                        <tbody id="update_tbody"></tbody>
                                    </table>

                            </div>
                        </div>
                    </div>

                    <div id="update_div" class="modal-footer">
                        <%--<button id="updatebtn"  style="width: 80px;height: 30px; border: 1px solid #cad9ea;">保存</button>--%>
                    </div>
                </div>
            </div>
        </div>

        <%--表数据查看详情--%>
        <div id="staticShowDataDetail" class="modal fade" tabindex="-1" data-width="200editTableFieldComsId">
            <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 50%;">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:#28a4a4!important;">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                                id="editTableFieldComsCloseId1"></button>
                        <h4 class="modal-title" id="checkDetial">查看详情</h4>

                    </div>

                    <div class="modal-body" style="overflow:scroll;max-height:600px;">
                        <div class="tab-content"
                             style="background-color: white;padding-top: 20px ;">
                            <div class="tab-pane active" id="checkData1"
                                 style="width: 98%;margin-right: 1%;margin-left: 1%; ">
                                <table border="1" id="checkTable">
                                    <thead>
                                    <th style="width:20%;">字段名</th>
                                    <th style="width:20%;">字段类型</th>
                                    <th style="width:20%;">注释</th>
                                    <th style="width:40%;">字段值</th>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<script type="text/html" id="showDataTmpl">
    {{each dataDatil as value i}}
    <tr>
        <td>{{value}}</td>
    </tr>
    {{/each}}
</script>
</body>
<div id="siteMeshJavaScript">
    <script src="${ctx}/resources/bundles/artTemplate/template.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-validation/js/jquery.validate.min.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/jquery-validation/js/additional-methods.min.js"></script>
    <script src="${ctx}/resources/js/jquery.json.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-toastr/toastr.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/bundles/layerJs/layer.js"></script>
    <script src="${ctx}/resources/bundles/echarts/echarts.min.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <%--<script src="${ctx}/resources/js/jquery-1.3.1.min.js"></script>--%>
    <script src="${ctx}/resources/js/jquery.jerichotab.js"></script>
    <script src="${ctx}/resources/bundles/bootstrapv3.3/js/bootstrap.min.js"></script>
    <script src="${ctx}/resources/bundles/bootstrap-closable-tab/bootstrap-closable-tab.js"></script>
    <%--<script src="${ctx}/resources/js/jquery.jerichotab.min.js"></script>--%>

    <script type="text/javascript">

        var subjectCode = '${sessionScope.SubjectCode}';

        // var S_subjectCode;
        // var S_tableName;
        // var S_column;
        // var S_dataType;
        var S_updateData;
        // var S_columnType;
        // var S_pkColumnArr;
        // var S_autoAddArr;
        var olddata = {};

        $.ajax({
            url: "${ctx}/showTable",
            type: "post",
            dataType: "json",
            data: {"subjectCode": subjectCode},
            success: function (data) {
                $("#alltableName").html("");
                console.log(data);
                var html = template("tableNameTempl", data);
                // var html1=template("tableNametitlecol",data);
                $("#alltableName").append(html);
                // $("#ul_id").append(html1);
                $("#alltableName").show();
            }
        });

        /**
         * 关闭前确认
         * @param i 被关闭的当前元素
         */
        function remove(i) {
            bootbox.confirm("<span style='font-size: 16px'>确认要关闭此条记录吗?</span>", function (r) {
                if (r) {
                    closableTab.closeTab(i);
                }
            })
        }

        /**
         * 分页
         * **/
        function fun_limit(subjectCode, tableName, data) {
            var currentPageNo = "#currentPageNo" + tableName;
            var totalPage = "#totalPages" + tableName;
            var totalCount = "#totalCount" + tableName;
            var pagination = "#pagination" + tableName;

            $(currentPageNo).html(data.currentPage);
            $(totalPage).html(data.totalPages);
            $(totalCount).html(data.totalCount);

            var s = pagination + " .bootpag";
            // alert(s)
            if ($(s).length != 0) {
                $(pagination).off();
                $(pagination).empty();
            }
            $(pagination).bootpag({
                total: data.totalPages,
                page: data.currentPage,
                maxVisible: 5,
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
                clickPageButton(subjectCode, tableName, num);
            });
        }

        //各个页签分页
        function clickPageButton(subjectCode, tableName, num) {
            var ids = "#tab_container_" + tableName;
            $(ids).html("");
            $.ajax({
                type: "post",
                url: "${ctx}/showTableData",
                data: {"subjectCode": subjectCode, "tableName": tableName, "pageNo": num},
                dataType: "json",
                success: function (data) {
                    S_updateData = [];
                    var arr = data.columns;
                    var dataType = data.dataType;
                    S_columnType = [];
                    S_columnType = data.columnType;
                    var columnComment = data.columnComment;
                    var dataArry = data.dataDatil;
                    console.log(dataArry);
                    var delPORTALID;
                    var tabs = "";
                    var s = " ";
                    s = "<table id='" + tableName + "' class='table table-bordered data-table' style='width:100%;'><thead ><tr class='tr_class' style='background-color:gainsboro;'>";
                    //表头
                    var il = 0;
                    if (dataArry.length > 0) {
                        for (var i = 0; i < arr.length; i++) {
                            if (il < 5) {
                                if (arr[i] === "PORTALID") {
                                    s += "<th style='display:none;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                                } else {
                                    s += "<th style='overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "<br/><p title=" + columnComment[i] + ">" + columnComment[i] + "</p></th>";
                                    il++;
                                }
                            } else {
                                s += "<th style='display:none;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;text-align: center;width:13%;height:70px;'title=" + arr[i] + ">" + arr[i] + "</th>";
                            }
                        }
                    }
                    var ss = "";
                    var m = 0;
                    if (dataArry.length > 0) {
                        for (var key in dataArry) {
                            m++;
                            ss += "<tbody><tr>";
                            var d = dataArry[key];
                            var eachData = [];
                            var i = 0;
                            var j = 0;
                            var n = 0;
                            for (var k in d) {
                                n++;
                                if (j < 5) {
                                    if (k === arr[i]) {
                                        if (dataType[i] === "datetime" && d[k] !== null && d[k] !== " ") {
                                            var date = d[k].split(".");
                                            d[k] = date[0];
                                        }
                                        if (k === "PORTALID") {
                                            delPORTALID = d[k];
                                            ss += "<td  style='display:none;' title='" + d[k] + "'>" + d[k] + "</td>";
                                        } else {
                                            ss += "<td title='" + d[k] + "' style='word-break:keep-all;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;'><xmp>" + d[k] + "</xmp></td>";
                                            j++;
                                        }
                                        eachData.push(d[k]);
                                        S_updateData.push(d[k]);
                                    } else {
                                        if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                            var date = d[arr[i]].split(".");
                                            d[arr[i]] = date[0];
                                        }
                                        if (arr[i] === "PORTALID") {
                                            delPORTALID = d[arr[i]];
                                            ss += "<td style='display:none;' title='" + d[arr[i]] + "'>" + d[arr[i]] + "</td>";
                                        } else {
                                            ss += "<td title='" + d[arr[i]] + "' style='word-break:keep-all;white-space: nowrap;text-overflow: ellipsis;overflow: hidden;'><xmp>" + d[arr[i]] + "</xmp></td>";
                                            j++;
                                        }
                                        eachData.push(d[arr[i]]);
                                        S_updateData.push(d[arr[i]]);
                                    }
                                    i++;
                                } else {
                                    if (k === arr[i]) {
                                        if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                            var date = d[k].split(".");
                                            d[k] = date[0];
                                        }
                                        if (k === "PORTALID") {
                                            delPORTALID = d[k];
                                        }
                                        eachData.push(d[k]);
                                        S_updateData.push(d[k]);
                                    } else {
                                        if (dataType[i] === "datetime" && d[arr[i]] !== null && d[arr[i]] !== " ") {
                                            var date = d[arr[i]].split(".");
                                            d[arr[i]] = date[0];
                                        }
                                        if (arr[i] === "PORTALID") {
                                            delPORTALID = d[arr[i]];
                                        }
                                        eachData.push(d[arr[i]]);
                                        S_updateData.push(d[arr[i]]);
                                    }
                                    i++;
                                }
                            }
                            ss += "<td ><a src='#' onclick=\" updateData('" + arr + "','"+delPORTALID+"','" + tableName + "','" + subjectCode + "')\">修改 | </a>" +
                                "<a href='#' onclick=\"checkDada('" + arr + "','"+delPORTALID+"','" + tableName + "','" + subjectCode + "')\">查看 | </a>" +
                                "<a href='#' onclick=\"deleteDate('" + delPORTALID + "','" + tableName + "','" + subjectCode + "')\">删除</a></td></tr>";
                        }
                        ss += "</tbody>";
                        s += "<th style='border:1px #ddd solid;overflow: hidden;white-space: nowrap;ext-overflow: ellipsis;text-align: center;width:22%;height:60px;'>操作</th></tr></thead>";
                        tabs = s + ss + "</table>";

                        tabs += "<div class='review-item clearfix'><div id='page_div" + tableName + "' style='padding-top: 25px; float: left;'>" +
                            "当前第<span style='color:blue;' id='currentPageNo" + tableName + "'></span>页,共<span style='color:blue;' id='totalPages" + tableName + "'></span>页,<span style='color:blue;' id='totalCount" + tableName + "'></span>" +
                            "条数据</div><div style='float: right;' ><div id='pagination" + tableName + "'></div></div></div>";
                        $(ids).append(tabs);
                        fun_limit(subjectCode, tableName, data);
                    } else {
                        $(ids).html(" ");
                        tabs = "<h5 style='font-size: 20px;text-align: center;margin-right: 30%;'>该表暂时没有数据</h5>";
                        $(ids).append(tabs);
                    }
                }
            });
        }

        /**
         * 新增加函数
         * **/
        function add_function() {

            var tableName = $("#ul_div111 li.active a").text();
            $.ajax({
                url: "${ctx}/toaddTableData",
                type: "post",
                dataType: "json",
                data: {"subjectCode": subjectCode, "tableName": tableName},
                success: function (data) {
                    $("#addTable tbody").html(" ");
                    $("#add_div").html(" ");
                    var strs2 = data.COLUMN_NAME;
                    var dataTypeArr = data.DATA_TYPE;
                    var columnComments = data.COLUMN_COMMENT;
                    var autoAddArr = data.autoAdd;
                    var pkColumnArr = data.pkColumn;
                    var s = "";
                    for (var i = 0; i < strs2.length; i++) {
                        if (pkColumnArr[i] === "PRI" && autoAddArr[i] === "auto_increment") {
                            if (strs2[i] === "PORTALID") {
                                s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                            } else {
                                s += "<tr style='display: none;'><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td><input class='addClass' value='0' name='" + strs2[i] + "'/></td></tr>";
                            }
                        } else if (pkColumnArr[i] === "PRI" && autoAddArr[i] !== "auto_increment") {
                            if (strs2[i] === "PORTALID") {
                                s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                            } else {
                                s += "<tr><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>  " + columnComments[i] + "</td><td><input class='addClass' style='width: 100%;height:100%;' value='' name='" + strs2[i] + "'/></td></tr>";
                            }
                        } else {
                            if (strs2[i] === "PORTALID") {
                                s += "<input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='0'/>";
                            } else {
                                s += "<tr><td>" + strs2[i] + "</td><td>" + S_columnType[i] + "</td><td>" + columnComments[i] + "</td><td><input class='addClass' style='width: 100%;height:100%;' value='' name='" + strs2[i] + "'/></td></tr>";
                            }
                        }
                    }

                    var s_add=" <button id='addbtn' style='width: 80px;height: 30px; border: 1px solid #cad9ea;' onclick=\"addTablefuntion('"+dataTypeArr+"','"+strs2+"','"+pkColumnArr+"','"+autoAddArr+"')\">保存</button>";
                    $("#addTable tbody").append(s);
                    $("#add_div").append(s_add);
                    $("#staticAddData").modal("show");
                    // S_subjectCode = subjectCode;
                    // S_tableName = tableName;
                    // S_dataType = dataTypeArr;
                    // S_column = strs2;
                    // S_pkColumnArr = pkColumnArr;
                    // S_autoAddArr = autoAddArr;
                }
            })
        }

        //点击增加按钮增加数据
        function addTablefuntion(dataTypeArr,strs2,pkColumnArr,autoAddArr) {
            //获得当前页码
            // var currentPage = $("#currentPageNo").html();
            var tableName = $("#ul_div111 li.active a").text();
            var dataArr = [];
            var S_dataType=dataTypeArr.split(",");
            var S_column=strs2.split(",");
            var S_pkColumnArr=pkColumnArr.split(",");
            var S_autoAddArr=autoAddArr.split(",");

            $('#addTable input').each(function () {
                dataArr.push($(this).val());
            });
            var data1 = [];
            var datacon = [];
            for (var i = 0, ii = 0; i < S_column.length; i++) {
                //隐藏字段
                if (S_column[i] === "PORTALID") {
                    datacon[i] = "";
                } else if (S_pkColumnArr[i] === "PRI" && S_autoAddArr[i] === "auto_increment") {
                    datacon[i] = "";
                } else {
                    datacon[i] = dataArr[ii];
                    ii++;
                }
            }

            for (var i = 0; i < S_column.length; i++) {
                var data2 = {};
                if (datacon[i] !== "" && datacon[i] !== null) {

                    //char类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "char") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount.length > 255) {
                            toastr.warning(S_column[i] + "字段超出范围！");
                            return;
                        }
                    }

                    //text类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "text") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 65535) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }
                    //longtext类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "longtext") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 4294967295) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }
                    //mediumtext类型判断
                    if (datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null" && S_dataType[i] === "mediumtext") {
                        var bytesCount = 0;
                        var str = datacon[i];
                        for (var j = 0; j < datacon[i].length; j++) {
                            var c = str.charAt(j);
                            if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                                bytesCount += 1;
                            } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                                bytesCount += 2;
                            } else {
                                bytesCount += 1;
                            }
                        }
                        if (bytesCount > 16777215) {
                            toastr.warning(S_column[i] + " 字段超出范围！");
                            return;
                        }
                    }

                    // bit数据类型判断
                    if (dataArr[i] !== "" && datacon[i] !== null && S_dataType[i] === "bit") {
                        if (dataArr[i] !== "0" && dataArr[i] !== "1") {
                            toastr.warning(S_column[i] + " 字段应是boolean类型！");
                            return;
                        }
                    }
                    if (datacon[i] !== null && datacon[i] !== "" && S_dataType[i] === "tinyint") {
                        if (!isNaN(datacon[i])) {
                            if (parseInt(datacon[i]) > 127 || parseInt(datacon[i]) < -128) {
                                toastr.warning(S_column[i] + " 字段超出范围！");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是tinyint类型！");
                            return;
                        }
                    }

                    //smallint数据类型判断
                    if (S_dataType[i] === "smallint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是smallint类型！");
                                return;
                            } else {
                                if (parseInt(datacon[i]) > 32767 || parseInt(datacon[i]) < -32768) {
                                    toastr.warning(S_column[i] + " 字段超出范围！");
                                    return;
                                }
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }

                    //mediumint数据类型判断
                    if (S_dataType[i] === "mediumint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是mediumint类型！");
                                return;
                            } else {
                                if (parseInt(datacon[i]) > 8388607 || parseInt(datacon[i]) < -8388608) {
                                    toastr.warning(S_column[i] + " 字段超出范围！");
                                    return;
                                }
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }
                    //bigint数据类型判断
                    if (S_dataType[i] === "bigint" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        if (!isNaN(datacon[i])) {
                            var result = datacon[i].match(/^(-|\+)?\d+$/);
                            if (result == null) {
                                //警告消息提示s，默认背景为橘黄色
                                toastr.warning(S_column[i] + " 字段应是bigint类型！");
                                return;
                            }
                            // else {
                            //     if (datacon[i] > '9223372036854775807' || datacon[i] > '-9223372036854775808') {
                            //         toastr.warning(S_column[i]+" 字段超出范围！");
                            //         return;
                            //     }
                            // }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }
                    //int数据类型
                    if (datacon[i] !== "" && (S_dataType[i] === "int" || S_dataType[i] === "integer")) {
                        if (!isNaN(datacon[i])) {
                            var reg = /^-?\d+$/;
                            if (!reg.exec(datacon[i])) {
                                toastr.warning(S_column[i] + " 字段应是int或integer类型！");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段应是数字类型！");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "float") {
                        if (isNaN(datacon[i])) {
                            toastr.warning(S_column[i] + " 字段应是float类型！");
                            return;
                        }
                    }
                    if (datacon[i] !== "" && S_dataType[i] === "double") {
                        if (isNaN(datacon[i])) {
                            toastr.warning(S_column[i] + " 字段应是double类型！");
                            return;
                        }
                    }
                    if (S_dataType[i] === "date" && datacon[i] !== null && datacon[i] !== "" && datacon[i] !== "null") {
                        // var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
                        var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                        var regExp = new RegExp(reg);
                        if (!regExp.test(datacon[i])) {
                            toastr.warning(S_column[i] + " 字段是时间格式,正确格式应为: xxxx-xx-xx ");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "datetime") {
                        var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\s+(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
                        var regExp = new RegExp(reg);
                        if (!regExp.test(datacon[i]) && datacon[i] !== null && datacon[i] !== "") {
                            toastr.warning(S_column[i] + " 字段正确格式应为: xxxx-xx-xx xx:xx:xx ");
                            return;
                        }
                    }

                    if (datacon[i] !== "" && S_dataType[i] === "decimal") {
                        var col_type_str = S_columnType[i].split(",");
                        var m = col_type_str[0].split("(")[1];
                        var s = col_type_str[1].split(")")[0];
                        var n = m - s;
                        var pattern = /^(-?\d+)(\.\d+)?$/;    //浮点数
                        var reg = new RegExp(pattern);
                        if (reg.test(datacon[i])) {
                            var ss = datacon[i].split(".");
                            if (ss[0].length > n) {
                                toastr.warning(S_column[i] + " 数据超出范围！ ");
                                return;
                            }
                        } else {
                            toastr.warning(S_column[i] + " 字段是decimal类型！ ");
                            return;
                        }
                    }
                    data2.columnName = S_column[i];
                    data2.columnValue = datacon[i];
                    data1.push(data2);
                } else {
                    data2.columnName = S_column[i];
                    data2.columnValue = datacon[i];
                    data1.push(data2);
                }
            }

            $.ajax({
                url: "${ctx}/addTableData",
                type: "POST",
                data: {
                    "subjectCode": subjectCode,
                    "tableName": tableName,
                    "addData": JSON.stringify(data1)
                },
                dataType: "json",
                success: function (data) {
                    if (data.data === "0") {
                        // alert("添加数据失败，主键重复！");
                        toastr.error("添加数据失败，主键重复！");
                    } else if (data.data === "1") {

                        toastr.success("添加成功!");
                        clickPageButton(subjectCode, tableName, 1);
                        $("#staticAddData").modal("hide");
                    } else if (data.data === "-1") {

                        toastr.error("添加数据失败，主键不能为空！");
                    } else {
                        var arr = data.data.split("+");
                        if (arr[0] === "-2") {
                            toastr.error("添加数据失败，" + arr[1] + " 列不能为空！");
                        }
                    }
                },
                error: function () {
                    alert("error!!!");
                }
            })
        }

        function updateData(columns, delPORTALID,tableName,subjectCode) {
            $("#form_id").html(" ");
            $("#update_tbody").html(" ");
            // $("#div_head").html("");
            $("#update_div").html("");
            //获得当前页码
            var currentPage = $("#currentPageNo"+tableName +"").html();

            var strs2 = new Array(); //定义一数组
            strs2 = columns.split(",");
            $.ajax({
                type: "post",
                url: "${ctx}/toupdateTableData",
                data: {"subjectCode": subjectCode, "tableName": tableName, "PORTALID": delPORTALID},
                dataType: "json",
                success: function (data) {
                    var dataTypeArr = data.DATA_TYPE;
                    var columnComments = data.COLUMN_COMMENT;
                    var autoAddArr = data.autoAdd;
                    var pkColumnArr = data.pkColumn;
                    var COLUMN_TYPE = data.COLUMN_TYPE;
                    var strs = data.data;
                    var delPORTALID="";
                    // var s_head = "<input style='width:20%;' type='text' value='字段名' readonly='true'/><input style='width:20%;' type='text'  value='字段类型' readonly='true'/><input style='width:20%;' type='text'  value='注释' readonly='true'/><input style='width:40%;' type='text'  value='字段值' readonly='true'/><br/>";
                    // var ss = "<input type='text' name='tableName'style='display:none;' value=" + tableName + " />";
                    // ss += "<input type='text' name='subjectCode'style='display:none;' value=" + subjectCode + " />";

                    // for (var i = 0; i < strs2.length; i++) {
                    //     if (strs2[i] === "PORTALID") {
                    //         delPORTALID=strs[i];
                    //         ss += "<input style='display:none;' type='text' value='" + strs2[i] + "' readonly='true'/><input style='display:none;' type='text'  value='" + COLUMN_TYPE[i] + "' readonly='true'/><input style='display:none;' type='text'  value='" + columnComments[i] + "' readonly='true' /><input style='display:none;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' />";
                    //     } else if (dataTypeArr[i] === "text" || dataTypeArr[i] === "longtext") {
                    //         ss += "<table ><tr><td  ><input style='width:100%;height:100%;' type='text' value='" + strs2[i] + "' readonly='true'/></td><td><input style='width:100%;height:100%;' type='text'  value='" + COLUMN_TYPE[i] + "' readonly='true'/></td><td><input  style='width:100%;height:100%;' type='text'  value='" + columnComments[i] + "' readonly='true' /></td><td style='width: 40%;'><textarea  style='width:100%;height:100%'  title='" + strs[i] + "' class='" + dataTypeArr[i] + "'  name=" + strs2[i] + " value='" + strs[i] + "' >" + strs[i] + "</textarea></td></tr>";
                    //     } else {
                    //         ss += "<tr><td><input style='width:20%;' type='text' value='" + strs2[i] + "' readonly='true'/></td><td><input style='width:20%;' type='text'  value='" + COLUMN_TYPE[i] + "' readonly='true'/></td><td><input style='width:20%;' type='text'  value='" + columnComments[i] + "' readonly='true' /></td><td><input title='" + strs[i] + "' style='width:40%;' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' /></td></tr>";
                    //     }
                    //     ss += "</table>";
                    //     var s_save = "<input class='eee' id='btn_save' type='button' value='保存' style='width:80px;height:35px;' onclick=\" saveDataTest('" + tableName + "','" + subjectCode + "','" + dataTypeArr + "','" + currentPage + "','" + strs2 + "','"+delPORTALID+"')\"/>";
                    // }

                    var s_tbody="";
                    for (var i = 0; i < strs2.length; i++) {
                        if (strs2[i] === "PORTALID") {
                            delPORTALID = strs[i];
                        }else{
                            s_tbody+= "<tr><td style='width:20%;'>" + strs2[i] + "</td><td style='width:20%;'> " + COLUMN_TYPE[i] + "</td><td style='width:20%;'>" + columnComments[i] + "</td><td><input title='" + strs[i] + "' style='width:100%;height=100%' class='" + dataTypeArr[i] + "' type='text' name=" + strs2[i] + " value='" + strs[i] + "' /></td></tr>";
                        }
                    }
                        var s_save = "<input class='eee' id='btn_save' type='button' value='保存' style='width:80px;height:35px;' onclick=\" saveDataTest('" + tableName + "','" + subjectCode + "','" + dataTypeArr + "','" + currentPage + "','" + strs2 + "','"+delPORTALID+"')\"/>";

                    // $("#div_head").append(s_head);
                    // $("#form_id").append(ss);
                    $("#update_tbody").append(s_tbody);
                    $("#update_div").append(s_save);
                    $("#staticUpdateData").modal("show");
                }
            });
        }
        
        //修改数据点击保存
        function saveDataTest(tableName, subjectCode, dataType, currentPage,alert_column,delPORTALID) {
            var newdata = $('#form_id').serializeArray();
            var dataTypeArr = dataType.split(",");
            var columnName=alert_column.split(",");
            var form1 = document.getElementById("form_id");
            var kk = 5;
            var checkdataArr = [];

            for (var i = 5; i < form1.elements.length; i++) {
                var e = document.form_id.elements[kk];
                checkdataArr.push(e.value);
                kk = kk + 4;
                if (kk > form1.elements.length) {
                    break;
                }
            }

            for (var i = 0; i < checkdataArr.length; i++) {
                //char类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "char") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount.length > 255) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }

                //text类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "text") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 65535) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }
                //longtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "longtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 4294967295) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }
                //mediumtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "mediumtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 16777215) {
                        toastr.warning(columnName[i]+" 字段超出范围！");
                        return;
                    }
                }

                //bit数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "bit") {
                    if (checkdataArr[i] !== "0" && checkdataArr[i] !== "1") {
                        toastr.warning(columnName[i]+" 字段应是bit类型！");
                        return;
                    }
                }
                //tinyint数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && dataTypeArr[i] === "tinyint") {
                    if (!isNaN(checkdataArr[i])) {
                        if (parseInt(checkdataArr[i]) > 127 || parseInt(checkdataArr[i]) < -128) {
                            toastr.warning(columnName[i]+" 字段超出范围！");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是tinyint等类型！");
                        return;
                    }
                }

                //smallint数据类型判断
                if (dataTypeArr[i] === "smallint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是smallint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 32767 || parseInt(checkdataArr[i]) < -32768) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 该字段应是数字类型！");
                        return;
                    }
                }

                //mediumint数据类型判断
                if (dataTypeArr[i] === "mediumint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是mediumint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 8388607 || parseInt(checkdataArr[i]) < -8388608) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }
                //bigint数据类型判断
                if (dataTypeArr[i] === "bigint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是bigint类型！");
                            return;
                        }
                        // else {
                        //     if (checkdataArr[i] > '9223372036854775807' || checkdataArr[i] > '-9223372036854775808') {
                        //         toastr.warning(columnName[i]+" 字段超出范围！");
                        //         return;
                        //     }
                        // }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }
                //int数据类型判断
                if ((dataTypeArr[i] === "int" || dataTypeArr[i] === "integer") && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i]+" 字段应是int或integer等类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 2147483647 || parseInt(checkdataArr[i]) < -2147483648) {
                                toastr.warning(columnName[i]+" 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段应是数字类型！");
                        return;
                    }
                }

                //float数据类型判断
                if (dataTypeArr[i] === "float" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段应是float类型！");
                        return;
                    }
                    // if(parseFloat(checkdataArr[i]>)){
                    // }
                }
                //double数据类型判断
                if (dataTypeArr[i] === "double" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段应是double类型！");
                        return;
                    }
                }
                //date数据类型判断
                if (dataTypeArr[i] === "date" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    // var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段是时间格式,正确格式应为: xxxx-xx-xx ");
                        return;
                    }
                }
                //datetime数据类型判断
                if (dataTypeArr[i] === "datetime" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\s+(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i]+" 字段正确格式应为: xxxx-xx-xx xx:xx:xx ");
                        return;
                    }
                }
                //decimal数据类型判断
                if (dataTypeArr[i] === "decimal" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var col_type_str = S_columnType[i].split(",");
                    var m = col_type_str[0].split("(")[1];
                    var s = col_type_str[1].split(")")[0];
                    var n = m - s;
                    var pattern = /^(-?\d+)(\.\d+)?$/;    //浮点数

                    var reg = new RegExp(pattern);
                    if (reg.test(checkdataArr[i])) {
                        var ss = checkdataArr[i].split(".");
                        if (ss[0].length > n) {
                            toastr.warning(columnName[i]+" 字段数据超出范围！ ");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i]+" 字段是decimal类型！ ");
                        return;
                    }
                }

            }

            $.ajax({
                url: "${ctx}/saveTableDataTest",
                type: "POST",
                data: {"newdata": JSON.stringify(newdata),
                        "subjectCode": subjectCode,
                         "tableName": tableName,
                         "delPORTALID": delPORTALID},
                dataType: "json",
                success: function (data) {
                    if (data.data === "0") {
                        // alert("更新数据失败！");
                        //错误消息提示，默认背景为浅红色
                        toastr.error("更新数据失败!");
                    } else if (data.data === "1") {
                        //成功消息提示，默认背景为浅绿色
                        toastr.success("更新成功!");
                        $("#staticUpdateData").modal("hide");
                        clickPageButton(subjectCode, tableName, currentPage);
                    } else {
                        var arr = data.data.split("+");
                        if (arr[0] === "-2") {
                            toastr.error("更新数据失败，" + arr[1] + " 列不能为空！");
                        }
                    }
                },
                error: function () {
                    alert("error!!!!!");
                }
            })
        }

        //删除数据
        function deleteDate(delPORTALID, tableName, subjectCode) {

            bootbox.confirm("<span style='font-size: 16px'>确认要删除此条记录吗?</span>", function (r) {
                if (r) {
                    //获得当前页码
                    var currentPage = $("#currentPageNo").html();
                    $.ajax({
                        url: "${ctx}/deleteData",
                        type: "POST",
                        dataType: "json",
                        data: {
                            "subjectCode": subjectCode,
                            "tableName": tableName,
                            "delPORTALID": delPORTALID
                        },
                        success: function (data) {
                            if (data.data === "1") {
                                toastr.success("删除成功!");
                                clickPageButton(subjectCode, tableName, currentPage);

                            }
                            if (data.data === "0") {
                                toastr.error("删除失败！");
                            }
                        }
                    })
                }
            })
        }

        //查看详情
        function checkDada(columns, delPORTALID,tableName,subjectCode) {
            // alert(delPORTALID);
            $("#checkTable tbody").html(" ");
            var strs2 = new Array(); //定义一数组
            strs2 = columns.split(",");

            $.ajax({
                type: "post",
                url: "${ctx}/toupdateTableData",
                data: {"subjectCode": subjectCode, "tableName": tableName, "PORTALID": delPORTALID},
                dataType: "json",
                success: function (data) {
                    var dataTypeArr = data.DATA_TYPE;
                    var columnComments = data.COLUMN_COMMENT;
                    var autoAddArr = data.autoAdd;
                    var pkColumnArr = data.pkColumn;
                    var COLUMN_TYPE=data.COLUMN_TYPE;
                    var t_data=data.data;
                    var s="";
                    for (var i = 0; i < strs2.length; i++) {
                            if (strs2[i] === "PORTALID") {
                                s += "<tr style='display:none;'><td>" + strs2[i] + "</td><td>" + COLUMN_TYPE[i] + "</td><td>" + columnComments[i] + "</td><td>" + t_data[i] + "</td></tr>";
                            } else {
                                s += "<tr><td>" + strs2[i] + "</td><td>" + COLUMN_TYPE[i] + "</td><td>" + columnComments[i] + "</td><td title='" + t_data[i] + "'>" + t_data[i] + "</td></tr>";
                            }
                        }
                    $("#checkTable tbody").append(s);
                    $("#staticShowDataDetail").modal("show");
                }
            });
        }

        //修改数据,保存
        function saveData(tableName, subjectCode, dataType, currentPage, alert_column) {
            var newdata = $('#form_id').serializeArray();
            var dataTypeArr = dataType.split(",");
            var columnName = alert_column.split(",");
            var form1 = document.getElementById("form_id");
            var kk = 5;
            var checkdataArr = [];

            for (var i = 5; i < form1.elements.length; i++) {
                var e = document.form_id.elements[kk];
                checkdataArr.push(e.value);
                kk = kk + 4;
                if (kk > form1.elements.length) {
                    break;
                }
            }
            for (var i = 0; i < checkdataArr.length; i++) {
                //char类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "char") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount.length > 255) {
                        toastr.warning(columnName[i] + " 字段超出范围！");
                        return;
                    }
                }

                //text类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "text") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 65535) {
                        toastr.warning(columnName[i] + " 字段超出范围！");
                        return;
                    }
                }
                //longtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "longtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 4294967295) {
                        toastr.warning(columnName[i] + " 字段超出范围！");
                        return;
                    }
                }
                //mediumtext类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "mediumtext") {
                    var bytesCount = 0;
                    var str = checkdataArr[i];
                    for (var j = 0; j < checkdataArr[i].length; j++) {
                        var c = str.charAt(j);
                        if (/^[\u0000-\u00ff]$/.test(c)) {          //匹配双字节
                            bytesCount += 1;
                        } else if (/^[\u4e00-\u9fa5]$/.test(c)) {
                            bytesCount += 2;
                        } else {
                            bytesCount += 1;
                        }
                    }
                    if (bytesCount > 16777215) {
                        toastr.warning(columnName[i] + " 字段超出范围！");
                        return;
                    }
                }

                //bit数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null" && dataTypeArr[i] === "bit") {
                    if (checkdataArr[i] !== "0" && checkdataArr[i] !== "1") {
                        toastr.warning(columnName[i] + " 字段应是bit类型！");
                        return;
                    }
                }
                //tinyint数据类型判断
                if (checkdataArr[i] !== null && checkdataArr[i] !== "" && dataTypeArr[i] === "tinyint") {
                    if (!isNaN(checkdataArr[i])) {
                        if (parseInt(checkdataArr[i]) > 127 || parseInt(checkdataArr[i]) < -128) {
                            toastr.warning(columnName[i] + " 字段超出范围！");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i] + " 字段应是tinyint等类型！");
                        return;
                    }
                }

                //smallint数据类型判断
                if (dataTypeArr[i] === "smallint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i] + " 字段应是smallint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 32767 || parseInt(checkdataArr[i]) < -32768) {
                                toastr.warning(columnName[i] + " 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i] + " 该字段应是数字类型！");
                        return;
                    }
                }

                //mediumint数据类型判断
                if (dataTypeArr[i] === "mediumint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i] + " 字段应是mediumint类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 8388607 || parseInt(checkdataArr[i]) < -8388608) {
                                toastr.warning(columnName[i] + " 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i] + " 字段应是数字类型！");
                        return;
                    }
                }
                //bigint数据类型判断
                if (dataTypeArr[i] === "bigint" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i] + " 字段应是bigint类型！");
                            return;
                        }
                        // else {
                        //     if (checkdataArr[i] > '9223372036854775807' || checkdataArr[i] > '-9223372036854775808') {
                        //         toastr.warning(columnName[i]+" 字段超出范围！");
                        //         return;
                        //     }
                        // }
                    } else {
                        toastr.warning(columnName[i] + " 字段应是数字类型！");
                        return;
                    }
                }
                //int数据类型判断
                if ((dataTypeArr[i] === "int" || dataTypeArr[i] === "integer") && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (!isNaN(checkdataArr[i])) {
                        var result = checkdataArr[i].match(/^(-|\+)?\d+$/);
                        if (result == null) {
                            //警告消息提示s，默认背景为橘黄色
                            toastr.warning(columnName[i] + " 字段应是int或integer等类型！");
                            return;
                        } else {
                            if (parseInt(checkdataArr[i]) > 2147483647 || parseInt(checkdataArr[i]) < -2147483648) {
                                toastr.warning(columnName[i] + " 字段超出范围！");
                                return;
                            }
                        }
                    } else {
                        toastr.warning(columnName[i] + " 字段应是数字类型！");
                        return;
                    }
                }

                //float数据类型判断
                if (dataTypeArr[i] === "float" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i] + " 字段应是float类型！");
                        return;
                    }
                    // if(parseFloat(checkdataArr[i]>)){
                    // }
                }
                //double数据类型判断
                if (dataTypeArr[i] === "double" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    if (isNaN(checkdataArr[i])) {
                        toastr.warning(columnName[i] + " 字段应是double类型！");
                        return;
                    }
                }
                //date数据类型判断
                if (dataTypeArr[i] === "date" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    // var reg = /^(\d{4})-(\d{2})-(\d{2})$/;
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i] + " 字段是时间格式,正确格式应为: xxxx-xx-xx ");
                        return;
                    }
                }
                //datetime数据类型判断
                if (dataTypeArr[i] === "datetime" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var reg = /^[1-9]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])\s+(20|21|22|23|[0-1]\d):[0-5]\d:[0-5]\d$/;
                    var regExp = new RegExp(reg);
                    if (!regExp.test(checkdataArr[i])) {
                        toastr.warning(columnName[i] + " 字段正确格式应为: xxxx-xx-xx xx:xx:xx ");
                        return;
                    }
                }
                //decimal数据类型判断
                if (dataTypeArr[i] === "decimal" && checkdataArr[i] !== null && checkdataArr[i] !== "" && checkdataArr[i] !== "null") {
                    var col_type_str = S_columnType[i].split(",");
                    var m = col_type_str[0].split("(")[1];
                    var s = col_type_str[1].split(")")[0];
                    var n = m - s;
                    var pattern = /^(-?\d+)(\.\d+)?$/;    //浮点数

                    var reg = new RegExp(pattern);
                    if (reg.test(checkdataArr[i])) {
                        var ss = checkdataArr[i].split(".");
                        if (ss[0].length > n) {
                            toastr.warning(columnName[i] + " 字段数据超出范围！ ");
                            return;
                        }
                    } else {
                        toastr.warning(columnName[i] + " 字段是decimal类型！ ");
                        return;
                    }
                }

            }
            $.ajax({
                url: "${ctx}/saveTableData",
                type: "POST",
                data: {"olddata": JSON.stringify(olddata), "newdata": JSON.stringify(newdata)},
                dataType: "json",
                success: function (data) {
                    if (data.data === "0") {
                        // alert("更新数据失败！");
                        //错误消息提示，默认背景为浅红色
                        toastr.error("更新数据失败!");
                    } else if (data.data === "1") {
                        //成功消息提示，默认背景为浅绿色
                        toastr.success("更新成功!");
                        // alert("更新成功！");
                        $("#staticUpdateData").modal("hide");
                        // editTableData(subjectCode, tableName, currentPage);
                    } else {
                        var arr = data.data.split("+");
                        if (arr[0] === "-2") {
                            toastr.error("更新数据失败，" + arr[1] + " 列不能为空！");
                        }
                    }
                },
                error: function () {
                    alert("error!!!!!");
                }
            })
        };

        $('.tab-close').on('click', function (ev) {
            var ev = window.event || ev;
            ev.stopPropagation();
            //先判断当前要关闭的tab选项卡有没有active类，再判断当前选项卡是否最后一个，
            // 如果是则给前一个选项卡以及内容添加active，否则给下一个添加active类
            var gParent = $(this).parent().parent(),
                parent = $(this).parent();
            if (gParent.hasClass('active')) {
                if (gParent.index() == gParent.length) {
                    gParent.prev().addClass('active');
                    $(parent.attr('href')).prev().addClass('active');
                } else {
                    gParent.next().addClass('active');
                    $(parent.attr('href')).next().addClass('active');
                }
            }
            gParent.remove();
            $(parent.attr('href')).remove();
        });

    </script>
</div>
</html>
