<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/10/30
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set value="${pageContext.request.contextPath}" var="ctx"/>

<html>

<head>
    <title>数据发布管理系统</title>

    <%--<link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jqeury-file-upload/css/jquery.fileupload.css">--%>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/css/jquery.Jcrop.css">
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" type="text/css"
          href="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.css">
    <link href="${ctx}/resources/bundles/select2/select2.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-datepicker/css/datepicker.css">
    <link href="${ctx}/resources/bundles/zTree_v3/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/zTree_v3/css/demo.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/resources/bundles/bootstrap-fileinput/css/fileinput.min.css">
    <style>
        .undeslist label {
            font-size: 18px;
        }

        .custom-error {
            color: #a94442 !important;
            border-color: #a94442 !important;
        }

        .key-word p, .permissions-word p {
            float: left;
            font-size: 14px;
            line-height: 28px;
        }

        .key-word span, .permissions-word span {
            float: left;
            cursor: pointer;
            margin-left: 5px;
            font-size: 16px;
            margin-top: 2px;
        }

        .step .item div {
            border-radius: 50% !important;
        }

    </style>
</head>

<body>
<div class="step">
    <div class="bar">
        <div class="rate" style="width:0"></div>
    </div>
    <table class="items">
        <tr>
            <td class="item active" id="firststep">
                <div class="number">1</div>
                <span>元数据</span></td>
            <td></td>
            <td class="item" id="secondstep">
                <div class="number">2</div>
                <span>实体数据</span></td>
            <td></td>
            <td class="item" id="thirdstep">
                <div class="number">3</div>
                <span>权限设置</span></td>
        </tr>
    </table>
</div>

