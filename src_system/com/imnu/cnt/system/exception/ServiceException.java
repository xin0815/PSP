package com.imnu.cnt.system.exception;

public class ServiceException extends Exception {
	private static final long serialVersionUID = -3622628107223619432L;

	public ServiceException(String errorInfo, Exception e) {
		super(errorInfo, e);
	}

	public ServiceException() {
		super();
	}

	public ServiceException(String message, Throwable cause) {
		super(message, cause);
	}

	public ServiceException(String message) {
		super(message);
	}

	public ServiceException(Throwable cause) {
		super(cause);
	}
}
