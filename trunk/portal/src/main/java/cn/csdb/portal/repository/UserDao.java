package cn.csdb.portal.repository;

import cn.csdb.portal.model.Group;
import cn.csdb.portal.model.User;
import com.mongodb.DBObject;
import com.mongodb.QueryBuilder;
import com.mongodb.WriteResult;
import org.apache.commons.lang.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.BasicQuery;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;
import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Pattern;

@Repository
public class UserDao {
    private Logger logger = LoggerFactory.getLogger(UserDao.class);

    @Resource
    MongoTemplate mongoTemplate;

    public int addUser(User user)
    {
        int addedUserCnt = 1;

        mongoTemplate.insert(user);

        DBObject dBObject = QueryBuilder.start().and("userName").is(user.getUserName()).get();
        Query query = new BasicQuery(dBObject);
        User theUser = mongoTemplate.findOne(query, User.class);
        String userId = theUser.getId();

        //为用户组增加用户
        String[] groupArr = user.getGroups().split(",");
        for (String groupName : groupArr)
        {
            addUserToGroup(userId, groupName);
        }

        return addedUserCnt;
    }

    /**
     * Function Description ： 这个函数的目的是讲userName存放到它对应的group的user数组中
     *  因为一个userName可能对应多个组，所以在每一个组中检查此用户是否在组中，如果在，就不更新，如果不在则添加
     * @param userId
     * @param groupName
     */
    private void addUserToGroup(String userId, String groupName)
    {
        //输入参数校验
        userId = userId.trim();
        groupName = groupName.trim();
        if(userId.equals("") || groupName.equals(""))
        {
            return;
        }

        //从t_group表中查找出名字为groupName的group，加入userName到它的users中去，之后把group再写入t_group表中
        logger.info("userId = " + userId + ", groupName = " + groupName);
        DBObject dBObject = QueryBuilder.start().and("groupName").is(groupName).get();
        Query query = new BasicQuery(dBObject);
        Group group = mongoTemplate.findOne(query, Group.class);
        List<String> users = group.getUsers();
        if (users == null)
        {
            users = new ArrayList<String>();
        }
        logger.info("groupName = " + groupName + ", users before add new user, users = " + users);
        users.add(userId);
        logger.info("groupName = " + groupName + ", users after added new user, users = " + users);
        group.setUsers(users);
        mongoTemplate.save(group);
    }

    /**
     * Function Description ： 这个函数的目的是将userName从group的user数组中删掉
     * @param userId
     * @param groupName
     */
    private void dropUserFromGroup(String userId, String groupName)
    {
        //从t_group表中查找出名字为groupName的group，加入userName到它的users中去，之后把group再写入t_group表中
        logger.info("userId = " + userId + ", groupName = " + groupName);
        DBObject dBObject = QueryBuilder.start().and("groupName").is(groupName).get();
        Query query = new BasicQuery(dBObject);
        Group group = mongoTemplate.findOne(query, Group.class);
        List<String> users = group.getUsers();
        logger.info("groupName = " + groupName + ", users before remove new user, users = " + users);
        if (users != null) {
            users.remove(userId);
        }
        logger.info("groupName = " + groupName + ", users after removed new user, users = " + users);
        group.setUsers(users);
        mongoTemplate.save(group);
    }