<div class="form">
    <div class="row">
        <div class="col-md-12">
            <div class="portlet box blue" id="form_wizard_1">

                <div class="portlet-body form">
                    <div class="form-wizard">
                        <div class="form-body">
                            <div class="tab-content">
                                <div class="tab-pane active" id="tab1">
                                    <form class="form-horizontal" id="submit_form1" accept-charset="utf-8" role="form"
                                          onfocusout="true"
                                          method="POST">
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_dataName">数据集名称 <span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="Task_dataName"
                                                       required="required"
                                                       id="Task_dataName" placeholder="请输入名称">
                                            </div>

                                        </div>
                                        <div class="form-group ">
                                            <label class="control-label col-md-3" for="dataDescribeID">简介 <span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">


                                                    <textarea type="text" class="form-control" cols="30" rows="4"
                                                              placeholder="数据集简介信息"
                                                              id="dataDescribeID" name="dataDescribeID"
                                                              required="required"></textarea>

                                            </div>
                                        </div>
                                    </form>
                                    <div style="overflow: hidden;margin: 0 -15px">
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili3" style="text-align: right">图片<span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-9">
                                                <div class=" margin-top-10">
                                                    <form name="form" id="fileForm" action="" class="form-horizontal"
                                                          method="post">
                                                        <div id="cutDiv"
                                                             style="width: 200px; height: 150px;border: 1px solid rgb(169, 169, 169)">
                                                            <%--<img alt="" src="" id="cutimg" style="height: 150px; width: 200px;"/>--%>
                                                            <input type="hidden" id="x" name="x"/>
                                                            <input type="hidden" id="y" name="y"/>
                                                            <input type="hidden" id="w" name="w"/>
                                                            <input type="hidden" id="h" name="h"/>
                                                            <input type="hidden" id="tag" name="tag" val=""/>
                                                            <input type="hidden" id="imgFlagNum" val=""/>
                                                        </div>
                                                        <span class="btn default btn-file" id="checkPicture">
                                                            <span class="fileinput-new">
                                                            选择一个图片</span>
                                                            <input class="photo-file" id="fcupload" type="file"
                                                                   name="imgFile" onchange="readURL(this);">
                                                            </span>
                                                        <span id="uploadSpan" class="btn default btn-file"
                                                              style="display: none">
                                                                <span class="fileinput-new">
                                                            上传</span>
                                                                <input type="button" onclick="doUpload();"/>
                                                        </span>
                                                    </form>
                                                    <div class="timeVili3" style="display: none">请上传选择图片,图片规格为800*600
                                                    </div>
                                                    <div class="clearfix margin-top-10">
                                                        <%--   <span class="label label-danger">
                                                       注意! </span>
                                                                   图片只能在 IE10+, FF3.6+, Safari6.0+, Chrome6.0+ 和
                                                                   Opera11.1+浏览器上预览。旧版本浏览器只能显示图片名称。--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <form class="form-horizontal" id="submit_form2" method="POST" accept-charset="utf-8"
                                          role="form" onfocusout="true">

                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="select2_tags">关键词<span
                                                    class="required">
                                                    * </span></label>
                                            <div class="checkbox-list col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" id="select2_tags" value=""
                                                       name="select2_tags" required="required" placeholder="至少三个关键词">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili2"
                                                   for="centerCatalogId">资源目录<span class="norequired">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" id="cemterCatalogDiv" style="padding-top:13px">

                                                <div id="jstree-demo"></div>
                                                <input type="text" id="centerCatalogId" name="centerCatalogId"
                                                       style="display: none">
                                                <div class="timeVili2" style="display: none">请选择目录</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3 timeVili">选择时间<span
                                                    style="margin-left: 13px">
                                                     </span></label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <div class="input-group input-daterange">
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="起始时间">
                                                    <div class="input-group-addon">to</div>
                                                    <input type="text" class="form-control selectData"
                                                           data-date-format="yyyy-mm-dd" placeholder="结束时间">
                                                </div>
                                                <div class="timeVili" style="display: none">请正确选择时间</div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="dataSourceDesID">版权声明<span
                                                    style="margin-left: 13px">
                                                     </span></label>
                                            <div class="col-md-5" id="dataSourceDes" style="padding-top:13px">
                                                <textarea type="text" class="form-control" cols="30" rows="4"
                                                          placeholder="请输入来源信息"
                                                          id="dataSourceDesID" name="dataSourceDesID"></textarea>

                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="create_Organization">创建者机构 <span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="create_Organization"
                                                       required="required" placeholder="请输入机构名"
                                                       id="create_Organization">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="create_person">创建人员<span
                                                    style="margin-left: 13px">
                                                     </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control"
                                                       id="create_person" name="create_person" placeholder="请输入创建人员">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3">创建日期<span style="margin-left: 13px">
                                                    </span></label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <div class="input-group input-daterange">
                                                    <input type="text" class="form-control selectData" id="createTime"
                                                           data-date-format="yyyy-mm-dd" placeholder="创建日期">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="publish_Organization">发布者机构 <span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="publish_Organization"
                                                       required="required" placeholder="请输入发布者机构"
                                                       id="publish_Organization">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_email">发布者邮箱<span
                                                    class="required">
                                                    * </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control"
                                                       id="Task_email" name="Task_email" required="required"
                                                       placeholder="请输入邮箱号">
                                            </div>

                                        </div>
                                        <div class="form-group">
                                            <label class="control-label col-md-3" for="Task_phone">发布者电话 <span
                                                    style="margin-left: 13px">
                                                     </span>
                                            </label>
                                            <div class="col-md-5" style="padding-top:13px">
                                                <input type="text" class="form-control" name="Task_phone"
                                                       placeholder="请输入电话号码"
                                                       id="Task_phone">
                                            </div>

                                        </div>
                                        <%--xiajl20190310增加 动态扩展元数据信自展示--%>
                                        <div id="divExtMetadata">
                                            <div><br/>自定义扩展的元数据信息：</div>
                                            <c:forEach items="${list}" var="item">
                                                <div class="form-group">
                                                    <label class="control-label col-md-3">${item.extFieldName}
                                                        <c:if test="${item.isMust eq 1}">
                                                            <span class="required"> * </span>
                                                        </c:if>
                                                        <c:if test="${item.isMust != 1}">
                                                            <span style="margin-left:13px"></span>
                                                        </c:if>
                                                    </label>
                                                    <div class="col-md-5" style="padding-top:13px">
                                                        <c:choose>
                                                            <c:when test="${item.type eq 'List'}">
                                                                <select class="form-control enumdataclass"
                                                                        data="${item.enumdata}"
                                                                        name=${item.extField} placeholder="请输入${item.extFieldName}"
                                                                        id=${item.extField}>
                                                                    <c:forEach items="${item.enumdataList}" var="data">
                                                                        <option value="${data}">${data}</option>
                                                                    </c:forEach>

                                                                </select>
                                                            </c:when>
                                                            <c:when test="${item.type eq 'DateTime'}">
                                                                <input type="text" class="form-control selectData"
                                                                       name=${item.extField}  "
                                                                       id=${item.extField}  data-date-format="
                                                                       yyyy-mm-dd" placeholder=${item.extFieldName} >
                                                            </c:when>
                                                            <c:when test="${item.type eq 'Integer'}">
                                                                <input type="text" class="form-control"
                                                                       name=${item.extField} placeholder="请输入${item.extFieldName}"
                                                                       id=${item.extField}  digits="true"
                                                                <c:if test="${item.isMust eq 1}">
                                                                       required='required'</c:if> >
                                                            </c:when>

                                                            <c:when test="${item.type eq 'Double'}">
                                                                <input type="text" class="form-control"
                                                                       name=${item.extField} placeholder="请输入${item.extFieldName}"
                                                                       id=${item.extField}  number="true"
                                                                <c:if test="${item.isMust eq 1}">
                                                                       required='required'</c:if> >
                                                            </c:when>
                                                            <c:otherwise>
                                                                <input type="text" class="form-control"
                                                                       name=${item.extField} placeholder="请输入${item.extFieldName}"
                                                                       id=${item.extField}
                                                                       <c:if test="${item.isMust eq 1}"> required='required'</c:if>  >
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </div>
                                                </div>
                                            </c:forEach>

                                        </div>


                                    </form>

                                </div>
                                <div class="tab-pane" id="tab2">
                                    <div style="font-size: 18px">
                                        <span>数据源:</span>
                                        <input name="ways" type="radio" checked="checked" value="DB" id="aaa"/>
                                        <label for="aaa" style="font-size: 18px;color: #1CA04C">数据库表</label>
                                        <input name="ways" type="radio" value="LH" id="bbb"/>
                                        <label for="bbb" style="font-size: 18px;color: #1CA04C">文件型数据</label>
                                    </div>
                                    <div style="height: 15px"></div>
                                    <div style="overflow: hidden" class="select-database">
                                        <div class="col-md-2" style="font-size: 18px;text-align:left;margin: 0 -15px ">
                                            <span>选择表资源</span>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="row undeslist">
                                            </div>
                                        </div>
                                    </div>
                                    <div style="overflow: hidden;display: none" class="select-local">
                                        <div class="col-md-4 col-md-offset-2" style="font-size: 18px;width: 68%;"
                                             id="fileContainerTree">
                                            <ul id="treeDemo" class="ztree" style="width: 100%;"></ul>
                                        </div>
                                        <div style="height: 15px;clear: both"></div>
                                        <div class="col-md-4 col-md-offset-2" style="font-size: 18px;width: 68%;">
                                            <span style="margin-left: -26%;position: absolute">在线上传：</span>
                                            <div>
                                                <input id="file-1" type="file" multiple>
                                            </div>
                                        </div>
                                        <div id="fileDescribeDiv" class="col-md-5 tagsinput"
                                             style="border: 1px solid grey;display: none">


                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="tab3">

                                    <div style="overflow: hidden">
                                        <div class="col-md-6 col-md-offset-1" style="font-size: 18px">
                                            <form class="form-horizontal">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label">可公开范围</label>
                                                    <div class="col-sm-8">
                                                        <select name="permissions" id="permissions" class="form-control"
                                                                multiple>
                                                        </select>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="form-actions">
                            <div class="row">
                                <div class="col-md-offset-3 col-md-9">
                                    <a href="javascript:;" class="btn btn-default" onclick="fromAction(false)"
                                       style="display: none;margin-left: 10%">
                                        <%--<i class="m-icon-swapleft"></i> --%>
                                        上一步 </a>
                                    <a href="javascript:;" class="btn btn-primary" onclick="fromAction(true)"
                                       style="margin-left: 30%;">
                                        下一步
                                        <%--<i class="m-icon-swapright m-icon-white"></i> --%>
                                    </a>
                                    <a href="javascript:;" class="btn green button-submit"
                                       style="display: none;margin-left: 30%;">
                                        提交
                                        <%--<i class="m-icon-swapup m-icon-white"></i>--%>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="subjectCode" value="${sessionScope.SubjectCode}"/>
