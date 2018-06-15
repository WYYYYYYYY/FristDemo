package com.student.controller;
import java.util.Collections;
import java.util.List;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.student.entity.Pagination;
import com.student.entity.Student;
import com.student.service.IStudentService;

/**
 * controller层使用@controller注解
 *@Controller 用于标记在一个类上，使用它标记的类就是一个SpringMVC Controller 对象。分发处理器将会扫描使用了该注解的类的方法。
 *通俗来说，被Controller标记的类就是一个控制器，这个类中的方法，就是相应的动作。
 *@RequestMapping是一个用来处理请求地址映射的注解，可用于类或方法上。用于类上，表示类中的所有响应请求的方法都是以该地址作为父路径。
 *若要直接往response中写内容而不经过视图解析器时可以使用@ResponseBody
 */

/**
 * @Controller:负责注册一个bean 到spring 上下文中
 * @RequestMapping:注解为控制器指定可以处理哪些 URL 请求
 * @RequestBody:　该注解用于读取Request请求的body部分数据，使用系统默认配置的HttpMessageConverter进行解析，然后把相应的数据绑定到要返回的对象上 ,
 * 				    再把HttpMessageConverter返回的对象数据绑定到 controller中方法的参数上
 * @ResponseBody:该注解用于将Controller的方法返回的对象，通过适当的HttpMessageConverter转换为指定格式后，写入到Response对象的body数据区
 * @RequestParam:在处理方法入参处使用 @RequestParam 可以把请求参 数传递给请求方法
 * @PathVariable:绑定 URL 占位符到入参
 * @ExceptionHandler:注解到方法上，出现异常时会执行该方法
 * @ControllerAdvice:使一个Contoller成为全局的异常处理类，类中用@ExceptionHandler方法注解的方法可以处理所有Controller发生的异常
 *
 */
@Controller
@RequestMapping("/student")
public class StudentController {
	private Logger log = LoggerFactory.getLogger(getClass());
	@Autowired 
	private IStudentService  studentService ;
	
	@RequestMapping("/addStudent")
	public String Insert(Student student)
	{
		log.debug("insert stu="+student.toString());
		studentService.insert(student);
		return "right";
	}
	@RequestMapping("/list")
	public @ResponseBody Pagination<Student> pageList(Student search, int offset, int limit){
		log.debug("search stu=="+search);
		log.debug("page info. offset={}, limit={}", offset, limit);
		return this.studentService.getPageData(search,offset, limit);
	}
	
	@RequestMapping("/list2")
	public @ResponseBody JSONObject list(Student search){
		List<Student> stuList = Collections.EMPTY_LIST;
		if(StringUtils.isNotBlank(search.getName()) && StringUtils.isNotBlank(search.getAge()) && StringUtils.isNotBlank(search.getAddress())){
			stuList = this.studentService.findByQuery(search.getName(),search.getAge(),search.getAddress());
		}else{
			stuList = this.studentService.findAll();
		}
		//JSONObject-lib包是一个beans,collections,maps,java arrays和xml和JSON互相转换的包
		JSONObject jo = new JSONObject();
		jo.put("total", stuList.size());		
		JSONArray ja = new JSONArray();
		for(Student stu:stuList){
			JSONObject job = new JSONObject();
			job.put("id", stu.getId());
			job.put("name", stu.getName());
			job.put("age", stu.getAge());
			job.put("sex", stu.getSex());
			job.put("birthday", stu.getBirthday());
			job.put("email", stu.getEmail());
			job.put("phone", stu.getPhone());
			job.put("address", stu.getAddress());
			ja.add(job);
		}
		jo.put("rows", ja);
		return jo;
	}
	
	@RequestMapping("/delStudent")
	public String deleteById(String[] ids){
		try {
			if(ids != null && ids.length > 0){
				for (String id : ids) {
					studentService.deleteById(id);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "right";
	}
	
	@RequestMapping("/findByIdStudent")
	@ResponseBody
	public Student findByIdStudent(String id){
		Student sd = studentService.findById(id);
		return sd; //?
	}
	
	@RequestMapping("/updateStudent")
	public String updateStudent(Student student){
		studentService.updateStudent(student);
		return "right";
	}
	
	
				
}
