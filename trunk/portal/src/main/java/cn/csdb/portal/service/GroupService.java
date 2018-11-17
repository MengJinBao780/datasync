package cn.csdb.portal.service;

import cn.csdb.portal.model.Group;
import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.GroupDao;
import cn.csdb.portal.repository.UserDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: user group Service class
 * @author: xiajl
 * @create: 2018-10-30 11:16
 **/
@Service
public class GroupService {
    @Resource
    private GroupDao groupDao;

    @Resource
    private UserDao userDao;

    @Transactional
    public void add(Group group){
        groupDao.add(group);
    }

    @Transactional
    public void update(Group group){
        groupDao.update(group);
    }

    /**
     * Function Description: 删除用户组
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/10/30 11:30
     */
    @Transactional
    public void delete(Group group){
        //1 删除组
        groupDao.delete(group);
        //2 删除用户表中存属于此组的组名
        //List<User> list = userDao.queryUser()
    }

    /**
     * Function Description:获取用户组分页列表数据
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/10/30 11:22
     */
    @Transactional(readOnly = true)
    public List<Group> getListByPage(String groupName, int pageNo, int pageSize){
        return groupDao.getListByPage(groupName,pageNo,pageSize);
    }

    @Transactional(readOnly = true)
    public Group get(String id){
        return groupDao.get(id);
    }

    /**
     * Function Description: 获取总记录数
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/10/30 11:22
     */
    @Transactional(readOnly = true)
    public long countByPage(String groupName){
        return groupDao.countByPage(groupName);
    }

    public List<Group> getGroupList() {
        return groupDao.getGroupList();
    }

    /**
     *
     * Function Description: get all group
     *
     * @param: []
     * @return: java.util.List<cn.csdb.portal.model.Group>
     * @auther: hw
     * @date: 2018/11/7 14:22
     */
    public List<Group> getAll(){
        return groupDao.getAll();
    }


    /**
     * Function Description: 是否己存在同名的用户组
     *
     * @param:groupName:用户组名称
     * @return:
     * @auther: xiajl
     * @date:   2018/11/17 10:44
     */
    public boolean exist(String groupName){
        return groupDao.exist(groupName);
    }
}
