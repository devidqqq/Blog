package com.blog.controller.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.blog.entity.Blog;
import com.blog.entity.BlogType;
import com.blog.entity.PageBean;
import com.blog.lucene_search.LuceneSearch;
import com.blog.service.BlogService;
import com.blog.service.BlogTypeService;
import com.blog.util.ResponseUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/blogType")
public class BlogTypeAdminController {

	@Resource
	private BlogTypeService blogTypeService;
	
	@Resource
	private BlogService blogService;
	
	@RequestMapping("/list")
	public String list(@RequestParam(value="page",required=false)String page,
			@RequestParam(value="rows",required=false)String rows,HttpServletResponse response)throws Exception{
		PageBean pageBean = new PageBean(Integer.parseInt(page),Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", pageBean.getStart());
		map.put("size", pageBean.getPageSize());
		List<BlogType> blogTypeList = blogTypeService.list(map);
		Long total = blogTypeService.count(map);
		JSONArray array = JSONArray.fromObject(blogTypeList);
		JSONObject result = new JSONObject();
		result.put("rows", array);
		result.put("total", total);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(BlogType blogType,HttpServletResponse response)throws Exception {
		int resultTotal = 0;
		if(blogType.getId()==null) {
			resultTotal = blogTypeService.add(blogType);
		}else {
			resultTotal = blogTypeService.update(blogType);
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
	
	@RequestMapping("/delete")
	public String delete(@RequestParam(value="ids")String ids, HttpServletResponse response)throws Exception{
		Map<String,Object> map = new HashMap<String, Object>();
		StringBuffer exist = new StringBuffer();
		String[] id = ids.split(",");
		for (String string : id) {
			map.put("typeId", string);
			Long blogCount = blogService.blogCount(map);
			if(blogCount>0) {
				exist.append(string);
				exist.append(",");
			}else {
				blogTypeService.delete(Integer.parseInt(string));
			}
		}
		JSONObject result = new JSONObject();
		result.put("success", true);
		result.put("exist", exist.toString().substring(0, exist.length()-1));
		ResponseUtil.write(response, result);
		return null;
	}
}


