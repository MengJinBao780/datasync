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
    <title>DataSync</title>
    <link href="${ctx}/resources/css/dataUpload.css" rel="stylesheet" type="text/css"/>
    <link href="${ctx}/resources/bundles/bootstrap-toastr/toastr.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="page-content">
    <div>
        <div class="uplod-head">
            <span>DataSync / 传输信息</span>
        </div>
        <div class="upload-title">
            <span>数据上传任务列表</span>
            <%--<a href="${ctx}/createTask">新建任务</a>--%>
        </div>
        <div class="alert alert-info" role="alert" style="margin:0  33px">
            <!--查询条件 -->
            <div class="row">
                <form class="form-inline">
                    <div class="form-group" >
                        <label >数据类型</label>
                        <select  id="dataSourceList" class="form-control" style="width: 150px">
                            <option value="">----------</option>
                            <option value="db">关系数据库</option>
                            <option value="file">文件数据库</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label  >状态</label>
                        <select  id="dataStatusList" class="form-control" style="width: 150px">
                            <option value="">----------</option>
                            <option value="1">上传完成</option>
                            <option value="0">未上传</option>
                        </select>
                    </div>
                    <button type="button" class="btn blue" style="margin-left: 49px">查询</button>
                    <button type="button" class="btn green" style="margin-left: 49px" onclick="relCreateTask()">新建任务</button>
                </form>
            </div>
        </div>
        <div class="upload-table">
            <div class="table-message">列表加载中......</div>
            <table class="table table-bordered data-table" id="upload-list" >
                <thead>
                <tr>
                    <th>任务编号</th>
                    <th>任务标识</th>
                    <th>数据来源类型</th>
                    <th>数据源</th>
                    <th>创建时间</th>
                    <th>上传进度</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="bd-data"></tbody>
            </table>
            <div class="page-message" style="float: left;line-height: 56px" ></div>
            <div class="page-list" style="float: right"></div>
        </div>
    </div>
</div>
<div id="EModal" class="modal fade" tabindex="-1" data-width="400">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">任务详情查看</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务标识:</label>
                        <div class="col-sm-8" name="tast-"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">数据源ID:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">表名:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">SQL语句:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">逻辑表名:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">文件路径:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建时间:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">创建者:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">上传进度:</label>
                        <div class="col-sm-8"></div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-3 control-label">任务状态:</label>
                        <div class="col-sm-8"></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn green" data-dismiss="modal" ><i
                        class="glyphicon glyphicon-ok"></i>完成
                </button>
                <button type="button" data-dismiss="modal" class="btn  btn-danger">取消</button>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="resourceTmp1">
    {{each data as value i}}
    <tr keyIdTr="{{value.dataTaskId}}">
        <td>{{i + 1}}</td>
        <td>{{value.sqlTableNameEn}}</td>
        <td>{{value.dataTaskType}}</td>
        <td>{{value.source}}</td>
        <td>{{value.createTime}}</td>
        <td  id="{{value.dataTaskId}}">--</td>
        <td  class="{{value.dataTaskId}}">{{upStatusName(value.status)}}</td>
        <td>
            <button type="button" class="btn green btn-xs exportSql" keyIdTd="{{value.dataTaskId}}"  value="{{value.dataTaskId}}" >导出SQL文件</button>
            {{if value.status  == 1}}
            <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}" disabled style="background-color: dimgrey">{{btnName(value.status)}}</button>
            {{else if value.status  == 0}}
            <button type="button" class="btn green upload-data btn-xs" keyIdTd="{{value.dataTaskId}}">{{btnName(value.status)}}</button>
            {{/if}}
            <button type="button" class="btn  edit-data btn-xs blue" keyIdTd="{{value.dataTaskId}}" ><i class="glyphicon glyphicon-eye-open"></i>&nbsp;查看</button>
            <button type="button" class="btn  btn-xs red remove-data" onclick="removeData('{{value.dataSourceId}}');"><i class="glyphicon glyphicon-trash"></i>&nbsp;删除</button>

        </td>
    </tr>
    {{/each}}