<input type="hidden" id="imgPath" val="">
<script type="text/html" id="dataRelationshipList">
    {{each list as value i}}
    <div class="col-md-4">
        <label>
            <div style="float: left;width: 20px;height: 34px"><input type="checkbox" name="resTable" keyval="{{value}}">
            </div>
            <div style="padding-left: 20px;word-break: break-all;cursor: pointer" keyval="{{value}}"> {{value}}</div>
        </label>
    </div>
    {{/each}}
</script>
<div id="staticSourceTableChoiceModal" class="modal fade" tabindex="-1" data-width="200">
    <div class="modal-dialog" style="min-width:600px;width:auto;max-width: 55%">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"
                        id="editTableFieldComsCloseId"></button>
                <h4 class="modal-title" id="relationalDatabaseModalTitle">预览数据</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="portlet box green-haze" style="border:0;">
                            <div class="portlet-title " style="display: none">
                                <ul class="nav nav-tabs" style="float:left;">
                                    <li class="active" style="display: none">
                                        <a href="#editTableFieldComsId" data-toggle="tab"
                                           id="editTableDataAndComsButtonId" aria-expanded="true">
                                            编辑 </a>
                                    </li>
                                    <li class="active">
                                        <a href="#previewTableDataAndComsId" id="previewTableDataAndComsButtonId"
                                           data-toggle="tab" aria-expanded="false">
                                            预览 </a>
                                    </li>
                                </ul>
                            </div>
                            <div class="tab-content"
                                 style="background-color: white;min-height:300px;max-height:70%;padding-top: 20px ; overflow: scroll;">
                                <div class="tab-pane active" id="editTableFieldComsId">
                                </div>
                                <div class="tab-pane" id="previewTableDataAndComsId">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" data-dismiss="modal" class="btn btn-success">关闭
                </button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="dataUserList">
    {{each groupList as value i}}
    <option value="{{value.groupName}}">{{value.groupName}}</option>
    {{/each}}
</script>
<%@ include file="./tableFieldComsTmpl.jsp" %>
</body>