    public List<User> queryUser(String loginId, String userName, String groups, int curUserPageNum, int pageSize)
    {
        long totalUsers =  0;
        totalUsers = getTotalUsers(loginId, userName, groups);
        long totalUserPages = 0;
        totalUserPages = totalUsers / pageSize + (totalUsers % pageSize == 0 ? 0 : 1);
        int start = 0;
        start = (curUserPageNum - 1) * pageSize;

        DBObject dbObject = null;

        if (loginId.trim().equals(""))
        {
            loginId = null;
        }
        if (userName.trim().equals(""))
        {
            userName = null;
        }
        if (groups.trim().equals(""))
        {
            groups = null;
        }

        QueryBuilder queryBuilder = null;

        if (loginId != null && userName != null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId != null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId != null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId == null && userName != null && groups != null)
        {

            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));;
        }
        else if (loginId != null && userName == null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$"));
        }
        else if (loginId == null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId == null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else
        {
            queryBuilder = QueryBuilder.start();
        }

        dbObject = queryBuilder.and("role").is("普通用户").get();
        //dbObject = queryBuilder.get();
        Query query = new BasicQuery(dbObject).skip(start).limit(pageSize);

        //排序
        Sort.Direction direction = false ? Sort.Direction.ASC : Sort.Direction.DESC;
        //query.with(new Sort(direction, "_id"));
        query.with(new Sort(direction, "createTime"));

        List<User> users = mongoTemplate.find(query, User.class);

        return users;
    }

    public long getTotalUsers(String loginId, String userName, String groups)
    {
/*
        DBObject dbObject = QueryBuilder.start().and("loginId").is(loginId).and("userName").is(userName).and("groups").exists(groups).get();
*/
        DBObject dbObject = null;

        if (loginId.trim().equals(""))
        {
            loginId = null;
        }
        if (userName.trim().equals(""))
        {
            userName = null;
        }
        if (groups.trim().equals(""))
        {
            groups = null;
        }

        QueryBuilder queryBuilder = null;

        if (loginId != null && userName != null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId != null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId != null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else if (loginId == null && userName != null && groups != null)
        {

            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$")).and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));;
        }
        else if (loginId != null && userName == null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("loginId").regex(Pattern.compile("^.*" + loginId + ".*$"));
        }
        else if (loginId == null && userName != null && groups == null)
        {
            queryBuilder = QueryBuilder.start().and("userName").regex(Pattern.compile("^.*" + userName + ".*$"));
        }
        else if (loginId == null && userName == null && groups != null)
        {
            queryBuilder = QueryBuilder.start().and("groups").regex(Pattern.compile("^.*" + groups + ".*$"));
        }
        else
        {
            queryBuilder = QueryBuilder.start();
        }

        dbObject = queryBuilder.and("role").is("普通用户").get();
        //dbObject = queryBuilder.get();

        Query query = new BasicQuery(dbObject);
        long totalUsers = mongoTemplate.count(query, "t_user");
        return totalUsers;
    }

    /*public int updateGroups(String loginId, String group) {
        int updatedUserCnt = 1;

        Query query = new Query();
        query.addCriteria(Criteria.where("loginId").is(loginId));
        Update update = Update.update("group", group);
        mongoTemplate.upsert(query, update, "t_user");

        return updatedUserCnt;
    }*/

    public int deleteUser(String id)
    {
        int deletedUserCnt = 0;
        DBObject dbObject = QueryBuilder.start().and("_id").is(id).get();
        Query query = new BasicQuery(dbObject);

        User user = mongoTemplate.findOne(query, User.class);
        String[] groupArr = user.getGroups().split(",");
        String userId = user.getId();
        for (String groupName : groupArr)
        {
            dropUserFromGroup(userId, groupName);
        }

        WriteResult writeResult = mongoTemplate.remove(query, "t_user");
        deletedUserCnt = writeResult.getN();

        return deletedUserCnt;
    }

    public User getUserById(String id)
    {
        DBObject dbObject = QueryBuilder.start().and("_id").is(id).get();
        Query query = new BasicQuery(dbObject);
        User user = mongoTemplate.findOne(query, User.class);

        return user;
    }

    public int updateUser(User user)
    {
        int updatedUserCnt = 1;

        String userName = user.getUserName();
        String[] groupArr = user.getGroups().split(",");
        updateUserGroup(user);

        mongoTemplate.save(user);

        return updatedUserCnt;
    }

    private void updateUserGroup(User user)
    {
        String userId = user.getId();
        String groupsBeforeUpdate = mongoTemplate.findById(userId, User.class).getGroups();
        String[] groupsBeforeUpdateArr = groupsBeforeUpdate.split(",");
        String[] updatedGroupsArr = user.getGroups().split(",");

        //如果有新增的用户组，则把用户加入到新增的用户组中去
        for (int i = 0; i < updatedGroupsArr.length; i++)
        {
            int j = 0;
            for (j = 0; j < groupsBeforeUpdateArr.length; j++)
            {
                if (updatedGroupsArr[i].equals(groupsBeforeUpdateArr[j]))
                {
                    break;
                }
            }

            if (j >= groupsBeforeUpdateArr.length)
            {
                addUserToGroup(userId, updatedGroupsArr[i]);
            }
        }

        //如果有删掉的用户组，则把用户从这些用户组中删去
        for (int i = 0; i < groupsBeforeUpdateArr.length; i++)
        {
            int j = 0;
            for (j = 0; j < updatedGroupsArr.length; j++)
            {
                if (groupsBeforeUpdateArr[i].equals(updatedGroupsArr[j]))
                {
                    break;
                }
            }

            if (j >= updatedGroupsArr.length)
            {
                dropUserFromGroup(userId, groupsBeforeUpdateArr[i]);
            }
        }
    }

    /**
     * Function Description: 获取所有的用户
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/5 15:14
     */
    public List<User> getAll(){
        return mongoTemplate.findAll(User.class);
    }

    /**
     * Function Description: 获取某指定角色类的所有用户
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/26 13:51
     */

    public List<User> getAllbyRole(String roleName){
        QueryBuilder queryBuilder = QueryBuilder.start();

        if (StringUtils.isNotEmpty(roleName)){
            queryBuilder = queryBuilder.and("role").is(roleName);
        }
        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        List<User> list = mongoTemplate.find(basicQuery,User.class);
        return list;
    }



    /**
     * Function Description: 根据用户组名称获取此组中的所有用户
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/17 12:09
     */
    public List<User> queryByGroupName(String groupName){
        QueryBuilder queryBuilder = QueryBuilder.start();

        if (StringUtils.isNotEmpty(groupName)){
            queryBuilder = queryBuilder.and("groups").regex(Pattern.compile("^.*"+groupName+".*$"));;
        }

        DBObject dbObject = queryBuilder.get();
        BasicQuery basicQuery = new BasicQuery(dbObject);
        List<User> list = mongoTemplate.find(basicQuery,User.class);
        return list;
    }


    public long queryLoginId(String loginId)
    {
        DBObject dbObject = QueryBuilder.start().and("loginId").is(loginId).get();
        Query query = new BasicQuery(dbObject);
        long loginIdCnt = mongoTemplate.count(query, "t_user");

        return loginIdCnt;
    }


    /**
     * Function Description: 从此用户的用户组中删除groupName
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/20 15:08
     */
    public void deleteGroupName(String userid, String groupName){
        String id = userid.replace("[","").replace("]","").replace("\"","");
        User user = getUserById(id);
        if (user != null) {
            String groups = user.getGroups();
            List<String> list = Arrays.asList(org.apache.commons.lang3.StringUtils.split(groups, ","));
            ArrayList<String> result = new ArrayList<String>(list);
            if (result.contains(groupName))
                result.remove(groupName);
            String str = org.apache.commons.lang3.StringUtils.join(result, ",");
            user.setGroups(str);
            updateOnlyUser(user);
        }
    }

    /**
     * Function Description: 从此用户的用户组中增加groupName
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/20 15:10
     */
    public void addGroupName(String userid, String groupName){
        String id = userid.replace("[","").replace("]","").replace("\"","");
        User user = getUserById(id);
        String groups = user.getGroups();
        List<String> list = Arrays.asList(org.apache.commons.lang3.StringUtils.split(groups,","));
        ArrayList<String> result = new ArrayList<String>(list);
        if (!result.contains(groupName))
            result.add(groupName);
        String str = org.apache.commons.lang3.StringUtils.join(result,",");
        user.setGroups(str);
        updateOnlyUser(user);
    }

    /**
     * Function Description: 只更新用户表信息，不修改组信息
     *
     * @param:
     * @return:
     * @auther: xiajl
     * @date:   2018/11/26 15:31
     */
    public int updateOnlyUser(User user)
    {
        int updatedUserCnt = 1;
        mongoTemplate.save(user);
        return updatedUserCnt;
    }

}
