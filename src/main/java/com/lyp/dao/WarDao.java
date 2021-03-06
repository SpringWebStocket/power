package com.lyp.dao;

import com.lyp.utils.Pages;
import com.lyp.model.War;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface WarDao {

    //接收任务
    @Insert("insert into war(userNumber,equipmentNumber,taskAcceptDate,state) values(#{1},#{0},#{2},#{3})")
    void addTask(String equipmentNumber, String userNumber,String taskAcceptDate,Integer state);




    //查看个人任务
    @Select("select count(*) from war where state=0")
    int getUserTaskCount();

    @Select("select * from war where state=0 limit #{startNow},#{pageSize}")
    List<War> selectUserTaskByPage(@Param(value = "startPage") Integer startPage, @Param(value = "pageSize") Integer pageSize) throws Exception;

    @Select("select * from war where state=0 order by userNumber ASC limit #{start},#{rows}")
    List<War> selectUserTaskPageList(Pages pages);

    @Select("select count(*) from war where state=0")
    Integer selectUserTaskPageCount(Pages pages);

    //取消任务
    @Delete("delete from war where equipmentNumber=#{equipmentNumber}")
    void deleteUserTask(String equipmentNumber);

    //添加音频
    @Update("update war set checkProblem=#{checkProblem},taskEndDate=#{taskEndDate},uploadWar=#{uploadWar},state=#{state} where equipmentNumber=#{equipmentNumber}")
    boolean updateWav(War war);

    //准备展示待审核任务
    @Select("select count(*) from war where state=1")
    int getUserTaskCount1();

    @Select("select * from war where state=1 limit #{startNow},#{pageSize}")
    List<War> selectUserTask1ByPage(@Param(value = "startPage") Integer startPage, @Param(value = "pageSize") Integer pageSize) throws Exception;

    @Select("select * from war where state=1 order by userNumber ASC limit #{start},#{rows}")
    List<War> selectUserTaskPageList1(Pages pages);

    @Select("select count(*) from war where state=1")
    Integer selectUserTaskPageCount1(Pages pages);

    //更改审核任务是否合格
    @Update("update war set state=#{1} where equipmentNumber=#{0}")
    boolean updateWavState(String equipmentNumber,int state);
}