package com.blog.dao;

import java.util.List;
import java.util.Map;

import com.blog.entity.Blog;

public interface BlogDao {

	/**
	 * 查找按日期分类
	 * @return List<Blog>
	 */
	public List<Blog> findBlogCountByTime();
	
	/**
	 * 阅读排行
	 * @return List<Blog>
	 */
	public List<Blog> findHotReader();
	
	/**
	 * 查找所有blog实体
	 * @param map
	 * @return List<Blog>
	 */
	public List<Blog> blogList(Map<String,Object> map);
	
	/**
	 * 按条件查找blog总数
	 * @param map
	 * @return Long
	 */
	public Long blogCount(Map<String,Object> map);
	
	/**
	 * 根据id查找实体
	 * @param id
	 * @return Blog
	 */
	public Blog getBlogById(Integer id);
	
	/**
	 * 更新文章
	 * @param Blog
	 * @return Integer
	 */
	public Integer update(Blog blog);
	
	/**
	 * 根据id获取上一篇博客
	 * @param id
	 * @return Blog
	 */
	public Blog getLastBlogById(Integer id);
	
	/**
	 * 根据id获取下一篇博客
	 * @param id
	 * @return Blog
	 */
	public Blog getNextBlogById(Integer id);
	
	/**
	 * 添加博客
	 * @param blog
	 * @return int
	 */
	public int add(Blog blog);
	
	/**
	 * 删除博客
	 * @param ids
	 * @return int
	 */
	public int delete(List<String> ids);
}


