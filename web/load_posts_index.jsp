<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page errorPage="error_page.jsp" %>

<!-- Yeh page profile page par load hoga . -->

<div class="row">
    
<%
    Thread.sleep(500);   //at that time we are at local host server so to see how loader is work we use thread of 0.5 sec delay .
    
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    int cid = Integer.parseInt(request.getParameter("cid"));
    
    List<Post> posts = null;
    
    if(cid==0)
    {
        posts = d.getAllPosts();
    }
    else
    {
        posts = d.getPostByCatId(cid);
    }
    
    if(posts.size()==0)
    {
        out.println("<h3 class='display-3 text-center my-5'>No Posts in  this category ....</h3>");
        return;
    }
    
    for(Post p:posts)  //(Type variable:name)
    {
    
%>
<div class="col-md-6 mb-4">  <!--column-medium screen-6 grid lo  . ek row mein total 12 grid hote hai && we can also use style="height: 300px" in img -->
    
    <div class="card mt-3">
        <img class="card-img-top" src="blog_pics/<%= p.getpPic() %>" alt="card image cap">
        <div class="card-body">
            <b><%= p.getpTitle() %></b>
            <p><%= p.getpContent() %></p>
        </div>
        
        <div class="card-footer primary-background text-center">
            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i> <span>10</span></a>
            <a href="show_blog_page.jsp?post_id=<%=p.getpId() %>" class="btn btn-outline-light btn-sm">Read More ...</a>
            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting"></i> <span>10</span></a>
        </div>
        
    </div>
    
</div>

<%
    }
%>

</div>