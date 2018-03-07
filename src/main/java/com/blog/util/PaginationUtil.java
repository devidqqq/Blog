package com.blog.util;

public class PaginationUtil {
	
	public static String genPagination(String url,int total,int currentPage,int pageSize,String param) {
		int totalPage = total%pageSize==0 ? total/pageSize : total/pageSize+1;
		StringBuffer paginationCode = new StringBuffer();
		paginationCode.append("<nav aria-label='...'>");
		paginationCode.append("<ul class='pagination'>");
		paginationCode.append("<li><a href='"+url+"?page="+1+"&"+param+"'>首页</a></li>");
		if(currentPage==1) {
			paginationCode.append("<li class='disabled'><a href='#'>上一页</a></li>");
		}else {
			paginationCode.append("<li><a href='"+url+"?page="+(currentPage-1)+"&"+param+"'>上一页</a></li>");
		}
		for(int i=currentPage-2;i<currentPage+2;i++) {
			if(i>=1 && i<=totalPage) {
				if(i==currentPage) {
					paginationCode.append("<li class='active'><a href='#'>"+i+"</a></li>");
				}else {
					paginationCode.append("<li><a href='"+url+"?page="+i+"&"+param+"'>"+i+"</a></li>");
				}
			}
		}
		if(currentPage==totalPage) {
			paginationCode.append("<li class='disabled'><a href='#'>下一页</a></li>");
		}else {
			paginationCode.append("<li><a href='"+url+"?page="+(currentPage+1)+"&"+param+"'>下一页 </a></li>");
		}
		paginationCode.append("<li><a href='"+url+"?page="+totalPage+"&"+param+"'>尾页</a></li>");
		paginationCode.append("</ul>");
		paginationCode.append("</nav>");
		return paginationCode.toString();
	}
}


