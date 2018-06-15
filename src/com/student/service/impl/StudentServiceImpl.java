package com.student.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.student.dao.IStudentDao;
import com.student.entity.Pagination;
import com.student.entity.Student;
import com.student.service.IStudentService;

/**
 * service采用@service注解  （@service 服务（注入dao））
 * 例：@Service("userService")注解是告诉Spring，当Spring要创建UserServiceImpl的的实例时，bean的名字必须叫做"userService"，
 *    这样当Action需要使用UserServiceImpl的的实例时,就可以由Spring创建好的"userService"，然后注入给Action。
 *
 */
@Service
public class StudentServiceImpl implements IStudentService {
	
	@Autowired
	private IStudentDao studentDao;
	

	public IStudentDao getStudentDao() {
		return studentDao;
	}
	public void setStudentDao(IStudentDao studentDao) {
		this.studentDao = studentDao;
	}
	@Override
	public void insert(Student student) {
		studentDao.insert(student);
	}
	@Override
	public List<Student> findAll() {
		return studentDao.findAll();
	}
	@Override
	public void deleteById(String id) {
		studentDao.deleteById(id);	
	}
	@Override
	public Student findById(String id) {
		return studentDao.findById(id);
	}
	
	@Override
	public void updateStudent(Student student) {
		studentDao.updateStudent(student);
	}
	@Override
	public List<Student> findByQuery(String name, String age,String address) {
		return studentDao.findByQuery(name, age,address);
	}

	@Override
	public Pagination getPageData(Student student, int offset, int limit) {
		return this.studentDao.getPageData(student, offset, limit);
	}
}
