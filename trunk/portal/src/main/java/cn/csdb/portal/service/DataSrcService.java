package cn.csdb.portal.service;

import cn.csdb.portal.model.DataSrc;
import cn.csdb.portal.repository.DataSrcDao;
import cn.csdb.portal.utils.SqlUtil;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

/**
 * Created by huangwei on 2016/4/6.
 */
@Service
@Transactional
public class DataSrcService {

    @Autowired
    private DataSrcDao dataSrcDao;


    public List<String> relationalDatabaseTableList(DataSrc dataSrc) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return null;
        return dataSource.getTableList(connection);
    }
//    表结构
    public  Map<String,List<String>> getTableStructure(DataSrc dataSrc,String tableName){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        Map<String,List<String>> map=new HashMap<>();
        List<String> list1=new ArrayList<>();
        List<String> list2=new ArrayList<>();
        List<String> list3=new ArrayList<>();
        List<String> list4=new ArrayList<>();
        List<String> list5=new ArrayList<>();
        List<String> list6=new ArrayList<>();
        List<String> list7=new ArrayList<>();
        try{
            String sql="SELECT COLUMN_NAME,IS_NULLABLE,DATA_TYPE,COLUMN_KEY,COLUMN_COMMENT,EXTRA,COLUMN_TYPE " +
                    "FROM information_schema. COLUMNS WHERE table_schema = ? AND table_name = ? ";

            PreparedStatement pst=connection.prepareStatement(sql);
            pst.setString(1,dataSrc.getDatabaseName());
            pst.setString(2,tableName);
            ResultSet set=pst.executeQuery();
            while (set.next()){
                list1.add(set.getString("COLUMN_NAME"));
                list2.add(set.getString("DATA_TYPE"));
                list3.add(set.getString("COLUMN_COMMENT"));
                list4.add(set.getString("COLUMN_KEY"));
                list5.add(set.getString("EXTRA"));
                list6.add(set.getString("IS_NULLABLE"));
                list7.add(set.getString("COLUMN_TYPE"));

//                System.out.println(set.getString("COLUMN_KEY")+"..."+set.getString("EXTRA"));
            }
            map.put("COLUMN_NAME",list1);
            map.put("DATA_TYPE",list2);
            map.put("COLUMN_COMMENT",list3);
            map.put("pkColumn",list4);
            map.put("autoAdd",list5);
            map.put("IS_NULLABLE",list6);
            map.put("COLUMN_TYPE",list7);

        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return map;
    }

//获得列名和字段类型
    public  Map<String,List<String>> getColumnName(DataSrc dataSrc,String tableName){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<String> list1=new ArrayList<>();
        List<String> list2=new ArrayList<>();
        List<String> list3=new ArrayList<>();
        List<String> list4=new ArrayList<>();
        List<String> list5=new ArrayList<>();
        Map<String,List<String>> map=new HashMap<>();
        try{

           String sql=" SELECT a.column_Name AS columnName,CASE WHEN p.column_Name IS NULL THEN 'false' ELSE 'true'END AS pkColumn,CASE WHEN a.extra = 'auto_increment' " +
                   "THEN  'true'  ELSE 'false' END AS autoAdd,a.data_type jdbcType, column_COMMENT descr FROM information_schema. COLUMNS a  " +
                   "LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS p ON a.table_schema = p.table_schema AND a.table_name = p.TABLE_NAME AND a.COLUMN_NAME = p.COLUMN_NAME AND p.constraint_name = 'PRIMARY' " +
                   "WHERE a.table_schema = ? AND a.table_name = ? ORDER BY  a.ordinal_position";

//            String sql="select  COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where TABLE_SCHEMA= ? and table_name =?";
            PreparedStatement pst=connection.prepareStatement(sql);
            pst.setString(1,dataSrc.getDatabaseName());
            pst.setString(2,tableName);
            ResultSet set=pst.executeQuery();
            while (set.next()){
                list1.add(set.getString("columnName"));
                list2.add(set.getString("jdbcType"));
                list3.add(set.getString("descr"));
                list4.add(set.getString("pkColumn"));
                list5.add(set.getString("autoAdd"));

                System.out.println(set.getString("pkColumn")+"..."+set.getString("autoAdd"));
            }
            map.put("COLUMN_NAME",list1);
            map.put("DATA_TYPE",list2);
            map.put("COLUMN_COMMENT",list3);
            map.put("pkColumn",list4);
            map.put("autoAdd",list5);
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return map;
    }

//    更新数据
    public  int updateDate(String condition,String setData,String tableName,DataSrc dataSrc){
        int i=0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try{
            String sql="update "+tableName+""+setData+condition;
            System.out.println("更新："+sql);
            PreparedStatement pst=connection.prepareStatement(sql);
            i= pst.executeUpdate();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{
                connection.close();
            }catch (Exception e){
                e.printStackTrace();
            }
        }
        return i;
    }

//    新增数据
    public  int addData(DataSrc dataSrc,String tableName,String col,String val) {
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
       int i=0;
        try {
            String sql="insert into  "+tableName +"("+ col + ")  values("+ val +")";
            System.out.println("新增："+sql);
            PreparedStatement pst=connection.prepareStatement(sql);
            i= pst.executeUpdate();

            System.out.println("影响数据行："+i);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return i;
    }
//判断主键是否重复
    public int checkPriKey(DataSrc dataSrc,String tableName,int primaryKey,String colName){
        int i=0;
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        try{
            String sql="select count("+colName+") as num "+"from "+tableName+ " where "+colName+"= ?";
            System.out.println("判断主键是否重复："+sql);
            PreparedStatement pst=connection.prepareStatement(sql);
            pst.setInt(1,primaryKey);
            ResultSet rs= pst.executeQuery();
            while(rs.next()){
               i= rs.getInt("num");
               System.out.println("是否重复"+i);
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return i;
    }

//    分页
    public int countData(DataSrc dataSrc,String tableName){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String,Object>> listMap=new ArrayList<Map<String,Object>>();
        int count=0;
        try{
            String sql="select count(*) as num from "+tableName+"";

            //         时间格式的数据怎么获得
            PreparedStatement pst=connection.prepareStatement(sql);
            ResultSet rs=pst.executeQuery();
            while(rs.next()){
                count=rs.getInt("num");
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            try{ connection.close();}catch (Exception e){
                e.printStackTrace();
            }
        }
        return count;
    }

//    连接mysql数据库，根据表明查出所有数据，供编辑
    public List<Map<String,Object>>  getTableData(DataSrc dataSrc,String tableName,int pageNo,int pageSize){
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        List<Map<String,Object>> listMap=new ArrayList<Map<String,Object>>();
         int start=pageSize*(pageNo-1);
       try{
//           select COLUMN_NAME,DATA_TYPE,COLUMN_COMMENT from information_schema.COLUMNS where table_name = '表名' and table_schema = '数据库名称';
           String sql="select * from "+tableName+" limit "+start+" ,"+ pageSize+"";

           //         时间格式的数据怎么获得
           PreparedStatement pst=connection.prepareStatement(sql);
           ResultSet set=pst.executeQuery();
           ResultSetMetaData rsm=set.getMetaData();

           while(set.next()){
               Map<String,Object> map=new HashMap<>();
               for(int i=1;i<=rsm.getColumnCount();i++){
                   if(set.getString(rsm.getColumnName(i))==null){
                       map.put(rsm.getColumnName(i),"");
                   }else {
                       map.put(rsm.getColumnName(i), set.getString(rsm.getColumnName(i)));
                   }
//                       System.out.println("第"+i+"列的值"+"列名："+rsm.getColumnName(i)+",,,"+set.getString(rsm.getColumnName(i)));
               }
               listMap.add(map);
           }
       }catch (Exception e){
           e.printStackTrace();
       }finally {
          try{ connection.close();}catch (Exception e){
              e.printStackTrace();
          }
       }
return listMap;
    }

    public boolean validateSql(String sql, int dataSourceId) {
        if (!SqlUtil.validateSelectSql(sql)) {
            return false;
        }
        DataSrc dataSrc = dataSrcDao.findById(dataSourceId);
        IDataSource dataSource = DataSourceFactory.getDataSource(dataSrc.getDatabaseType());
        Connection connection = dataSource.getConnection(dataSrc.getHost(), dataSrc.getPort(), dataSrc.getUserName(), dataSrc.getPassword(), dataSrc.getDatabaseName());
        if (connection == null)
            return false;
        return dataSource.validateSql(connection, sql);
    }
}
