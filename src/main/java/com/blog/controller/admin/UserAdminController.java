package com.blog.controller.admin;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.blog.entity.User;
import com.blog.service.UserService;
import com.blog.util.CryptographyUtil;
import com.blog.util.DateUtil;
import com.blog.util.ResponseUtil;

import net.sf.json.JSONObject;

@Controller
@RequestMapping("/admin/user")
public class UserAdminController {

	@Resource
	private UserService userService;
	
	@RequestMapping("/getUserInfo")
	public String getUserInfo(@RequestParam(value="userName")String userName,HttpServletResponse response)throws Exception {
		User user = userService.getUserByUserName(userName);
		JSONObject result = JSONObject.fromObject(user);
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/save")
	public String save(@RequestParam(value="imageFile")MultipartFile imageFile ,User user,HttpServletRequest request ,HttpServletResponse response)throws Exception{
		if(!imageFile.isEmpty()) {
			String imagePath = request.getServletContext().getRealPath("/")+"static/userImages/";
			String imageName = DateUtil.getCurrentDateStr()+"."+imageFile.getOriginalFilename().split("\\.")[1];
			imageFile.transferTo(new File(imagePath+imageName));
			user.setImageName(imageName);
		}
		int resultTotal=userService.update(user);
		StringBuffer result=new StringBuffer();
		if(resultTotal>0){
			result.append("<script language='javascript'>alert('修改成功！');winsow.parent.refreshTab();</script>");
		}else{
			result.append("<script language='javascript'>alert('修改失败！');</script>");
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/update")
	public String update(@RequestParam(value="password")String password,@RequestParam(value="id")String id,HttpServletResponse response)throws Exception{
		User user = new User();
		user.setPassword(CryptographyUtil.MD5(password, "admin"));
		user.setId(Integer.parseInt(id));
		int resultTotal=userService.update(user);
		JSONObject result = new JSONObject();
		if(resultTotal>0) {
			result.put("success", true);
		}else {
			result.put("success", false);
		}
		ResponseUtil.write(response, result);
		return null;
	}
	
	@RequestMapping("/logout")
	public String logout()throws Exception{
		SecurityUtils.getSubject().logout();
		return "redirect:/login.jsp";
	}
}


