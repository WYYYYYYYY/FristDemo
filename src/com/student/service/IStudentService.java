package com.student.service;

import java.util.List;
import com.student.entity.Pagination;
import com.student.entity.Student;

public interface IStudentService {
	
	/**
	 * 添加
	 * @param student
	 */
	public void insert(Student student);
	/***
	 * 查找全部
	 * @return
	 */
	public List<Student> findAll();
	
	/**
	 * 根据id删除学生
	 * @param id
	 */
	public void deleteById(String ids);
	/**
	 * 根据id查找
	 * @param id
	 * @return
	 */
	public Student findById(String id);
	/**
	 * 修改
	 * @param id
	 */
	public void updateStudent(Student student);

	/**
	 * 条件查询
	 * @param name
	 * @param age
	 * @param address
	 * @return
	 */
	public List<Student> findByQuery(String name, String age,String address);
	

	/**
	 * 分页
	 * @param offset
	 * @param limit
	 * @return
	 */
	public Pagination getPageData(Student student,int offset, int limit);

}
