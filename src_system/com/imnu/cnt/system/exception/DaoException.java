package com.imnu.cnt.system.exception;

public class DaoException extends Exception {
	private static final long serialVersionUID = -3622628107223619432L;

	public DaoException(String errorInfo, Exception e) {
		super(errorInfo, e);
	}

	public DaoException() {
		super();
	}

	public DaoException(String message, Throwable cause) {
		super(message, cause);
	}

	public DaoException(String message) {
		super(message);
	}

	public DaoException(Throwable cause) {
		super(cause);
	}
}
