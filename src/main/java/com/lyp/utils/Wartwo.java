package com.lyp.utils;

public class Wartwo {

    private String userNumber;

    private String uploadWar;

    private String equipmentNumber;

    private String taskAcceptDate;

    private String taskEndDate;

    private String checkProblem;

    private String equipmentName;

    public String getUserNumber() {
        return userNumber;
    }

    public void setUserNumber(String userNumber) {
        this.userNumber = userNumber;
    }

    public String getUploadWar() {
        return uploadWar;
    }

    public void setUploadWar(String uploadWar) {
        this.uploadWar = uploadWar;
    }

    public String getEquipmentNumber() {
        return equipmentNumber;
    }

    public void setEquipmentNumber(String equipmentNumber) {
        this.equipmentNumber = equipmentNumber;
    }

    public String getTaskAcceptDate() {
        return taskAcceptDate;
    }

    public void setTaskAcceptDate(String taskAcceptDate) {
        this.taskAcceptDate = taskAcceptDate;
    }

    public String getTaskEndDate() {
        return taskEndDate;
    }

    public void setTaskEndDate(String taskEndDate) {
        this.taskEndDate = taskEndDate;
    }

    public String getCheckProblem() {
        return checkProblem;
    }

    public void setCheckProblem(String checkProblem) {
        this.checkProblem = checkProblem;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    @Override
    public String toString() {
        return "Wartwo{" +
                "userNumber='" + userNumber + '\'' +
                ", uploadWar='" + uploadWar + '\'' +
                ", equipmentNumber='" + equipmentNumber + '\'' +
                ", taskAcceptDate='" + taskAcceptDate + '\'' +
                ", taskEndDate='" + taskEndDate + '\'' +
                ", checkProblem='" + checkProblem + '\'' +
                ", equipmentName='" + equipmentName + '\'' +
                '}';
    }
}
