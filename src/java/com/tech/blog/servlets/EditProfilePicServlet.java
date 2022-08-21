package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig  //jo form submit huya uska ka data as multipart data aaya hai . it is class base anotation so write before class .
public class EditProfilePicServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProfilePicServlet</title>");            
            out.println("</head>");
            out.println("<body>");
         
             Part part = request.getPart("image");   // iss ke pass selected image ka pura data hai .  form mein humne name="image" diya tha
            String imageName = part.getSubmittedFileName();  // file ka name aa jayega with extension in imageName variable mein .
            
           //  get user from session  ( purana data jo session mein aaya jab login kiya the )
           
            HttpSession s = request.getSession();    // servlet mein aise he hota hai jsp mein toh session.getAttribute("name"); se he aa jata hai
         
            User user = (User)s.getAttribute("currentUser");     // iss naam se main session mein set kiya tha login ke waqt LoginServlet.java file mein .
            
//iske ander ke details ko replace karna hai naye wale se .
            
            String oldFile = user.getProfile();
      //      System.out.print("\n\n"+imageName+"\n\n"+user.getName());
            user.setProfile(imageName);
            
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
          
            boolean ans = userDao.updateUser(user);
            
            if(ans)
            {
                
                String path = request.getRealPath("/")+"pics"+File.separator+user.getProfile();
                
                String pathOldFile = request.getRealPath("/")+"pics"+File.separator+oldFile;
                
                // delete previous pic 
                if(!oldFile.equals("default.png"))
                {
                    System.out.print("\n\nhello 1\n\n");
                Helper.deleteFile(pathOldFile);
                }
               
                if(Helper.saveFile(part.getInputStream(), path))
                {
                    //out.println("Profile pic updated");
                     Message msg = new Message("Profile Pic updated Successfully","success","alert-success");
                
                    s.setAttribute("msg", msg);   //"msg" yeh name hai get karne ke kaam aayega or , wala msg value hai (Message ka obj wala) .
                
                    response.sendRedirect("profile.jsp");
                
                }else
                {
                    Message msg = new Message("Something went wrong","error","alert-danger");
                
                    s.setAttribute("msg", msg);
                    response.sendRedirect("profile.jsp");
                }
       
            }
            else
                {
                    Message msg = new Message("Something went wrong","error","alert-danger");
                
                    s.setAttribute("msg", msg);
                    response.sendRedirect("profile.jsp");
                  
                }
            
            out.println("</body>");
            out.println("</html>");
        }
    }

}