<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script type="text/javascript" src="${ctx}/resources/js/jquery.Jcrop.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/jquery-form/jquery.form.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/bootstrap-new-fileinput/bootstrap-fileinput.js"></script>
    <script src="${ctx}/resources/bundles/jstree/dist/jstree.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/select2/select2.min.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript"
            src="${ctx}/resources/bundles/bootstrap-datepicker/js/locales/bootstrap-datepicker.zh-CN.js"></script>
    <script src="${ctx}/resources/js/dataRegisterEditTableFieldComs.js"></script>
    <script src="${ctx}/resources/bundles/zTree_v3/js/jquery.ztree.all.js"></script>
    <script src="${ctx}/resources/js/jquery.json.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script type="text/javascript" src="${ctx}/resources/bundles/bootstrap-fileinput/js/locals/zh.js"></script>
    <script type="text/javascript">
        var ctx = '${ctx}';
        var sdoId = "${resourceId}";
        var sub = '${sessionScope.SubjectCode}'
        var initNum = 1;
        var firstFlag = false;
        var secondFlag = false;
        var resourceId = sdoId;
        var publicType = "mysql";
        var firstTime;
        var lastTime;
        var uploadFilePath = [];
        var userList;

        $(function () {
            // $(".time_div").html("");
            $(".fabu_div2").html("数据发布 - 第1步，共3步");
            $("#file-1").fileinput({
                uploadAsync: false,
                theme: 'fas',
                language: 'zh',
                uploadUrl: '${ctx}/fileNet/uploadResourceExtraFile', // you must set a valid URL here else you will get an error
                overwriteInitial: false,
                maxFileSize: 500000,
                maxFileCount: 10,
                dropZoneEnabled: false,
                showPreview: true,
                layoutTemplates: { // 设置预览框中的按钮
                    actionUpload: ''    //设置为空可去掉上传按钮
                    // actionDelete:''  //设置为空可去掉删除按钮
                },
                showUploadedThumbs: true,
                // 文件缓存过程将源文件名称中的敏感字符替换
                slugCallback: function (filename) {
                    return filename.replace('(', '_').replace(']', '_');
                }
            }).on("filebatchuploadsuccess", function (event, data) { // 选中文件全部上传成功后调用
                uploadFilePath = data.response;
            }).on("filesuccessremove", function (event, id, index) {// 预览且已上传情况下 删除之前
                var deleteFileName = $("#" + id).find(".file-thumbnail-footer").find(".file-footer-caption").attr("title");
                removeFileFromFtpAndUploadFilePath(deleteFileName);
            });
        });

        function removeFileFromFtpAndUploadFilePath(deleteFileName) {

            var ftpFilePath = findFtpPathAndRemove(deleteFileName);
            $.ajax({
                url: "${ctx}/fileNet/deleteFile",
                type: "POST",
                dataType: "JSON",
                data: {
                    deletePath: ftpFilePath
                },
                success: function (data) {

                }
            })
        }

        function findFtpPathAndRemove(deleteFileName) {
            var ftpFilePath, pathIndex;
            $.each(uploadFilePath, function (index, value) {
                if (value.endsWith(deleteFileName)) {
                    ftpFilePath = value;
                    pathIndex = index;
                }
            });
            uploadFilePath.splice(pathIndex, 1);
            return ftpFilePath;
        }

        /*var tagNames=new Array();*/
        $('.selectData').datepicker({
            language: 'zh-CN'
        });
        $('.selectData').each(function () {
            $(this).datepicker('clearDates');
        });
        $('.selectData:eq(0)').datepicker().on("changeDate", function (ev) {
            firstTime = new Date(ev.date).getTime()
            $(".timeVili").removeClass("custom-error")
            $(".timeVili:eq(1)").hide()
        })
        $('.selectData:eq(1)').datepicker().on("changeDate", function (ev) {
            lastTime = new Date(ev.date).getTime()
            $(".timeVili").removeClass("custom-error")
            $(".timeVili:eq(1)").hide()
        })

        var validData = {
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                Task_dataName: {
                    required: true,
                    minlength: 15
                },
                dataDescribeID: {
                    required: true,
                    minlength: 50
                }
            },
            messages: {
                Task_dataName: {
                    required: "请输入数据集名称",
                    minlength: "不少于15个字符"
                },

                dataDescribeID: {
                    required: "请输入简介信息",
                    minlength: "不少于50个字符"
                },
            },
            errorPlacement: function (error, element) { // render error placement for each input type
                if (element.parent(".input-group").size() > 0) {
                    error.insertAfter(element.parent(".input-group"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },
            highlight: function (element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            }
        };
        var validData2 = {
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            rules: {
                select2_tags: {
                    required: true,
                    minThreeKey: true
                },
                startTime: {
                    required: true
                },
                endTime: {
                    required: true
                },
                create_Organization: {
                    required: true,
                },
                publish_Organization: {
                    required: true,
                },
                Task_phone: {
                    isPhone: true
                },
                Task_email: {
                    required: true,
                    isEmail: true
                },
                centerCatalogId: {
                    resourceDir: true
                }
            },
            messages: {
                select2_tags: {
                    required: "至少添加三个关键词"
                },
                startTime: {
                    required: "请输入起始时间"
                },
                endTime: {
                    required: "请输入结束时间"
                },
                create_Organization: {
                    required: "请输入机构名",
                },
                publish_Organization: {
                    required: "请输入发布者机构",
                },
                Task_email: {
                    required: "请输入发布者邮箱地址"
                },
            },
            errorPlacement: function (error, element) { // render error placement for each input type
                if (element.parent(".input-group").size() > 0) {
                    error.insertAfter(element.parent(".input-group"));
                } else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
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

        };

        jQuery.validator.addMethod("isPhone", function (value, element) {
            var isPhone = /^([0-9]{3,4}-)?[0-9]{7,8}$/;
            var isMob = /^((\+?86)|(\(\+86\)))?(13[012356789][0-9]{8}|15[012356789][0-9]{8}|18[02356789][0-9]{8}|147[0-9]{8}|1349[0-9]{7})$/;
            return this.optional(element) || isMob.test(value) || isPhone.test(value);
        }, "请输入正确电话号码");

        jQuery.validator.addMethod("isEmail", function (value, element) {
            var winPath = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
            return this.optional(element) || winPath.test(value);
        }, "请输入正确邮箱地址");

        jQuery.validator.addMethod("minThreeKey", function (value, element) {
            var keyFlag = $("#select2_tags").val().split(",").length < 3 ? false : true
            return keyFlag;
        }, "至少输入三个关键词");

        jQuery.validator.addMethod("resourceDir", function () {
            var resurceDir = $.trim($("#centerCatalogId").val()).length === 0 ? false : true;
            return resurceDir;
        }, "请选择资源目录");

        $("#select2_tags").change(function () {
            $("#submit_form2").validate(validData2).element($(this)); //revalidate the chosen dropdown value and show error or success message for the input
        })

        $("#submit_form1").validate(validData)
        $("#submit_form2").validate(validData2)


        //将图片截图并上传功能
        var api = null;

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.readAsDataURL(input.files[0]);
                reader.onload = function (event) {
                    $('#cutimg').removeAttr('src');
                    $('#cutimg').attr('src', event.target.result);
                    $("#checkPicture").hide();
                    $("#uploadSpan").show();
                    // console.log(event.target.result)
                    api = $.Jcrop('#cutimg', {
                        setSelect: [10, 10, 100, 100],
                        aspectRatio: 4 / 3,
                        allowSelect: true,
                        /* allowSelect:false,
                         allowResize:false,*/
                        onSelect: updateCoords,
                        onChange: updateCoords
                    });
                };
                if (api != undefined) {
                    api.destroy();
                }
            }

            function updateCoords(obj) {
                $("#x").val(obj.x);
                $("#y").val(obj.y);
                $("#w").val(obj.w);
                $("#h").val(obj.h);
            };
        }

        function doUpload() {
            $(".jcrop-holder").hide();
            var formData = new FormData($("#fileForm")[0]);
            $.ajax({
                url: '${ctx}/resource/uploadHeadImage',
                type: 'post',
                data: formData,
                async: false,
                cache: false,
                contentType: false,
                processData: false,
                success: function (result) {
                    var resultJson = JSON.parse(result);
                    // console.log(resultJson)
                    var filePath = resultJson.saveName;
                    $("#imgPath").val(resultJson.saveName);
                    $('.jcrop-tracker').hide();
                    $("#checkPicture").show();
                    $("#uploadSpan").hide();
                    $('#cutimg').attr('src', filePath);
                    $('#cutimg').show();
                },
                error: function (returndata) {
                    alert(returndata);
                }
            });
        }

        $(".progress-bar-success").width(initNum * 33 + "%");
        $("[name='ways']").on("change", function () {
            if (this.value == "DB") {
                $(".select-database").show();
                $(".select-local").hide();
                publicType = "mysql"
            } else {
                $(".select-database").hide();
                $(".select-local").show();
                publicType = "file"
            }
        })
        $("[name='need_checked']").on("change", function () {
            var $index = $("[name='need_checked']").index($(this))
            if ($(this).val() != "" && $(this).val().trim() != "") {
                $("[name='need_checked']:eq(" + $index + ")").removeClass("custom-error")
                $("[name='need_message']:eq(" + $index + ")").removeClass("custom-error")
                $("[name='need_message']:eq(" + $index + ")").hide()
                $(".required:eq(" + $index + ")").parent().removeClass("custom-error")
            }
        })
        $("#task_email").on("change", function () {
            $("[name='data_email']").hide()
        })
        $("#task_phone").on("change", function () {
            $("[name='data_phone']").hide()
        })
        $(".undeslist").delegate("input", "click", function () {
            staticSourceTableChoice(1, this, sub, $(this).attr("keyval"), "dataResource")
            $("#previewTableDataAndComsButtonId").click()
        })
        $(".button-submit").click(function () {
            addResourceThirdStep()
        })

        relationalDatabaseTableList();

        function fromAction(flag) {
            if (flag) {
                ++initNum;
                if (initNum == 2) {
                    if (resourceId == "") {
                        addResourceFirstStep()
                    } else {
                        editResourceFirstStep()
                    }
                    if (firstFlag) {
                        initNum--
                        toastr["error"]("请填写必须项目");
                        return
                    }
                    $("#firststep").removeClass("item active");
                    $("#firststep").addClass("item finish");
                    $(".fabu_div2").html("数据发布 - 第2步，共3步");
                    $("#secondstep").removeClass("item");
                    $("#secondstep").addClass("item active");
                    $(".rate").css("width", "50%");

                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum * 33 + "%");
                    $("#tab1").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(1)").addClass("active")
                    $(".btn-default").show();
                } else if (initNum == 3) {
                    addResourceSecondStep()
                    if (secondFlag) {
                        initNum--
                        toastr["error"]("请选择至少一项");
                        return
                    }
                    $("#secondstep").removeClass("item active");
                    $("#secondstep").addClass("item finish");
                    $(".fabu_div2").html("数据发布 - 第3步，共3步");
                    $("#thirdstep").removeClass("item");
                    $("#thirdstep").addClass("item active");
                    $(".rate").css("width", "100%");

                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum * 33 + "%");
                    $("#tab2").removeClass("active")
                    $("#tab3").addClass("active")
                    $(".steps li:eq(2)").addClass("active")
                    $(".button-submit").show()
                    $(".btn-primary").hide()
                }
            } else {
                --initNum
                if (initNum == 1) {
                    $("#secondstep").removeClass("item active");
                    $("#secondstep").addClass("item");
                    $(".fabu_div2").html("数据发布 - 第1步，共3步");
                    $("#firststep").removeClass("item finish");
                    $("#firststep").addClass("item active");
                    $(".rate").css("width", "0");

                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum * 33 + "%");
                    $("#tab2").removeClass("active")
                    $("#tab1").addClass("active")
                    $(".steps li:eq(1)").removeClass("active")
                    $(".btn-default").hide();
                } else if (initNum == 2) {
                    $("#thirdstep").removeClass("item active");
                    $("#thirdstep").addClass("item");
                    $(".fabu_div2").html("数据发布 - 第2步，共3步");
                    $("#secondstep").removeClass("item finish");
                    $("#secondstep").addClass("item active");
                    $(".rate").css("width", "50%");

                    $("#staNum").html(initNum)
                    $(".progress-bar-success").width(initNum * 33 + "%");
                    $("#tab3").removeClass("active")
                    $("#tab2").addClass("active")
                    $(".steps li:eq(2)").removeClass("active")
                    $(".btn-primary").show()
                    $(".button-submit").hide()
                }
            }
        }

        function initCenterResourceCatalogTree(container, index) {
            $.ajax({
                url: ctx + "/getLocalResCatalog",
                type: "get",
                dataType: "json",
                data: {editable: false},
                success: function (data) {
                    // console.log(data)
                    // console.log(index)
                    var listPar = data.core.data
                    if (data.id == index) {
                        data.state.selected = true
                    } else {

                    }
                    $(container).jstree(data).bind("select_node.jstree", function (event, selected) {
                        /*$(".button-save").removeAttr("disabled");*/
                        $("#centerCatalogId").val(selected.node.id);
                        $(".timeVili2").removeClass("custom-error")
                        $(".timeVili2:eq(1)").hide()
                    }).on("loaded.jstree", function (event, data) {
                        //这两句化是在loaded所有的树节点后，然后做的选中操作，这点是需要注意的，loaded.jstree 这个函数
                        //取消选中，然后选中某一个节点
                        $(container).jstree("deselect_all", true);
                        //$("#keyKamokuCd").val()是选中的节点id，然后后面的一个参数 true表示的是不触发默认select_node.change的事件
                        $(container).jstree('select_node', index, true);
                    });
                }
            })
        }

        function relationalDatabaseTableList() {
            $.ajax({
                url: ctx + "/resource/relationalDatabaseTableList",
                type: "GET",
                success: function (data) {
                    $(".undeslist").empty();
                    var List = JSON.parse(data)
                    // console.log(List)
                    var tabCon = template("dataRelationshipList", List);
                    $(".undeslist").append(tabCon);

                },
                error: function (data) {
                    console.log("请求失败")
                }
            })
        }

        function userGroupList() {
            $.ajax({
                url: ctx + "/resource/getUserGroups",
                type: "GET",
                async: false,
                success: function (data) {
                    var list = JSON.parse(data)
                    var tabCon = template("dataUserList", list);
                    $("#permissions").append(tabCon);
                    $('#permissions').select2().val(userList).trigger("change");
                    $('#permissions').select2({
                        placeholder: "请选择用户",
                        allowClear: true,
                    });
                    debugger
                },
                error: function () {
                    console.log("请求失败")
                }
            })
        }

        function addResourceSecondStep() {
            secondFlag = false
            var dataList = ""
            if (publicType == "mysql") {
                var $ele = $("[name='resTable']:checked")

                $ele.each(function () {
                    dataList += $(this).attr("keyval") + ";"
                })
            } else {
                var fileList = getChecedValueInLocalTree();
                if (fileList.length !== 0) {
                    var userUploadPath = $.fn.zTree.getZTreeObj("treeDemo").getNodesByFilter(function (node) {
                        return node.level === 0;
                    }, true).id + "/userUpload";
                    if (fileList.indexOf(userUploadPath) === -1) {
                        fileList.splice(0, 0, userUploadPath);
                    }
                    dataList = fileList.toString();
                }
            }
            if (dataList.length === 0) {
                secondFlag = true;
                return
            }
            var reg2 = new RegExp(',', "g");
            dataList = dataList.replace(reg2, ';');
            $.ajax({
                url: ctx + "/resource/addResourceSecondStep",
                type: "POST",
                data: {
                    resourceId: resourceId,
                    publicType: publicType,
                    dataList: dataList
                },
                success: function (data) {
                    // console.log(data)
                },
                error: function (data) {
                    console.log("请求失败")
                }
            })
            userGroupList()
        }

        function addResourceThirdStep() {
            var $preEle = $("#permissions").val();
            if ($preEle == null) {
                toastr["error"]("请选择用户组");
                return
            }
            $.ajax({
                url: ctx + "/resource/addResourceThirdStep",
                type: "POST",
                data: {
                    resourceId: resourceId,
                    userGroupIdList: $preEle.toString()
                },
                success: function (data) {
                    window.location.href = "${ctx}/dataRelease"
                },
                error: function (data) {
                    console.log("请求失败")
                }
            })
        }

        function editResourceFirstStep() {
            firstFlag = false
            if ((firstTime == null && lastTime != null) || (firstTime != null && lastTime == null) || (firstTime > lastTime)) {
                $(".timeVili").addClass("custom-error")
                $(".timeVili:eq(1)").show()
                firstFlag = true
            }
            if ($("#centerCatalogId").val() == "") {
                $(".timeVili2").addClass("custom-error")
                $(".timeVili2:eq(1)").show()
                firstFlag = true
            }
            if (!$("#submit_form1").valid()) {
                firstFlag = true
            }
            if (!$("#submit_form2").valid()) {
                firstFlag = true
            }
            if (firstFlag) {
                return
            }
            var keywordStr = $("#select2_tags").val()
            var createTime = "";
            if ($.trim($("#createTime").val()).length === 0) {
                var date = new Date();
                createTime = date.Format("yyyy-MM-dd");
            } else {
                createTime = $.trim($("#createTime").val());
            }
            //xiajl20190310增加 扩展元数据
            var d = {};
            var t = $("#submit_form2").serializeArray();
            $.each(t, function () {
                // console.log(this.name);
                if (this.name.indexOf("ext_") >= 0) {
                    d[this.name] = this.value;
                }
            });
            var extData = JSON.stringify(d);
            $.ajax({
                url: ctx + "/resource/editResourceFirstStep",
                type: "POST",
                data: {
                    resourceId: resourceId,
                    title: $("#Task_dataName").val(),
                    imagePath: $("#imgPath").val(),
                    introduction: $("#dataDescribeID").val(),
                    keyword: keywordStr,
                    catalogId: $("#centerCatalogId").val(),
                    createdByOrganization: $("#dataSourceDesID").val(),
                    startTime: $('.selectData:eq(0)').val(),
                    endTime: $('.selectData:eq(1)').val(),
                    email: $("#Task_email").val(),
                    phoneNum: $("#Task_phone").val(),
                    creatorCreateTimeString: createTime,
                    publishOrganization: $("#publish_Organization").val(),
                    createOrganization: $("#create_Organization").val(),
                    createPerson: $("#create_person").val(),
                    extMetadata: extData
                },
                success: function (data) {
                },
                error: function (data) {
                    console.log("请求失败")
                }
            })
        }

        function getResourceById() {
            $.ajax({
                url: ctx + "/resource/getResourceById",
                type: "POST",
                data: {
                    resourceId: resourceId,
                },
                success: function (data) {
                    var totalList = JSON.parse(data).resource
                    // console.log(JSON.parse(data));
                    initCenterResourceCatalogTree($("#jstree-demo"), totalList.catalogId);
                    $("#Task_dataName").val(totalList.title)
                    $("#Task_email").val(totalList.email)
                    $("#Task_phone").val(totalList.phoneNum)
                    firstTime = totalList.startTime
                    lastTime = totalList.endTime
                    if (firstTime != null) {
                        $('.selectData:eq(0)').val(convertMilsToDateString(firstTime))
                    }
                    if (lastTime != null) {
                        $('.selectData:eq(1)').val(convertMilsToDateString(lastTime))
                    }
                    if (totalList.creatorCreateTime != null) {
                        $("#createTime").val(convertMilsToDateString(totalList.creatorCreateTime))
                    }
                    $("#publish_Organization").val(totalList.publishOrgnization)
                    $("#create_Organization").val(totalList.createOrgnization)
                    $("#create_person").val(totalList.createPerson)
                    $("#dataDescribeID").val(totalList.introduction)
                    $("#cutDiv").append('<img src="" id="cutimg" style="height:100%; width: 100%;display: block"/>');
                    var path = totalList.imagePath;
                    $('#cutimg').attr('src', path);
                    $('#imgPath').val(totalList.imagePath);
                    publicType = totalList.publicType == "" ? "mysql" : totalList.publicType == "mysql" ? "mysql" : "file"
                    $("#select2_tags").val(totalList.keyword)
                    $("#select2_tags").select2({
                        tags: true,
                        multiple: true,
                        tags: [""],
                    });
                    $("#dataSourceDesID").val(totalList.createdByOrganization)
                    var publicContentList = totalList.publicContent.split(";")
                    var typeNum = (totalList.publicType == "mysql" || totalList.publicType == "") ? 0 : 1;
                    $("[name='ways']:eq(" + typeNum + ")").prop("checked", true)
                    if (typeNum == 0) {
                        for (var i = 0; i < publicContentList.length; i++) {
                            $("[keyval='" + publicContentList[i] + "']").prop("checked", true)
                        }
                    } else {
                        var fileId = totalList.filePath
                        fileId = fileId.substr(0, fileId.length - 1);
                        var str = fileId.replace(/%_%/g, "/");
                        // console.log(str);
                        var filePathList = str.split(";")
                        // console.log(filePathList)
                        $(".select-database").hide();
                        $(".select-local").show();

                    }
                    userList = totalList.userGroupId.split(",")

                    //xiajl20190310增加，显示扩展元数据信息
                    // console.log('begin20190310');

                    $("#divExtMetadata input,select").each(function () {
                        var str = this.name;
                        var valueStr = "";
                        for (var i = 0; i < totalList.extMetadata.length; i++) {
                            $.each(totalList.extMetadata[i], function (key, value) {
                                if (key == str) {
                                    valueStr = value;
                                }
                            })
                        }
                        // console.log("xiajl=====:" + valueStr);
                        $(this).val(valueStr);
                    });
                },
                error: function (data) {
                    console.log("请求失败")
                }
            })
        }


        function initFileTree() {
            var root;
            $.ajax({
                type: "GET",
                url: '${ctx}/resource/fileSourceZtreeFileList',
                data: {
                    resourceId: resourceId
                },
                dataType: "json",
                async: false,
                success: function (data) {
                    var zTreeObj = $.fn.zTree.getZTreeObj("treeDemo");
                    if (zTreeObj != null) {
                        zTreeObj.destroy();//用之前先销毁tree
                    }
                    var fileNodes = data.nodeList;
                    var zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, fileNodes);

                    root = data;
                }
            });
            return root;
        }

        function getFileList(folderPath) {
            var children;
            $.ajax({
                url: "${ctx}/resource/treeNode",
                type: "get",
                data: {'filePath': folderPath},
                dataType: "json",
                async: false,
                success: function (data) {
                    children = data;
                }
            });
            return children;
        }

        function generateChildJson(childArray) {
            // console.log(childArray)
            for (var i = 0; i < childArray.length; i++) {
                var child = childArray[i];
                if (child.type == 'directory') {
                    child.children = true;
                    child.icon = "jstree-folder";
                } else {
                    child.icon = "jstree-file";
                }
            }
        }

        function tagClick(obj) {
            $(obj).parent().remove();
        }

        jQuery(document).ready(function () {
            getResourceById();
            initFileTree();
        })


        var setting = {
            async: {
                enable: true,
                url: "${ctx}/resource/ZTreeNode",
                autoParam: ["id", "pid", "name"],
                dataFilter: filter
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'pid',
                    rootPId: 0
                }
            },
            check: {
                enable: true
            },
            callback: {
                beforeAsync: beforeAsync,
                onAsyncSuccess: onAsyncSuccess,
                onAsyncError: onAsyncError,
                onCheck: asyncAll
            }
        };

        function filter(treeId, parentNode, childNodes) {
            if (parentNode.checked == true) {
                for (var num = 0; num < childNodes.length; num++) {
                    childNodes[num].open = true;
                    childNodes[num].checked = true;
                }
            }
            return childNodes;
        }

        // 递归，获取所有子节点
        function getAllChildrenNodes(treeNode, result) {
            if (treeNode.isParent) {
                var childrenNodes = treeNode.children;
                if (childrenNodes) {
                    for (var i = 0; i < childrenNodes.length; i++) {
                        result += ',' + childrenNodes[i].id;
                        result = getAllChildrenNodes(childrenNodes[i], result);
                    }
                }
            }
            return result;
        }


        //获取界面中所有被选中的radio
        function getChecedValueInLocalTree() {
            var pathsOfCheckedFiles = new Array();
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo"),
                nodes = treeObj.getCheckedNodes(true), v = "";
            for (var i = 0; i < nodes.length; i++) {
                if (nodes[i].pid != "0") {
                    pathsOfCheckedFiles.push(nodes[i].id);
                }
            }
            return pathsOfCheckedFiles.concat(uploadFilePath);
        }


        function asyncAll(event, treeId, treeNode) {
            if (!check()) {
                return;
            }
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            if (false) {
            } else {
                var nodes = new Array([treeNode]);
                asyncNodes(nodes[0]);
            }
        };

        function asyncNodes(nodes) {
            if (!nodes) return;
            curStatus = "async";
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            for (var i = 0, l = nodes.length; i < l; i++) {
                if (nodes[i].isParent && nodes[i].zAsync) {
                    asyncNodes(nodes[i].children);
                    // whetherChecked=false;
                } else {
                    goAsync = true;
                    zTree.reAsyncChildNodes(nodes[i], "refresh", true);
                }
            }
        };

        function beforeAsync() {
            curAsyncCount++;
        }

        function onAsyncSuccess(event, treeId, treeNode, msg) {
            curAsyncCount--;
            if (curStatus == "expand") {
                expandNodes(treeNode.children);
            } else if (curStatus == "async") {
                asyncNodes(treeNode.children);
            }

            if (curAsyncCount <= 0) {
                if (curStatus != "init" && curStatus != "") {
                    asyncForAll = true;
                }
                curStatus = "";
            }
        }

        function onAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown) {
            curAsyncCount--;

            if (curAsyncCount <= 0) {
                curStatus = "";
                if (treeNode != null) asyncForAll = true;
            }
        }

        var curStatus = "init", curAsyncCount = 0, asyncForAll = false,
            goAsync = false;

        function expandNodes(nodes) {
            if (!nodes) return;
            curStatus = "expand";
            var zTree = $.fn.zTree.getZTreeObj("treeDemo");
            for (var i = 0, l = nodes.length; i < l; i++) {
                zTree.expandNode(nodes[i], true, false, false);
                if (nodes[i].isParent && nodes[i].zAsync) {
                    expandNodes(nodes[i].children);
                } else {
                    goAsync = true;
                }
            }
        }


        function check() {
            if (curAsyncCount > 0) {
                return false;
            }
            return true;
        }


    </script>
</div>

</html>
