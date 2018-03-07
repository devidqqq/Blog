package com.blog.controller.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.blog.controller.util.DateJsonValueProcessor;
import com.blog.entity.Blog;
import com.blog.entity.PageBean;
import com.blog.lucene_search.LuceneSearch;
import com.blog.service.BlogService;
import com.blog.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
@RequestMapping("/admin/blog")
public class BlogAdminController {

	@Resource
	private BlogService blogService;
	private LuceneSearch lucene = new LuceneSearch();
	@RequestMapping("/save")
	public String save(Blog blog,HttpServletResponse response)throws Exception {
		int resultTotal = 0;
		if(blog.getId()==null) {
			resultTotal = blogService.add(blog);
			lucene.addIndex(blog);
		}else {
			resultTotal = blogService.update(blog);
			lucene.updateIndex(blog);
		}
		JSONObject result = new JSONObject();
		if(resultTotal>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows",required=false)String rows,HttpServletResponse response)throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<Blog> blogList = blogService.blogList(map);
		Long total = blogService.blogCount(map);
		JSONObject result = new JSONObject();
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray jsonArray = JSONArray.fromObject(blogList, jsonConfig);
		result.put("rows", jsonArray);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids",required=false)String ids,HttpServletResponse response)throws Exception{
		List<String> l = new ArrayList<String>();
		String[] s = ids.split(",");
		for (String string : s) {
			l.add(string);
			lucene.deleteIndex(string);
		}
		int num = blogService.delete(l);
		JSONObject result=new JSONObject();
		if(num>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/getBlogById")
	public String update(@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		Blog blog = blogService.getBlogById(Integer.parseInt(id));
		JSONObject result = JSONObject.fromObject(blog);
		ResponseUtil.write(response, result);
		return null;
	}
}


