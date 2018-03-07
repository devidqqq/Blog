package com.blog.service;

import java.util.List;
import java.util.Map;

import com.blog.entity.Comment;

public interface CommentService {

	
	/**
	 * 查找评论列表
	 * @param map
	 * @return List<Comment>
	 */
	public List<Comment> list(Map<String,Object> map);
	
	/**
	 * 添加评论
	 * @param comment
	 * @return int
	 */
	public int add(Comment comment);
	
	/**
	 * 按条件查找comment总数
	 * @param map
	 * @return Long
	 */
	public Long commentCount(Map<String,Object> map);
	
	/**
	 * 更新comment狀態
	 * @param comment
	 * @return Integer
	 */
	public Integer update(Comment comment);
	
	/**
	 * 刪除評論
	 * @param ids
	 * @return Integer
	 */
	public Integer delete(List<String> ids);
}


