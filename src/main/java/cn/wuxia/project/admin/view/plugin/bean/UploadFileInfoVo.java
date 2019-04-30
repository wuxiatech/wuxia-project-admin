package cn.wuxia.project.admin.view.plugin.bean;

import java.io.Serializable;

/**
 * 素材VO
 * The persistent class for the UploadFileInfo database table.
 */
public class UploadFileInfoVo implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;

//    private String uploadFileSetInfoId;

    private String clientHostName;

    private String fileEncoding;

    private String fileName;

    private Long fileSize;

    private String fileStatus;

    private String fileType;

    private String location;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

//    public String getUploadFileSetInfoId() {
//        return uploadFileSetInfoId;
//    }
//
//    public void setUploadFileSetInfoId(String uploadFileSetInfoId) {
//        this.uploadFileSetInfoId = uploadFileSetInfoId;
//    }

    public String getClientHostName() {
        return clientHostName;
    }

    public void setClientHostName(String clientHostName) {
        this.clientHostName = clientHostName;
    }

    public String getFileEncoding() {
        return fileEncoding;
    }

    public void setFileEncoding(String fileEncoding) {
        this.fileEncoding = fileEncoding;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }

    public String getFileStatus() {
        return fileStatus;
    }

    public void setFileStatus(String fileStatus) {
        this.fileStatus = fileStatus;
    }

    public String getFileType() {
        return fileType;
    }

    public void setFileType(String fileType) {
        this.fileType = fileType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
