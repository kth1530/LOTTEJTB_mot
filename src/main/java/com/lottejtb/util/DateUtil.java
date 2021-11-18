package com.lottejtb.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public final class DateUtil {

	private static SimpleDateFormat dateFormatter = new SimpleDateFormat(
			"yyyyMMdd");

	private static SimpleDateFormat timeFormatter = new SimpleDateFormat(
			"HHmmss");

	private static SimpleDateFormat dateTimeFormatter = new SimpleDateFormat(
			"yyyyMMddHHmmss");

	private static SimpleDateFormat dateMilliTimeFormatter = new SimpleDateFormat(
			"yyyyMMddHHmmssSSS");
	
	private DateUtil(){
	}

	/**
	 * 현재 날짜를 java.sql.Date 형으로 변환한다.
	 * 
	 * @return java.sql.Date 현재 날짜 (Date 형)
	 */
	public static java.sql.Date getDate() {
		return getSystemDate();
	}

	/**
	 * 현재 날짜를 java.sql.Timestamp 형으로 변환한다.
	 *
	 * @return java.sql.Timestamp 현재 날짜(Timestamp 형)
	 */
	public static java.sql.Timestamp getTimestamp() {
		return new Timestamp(getSystemDate().getTime());
	}

	/**
	 * 현재 날짜를 yyyyMMdd 형식의 문자열로 구한다.
	 *
	 * <pre>
	 * [사용 예]
	 * DateUtil.toDateString() => "20070626" (현재 날짜가 출력됨)
	 * </pre>
	 * 
	 * @return String 현재 날짜를 yyyyMMdd 형식으로 변환한 문자열
	 */
	public static String toDateString() {
		return dateFormatter.format(getSystemDate());
	}

	/**
	 * 현재 날짜를 지정 Formmater 형식의 문자열로 구한다.
	 *
	 * <pre>
	 * [사용 예]
	 * DateUtil.toDateString("yyyy-MM-dd") => "2007-06-26" (현재 날짜가 출력됨)
	 * </pre>
	 * 
	 * @return String 현재 날짜를 yyyyMMdd 형식으로 변환한 문자열
	 */
	public static String toDateString(String dateFormat) {
		return new SimpleDateFormat(dateFormat).format(getSystemDate());
	}

	/**
	 * java.sql.Date 객체를 yyyyMMdd 형식의 문자열로 변환한다.
	 *
	 * @param date
	 *            변환대상 java.sql.Date 객체
	 * @return yyyyMMdd 형식으로 변환된 문자열
	 */
	public static String toDateString(java.sql.Date date) {
		if (date == null || date.toString().startsWith("1900"))
			return "";
		return dateFormatter.format(date);
	}

	/**
	 * java.sql.Timestamp 객체를 yyyyMMdd 형식의 문자열로 변환한다.
	 *
	 * @param timestamp
	 *            변환대상 java.sql.Timestamp 객체
	 * @return String yyyyMMdd 형식으로 변환된 문자열
	 */
	public static String toDateString(java.sql.Timestamp timestamp) {
		if (timestamp == null || timestamp.toString().startsWith("1900"))
			return "";
		return dateFormatter.format(timestamp);
	}

	/**
	 * 현재 시간을 HHmmss 형식의 문자열로 변환한다.
	 *
	 * @return String 현재 시간을 HHmmss 형식으로 변환한 문자열
	 */
	public static String toTimeString() {
		return timeFormatter.format(getSystemDate());
	}

	/**
	 * java.sql.Date 객체를 HHmmss 형식의 문자열로 변환한다.
	 *
	 * @param date
	 *            변환대상 java.sql.Date 객체
	 * @return String HHmmss 형식으로 변환된 문자열
	 */
	public static String toTimeString(java.sql.Date date) {
		if (date == null || date.toString().startsWith("1900"))
			return "";
		return timeFormatter.format(date);
	}

	/**
	 * java.sql.Timestamp 객체를 HHmmss 형식의 문자열로 변환한다.
	 *
	 * @param time
	 *            변환대상 java.sql.Timestamp 객체
	 * @return String HHmmss 형식으로 변환된 문자열
	 */
	public static String toTimeString(java.sql.Timestamp time) {
		if (time == null || time.toString().startsWith("1900"))
			return "";
		return timeFormatter.format(time);
	}

	/**
	 * 현재 날짜를 yyyyMMddHHmmss 형식의 문자열로 변환한다.
	 *
	 * @return String 현재 날짜+시간을 yyyyMMddHHmmss 형식으로 변환한 문자열
	 */
	public static String toDateTimeString() {
		return dateTimeFormatter.format(getSystemDate());
	}

	/**
	 * 현재 날짜를 yyyyMMddHHmmssSSS 형식의 문자열로 변환한다.
	 *
	 * @return String 현재 날짜+시간을 yyyyMMddHHmmssSSS 형식으로 변환한 문자열
	 */
	public static String toDateMilliTimeString() {
		return dateMilliTimeFormatter.format(getSystemDate());
	}

	/**
	 * java.sql.Date 객체를 yyyyMMddHHmmss 형식의 문자열로 변환한다.
	 *
	 * @param date
	 *            변환대상 java.sql.Date 객체
	 * @return String yyyyMMddHHmmss 형식으로 변환된 문자열
	 */
	public static String toDateTimeString(java.sql.Date date) {
		if (date == null || date.toString().startsWith("1900"))
			return "";
		return dateTimeFormatter.format(date);
	}

	/**
	 * java.sql.Timestamp 객체를 yyyyMMddHHmmss 형식의 문자열로 변환한다.
	 *
	 * @param timestamp
	 *            변환대상 java.sql.Timestamp 객체
	 * @return String yyyyMMddHHmmss 형식으로 변환된 문자열
	 */
	public static String toDateTimeString(java.sql.Timestamp timestamp) {
		if (timestamp == null || timestamp.toString().startsWith("1900"))
			return "";
		return dateTimeFormatter.format(timestamp);
	}

	/**
	 * java.sql.Date 객체를 java.sql.Timestamp 형으로 변환한다.
	 *
	 * @param date
	 *            변환대상 java.sql.Date 객체
	 * @return java.sql.Timestamp 변환된 Timestamp 객체
	 */
	public static Timestamp toTimestamp(Date date) {
		if (date == null || date.toString().startsWith("1900"))
			return null;
		return new Timestamp(date.getTime());
	}

	/**
	 * 두 날짜 사이의 날짜수 차이를 구한다.
	 *
	 * @param beginDate
	 *            비교대상 Date1
	 * @param endDate
	 *            비교대상 Date2
	 * @return long 두 날짜 사이의 날짜수
	 */
	public static long getDaysDiff(java.sql.Date beginDate,
			java.sql.Date endDate) {
		if (endDate.after(beginDate))
			return doGetDaysDiff(beginDate, endDate);
		return -doGetDaysDiff(endDate, beginDate);
	}

	/**
	 * 두 날짜 사이의 날짜수 차이를 구한다.
	 *
	 * @param beginDate
	 *            비교대상 Date1
	 * @param endDate
	 *            비교대상 Date2
	 * @return long 두 날짜 사이의 날짜수
	 */
	private static long doGetDaysDiff(java.sql.Date beginDate,
			java.sql.Date endDate) {
		long diff = endDate.getTime() - beginDate.getTime();

		return diff / (24 * 3600 * 1000);
	}

	/**
	 * 두 날짜 사이의 날짜수를 구한다. 1일을 넘어서면 2일로 계산한다.
	 *
	 * @param beginDate
	 *            비교대상 Date1
	 * @param endDate
	 *            비교대상 Date2
	 * @return long 두 날짜 사이의 날짜수
	 */
	public static long getDaysDiffAbove(java.sql.Date beginDate,
			java.sql.Date endDate) {
		if (endDate.after(beginDate))
			return doGetDaysDiffAbove(beginDate, endDate);

		return -doGetDaysDiffAbove(endDate, beginDate);
	}

	/**
	 * 두 날짜 사이의 날짜수를 구한다. 1일을 넘어서면 2일로 계산한다.
	 *
	 * @param beginDate
	 *            비교대상 Date1
	 * @param endDate
	 *            비교대상 Date2
	 * @return long 두 날짜 사이의 날짜수
	 */
	private static long doGetDaysDiffAbove(java.sql.Date beginDate,
			java.sql.Date endDate) {
		long diff = endDate.getTime() - beginDate.getTime();

		double dayDiff = diff / (24 * 3600 * 1000.0);

		return (long) Math.ceil(dayDiff);
	}

	/**
	 * java.util.Date 객체를 java.sql.Date 객체로 변환한다.
	 *
	 * @param utilDate
	 *            변환대상 java.util.Date 객체
	 * @return java.sql.Date 변환된 객체
	 */
	public static java.sql.Date toSqlType(java.util.Date utilDate) {
		if (utilDate == null)
			return null;

		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		return sqlDate;
	}

	/**
	 * 날짜의 분기 값을 구한다.
	 *
	 * @param strDate
	 *            yyyyMMdd 형식의 문자열, 구분자는 허용하지 않음
	 * @return int 날짜에 대한 분기 값(1 ~ 4)
	 */
	public static int getQuater(String strDate) {
		String[] pd = parseDate(strDate);
		if (pd == null)
			return -1;

		int month = Integer.parseInt(pd[1]);

		return (month - 1) / 3 + 1;
	}

	/**
	 * 시스템의 현재 시간을 구한다.
	 *
	 * @return Date 시스템의 현재 시간
	 */
	private static java.sql.Date getSystemDate() {
		return new java.sql.Date(System.currentTimeMillis());
	}

	/**
	 * 입력 날짜를 년,월,일로 구분된 문자배열로 변환한다.<br>
	 *
	 * @param strDate
	 *            날짜 - yyyyMMdd 형식의 문자열, 구분자가 있어도 상관없음.
	 * @return String[] 입력 날짜를 String[] {년,월,일} 배열로 반환
	 */
	private static String[] parseDate(String strDate) {
		if (strDate == null)
			return null;

		strDate = strDate.replaceAll("^\\D+$", "");
		if (strDate.length() >= 10)
			return new String[]{strDate.substring(0, 4),
					strDate.substring(4, 6), strDate.substring(6, 8)};
		else if (strDate.length() >= 8)
			return new String[]{strDate.substring(0, 4),
					strDate.substring(4, 6), strDate.substring(6, 8)};
		else if (strDate.length() >= 6)
			return new String[]{strDate.substring(0, 4),
					strDate.substring(4, 6), "00"};
		else if (strDate.length() >= 4)
			return new String[]{strDate.substring(0, 4), "00", "00"};
		else
			return null;
	}

	/**
	 * 밀리초 단위의 시간(long)을 yyyyMMddHHmmss 형태의 문자열로 변환한다.
	 *
	 * @param lDateTime
	 *            밀리초 단위 시간(long)
	 * @return String 밀리초 단위 시간을 yyyyMMddHHmmss 형식의 문자열로 변환
	 */
	public static String convNumber2String(long lDateTime) {
		SimpleDateFormat dateTimeFormatter1 = new SimpleDateFormat(
				"yyyyMMddHHmmssSSS");

		try {
			return dateTimeFormatter1.format(new java.util.Date(lDateTime));
		} catch (Exception e) {
			return "";
		}
	}

	/**
	 * 밀리초 단위의 시간(문자열)을 yyyyMMddHHmmss 형태의 문자열로 변환한다.
	 *
	 * @param strDateTime
	 *            밀리초 단위 시간(문자열)
	 * @return String 밀리초 단위 시간을 yyyyMMddHHmmss 형식의 문자열로 변환
	 */
	public static String convNumber2String(String strDateTime) {
		return convNumber2String(Long.parseLong(strDateTime));
	}

}