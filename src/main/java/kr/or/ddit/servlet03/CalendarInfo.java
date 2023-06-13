package kr.or.ddit.servlet03;

import java.io.Serializable;
import java.time.DayOfWeek;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.temporal.TemporalField;
import java.time.temporal.WeekFields;
import java.util.Locale;
import java.util.Objects;

public class CalendarInfo implements Serializable {
	
	// 사용자에게 요청받는 멤버변수
	private YearMonth targetYM;
	private Locale locale;
	private ZoneId zone;
	
	public CalendarInfo(YearMonth targetYM, Locale locale, ZoneId zone) {
		super();
		this.targetYM = targetYM;
		this.locale = locale;
		this.zone = zone;
		
		weekFields = WeekFields.of(locale);
		firstDayOfWeek = weekFields.getFirstDayOfWeek();
		dayOfWeek = weekFields.dayOfWeek();
		
		beforeYM = targetYM.minusMonths(1);
		nextYM = targetYM.plusMonths(1);
	}
	
	// 생성자 안에서 결정되는 멤버변수
	private YearMonth beforeYM;
	private YearMonth nextYM;
	private WeekFields weekFields;
	private DayOfWeek firstDayOfWeek;
	private TemporalField dayOfWeek;

	public YearMonth getTargetYM() {
		return targetYM;
	}
	public Locale getLocale() {
		return locale;
	}
	public ZoneId getZone() {
		return zone;
	}
	public YearMonth getBeforeYM() {
		return beforeYM;
	}
	public YearMonth getNextYM() {
		return nextYM;
	}
	public WeekFields getWeekFields() {
		return weekFields;
	}
	public DayOfWeek getFirstDayOfWeek() {
		return firstDayOfWeek;
	}
	public TemporalField getDayOfWeek() {
		return dayOfWeek;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(locale, targetYM, zone);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CalendarInfo other = (CalendarInfo) obj;
		return Objects.equals(locale, other.locale) && Objects.equals(targetYM, other.targetYM)
				&& Objects.equals(zone, other.zone);
	}
	
	@Override
	public String toString() {
		return "CalendarInfo [targetYM=" + targetYM + ", locale=" + locale + ", zone=" + zone + ", beforeYM=" + beforeYM
				+ ", nextYM=" + nextYM + ", weekFields=" + weekFields + ", firstDayOfWeek=" + firstDayOfWeek
				+ ", dayOfWeek=" + dayOfWeek + "]";
	}
	
}
