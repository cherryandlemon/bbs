package com.ncu.bbs.wale.services.impl;

import com.ncu.bbs.bean.Main;
import com.ncu.bbs.bean.MainExample;
import com.ncu.bbs.dao.MainMapper;
import com.ncu.bbs.wale.services.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service("MainService")
@ContextConfiguration("classpath:applicationContext.xml")
public class MainServiceImpl implements MainService {

    @Autowired
    MainMapper mainMapper;

    /**
     * 根据版块id查找某一个版块的所有帖子
     * @param sectionId
     * @return
     */
    public List<Main> getMainBySectionId(Integer sectionId) {
        List<Main> mainlist=new ArrayList<Main>();
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        mainExample.setOrderByClause("m_maindate desc");//按照发布时间排序
        mainlist=mainMapper.selectByExampleWithMainer(mainExample);//带有发布者信息的查询
        return mainlist;
    }

    /**
     * 根据版块id和符合条件的数量num查找某个版块的num个帖子
     * @param sectionId
     * @param num
     * @return
     */
    public List<Main> getMainBySectionIdAndNum(Integer sectionId, int num) {
        List<Main> mainlist=new ArrayList<Main>();
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        criteria.andMIsperfectEqualTo(1);//查找某一个版块的所有精华帖
        mainlist=mainMapper.selectByExample(mainExample);
        List<Main> finals=new ArrayList<Main>();
        for(int i=0;i<mainlist.size();i++){
            if(i<num){
                finals.add(mainlist.get(i));
            }
        }
        return finals;
    }

    /**
     * 根据版块id查找该板块的所有置顶帖
     * @param sectionId
     * @return
     */
    public List<Main> getTopMain(Integer sectionId) {
        List<Main> mainlist=new ArrayList<Main>();
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        criteria.andMIsontopEqualTo(1);//查找置顶帖
        mainlist=mainMapper.selectByExampleWithMainer(mainExample);//带有发布者信息的查询
        return mainlist;
    }

    /**
     * 根据版块id查找所有的不是置顶帖的帖子
     * @param sectionId
     * @return
     */
    public List<Main> getNotTopMainBySectionId(Integer sectionId) {
        List<Main> mainlist=new ArrayList<Main>();
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        criteria.andMIsontopEqualTo(0);//查找非置顶帖
        mainExample.setOrderByClause("m_maindate desc");//按照时间进行排序
        mainlist=mainMapper.selectByExampleWithMainer(mainExample);//带有发布者信息的查询
        return mainlist;
    }

    /**
     * 根据版块id来查找所有不是精华帖的帖子
     * @param sectionId
     * @return
     */
    public List<Main> getNotPerfectMainBySectionId(Integer sectionId) {
        List<Main> mainlist=new ArrayList<Main>();
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        criteria.andMIsperfectEqualTo(0);//查找非精华帖
        mainExample.setOrderByClause("m_maindate desc");//按照时间进行排序
        mainlist=mainMapper.selectByExampleWithMainer(mainExample);//带有发布者信息的查询
        return mainlist;
    }

    /**
     * 根据主贴id批量增加精华帖
     * @param del_ids
     */
    public void addPerfectBatch(List<Integer> del_ids) {
        for (int mainId:del_ids) {
            MainExample mainExample=new MainExample();
            MainExample.Criteria criteria =mainExample.createCriteria();
            criteria.andMMainidEqualTo(mainId);
            Main main=new Main();
            main.setmIsperfect(1);
            mainMapper.updateByExampleSelective(main,mainExample);
        }
    }

    /**
     * 根据主贴id来加精
     * @param id
     */
    public void addPerfect(Integer id) {
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria =mainExample.createCriteria();
        criteria.andMMainidEqualTo(id);
        Main main=new Main();
        main.setmIsperfect(1);
        mainMapper.updateByExampleSelective(main,mainExample);
    }

    /**
     * 根据主贴id查找版块id
     * @param mainId
     * @return
     */
    public int getSectionIdByMainId(Integer mainId) {
        Main main=mainMapper.selectByPrimaryKey(mainId);
        return main.getmSectionid();
    }

