package com.blog.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.blog.dao.CommentDao;
import com.blog.entity.Comment;
import com.blog.service.CommentService;

@Service("commentService")
public class CommentServiceImpl implements CommentService{

	@Resource
	private CommentDao commentDao;
	
	public List<Comment> list(Map<String, Object> map) {
		return commentDao.list(map);
	}

	public int add(Comment comment) {
		return commentDao.add(comment);
	}

	public Long commentCount(Map<String, Object> map) {
		return commentDao.commentCount(map);
	}

	public Integer update(Comment comment) {
		// TODO Auto-generated method stub
		return commentDao.update(comment);
	}

	public Integer delete(List<String> ids) {
		// TODO Auto-generated method stub
		return commentDao.delete(ids);
	}


}


