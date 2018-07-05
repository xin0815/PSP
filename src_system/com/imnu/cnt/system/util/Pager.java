 package com.imnu.cnt.system.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.struts.util.LabelValueBean;

public class Pager {
	
	public final static String NUMBER_DEFAULT_PATTERN = "^\\d+$";
	
	private static int DEFAULT_PAGE_SIZE = 10;
	
	public int pageSize ;
	
	public int currentPage;//当前页数
	
	public int totalPage ;
	
	public static Collection<LabelValueBean> pageSizeOptions = null;
	static{
		pageSizeOptions = new ArrayList<LabelValueBean>();
		pageSizeOptions.add( new LabelValueBean("5","5"));
		pageSizeOptions.add( new LabelValueBean("10","10"));
		pageSizeOptions.add( new LabelValueBean("20","20"));
		pageSizeOptions.add( new LabelValueBean("50","50"));
		pageSizeOptions.add( new LabelValueBean("100","100"));
	}
	
	public long totalRecord;
	
	public List<?> data; // 当前页中存放的记录,类型一般为List
	

	public Pager() {

	}

	public Pager(int currentPage, int pageSize ) {
		this.pageSize = pageSize;
		this.currentPage = validCurrentPage(currentPage, totalPage);
	}
	
/*	public Pager(String currentPage, String pageSize ) {
		if(currentPage!=null && currentPage.matches(NUMBER_DEFAULT_PATTERN)){
			this.currentPage = validCurrentPage(Integer.parseInt(currentPage), totalPage);
		}else{
			this.currentPage = 1;
		}
		if(pageSize!=null && pageSize.matches(NUMBER_DEFAULT_PATTERN)){
			this.pageSize = Integer.parseInt(pageSize);
		}else{
			this.pageSize = DEFAULT_PAGE_SIZE;
		}
		
	}*/
	
	public Pager(int currentPage, int pageSize, long totalRecord) {
		this.pageSize = pageSize;
		this.totalRecord = totalRecord;
		this.totalPage = (int)Math.ceil(((double)totalRecord+(double)pageSize)/(double)pageSize);
		this.currentPage = validCurrentPage(currentPage, totalPage);
	}
	
	public Pager(int currentPage, int pageSize, long totalRecord,
			List<?> data) {
		this.pageSize = pageSize;
		this.totalRecord = totalRecord;
//		if((int)(((double)totalRecord+(double)pageSize)%(double)pageSize)==0)
//			this.totalPage = (int)((double)totalRecord /(double)pageSize);
//		else
//			this.totalPage = (int)(((double)totalRecord+(double)pageSize)/(double)pageSize);
		this.totalPage = (int)Math.ceil((double)totalRecord/(double)pageSize);
		this.currentPage = validCurrentPage(currentPage, totalPage);
		this.data = data;
	}

	private int validCurrentPage(int currentPage, int totalPage){
		if(currentPage > totalPage){
			currentPage = totalPage;
		}else if(currentPage <= 0){
			currentPage = 1;
		}
		return currentPage;
	}
	
	public static int validPageNo(int currentPage, int pageSize,long totalRecord){
		int tmpTotalPage = 0 ;
//		if((int)(((double)totalRecord+(double)pageSize)%(double)pageSize)==0)
//			tmpTotalPage = (int)((double)totalRecord /(double)pageSize);
//		else
//			tmpTotalPage = (int)(((double)totalRecord+(double)pageSize)/(double)pageSize);		
		tmpTotalPage = (int)Math.ceil((double)totalRecord/(double)pageSize);
		if(currentPage > tmpTotalPage){
			currentPage = tmpTotalPage;
		}else if(currentPage <= 0){
			currentPage = 1;
		}
		return currentPage;
	}
	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = validCurrentPage(currentPage, this.totalPage);
	}

	public long getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(long totalRecord) {
		this.totalRecord = totalRecord;
		this.totalPage = (int)Math.ceil(((double)totalRecord+(double)pageSize)/(double)pageSize);
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Collection<LabelValueBean> getPageSizeOptions() {
		return pageSizeOptions;
	}

	public void setPageSizeOptions(Collection<LabelValueBean> pageSizeOptions) {
		Pager.pageSizeOptions = pageSizeOptions;
	}

	/**
	 * 获取任一页第一条数据在数据集的位置，每页条数使用默认值.
	 *
	 * @see #getStartOfPage(int,int)
	 */
	protected static int getStartOfPage(int pageNo) {
		return getStartOfPage(pageNo, DEFAULT_PAGE_SIZE);
	}

	/**
	 * 获取任一页第一条数据在数据集的位置.
	 *
	 * @param pageNo   从1开始的页号
	 * @param pageSize 每页记录条数
	 * @return 该页第一条数据
	 */
	public static int getStartOfPage(int pageNo, int pageSize) {
		
		return (pageNo - 1) * pageSize;
	}
}
