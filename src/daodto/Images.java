package daodto;

public class Images {
	int bd_key;
	String fileName;
	String fileRealName;
	public Images(int bd_key, String fileName, String fileRealName) {
		this.bd_key = bd_key;
		this.fileName = fileName;
		this.fileRealName = fileRealName;
	}
	public int getBd_key() {
		return bd_key;
	}
	public void setBd_key(int bd_key) {
		this.bd_key = bd_key;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFileRealName() {
		return fileRealName;
	}
	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}
	
}
