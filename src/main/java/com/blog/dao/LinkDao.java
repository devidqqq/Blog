package com.blog.dao;

import java.util.List;
import java.util.Map;

import com.blog.entity.Link;

public interface LinkDao {

	/**
	 * 获取所有链接实体
	 * @return List<Link>
	 */
	public List<Link> find();
	
	/**
	 * 查询所有友情链接
	 * @return List<Link>
	 */
	public List<Link> list(Map<String,Object> map);
	
	/**
	 * 查询总记录数
	 * @param map
	 * @return Long
	 */
	public Long count(Map<String,Object> map);
	
	/**
	 * 根据id查找link实体
	 * @param id
	 * @return Link
	 */
	public Link findById(Integer id);
	
	/**
	 * 添加友情链接
	 * @param link
	 * @return int
	 */
	public int add(Link link);
	
	/**
	 * 修改友情链接
	 * @param link
	 * @return int
	 */
	public int update(Link link);
	
	/**
	 * 删除友情链接
	 * @param id
	 * @return int
	 */
	public int delete(Integer id);
}