    /**
     * 根据主贴id来取消置顶帖子
     * @param mainId
     */
    public void cancelTopByMainId(Integer mainId) {
        Main main=new Main();
        main.setmMainid(mainId);
        main.setmIsontop(0);
        mainMapper.updateByPrimaryKeySelective(main);
    }

    /**
     * 根据主帖编号取消加精多个帖子
     * @param del_ids
     */
    public void cancelPerfectBatch(List<Integer> del_ids) {
        for (Integer del_id : del_ids) {
            cancelPerfect(del_id);
        }
    }
    /**
     * 根据主帖编号取消加精单个帖子
     * @param
     */
    public void cancelPerfect(Integer id) {
        Main main=new Main();
        main.setmMainid(id);
        main.setmIsperfect(0);//非精华帖
        mainMapper.updateByPrimaryKeySelective(main);
    }

    /**
     * 根据主贴id来查找帖子包含发布该帖子的信息
     * @param mainId
     * @return
     */
    public Main getMainByMainId(Integer mainId) {
        return mainMapper.selectByPrimaryKeyWithMainer(mainId);
    }

    /**
     * 根据版块id查找该版块的所有需求帖
     * @param sectionId
     */
    @Override
    public List<Main> getNeedPostBySectionId(Integer sectionId) {
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMPointGreaterThan(0);
        criteria.andMSectionidEqualTo(sectionId);
        //按照回复数来进行排序
        mainExample.setOrderByClause("m_point desc");//按照时间进行排序
        return mainMapper.selectByExampleWithMainer(mainExample);
    }

    /**
     * 根据版块id查找所有的热门帖
     * @param sectionId
     * @return
     */
    @Override
    public List<Main> getHotPostBySectionId(Integer sectionId) {
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        return mainMapper.selectByExampleWithFollowNums(mainExample);
    }

    /**
     * 根据版块id查找所有最新帖
     * @param sectionId
     * @param deadline
     * @return
     */
    @Override
    public List<Main> getLatestPostBySectionId(Integer sectionId, Date deadline) {
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria=mainExample.createCriteria();
        criteria.andMSectionidEqualTo(sectionId);
        criteria.andMMaindateGreaterThan(deadline);
        mainExample.setOrderByClause("m_maindate desc");
        return mainMapper.selectByExampleWithMainer(mainExample);
    }

    /**
     * 根据版块id来查找该版块的所有精华帖
     * @param sectionId
     * @return
     */
    public List<Main> getPerfectBySectionId(Integer sectionId) {
        List<Main> perfectlist=new ArrayList<Main>();
        MainExample example=new MainExample();
        MainExample.Criteria criteria=example.createCriteria();
        criteria.andMIsperfectEqualTo(1);
        criteria.andMSectionidEqualTo(sectionId);
        perfectlist=mainMapper.selectByExampleWithMainer(example);
        return perfectlist;
    }

    /**
     * 根据main增加一个主贴记录
     * @param main
     */
    public void addMainPost(Main main) {
        mainMapper.insertSelective(main);
    }

    /**
     * 批量增加置顶帖
     * @param del_ids
     */
    public void addTopBatch(List<Integer> del_ids) {
        for (int mainId:del_ids) {
            MainExample mainExample=new MainExample();
            MainExample.Criteria criteria =mainExample.createCriteria();
            criteria.andMMainidEqualTo(mainId);
            Main main=new Main();
            main.setmIsontop(1);
            mainMapper.updateByExampleSelective(main,mainExample);
        }
    }

    /**
     *置顶单个帖子
     * @param id
     */
    public void addTop(Integer id) {
        MainExample mainExample=new MainExample();
        MainExample.Criteria criteria =mainExample.createCriteria();
        criteria.andMMainidEqualTo(id);
        Main main=new Main();
        main.setmIsontop(1);
        mainMapper.updateByExampleSelective(main,mainExample);
    }


}
