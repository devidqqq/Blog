package com.blog.service;

import com.blog.entity.User;

public interface UserService {

	
	/**
	 * 通过用户名查询用户
	 * @param userName
	 * @return User
	 */
	public User getUserByUserName(String userName);
	
	/**
	 * 获取当前登录用户信息
	 * @return User
	 */
	public User getUser();
	
	/**
	 * 更新用户信息
	 * @param user
	 * @return Integer
	 */
	public Integer update(User user);
}


