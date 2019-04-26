package cn.csdb.portal.controller;

/**
 * Created by Administrator on 2017/4/19 0019.
 */

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.ShowTypeInf;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.model.TableInfo;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.DataSrcService;
import cn.csdb.portal.service.ShowTypeInfService;
import cn.csdb.portal.service.TableFieldComsService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TableFieldComsController {
    private Logger logger = LoggerFactory.getLogger(TableFieldComsController.class);

    @Resource
    private TableFieldComsService tableFieldComsService;

    @Resource
    private ShowTypeInfService showTypeInfService;

    @Autowired
    private CheckUserDao checkUserDao;

    @Autowired
    private DataSrcService dataSrcService;
    /**
     * 获取表的字段注释
     *
     * @param subjectCode
     * @param tableName
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getTableFieldComs")
    public JSONObject getFieldComsByTableName(String subjectCode, String tableName) {
        JSONObject jsonObject = new JSONObject();
        Map<String, List<TableInfo>> fieldComsByTableName = tableFieldComsService.getDefaultFieldComsByTableName(subjectCode, tableName);
        if (fieldComsByTableName != null) {
            List<TableInfo> tableInfos = fieldComsByTableName.get(tableName);
            jsonObject.put("tableInfos", tableInfos);
        }
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value = "saveTableFieldComs")
    public JSONObject saveTableFieldComs(HttpServletRequest request,
                                         @RequestParam(required = false) String curDataSubjectCode,
                                         @RequestParam(required = false) String tableName,
                                         @RequestParam(required = false) String tableInfos,
                                         @RequestParam(required = false) String state,
                                         String tableComment) {
        JSONObject jsonObject = new JSONObject();
        List<TableInfo> tableInfosList = JSON.parseArray(tableInfos, TableInfo.class);
        boolean result = tableFieldComsService.insertTableFieldComs(curDataSubjectCode, tableName, tableInfosList, state);
        // 注释完整之后更新MySQL中的注释
        if ("1".equals(state)) {
            String realPath = request.getRealPath("/") + "temp/";
            tableFieldComsService.syncMySQLComment(curDataSubjectCode, tableName, tableInfosList, realPath);
        }

//        保存表名注释
        showTypeInfService.saveTableComment(tableName, tableComment);
//点击外层保存按钮
        showTypeInfService.updateSatusOne(tableName);

        jsonObject.put("result", result);
        return jsonObject;
    }
//    文本类型


    //    数据字段配置，显示类型配置--URL
    @RequestMapping("/saveTypeURL")
    @ResponseBody
    public JSONObject saveTypeURL(int DisplayType, String tableName, String columnName, String optionMode, String address) {
        JSONObject jsonObject = new JSONObject();
//         System.out.println(tableName+"..."+columnName);
        showTypeInfService.saveTypeURL(DisplayType, tableName, columnName, optionMode, address);
        jsonObject.put("success", "success");
        return jsonObject;
    }

    //    数据字段配置，显示类型配置--URL
    @RequestMapping("/saveTypeEnum")
    @ResponseBody
    public JSONObject saveTypeEnum(int DisplayType, String tableName, String columnName, String optionMode, String address, String enumData) {
        JSONObject jsonObject = new JSONObject();
        showTypeInfService.saveTypeEnum(DisplayType, tableName, columnName, optionMode, address, enumData);
//        System.out.println(tableName+"..."+columnName);
        jsonObject.put("success", "success");
        return jsonObject;
    }

    //    删除status=2的数据
    @RequestMapping("/deleteStatusTwo")
    @ResponseBody
    public JSONObject deleteStatusTwo(String tableName) {
        JSONObject jsonObject = new JSONObject();
        showTypeInfService.deleteStatusTwo(tableName);
        jsonObject.put("success", "success");
        return jsonObject;
    }


    //    根据登录人员的subjectCode，获得对应数据库连接信息
    public DataSrc getDataSrc(String subjectCode){
        Subject subject=checkUserDao.getSubjectByCode(subjectCode);
        DataSrc datasrc = new DataSrc();
        datasrc.setDatabaseName(subject.getDbName());//数据库名
        datasrc.setDatabaseType("mysql");          //数据库类型
        datasrc.setHost(subject.getDbHost());       //连接地址
        datasrc.setPort(subject.getDbPort());       //端口号
        datasrc.setUserName(subject.getDbUserName());  //用户名
        datasrc.setPassword(subject.getDbPassword());  //密码
        return datasrc;
    }

    //    查询出该表关联的数据表
    @RequestMapping("/getDatasheetTable")
    @ResponseBody
    public JSONObject getDatasheetTable(String tableName,String subjectCode){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        List<String> list = dataSrcService.relationalDatabaseTableList(datasrc);
        for(int i=0;i<list.size();i++){
            if(list.get(i).equals(tableName)){
                list.remove(list.get(i));
            }
        }
        jsonObject.put("list",list);
        return jsonObject;
    }
    @RequestMapping("/getDatasheetTableColumn")
    @ResponseBody
    public JSONObject getDatasheetTableColumn(String tableName,String subjectCode){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        List<String> list = dataSrcService.getColumnName(datasrc,tableName);
        jsonObject.put("list",list);
        return jsonObject;
    }

//    保存关联表字段数据
    @RequestMapping("/saveTypeDatasheet")
    @ResponseBody
    public JSONObject saveTypeDatasheet(int DisplayType, String tableName, String columnName, String relationTable, String relationColumn){
        JSONObject jsonObject=new JSONObject();
//        System.out.println(relationTable+"..."+relationColumn);
      showTypeInfService.saveTypeDatasheet(DisplayType,tableName,columnName,relationTable,relationColumn);
        return jsonObject;
    }

//    保存文件类型
    @RequestMapping("/saveTypeFile")
    @ResponseBody
    public JSONObject saveTypeFile(int DisplayType, String tableName, String columnName, String address, String optionMode,String Separator){
        JSONObject jsonObject=new JSONObject();
        showTypeInfService.saveTypeFile(DisplayType,tableName,columnName,address,optionMode,Separator);
        return jsonObject;
    }

    //    查询该表设置的显示类型

    @RequestMapping("/getShowTypeInfMsg")
    @ResponseBody
    public JSONObject getShowTypeInf(String tableName){
        JSONObject jsonObject=new JSONObject();
        ShowTypeInf showTypeInf=showTypeInfService.getShowTypeInf(tableName);
        if(showTypeInf==null){
            jsonObject.put("alert",0);//此表没有设置过显示类型
        }
        jsonObject.put("showTypeInfmsg",showTypeInf);
          return jsonObject;
    }
    }
