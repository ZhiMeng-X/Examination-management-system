package com.xzm.student.domain;

public class School {

    private String id;
    private String school;

    public School() {
    }

    public School(String id, String school) {
        this.id = id;
        this.school = school;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    @Override
    public String toString() {
        return "School{" +
                "id='" + id + '\'' +
                ", school='" + school + '\'' +
                '}';
    }
}
