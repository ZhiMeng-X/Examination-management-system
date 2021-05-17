package com.xzm.student.domain;

public class ExamHistory {
    private String id;
    private String student;
    private String score;
    private String createTime;

    public ExamHistory() {
    }

    public ExamHistory(String id, String student, String score, String createTime) {
        this.id = id;
        this.student = student;
        this.score = score;
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

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    @Override
    public String toString() {
        return "ExamHistory{" +
                "id='" + id + '\'' +
                ", student='" + student + '\'' +
                ", score='" + score + '\'' +
                ", createTime='" + createTime + '\'' +
                '}';
    }
}
