package com.xzm.exam.domain;

public class NetChooseCollection {

    private String id;
    private String student;
    private String exam;
    private String createTime;

    public NetChooseCollection() {
    }

    public NetChooseCollection(String id, String student, String exam, String createTime) {
        this.id = id;
        this.student = student;
        this.exam = exam;
        this.createTime = createTime;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getStudent() {
        return student;
    }

    public void setStudent(String student) {
        this.student = student;
    }

    public String getExam() {
        return exam;
    }

    public void setExam(String exam) {
        this.exam = exam;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "NetChooseCollection{" +
                "id='" + id + '\'' +
                ", student='" + student + '\'' +
                ", exam='" + exam + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
