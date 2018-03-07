package com.blog.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.blog.dao.LinkDao;
import com.blog.entity.Link;
import com.blog.service.LinkService;

@Service("linkService")
public class LinkServiceImpl implements LinkService{

	@Resource
	private LinkDao linkDao;
	
	public List<Link> find() {
		// TODO Auto-generated method stub
		return linkDao.find();
	}

	public List<Link> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return linkDao.list(map);
	}

	public Long count(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return linkDao.count(map);
	}

	public Link findById(Integer id) {
		// TODO Auto-generated method stub
		return linkDao.findById(id);
	}

	public int add(Link link) {
		// TODO Auto-generated method stub
		return linkDao.add(link);
	}

	public int update(Link link) {
		// TODO Auto-generated method stub
		return linkDao.update(link);
	}

	public int delete(Integer id) {
		// TODO Auto-generated method stub
		return linkDao.delete(id);
	}

}


