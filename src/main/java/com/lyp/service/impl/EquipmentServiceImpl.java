package com.lyp.service.impl;

import com.lyp.dao.EquipmentDao;
import com.lyp.model.Equipment;
import com.lyp.utils.Page;
import com.lyp.utils.Pages;
import com.lyp.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
public class EquipmentServiceImpl implements EquipmentService {

    @Autowired
    private EquipmentDao equipmentDao;

    @Override
    public void showEquipmentByPage(HttpServletRequest request, Model model) throws Exception {

        String pageNow = request.getParameter("pageNow");

        System.out.println("-->pageNow:"+pageNow);

        Page page = null;

        List<Equipment> equipmentList = new ArrayList<Equipment>();

        int totalCount = equipmentDao.getEquipmentCount();

        if (pageNow != null){

            page = new Page(totalCount,Integer.parseInt(pageNow));

            System.out.println(page);

            equipmentList = equipmentDao.selectEquipmentByPage(page.getStartPos(),page.getPageSize());

            System.out.println(equipmentList);

            for (int i = 0;i < equipmentList.size();i++){

                System.out.println(equipmentList.get(i));
            }
        }else {

            page = new Page(totalCount,1);

            System.out.println("equipmentList");

            for (int i = 0; i < equipmentList.size(); i++) {

                System.out.println(equipmentList.get(i));

            }

            equipmentList = equipmentDao.selectEquipmentByPage(page.getStartPos(),page.getPageSize());
        }

        model.addAttribute("equipmentList",equipmentList);

        model.addAttribute("page",page);
    }

    @Override
    public List<Equipment> selectPageList(Pages page) {

        List<Equipment> list = equipmentDao.selectPageList(page);

        return list;
    }

    @Override
    public Integer selectPageCount(Pages page) {
        return equipmentDao.selectPageCount(page);
    }

    @Override
    public boolean addequipment(Equipment equipment) {
        return equipmentDao.addEquipment(equipment);
    }

    @Override
    public void deleteequipmentByNum(String equipmentNumber) {
        equipmentDao.deleteequipmentByNum(equipmentNumber);
    }

    @Override
    public void sendtask(String equipmentNumber, String task,String taskBirthDate,String endDate) {
        equipmentDao.sendtask(equipmentNumber,task,taskBirthDate,endDate);
    }

    @Override
    public void updateState(String equipmentNumber,String state) {
        equipmentDao.updateState(equipmentNumber,state);
    }

    @Override
    public Equipment findEquipmentByNum(String equipmentNumber) {
        return equipmentDao.findEquipmentByNum(equipmentNumber);
    }

    @Override
    public String findEquStateByNum(String equipmentNumber) {
        return equipmentDao.findEquStateByNum(equipmentNumber);
    }

    @Override
    public void showEquipmentByPageByState(HttpServletRequest request, Model model) throws Exception {
        String pageNow = request.getParameter("pageNow");

        System.out.println("-->pageNow:"+pageNow);

        Page page = null;

        List<Equipment> equipmentList = new ArrayList<Equipment>();

        int totalCount = equipmentDao.getEquipmentCountByState();

        if (pageNow != null){

            page = new Page(totalCount,Integer.parseInt(pageNow));

            System.out.println(page);

            equipmentList = equipmentDao.selectEquipmentByPageByState(page.getStartPos(),page.getPageSize());

        }else {
            page = new Page(totalCount,1);
        }

        equipmentList = equipmentDao.selectEquipmentByPageByState(page.getStartPos(),page.getPageSize());

        model.addAttribute("equipmentList",equipmentList);

        model.addAttribute("page",page);
    }

    @Override
    public List<Equipment> selectPageListByState(Pages pages) {

        List<Equipment> list = equipmentDao.selectPageListByState(pages);
        return list;
    }

    @Override
    public Integer selectPageCountByState(Pages pages) {
        return equipmentDao.selectPageCountByState(pages);
    }

    @Override
    public void deleteTask(String equipmentNumber) {
        equipmentDao.deleteTask(equipmentNumber);
    }

    @Override
    public void deleteUserTask(String equipmentNumber) {
        equipmentDao.deleteUserTask(equipmentNumber);
    }

    @Override
    public void updateEquipmentCount(int equipmentAmount, String equipmentNumber) {
        equipmentDao.updateEquipmentCount(equipmentAmount,equipmentNumber);
    }

}
