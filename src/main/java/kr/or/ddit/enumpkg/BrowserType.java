package kr.or.ddit.enumpkg;

public enum BrowserType {
	WHALE("웨일"), EDG("엣지"), CHROME("크롬"), OTHERS("기타");

	private BrowserType(String browserName) {
		this.browserName = browserName;
	}

	private String browserName;

	public String getBrowserName() {
		return browserName;
	}

	public static BrowserType findBrowserType(String userAgent) {
		BrowserType finded = OTHERS;
		BrowserType[] values = values();
		for (BrowserType tmp : values) {
			if (userAgent.toUpperCase().contains(tmp.name())) {
				finded = tmp;
				break;
			}
		}
		return finded;
	}
}
