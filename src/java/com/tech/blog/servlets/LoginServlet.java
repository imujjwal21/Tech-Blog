package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.annotation.MultipartConfig;

@MultipartConfig
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            String userEmail = request.getParameter("email");
            String userPassword = request.getParameter("password");
            
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            
            User u = dao.getUserByEmailAndPassword(userEmail, userPassword);
            
            if(u==null)
            {
                //error
               //  out.println("invalid details .. invalid");
                Message msg = new Message("Incorrect Email or Password ! Try Again","error","alert-danger");
                
                HttpSession s = request.getSession();
                s.setAttribute("msg", msg);   //"msg" yeh name hai get karne ke kaam aayega or , wala msg value hai (Message ka obj wala) .
                
                response.sendRedirect("login_page.jsp");
            }
            
            else
            {
                HttpSession s = request.getSession();
                s.setAttribute("currentUser", u);
                
                response.sendRedirect("profile.jsp");
            }
            
            out.println("</body>");
            out.println("</html>");
        }
    }

}
