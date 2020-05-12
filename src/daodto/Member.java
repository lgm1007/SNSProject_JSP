package daodto;

public class Member {
	String id;
	String pw;
	String name;
	String tel1;
	String tel2;
	String tel3;
	
	public Member(String id, String pw, String name, String tel1, String tel2, String tel3) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.tel1 = tel1;
		this.tel2 = tel2;
		this.tel3 = tel3;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getTel1() {
		return tel1;
	}

	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}

	public String getTel2() {
		return tel2;
	}

	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}

	public String getTel3() {
		return tel3;
	}

	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	
	
}
