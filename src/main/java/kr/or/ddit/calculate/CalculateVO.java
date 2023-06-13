package kr.or.ddit.calculate;

import kr.or.ddit.enumpkg.OperatorType;

public class CalculateVO {
	private double leftOp;
	private double rightOp;
	private OperatorType opParam;
	
	public double getLeftOp() {
		return leftOp;
	}
	public void setLeftOp(double leftOp) {
		this.leftOp = leftOp;
	}
	public double getRightOp() {
		return rightOp;
	}
	public void setRightOp(double rightOp) {
		this.rightOp = rightOp;
	}
	public OperatorType getOpParam() {
		return opParam;
	}
	public void setOpParam(OperatorType opParam) {
		this.opParam = opParam;
	}
	public double getResult() {
		return opParam.biOperate(leftOp, rightOp);
	}
	public String getExpr() {
		return opParam.expression(leftOp, rightOp);
	}
	
	@Override
	public String toString() {
		return "CalculateVO [leftOp=" + leftOp + ", rightOp=" + rightOp + ", opParam=" + opParam + "]";
	}
}