</script>
</body>
<!--为了加快页面加载速度，请把js文件放到这个div里-->
<div id="siteMeshJavaScript">
    <script>
        var searchObj={}
        function relCreateTask(){
            window.location.href="${ctx}/createTask";
        }
        $(function(){
            tableConfiguration2(1)
            /*$.ajax({
                url:
            })*/
        });
        $("#dataSourceList").on("change",function () {
            var id = $("#dataSourceList option:selected").attr("id");
            dataRelSrcId =id;
            var name = $(this).val();
        });
        $("#dataStatusList").on("change",function () {
            var id = $("#dataStatusList option:selected").attr("id");
            dataRelSrcId =id;
            var name = $(this).val();


        });
        //导出SQL文件
        $("#upload-list").delegate(".exportSql","click",function () {
            var souceID = $(this).attr("keyIdTd");
            //var keyID = souceID + new Date().getTime();
            $.ajax({
                url:"${ctx}/datatask/" + souceID,
                type:"POST",
                dataType:"JSON",
                success:function (data) {
                    console.log(data.result);
                    if (data.result == 'true') {
                        toastr.success("导出SQL文件成功!");
                    }
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });
        /* localStorage.setItem("uploadTask",uploadTasks)*/
        template.helper("btnName",function (num) {
            var name=""
            if(num ==0){
                name="&nbsp;&nbsp;&nbsp;上传&nbsp;&nbsp;&nbsp;"
            }else {
                name="重新上传"
            }
            return name
        })
        template.helper("upStatusName",function (num) {
            var name=""
            if(num ==0){
                name="--"
            }else if(num == 1 ) {
                name="正在导入"
            }else {
                name ="导入完成"
            }
            return name
        })
        $("#upload-list").delegate(".upload-data","click",function () {
            $(this).css("background-color","dimgrey");
            $(this).attr("disabled","disabled");
            var souceID = $(this).attr("keyIdTd");
            var keyID = souceID + new Date().getTime();

            uploadTasks.push(new ObjStory(keyID,souceID));
            localStorage.setItem("uploadList",JSON.stringify(uploadTasks));
            $.ajax({
                url:"${ctx}/ftpUpload",
                type:"POST",
                data:{dataTaskId:souceID,processId:keyID},
                success:function (data) {

                    /*send request get Process */

                },
                error:function () {
                    console.log("请求失败")
                }
            })
            $("."+souceID).text("正在上传");

            getProcess(keyID,souceID);
        })
        $("#upload-list").delegate(".edit-data","click",function () {
            /*send request*/
            var souceID = $(this).attr("keyIdTd");

            $.ajax({
                url:"${ctx}/datatask/detail",
                type:"POST",
                data:{datataskId:souceID},
                success:function (data) {
                    console.log(JSON.parse(data))

                },
                error:function () {
                    console.log("请求失败")
                }
            })
            $("#EModal").modal('show');
        })
        <!-- remove dataTask-->
        function removeData(id){
            $.ajax({
                url:"${ctx}/datatask/delete",
                type:"POST",
                data:{
                    datataskId:id
                },
                success:function (data) {
                    console.log(data);
                    tableConfiguration2(1);
                },
                error:function () {
                    console.log("请求失败");
                }
            })
        }
        var arr = []
       /* var json = {
                        name:"caocao",
                         sex:"男"
                    }
        arr.push(json)
        json.name="aaa";
        json.sex="aaa"*/
       function ObjStory(keyid,souceid){
           this.keyID=keyid;
           this.souceID=souceid
       }
        arr.push(new ObjStory("1","2"))
        arr.push(new ObjStory("3","4"))
        console.log(JSON.stringify(arr))



        if(localStorage.getItem("uploadList") == null){
            var uploadTasks = [];
        }else {
            var uploadTasks=JSON.parse(localStorage.getItem("uploadList"));
        }



        /*//导出SQL文件
        $("#upload-list").delegate(".exportSql","click",function () {
            var souceID = $(this).attr("keyIdTd");
            //var keyID = souceID + new Date().getTime();
            $.ajax({
                url:"${ctx}/task/" + souceID,
                type:"POST",
                dataType:"JSON",
                success:function (data) {
                    console.log(data.result);
                    if (data.result == 'true') {
                        console.log("aaaaaaa")
                        alert("导出SQL文件成功!");
                    }
                },
                error:function () {
                    console.log("请求失败")
                }
            })
        });*/
        function getProcess(keyID,souceID) {
           var setout= setInterval(function () {
                $.ajax({
                    url:"${ctx}/ftpUploadProcess",
                    type:"POST",
                    data:{
                        processId:keyID
                    },
                    success:function (data) {
                        console.log(data)
                        if(data == "100"){
                            $("#"+souceID).text(data+"%");
                            $("."+souceID).text("上传完成")
                            clearInterval(setout)
                        }
                        $("#"+souceID).text(data+"%");
                    }
                })
            },1000)

        }
        function tableConfiguration(num,data) {
            data.pageNum=num;
            var conData = data;
            $.ajax({
                url:"${ctx}/datatask/getAll",
                type:"GET",
                data:conData,
                success:function (data) {
                    $(".data-table").html("");
                    var DataList = JSON.parse(data);
                    if(DataList=="{}"){
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
                    $(".page-message").html("当前第"+dataFile.pageNum +"页,共"+dataFile.totalPage +"页,共"+dataFile.totalNum+"条数据");
                    $('#page-list').bootpag({
                        total: DataList.totalPage,
                        page: DataList.pageNum,
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
                        tableConfiguration(num,conData);
                    });
                },
                error:function () {
                    $(".table-message").html("请求失败");
                }
            })
        }
        function tableConfiguration2(num) {
            $.ajax({
                url:"${ctx}/datatask/list",
                type:"GET",
                data:{
                    pageNo:num,
                    datataskType:"",
                    status:""
                },
                success:function (data) {
                    console.log(data);
                    $(".table-message").hide();
                    $("#bd-data").html("");
                    var DataList = JSON.parse(data);
                    console.log(DataList)
                    var tabCon = template("resourceTmp1", DataList);
                    $("#bd-data").append(tabCon);

                    if(DataList=="{}"){
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
                    $(".page-message").html("当前第"+1 +"页,共"+5 +"页,共"+10+"条数据");
                    $('.page-list').bootpag({
                        total: 5,
                        page:num,
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
                        tableConfiguration2(num);
                    });
                },
                error:function () {
                    $(".table-message").html("请求失败");
                }
            })
        }





    </script>
</div>

</html>
