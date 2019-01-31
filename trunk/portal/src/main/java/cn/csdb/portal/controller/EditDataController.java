package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.service.DataSrcService;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
public class EditDataController {
    @Autowired
    private CheckUserDao checkUserDao;

    @Autowired
    private DataSrcService dataSrcService;


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

    @ResponseBody
    @RequestMapping("/showTable")
    public JSONObject showTable(String subjectCode){
        JSONObject jsonObject=new JSONObject();
        DataSrc datasrc=getDataSrc(subjectCode);
        List<String> list = dataSrcService.relationalDatabaseTableList(datasrc);

        System.out.println();
        jsonObject.put("list", list);
        jsonObject.put("dataSourceName", datasrc.getDataSourceName());
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping("/showTableData")
        public JSONObject test(String subjectCode, String tableName,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                               @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        DataSrc datasrc=getDataSrc(subjectCode);
         List<Map<String,Object>> list=new ArrayList<>();

//        Map<String,List<String>> map=dataSrcService.getColumnName(datasrc,tableName);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);
        List<String> list3=map.get("COLUMN_NAME");
        List<String> list4=map.get("DATA_TYPE");
        List<String> list5=map.get("COLUMN_COMMENT");
        List<String> list6=map.get("pkColumn");
        List<String> list7=map.get("autoAdd");
             list=dataSrcService.getTableData(datasrc,tableName,pageNo,pageSize);
        List<String> list1=new ArrayList<>();
//         for(int i=0;i<=0;i++){
//             Map<String,Object> map1=list.get(i);
//             for(String key:map1.keySet()){
//                 list1.add(key);
//                 System.out.println("key:"+key+"...."+"value:"+map1.get(key));
//             }
//         }

        int countNum=dataSrcService.countData(datasrc,tableName);
        JSONObject jsonObject=new JSONObject();
        jsonObject.put("totalCount", countNum);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", countNum % pageSize == 0 ? countNum / pageSize : countNum / pageSize + 1);

         jsonObject.put("dataDatil",list);
         jsonObject.put("columns",list3);
        jsonObject.put("dataType",list4);
        jsonObject.put("columnComment",list5);
        jsonObject.put("pkColumn",list6);
        jsonObject.put("autoAdd",list7);
       return jsonObject;
    }

    @RequestMapping("/saveTableData")
    @ResponseBody
    public JSONObject saveTableData(@Param("olddata") String olddata, @Param("newdata") String newdata){
        JSONObject jsonObject=new JSONObject();

         JSONArray jsonArray1=JSONArray.parseArray(olddata);
         JSONArray jsonArray2=JSONArray.parseArray(newdata);

         JSONObject tableNameObjext=jsonArray1.getJSONObject(0);
        JSONObject dbNameObjext=jsonArray1.getJSONObject(1);
        String tableName= tableNameObjext.getString("value");
        String dbName=dbNameObjext.getString("value");

        DataSrc datasrc=getDataSrc(dbName);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);

        List<String> list1=map.get("pkColumn");
        List<String> list2=map.get("autoAdd");
        List<String> list3=map.get("IS_NULLABLE");


//        条件设置,拼串
        String conditionstr=" where ";
        for(int i=2;i<jsonArray1.size();i++){
            String column=jsonArray1.getJSONObject(i).getString("name");
            String value=jsonArray1.getJSONObject(i).getString("value");
            if(!value.equals("")&& value!=null && !value.equals("null")) {
                conditionstr += "" + column + "= '" + value + "' and ";
            }

        }
  //更新的数据
     String updatestr=" set ";
        int j=0;
        for(int i=2;i<jsonArray2.size();i++){

            String column=jsonArray2.getJSONObject(i).getString("name");
            String value=jsonArray2.getJSONObject(i).getString("value");

            if(list3.get(i-2).equals("NO") && value.equals("null")||value.equals("")){
//                System.out.println(list3.get(i-2));
                jsonObject.put("data","-2+"+column);//该列不能为空
                return jsonObject;
            }

            if(!value.equals(jsonArray1.getJSONObject(i).getString("value"))) {
                if(value.equals("") && jsonArray1.getJSONObject(i).getString("value").equals("null")){

                }else {
                    updatestr += "" + column + "= '" + value + "' , ";
                    j++;
                }
            }
        }
        if(j==0){
            jsonObject.put("data","1");
            return jsonObject;
        }
        int l=conditionstr.length();
        String s1=conditionstr.substring(0,l-5);
        int ll=updatestr.length();
        String s2=updatestr.substring(0,ll-2);
//        DataSrc datasrc=getDataSrc(dbName);
        int n=dataSrcService.updateDate(s1,s2,tableName,datasrc);
//         System.out.println(s2+"............"+ s1);
        if(n==1){
            jsonObject.put("data","1");
        }else{
            jsonObject.put("data","0");
        }
        return jsonObject;
    }

