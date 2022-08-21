package com.tech.blog.dao;
import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class PostDao {
    public Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
       
    // Function  
    public ArrayList<Category> getAllCategories(){
        
        ArrayList<Category> list = new ArrayList<>();
        
        try{
            String q = "select * from Categories";
            
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(q);
            
            while(rs.next())
            {
                int cid = rs.getInt("cid");
                String name = rs.getString("name");
                String description = rs.getString("description");
                
                Category c = new Category(cid,name,description);
                
                list.add(c);
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return list;   
    }
    
    // Function
    
    public boolean savePost(Post p)
    {
        boolean f = false;
        
        try{
            String query = "insert into posts(pTitle,pContent,pCode,pPic,catId,userId) values(?,?,?,?,?,?)";
            PreparedStatement psp = con.prepareStatement(query);
            
            psp.setString(1, p.getpTitle());
            psp.setString(2, p.getpContent());
            psp.setString(3, p.getpCode());
            psp.setString(4, p.getpPic());
            psp.setInt(5, p.getCatId());
            psp.setInt(6, p.getUserId());
            
            psp.executeUpdate();
            
            f=true;
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    public List<Post> getAllPosts()
    {
        List<Post> list = new ArrayList<>();
        // Fetch all post 
        
        try{
            PreparedStatement ps = con.prepareStatement("select * from posts order by pid desc");
            ResultSet rst = ps.executeQuery();
            
            while(rst.next())
            {
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pCode = rst.getString("pCode");
                String pPic = rst.getString("pPic");
                Timestamp date= rst.getTimestamp("pDate");
                int catId = rst.getInt("catId");
                int userId = rst.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
                
            }
         
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return list;
    }
    
    
    public List<Post> getAllPostsByUserId(int uid)
    {
        List<Post> list = new ArrayList<>();
        // Fetch all post 
        
        try{
            PreparedStatement ps = con.prepareStatement("select * from posts where userId=? order by pid desc");
            ps.setInt(1, uid);
            ResultSet rst = ps.executeQuery();
            
            while(rst.next())
            {
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pCode = rst.getString("pCode");
                String pPic = rst.getString("pPic");
                Timestamp date= rst.getTimestamp("pDate");
                int catId = rst.getInt("catId");
                int userId = rst.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
                
            }
         
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return list;
    }
    
    
    
    
    public List<Post> getPostByCatId(int catId)
    {
        List<Post> list = new ArrayList<>();
        // Fetch all post by id
        
        try{
            PreparedStatement ps = con.prepareStatement("select * from posts where catId=?");
            ps.setInt(1, catId);
            ResultSet rst = ps.executeQuery();
            
            while(rst.next())
            {
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pCode = rst.getString("pCode");
                String pPic = rst.getString("pPic");
                Timestamp date= rst.getTimestamp("pDate");
                
                int userId = rst.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return list;  
    }
    
    
    public List<Post> getPostByCatIdAndUserId(int catId ,int uid)
    {
        List<Post> list = new ArrayList<>();
        // Fetch all post by id
        
        try{
            PreparedStatement ps = con.prepareStatement("select * from posts where catId=? and userId=?");
            ps.setInt(1, catId);
            ps.setInt(2, uid);
            ResultSet rst = ps.executeQuery();
            
            while(rst.next())
            {
                int pid = rst.getInt("pid");
                String pTitle = rst.getString("pTitle");
                String pContent = rst.getString("pContent");
                String pCode = rst.getString("pCode");
                String pPic = rst.getString("pPic");
                Timestamp date= rst.getTimestamp("pDate");
                
                int userId = rst.getInt("userId");
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post);
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return list;  
    }
    
    
    // user for show_blog which show one blog on one page ( separateley ) .
    
    public Post getPostByPostId(int postId)
    {
        Post post = null;
        
        String q = "select * from posts where pid=?";
        
        try
        {
        PreparedStatement p = this.con.prepareStatement(q);
        p.setInt(1, postId);
        ResultSet st = p.executeQuery();
        
        if(st.next())
        {
                post = new Post();
            
                int pid = st.getInt("pid");
                String pTitle = st.getString("pTitle");
                String pContent = st.getString("pContent");
                String pCode = st.getString("pCode");
                String pPic = st.getString("pPic");
                Timestamp date= st.getTimestamp("pDate");
                int cid = st.getInt("catId");
                
                int userId = st.getInt("userId");
                
                post = new Post(pid, pTitle, pContent, pCode, pPic, date, cid, userId);
               //post = new Post(postId, pTitle, pContent, pCode, pPic, date, cid, userId);  yeh bhi sahi hai toh int pid nahi banana padega .
               
        }
        
        }catch(Exception e)
        {
            System.out.print(e);
        }
        return post;
    }
    
    
}
