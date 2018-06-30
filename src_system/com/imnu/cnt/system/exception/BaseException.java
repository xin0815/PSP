package com.imnu.cnt.system.exception;

import org.apache.struts.action.ActionMessage;

public class BaseException extends Exception {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * <p>
	 * The message key for this message.
	 * </p>
	 */
	protected String key = null;

	/**
	 * <p>
	 * The replacement values for this mesasge.
	 * </p>
	 */
	protected Object[] values = null;

	protected boolean flag;
	
	public BaseException(String message) {
		super(message);
		key = message;
	}

	public BaseException(String message, boolean flag) {
		super(message);
		key = message;
	}

	public BaseException(String key, Object value0) {
		this(key, new Object[] { value0 });
	}

	public BaseException(String key, Object value0, Object value1) {
		this(key, new Object[] { value0, value1 });
	}

	public BaseException(String key, Object value0, Object value1,
			Object value2) {
		this(key, new Object[] { value0, value1, value2 });
	}

	public BaseException(String key, Object value0, Object value1,
			Object value2, Object value3) {
		this(key, new Object[] { value0, value1, value2, value3 });
	}

	public BaseException(String key, Object[] values) {
		this.key = key;
		this.values = values;
	}

	public BaseException() {
	}

	public BaseException(String message, Throwable cause) {
		super(message, cause);
	}

	public BaseException(Throwable cause) {
		super(cause);
	}

	public ActionMessage getActionMessage() {
			return new ActionMessage(key, values);
	}
}
