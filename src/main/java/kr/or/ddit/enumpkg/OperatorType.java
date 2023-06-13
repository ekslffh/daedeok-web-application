package kr.or.ddit.enumpkg;

import java.text.MessageFormat;
import kr.or.ddit.calculate.BiOperandOperator;

public enum OperatorType {
	PLUS('+', ((l, r) -> l + r)), 
	MINUS('-', ((l, r) -> l - r)), 
	MULTIPLY('*', ((l, r) -> l * r)), 
	DIVIDE('/', ((l, r) -> l / r));
	
	private OperatorType(char sign, BiOperandOperator operator) {
		this.sign = sign;
		this.operator = operator;
	}

	private char sign;
	
	private BiOperandOperator operator;
	
	public char getSign() {
		return sign;
	}
	
	public double biOperate(double left, double right) {
		return operator.operate(left, right);
	}
	
	public String expression(double left, double right) {
		return MessageFormat.format("{0} {3} {1} = {2}", left, right, biOperate(left, right), sign);
		
	}
}
