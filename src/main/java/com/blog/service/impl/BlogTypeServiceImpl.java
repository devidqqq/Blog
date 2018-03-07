package com.blog.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.blog.dao.BlogTypeDao;
import com.blog.entity.BlogType;
import com.blog.service.BlogTypeService;

@Service("blogTypeService")
public class BlogTypeServiceImpl implements BlogTypeService{
	
	@Resource
	private BlogTypeDao blogTypeDao;


	public List<BlogType> blogTypeList() {
		// TODO Auto-generated method stub
		return blogTypeDao.blogTypeList();
	}


	public List<BlogType> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return blogTypeDao.list(map);
	}


	public Long count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return blogTypeDao.count(map);
	}


	public int add(BlogType blogType) {
		// TODO Auto-generated method stub
		return blogTypeDao.add(blogType);
	}


	public int update(BlogType blogType) {
		// TODO Auto-generated method stub
		return blogTypeDao.update(blogType);
	}


	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return blogTypeDao.delete(id);
	}

}