    @RequestMapping("/addTableData")
    @ResponseBody
    public JSONObject addTableData(String subjectCode,String tableName,String  addData){

        JSONObject jsonObject=new JSONObject();
        JSONArray jsonArray=JSONArray.parseArray(addData);
//        System.out.println("请求成功！！！！"+tableName+"....."+addData+"..."+jsonArray.getJSONObject(1));

        String column="";
        String values="";
        DataSrc datasrc=getDataSrc(subjectCode);
        Map<String,List<String>> map=dataSrcService.getTableStructure(datasrc,tableName);

        List<String> list1=map.get("pkColumn");
        List<String> list2=map.get("autoAdd");
        List<String> list3=map.get("IS_NULLABLE");

//        for(int i=0;i<jsonArray.size();i++){
//            String col = jsonArray.getJSONObject(i).getString("columnName");
//            String val = jsonArray.getJSONObject(i).getString("columnValue");
//
//            if(list1.get(i).equals("true") && list2.get(i).equals("true")){ //有主键且自增
//                System.out.println(jsonArray.getJSONObject(i).getString("columnName"));
//
//            }else if(list1.get(i).equals("true") && list2.get(i).equals("false")){   //有主键但不自增，判断新增主键是否重复
//                if(val!=null && !val.equals("")){
//                   if( dataSrcService.checkPriKey(datasrc,tableName,Integer.parseInt(val),col)==1){
//                       jsonObject.put("data","0");
//                       return jsonObject;
//                   }
//                    column += "" + col + " ,";
//                    values += "'" + Integer.parseInt(val) + "' ,";
//                  }else{
//                    jsonObject.put("data","-1");
//                    return jsonObject;
//                 }
//            }else {   //无主键
//                if(val!=null&& !val.equals("")){
//                    column += "" + col + " ,";
//                    values += "'" + val + "' ,";
//                }
//            }
//        }

        for(int i=0;i<jsonArray.size();i++){
            String col = jsonArray.getJSONObject(i).getString("columnName");
            String val = jsonArray.getJSONObject(i).getString("columnValue");

            if(list1.get(i).equals("PRI") && list2.get(i).equals("auto_increment")){ //有主键且自增
                System.out.println(jsonArray.getJSONObject(i).getString("columnName"));

            }else if(list1.get(i).equals("PRI") && !list2.get(i).equals("auto_increment")){   //有主键但不自增，判断新增主键是否重复
                if(val!=null && !val.equals("")){
                    if( dataSrcService.checkPriKey(datasrc,tableName,Integer.parseInt(val),col)==1){
                        jsonObject.put("data","0");
                        return jsonObject;
                    }
                    column += "" + col + " ,";
                    values += "'" + Integer.parseInt(val) + "' ,";
                }else{
                    jsonObject.put("data","-1");
                    return jsonObject;
                }
            }else {   //无主键
                if(val!=null&& !val.equals("")){
                    column += "" + col + " ,";
                    values += "'" + val + "' ,";
                }else if(list3.get(i).equals("NO")){
                    jsonObject.put("data","-2+"+col);//该列不能为空
                    return jsonObject;
                }
            }
        }
//        表随机主键
//        String uuid = UUID.randomUUID().toString();
//        column+="PORTLID , ";
//        values+="'"+uuid+"',";

        column=column.substring(0,column.length()-1);
        values=values.substring(0,values.length()-1);

        int n=dataSrcService.addData(datasrc,tableName,column,values);
        if(n==1){
            jsonObject.put("data","1");
        }else{
            jsonObject.put("data","0");
        }
          return jsonObject;
    }
}
