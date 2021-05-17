package com.xzm.student.domain;

public class Academic {

    private String id;
    private String academic;
    private String school;

    public Academic() {
    }

    public Academic(String id, String academic, String school) {
        this.id = id;
        this.academic = academic;
        this.school = school;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAcademic() {
        return academic;
    }

    public void setAcademic(String academic) {
        this.academic = academic;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    @Override
    public String toString() {
        return "Academic{" +
                "id='" + id + '\'' +
                ", academic='" + academic + '\'' +
                ", school='" + school + '\'' +
                '}';
    }
}
