package cn.csdb.portal.service;

import cn.csdb.portal.repository.DataSrcDao;
import cn.csdb.portal.repository.ResourceDao;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * @program: DataSync
 * @description: Resource Service
 * @author: xiajl
 * @create: 2018-10-23 16:19
 **/
@Service
public class ResourceService {

    @Resource
    private ResourceDao resourceDao;

    @Resource
    private DataSrcDao dataSrcDao;

    /**
     * Function Description: 保存资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date: 2018/10/23 16:22
     */
    @Transactional
    public String save(cn.csdb.portal.model.Resource resource) {
        return resourceDao.save(resource);
    }

    @Transactional
    public void saveFileInfo(cn.csdb.portal.model.FileInfo fileInfo) {
        resourceDao.saveFileInfo(fileInfo);
    }

    @Transactional
    public void deleteFileInfo(String id) {
        resourceDao.deleteFileInfo(id);
    }

    /**
     * Function Description: 删除资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date: 2018/10/23 16:25
     */
    @Transactional
    public void delete(String id) {
        resourceDao.delete(id);
    }

    @Transactional
    public void delete(cn.csdb.portal.model.Resource resource) {
        resourceDao.delete(resource);
    }

    /**
     * Function Description: 分页查询获取资源List
     *
     * @param:  subjectCode:专题库代码, title:资源名称, status:状态, pageNo:页数, pageSize:第页记录条数
     * @return: 资源List列表
     * @auther: Administrator
     * @date:   2018/10/23 16:28
     */
    @Transactional(readOnly = true)
    public List<cn.csdb.portal.model.Resource> getListByPage(String subjectCode, String title, String publicType, String status, int pageNo, int pageSize) {
        return resourceDao.getListByPage(subjectCode, title, publicType, status, pageNo, pageSize);
    }


    @Transactional(readOnly = true)
    public long countByPage(String subjectCode, String title,String publicType, String resState){
        return resourceDao.countByPage(subjectCode,title,publicType, resState);
    }
/*----------------------------------------------------------------------------------------*/

    public List<JSONObject> fileSourceFileList(String filePath) {
        System.out.println("filePath为"+filePath);
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>();
        File file = new File(filePath);
        if (!file.exists() || !file.isDirectory()) {
            return jsonObjects;
        }
        System.out.println("1");
//        String[] fp = filePath.split(";");
        File[] fp = file.listFiles();
        for (int i = 0; i < fp.length; i++) {
//            if(StringUtils.isBlank(fp[i])){
//                continue;
//            }
//            File file = new File(fp[i]);
//            if(!file.exists()){
//                continue;
//            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", fp[i].getPath().replaceAll("\\\\", "%_%"));
            jsonObject.put("text", fp[i].getName().replaceAll("\\\\", "%_%"));
            if (fp[i].isDirectory()) {
                jsonObject.put("type", "directory");
                JSONObject jo = new JSONObject();
                jo.put("disabled", "true");
                jsonObject.put("state", jo);
            } else {
                jsonObject.put("type", "file");
            }
            jsonObjects.add(jsonObject);
    }
        System.out.println("2");
        Collections.sort(jsonObjects, new FileComparator());
        System.out.println("3");
        return jsonObjects;

    }

    public List<JSONObject> fileSourceFileListFirst(String filePath) {
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>();
        File file = new File(filePath);
        if (!file.exists() || !file.isDirectory())
            return jsonObjects;
//        String[] fp = filePath.split(";");
        String separator = File.separator;
        String reg = "";
        if ("/".equals(separator)) {
            reg = separator;
        } else {
            reg = "\\\\";
        }
        File[] fp = file.listFiles();
        for (int i = 0; i < fp.length; i++) {
//            if(StringUtils.isBlank(fp[i])){
//                continue;
//            }
//            File file = new File(fp[i]);
//            if(!file.exists()){
//                continue;
//            }
            JSONObject jsonObject = new JSONObject();
            if(fp[i].getPath().indexOf("_sql")==-1){
                if (fp[i].isDirectory()) {
                    if(fp[i].getPath().indexOf("_sql")==-1) {
                        jsonObject.put("id", fp[i].getPath().replaceAll(reg, "%_%"));
                        jsonObject.put("text", fp[i].getName().replaceAll(reg, "%_%"));
                        jsonObject.put("type", "directory");
//                        JSONObject jo = new JSONObject();
//                        jo.put("disabled", "true");
//                        jsonObject.put("state", jo);
                        jsonObjects.add(jsonObject);
                    }
                }
            }
        }
        Collections.sort(jsonObjects, new FileComparator());
        return jsonObjects;

    }

    /**
     * 配置前端文件树搜索功能 重新实现树首次加载方法
     *
     * @param filePath 当前文件路径
     * @param count    递归次数决定文件默认深度
     * @return 树值
     */
    public List<JSONObject> treeNodeFirst(String filePath, int count) {
        count--;
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>(32);
        File file = new File(filePath);
        if (!file.exists() || !file.isDirectory()) {
            return jsonObjects;
        }
        String separator = File.separator;
        String reg = "";
        if ("/".equals(separator)) {
            reg = separator;
        } else {
            reg = "\\\\";
        }
        File[] fp = file.listFiles();
        for (int i = 0; i < fp.length; i++) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", fp[i].getPath().replaceAll("\\\\", "%_%"));
            jsonObject.put("text", fp[i].getName().replaceAll("\\\\", "%_%"));
            if (fp[i].isDirectory()) {
                jsonObject.put("type", "directory");
                if (count >= 0) {
                    jsonObject.put("children", treeNodeFirst(fp[i].getPath(), count));
                }
            } else {
                jsonObject.put("type", "file");
            }
            jsonObjects.add(jsonObject);
        }
        Collections.sort(jsonObjects, new FileComparator());
        return jsonObjects;
    }


    class FileComparator implements Comparator<JSONObject> {

        public int compare(JSONObject o1, JSONObject o2) {
            if ("directory".equals(o1.getString("type")) && "directory".equals(o2.getString("type"))) {
                return o1.getString("text").compareTo(o2.getString("text"));
            } else if ("directory".equals(o1.getString("type")) && !"directory".equals(o2.getString("type"))) {
                return -1;
            } else if (!"directory".equals(o1.getString("type")) && "directory".equals(o2.getString("type"))) {
                return 1;
            } else {
                return o1.getString("text").compareTo(o2.getString("text"));
            }
        }
    }

    public cn.csdb.portal.model.Resource getById(String resourceId){


        return resourceDao.getById(resourceId);
    }

    public int getRecordCount(String host, String port, String userName, String password, String databaseName, List<String> tableName) {
        return dataSrcDao.getRecordCount( host,  port,  userName,  password,  databaseName,  tableName);
    }
}