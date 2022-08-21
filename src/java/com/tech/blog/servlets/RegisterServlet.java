package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import javax.servlet.annotation.MultipartConfig;

@MultipartConfig 
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
            //fetch all form data
            
            UserDao dao=new UserDao(ConnectionProvider.getConnection());
            
            String check=request.getParameter("check");
            String useremail=request.getParameter("user_email");
            if(check==null)
            {
                out.print("Box not checked .");
            }
            else if(dao.CheckUserExistency(useremail))
            {
                out.print("This E-mail Already Exit ! Please Enter Another . ");
            }
           
            else
            {
                String name=request.getParameter("user_name");
                String email=request.getParameter("user_email");
                String password=request.getParameter("user_password");
                String gender=request.getParameter("gender");
                String about=request.getParameter("about");
                

                //create user obj and set all data to that obj.
                User user =new User(name,email,password,gender,about);
                
                // constructor banane ke jagah yeh bhi kar sakta tha
                
                //iske ander ke details ko replace karna hai naye wale se .
                
          //                User user = new User();
                
//            user.setEmail(email);
//            user.setName(name);
//            user.setPassword(password);
//            user.setAbout(about);
//            user.setGender(gender);
                
                
                //create obj of user dao .
                
                
                if(dao.saveUser(user))
                {
                    out.println("done");
                }
                else
                {
                    out.println("error");
                }
            }
            
            
            
        }
    }
}
