package com.lyp.service;

import com.lyp.model.Pages;
import com.lyp.model.War;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface WarService {

    //分页
    void showUserTaskByPage(HttpServletRequest request, Model model) throws Exception;

    List<War> selectUserTaskPageList(Pages pages);

    Integer selectUserTaskPageCount(Pages pages);

    //用户领取任务
    void addTask(String equipmentNumber, String userNumber,String taskAcceptDate);
}