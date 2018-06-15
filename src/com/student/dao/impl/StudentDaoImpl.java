package com.student.dao.impl;

import java.util.List;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;
import com.student.dao.IStudentDao;
import com.student.entity.Pagination;
import com.student.entity.Student;


/**
 * dao层使用@repository注解（实现dao访问）； @Repository(value="userDao")注解是告诉Spring，让Spring创建一个名字叫“userDao”的UserDaoImpl实例。
 * 当Service需要使用Spring创建的名字叫“userDao”的UserDaoImpl实例时，就可以使用@Resource(name = "userDao")注解告诉Spring，Spring
 * 把创建好的userDao注入给Service即可。
 * @Autowired可以对成员变量、方法和构造函数进行标注，来完成自动装配的工作，我们也要清楚，@Autowired是根据类型进行自动装配的
 */
@Repository
public class StudentDaoImpl implements IStudentDao {

	@Autowired
	private MongoTemplate mongoTemplate;
	
	public MongoTemplate getMongoTemplate() {
		return mongoTemplate;
	}

	public void setMongoTemplate(MongoTemplate mongoTemplate) {
		this.mongoTemplate = mongoTemplate;
	}

	@Override
	public void insert(Student student) {
		getMongoTemplate().insert(student);
	}

	@Override
	public List<Student> findAll() {
		 return getMongoTemplate().findAll(Student.class);
	}

	@Override
	public void deleteById(String id) {
		Query query=new Query(Criteria.where("_id").is(id));
		getMongoTemplate().remove(query,Student.class);
	}

	@Override
	public Student findById(String id) {
		Query query = new Query(Criteria.where("_id").is(id));
		return getMongoTemplate().findOne(query, Student.class);
	}

	@Override
	public void updateStudent(Student stu) {
		Query query = new Query();
	    query.addCriteria(Criteria.where("_id").is(stu.getId()));
	    Update update = new Update();
	    update.set("_id", stu.getId());
	    update.set("name", stu.getName());
	    update.set("age", stu.getAge());
	    update.set("sex", stu.getSex());
	    update.set("birthday", stu.getBirthday());
	    update.set("email", stu.getEmail());
	    update.set("phone", stu.getPhone());
	    update.set("address", stu.getAddress());
	    mongoTemplate.updateFirst(query, update, Student.class);		
	}

	@Override
	public List<Student> findByQuery(String name, String age,String address) {	
		Query query  = new Query(Criteria.where("name").is(name)).addCriteria(Criteria.where("age").is(age)).addCriteria(Criteria.where("address").is(address));
		System.out.println("query=="+query);
		return getMongoTemplate().find(query, Student.class);
	}
	
	/**
	 * 分页
	 */
	@Override
	public Pagination getPageData(Student student, int offset, int limit) {
		long count = this.mongoTemplate.count(new Query(), Student.class);
		
		Query q = new Query();
		
		if(StringUtils.isNotBlank(student.getName())){
			q.addCriteria(Criteria.where("name").regex(student.getName(), "i"));
		}
		if(StringUtils.isNotBlank(student.getAge())){
			q.addCriteria(Criteria.where("age").regex(student.getAge(), "i"));
		}
		if(StringUtils.isNotBlank(student.getAddress())){
			q.addCriteria(Criteria.where("address").regex(student.getAddress(), "i"));
		}
		q.skip(offset).limit(limit);
		
		List<Student> list = this.mongoTemplate.find(q, Student.class);
		
		Pagination<Student> page = new Pagination<Student>();
		page.setTotal(count);
		page.setRows(list);
		return page;
	}
}
