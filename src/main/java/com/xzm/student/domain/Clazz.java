package com.xzm.student.domain;

public class Clazz {

    private String id;
    private String clazz;
    private String academic;
    private String school;

    public Clazz() {
    }

    public Clazz(String id, String clazz, String academic, String school) {
        this.id = id;
        this.clazz = clazz;
        this.academic = academic;
        this.school = school;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getClazz() {
        return clazz;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz;
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
        return "Clazz{" +
                "id='" + id + '\'' +
                ", Clazz='" + clazz + '\'' +
                ", academic='" + academic + '\'' +
                ", school='" + school + '\'' +
                '}';
    }
}
