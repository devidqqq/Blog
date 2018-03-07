package com.blog.service;

import java.util.List;
import java.util.Map;

import com.blog.entity.BlogType;

public interface BlogTypeService {

	
	/**
	 * 查询所有博客类别，以及类别下的博客数量
	 * @return List<BlogType>
	 */
	public List<BlogType> blogTypeList();
	
	/**
	 * 查询所有博客类别，以及类别下的博客数量
	 * @return List<BlogType>
	 */
	public List<BlogType> list(Map<String,Object> map);
	
	/**
	 * 查询总记录数
	 * @param map
	 * @return Long
	 */
	public Long count(Map<String,Object> map);
	
	/**
	 * 添加博客类型
	 * @param blogType
	 * @return int
	 */
	public int add(BlogType blogType);
	
	/**
	 * 修改博客类别
	 * @param blogType
	 * @return int
	 */
	public int update(BlogType blogType);
	
	/**
	 * 删除博客类别
	 * @param id
	 * @return int
	 */
	public int delete(Integer id);
}


