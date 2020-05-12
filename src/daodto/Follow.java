package daodto;

public class Follow {
	int fl_key;
	String follow;
	String follower;
	
	public Follow(int fl_key, String follow, String follower) {
		this.fl_key = fl_key;
		this.follow = follow;
		this.follower = follower;
	}

	public int getFl_key() {
		return fl_key;
	}

	public void setFl_key(int fl_key) {
		this.fl_key = fl_key;
	}

	public String getFollow() {
		return follow;
	}

	public void setFollow(String follow) {
		this.follow = follow;
	}

	public String getFollower() {
		return follower;
	}

	public void setFollower(String follower) {
		this.follower = follower;
	}
	
	
	
}
