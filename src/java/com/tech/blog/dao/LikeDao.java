package com.tech.blog.dao;
import java.sql.*;

public class LikeDao {
    
    public Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    
    public boolean insertLike(int pid,int uid)
    {
        boolean f = false;
        try{
            String q = "insert into likes(pid,uid) values(?,?)";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1,pid);
            ps.setInt(2,uid);
            
            ps.executeUpdate();
            
            f=true;
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    public int countLikeOnPost(int pid)
    {
        int count = 0;
        
        try{ 
            String q ="select count(*) from likes where pid=?";   //select count(lid) form likes where pid=?;  yeh bhi likh sakte hai .
            // string q local variable banaya hai humne iss liye hum koi or function mein bhi fir se String q le sakte hai .
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, pid);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                count = rs.getInt("count(*)");   // or yeh bhi likh sakte hai rs.getInt(1); 
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return count;
    }
    
    public boolean isLikeByUser(int pid,int uid)
    {
        boolean f = false;
        
        try{
            String q ="select * from likes where pid=? and uid=?";
            
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1,pid);
            ps.setInt(2,uid);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                f = true;
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    public boolean deleteLike(int pid,int uid)
    {
        boolean f = false;
        
        try{
            
            PreparedStatement ps = this.con.prepareStatement("delete from likes where pid=? and uid=?");
            ps.setInt(1, pid);
            ps.setInt(2, uid);
            
            ps.executeUpdate();
            
            f = true;
         
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    
    
}
