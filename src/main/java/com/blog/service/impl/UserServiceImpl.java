package com.blog.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.blog.dao.UserDao;
import com.blog.entity.User;
import com.blog.service.UserService;

@Service("userService")
public class UserServiceImpl implements UserService{

	@Resource
	private UserDao userDao;
	
	public User getUserByUserName(String userName) {
		return userDao.getUserByUserName(userName);
	}

	public User getUser() {
		return userDao.getUser();
	}

	public Integer update(User user) {
		return userDao.update(user);
	}

}


