package kr.or.ddit.vo;

import java.io.Serializable;
import java.util.Arrays;

public class SampleFormVO implements Serializable {
	
	private String[] chkParam;
	private String dateParam;
	private String datetimeParam;
	private String param1;
	private int param2;
	private String rdoParam;
	private String[] selParamMulti;
	private String selParamSingle;
	
	@Override
	public String toString() {
		return "SampleFormVO [chkParam=" + Arrays.toString(chkParam) + ", dateParam=" + dateParam + ", datetimeParam="
				+ datetimeParam + ", param1=" + param1 + ", param2=" + param2 + ", rdoParam=" + rdoParam
				+ ", selParamMulti=" + Arrays.toString(selParamMulti) + ", selParamSingle=" + selParamSingle + "]";
	}
	
	public String[] getChkParam() {
		return chkParam;
	}
	public void setChkParam(String[] chkParam) {
		this.chkParam = chkParam;
	}
	public String getDateParam() {
		return dateParam;
	}
	public void setDateParam(String dateParam) {
		this.dateParam = dateParam;
	}
	public String getDatetimeParam() {
		return datetimeParam;
	}
	public void setDatetimeParam(String datetimeParam) {
		this.datetimeParam = datetimeParam;
	}
	public String getParam1() {
		return param1;
	}
	public void setParam1(String param1) {
		this.param1 = param1;
	}
	public int getParam2() {
		return param2;
	}
	public void setParam2(int param2) {
		this.param2 = param2;
	}
	public String getRdoParam() {
		return rdoParam;
	}
	public void setRdoParam(String rdoParam) {
		this.rdoParam = rdoParam;
	}
	public String[] getSelParamMulti() {
		return selParamMulti;
	}
	public void setSelParamMulti(String[] selParamMulti) {
		this.selParamMulti = selParamMulti;
	}
	public String getSelParamSingle() {
		return selParamSingle;
	}
	public void setSelParamSingle(String selParamSingle) {
		this.selParamSingle = selParamSingle;
	}
	
}
