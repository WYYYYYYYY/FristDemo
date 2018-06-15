package com.student.dao;
import java.util.List;
import com.student.entity.Pagination;
import com.student.entity.Student;
public interface IStudentDao {
	
	/**
	 * 添加
	 * @param student
	 */
	public void insert(Student student);
	/**
	 * 查找全部学生
	 * @return
	 */
	public List<Student> findAll();
	
	/**
	 * 根据id删除学生
	 * @param id
	 */
	public void deleteById(String id);
	
	/**
	 * 根据id查找学生
	 * @param id
	 * @return
	 */
	public Student findById(String id);
	/**
	 * 修改
	 * @param stu
	 */
	public void updateStudent(Student  stu);
	
	/**
	 * 根据条件查询
	 * @param name
	 * @param age
	 * @param address
	 * @return
	 */
	public List<Student> findByQuery(String name,String age,String address);
	
	/**
	 * 分页
	 * @param pageNum
	 * @return
	 */
 
	public Pagination getPageData(Student student,int offset, int limit);
	
}
