package kr.or.ddit.calculate;

@FunctionalInterface
public interface BiOperandOperator {
	public double operate(double left, double right);
}
