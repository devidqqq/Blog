package com.blog.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.Link;
import com.blog.entity.User;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.service.LinkService;
import com.blog.service.UserService;

@Component
public class InitComponent implements ServletContextListener,ApplicationContextAware{

	private static ApplicationContext applicationContext;
	
	public void contextInitialized(ServletContextEvent servletContext) {
		
		//获取用户信息
		ServletContext application = servletContext.getServletContext();//通过servletContext获取application
		UserService userService = (UserService) applicationContext.getBean("userService");
		User currentUser = userService.getUser();
		currentUser.setPassword(null);
		application.setAttribute("currentUser", currentUser);
		
		//获取blogType信息
		BlogTypeService blogTypeService = applicationContext.getBean("blogTypeService", BlogTypeService.class);
		List<BlogType> blogTypeList = blogTypeService.blogTypeList();
		application.setAttribute("blogTypeList", blogTypeList);
		
		//获取link信息
		LinkService linkService = applicationContext.getBean("linkService", LinkService.class);
		List<Link> linkList = linkService.find();
		application.setAttribute("linkList", linkList);
		
		//获取按日期分类
		BlogService blogService = applicationContext.getBean("blogService", BlogService.class);
		List<Blog> blogCountListWithTime = blogService.findBlogCountByTime();
		application.setAttribute("blogCountListWithTime", blogCountListWithTime);
		
	}

	public void contextDestroyed(ServletContextEvent servletContext) {
		// TODO Auto-generated method stub
		
	}

	/**
	 * 通过spring实例化applicationContext实例
	 * @param applicationContext
	 * @throws BeansException void
	 */
	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		// TODO Auto-generated method stub
		this.applicationContext=applicationContext;
	}

}


