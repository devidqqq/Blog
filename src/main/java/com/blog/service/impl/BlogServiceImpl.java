package com.blog.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.blog.dao.BlogDao;
import com.blog.entity.Blog;
import com.blog.service.BlogService;

@Service("blogService")
public class BlogServiceImpl implements BlogService{

	@Resource
	private BlogDao blogDao;
	
	public List<Blog> findBlogCountByTime() {
		// TODO Auto-generated method stub
		return blogDao.findBlogCountByTime();
	}

	public List<Blog> blogList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return blogDao.blogList(map);
	}

	public Long blogCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return blogDao.blogCount(map);
	}

	public List<Blog> findHotReader() {
		// TODO Auto-generated method stub
		return blogDao.findHotReader();
	}

	public Blog getBlogById(Integer id) {
		// TODO Auto-generated method stub
		return blogDao.getBlogById(id);
	}

	public Integer update(Blog blog) {
		// TODO Auto-generated method stub
		return blogDao.update(blog);
	}

	public Blog getLastBlogById(Integer id) {
		// TODO Auto-generated method stub
		return blogDao.getLastBlogById(id);
	}

	public Blog getNextBlogById(Integer id) {
		// TODO Auto-generated method stub
		return blogDao.getNextBlogById(id);
	}

	public int add(Blog blog) {
		// TODO Auto-generated method stub
		return blogDao.add(blog);
	}

	public int delete(List<String> ids) {
		// TODO Auto-generated method stub
		return blogDao.delete(ids);
	}

}


