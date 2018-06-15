package com.student.entity;

import java.io.Serializable;
import java.util.Iterator;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public class SpringDataPageable implements Serializable ,Page<Student>{

	private static final long serialVersionUID = 1;
    // 当前页
    private Integer pagenumber = 1;
    // 当前页面条数
    private Integer pagesize = 10;
    //总条数
    private Integer pagetotal;
    
	public Integer getPagenumber() {
		return pagenumber;
	}
	public void setPagenumber(Integer pagenumber) {
		this.pagenumber = pagenumber;
	}
	public Integer getPagesize() {
		return pagesize;
	}
	public void setPagesize(Integer pagesize) {
		this.pagesize = pagesize;
	}
	
    public Integer getPagetotal() {
		return pagetotal;
	}
	public void setPagetotal(Integer pagetotal) {
		this.pagetotal = pagetotal;
	}

	@Override
	public List<Student> getContent() {
		return null;
	}
	@Override
	public int getNumber() {
		return 0;
	}
	@Override
	public int getNumberOfElements() {
		return 0;
	}
	@Override
	public int getSize() {
		return 0;
	}
	@Override
	public long getTotalElements() {
		return 0;
	}
	@Override
	public int getTotalPages() {
		return 0;
	}
	@Override
	public boolean hasContent() {
		return false;
	}
	@Override
	public boolean hasNextPage() {
		return false;
	}
	@Override
	public boolean hasPreviousPage() {
		return false;
	}
	@Override
	public boolean isFirstPage() {
		return false;
	}
	@Override
	public boolean isLastPage() {
		return false;
	}
	@Override
	public Iterator<Student> iterator() {
		return null;
	}
	@Override
	public Pageable nextPageable() {
		return null;
	}
	@Override
	public Pageable previousPageable() {
		return null;
	}
	@Override
	public Sort getSort() {
		// TODO Auto-generated method stub
		return null;
	}

    

}
