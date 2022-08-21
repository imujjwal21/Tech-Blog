package com.tech.blog.dao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.sql.*;

public class UserDao {
    
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    
    public boolean CheckUserExistency(String email)
    {
        
        boolean f = false;
        
        try{
            String query = "select * from user where email=?";
            
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1,email);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                f=true;
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    //to insert user to database .
    
    public boolean saveUser(User user)
    {
        boolean f=false;
        
        try{
            String query= "insert into user(name,email,password,gender,about) values(?,?,?,?,?)";
            
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1 ,user.getName());
            ps.setString(2 ,user.getEmail());
            ps.setString(3 ,user.getPassword());
            ps.setString(4 ,user.getGender());
            ps.setString(5 ,user.getAbout());
            
            ps.executeUpdate();
            
            f=true;
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;    
    }    // end saveUser .
    
    // get user by user email and user password .
     
    public User getUserByEmailAndPassword(String email,String password)
    {
        User user=null;
        
        try{
            String query = "select * from user where email=? and password=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs =  ps.executeQuery();
            
            if(rs.next())  //direct he kar diya kyuki 1 he user hoga .
            {
                user = new User();  // make new obj of User class which is present at User.java that why we import com.tech.blog.entities.User;
                String name = rs.getString("name"); //database se nikala  ( also like this  rs.getString(2); )
                user.setName(name);            //set to user obj
                
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDateTime(rs.getTimestamp("rdate"));
                user.setProfile(rs.getString("profile"));
            }
            
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        return user;
    }
    
    public boolean updateUser(User user)
    {
       
        boolean f=false;
        
        try{
            String query= "update user set name=? , email=? , password=? ,gender=? , about=? ,profile=? where id=?";
           
            PreparedStatement ps = con.prepareStatement(query);   // this.con bhi likh sakte hai
           
            ps.setString(1 ,user.getName());
            ps.setString(2 ,user.getEmail());
            ps.setString(3 ,user.getPassword());
            ps.setString(4 ,user.getGender());
            ps.setString(5 ,user.getAbout());
            ps.setString(6 ,user.getProfile());
            ps.setInt(7 ,user.getId());
            
            ps.executeUpdate();
            
            
            f=true;
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        return f;
    }
    
    
    // For  #24   video
    
    public User getUserByUserId(int userId)
    {
        User user = null;
        
        String q = "select * from user where id=?";
        
        try
        {
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1,userId);
            
            ResultSet rs = ps.executeQuery();
            
            while(rs.next())
            {
                user = new User();  // make new obj of User class which is present at User.java that why we import com.tech.blog.entities.User;
                String name = rs.getString("name"); //database se nikala  ( also like this  rs.getString(2); )
                user.setName(name);            //set to user obj
                
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDateTime(rs.getTimestamp("rdate"));
                user.setProfile(rs.getString("profile"));
            }
            
        }catch(Exception e)
        {
            System.out.print(e);
        }
        
        
        return user;
    }
    
    
}
