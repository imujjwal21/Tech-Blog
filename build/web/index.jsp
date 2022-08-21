
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="com.tech.blog.helper.ConnectionProvider" %>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.tech.blog.entities.User"%>

<%
    User user1 = (User) session.getAttribute("currentUser");
%>
 

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        
                        <!--        css-->
       <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0, 100% 0%, 100% 91%, 63% 100%, 22% 91%, 0% 99%, 0 0);
            }
        </style>
        
    </head>
    <body>
        
<!--        navbar-->
        
        <%@include file="normal_navbar.jsp" %>
        
<!--        banner-->
        
        <div class="container-fluid m-0 p-0">
            
            <div class="jumbotron primary-background text-white banner-background">
                
                <div class="container">
                
                    <h3 class="display-3">Welcome to TechBlog</h3>
                
                <p>A programming language is a formal language comprising a set of strings that produce various kinds of machine code output. Programming languages are one kind of computer language, and are used in computer programming to implement algorithms.</p>
                <p>  If you want to post you blog then you have to Login in this website and then you get Do Post Option .</p>
                
                
                <%
                if(user1 == null)
                    {
                %>
                
                <a href="register_page.jsp" class="btn btn-outline-light btn-md"><span class="fa fa-user-plus"></span>    Start ! its Free</a>
                
                <a href="login_page.jsp" class="btn btn-outline-light btn-md"><span class="fa fa-user-circle fa-spin"></span>    Login</a>
                
                <%
                    }
                %>
                
                </div>   
                <br>
            </div>
            
            
                   
        </div>

<!--            cards     -->

<div class="container">
    
        <div class="row">
    
              <div class="col-md-4">
                  
                     <div class="list-group mt-5">
                                                          <!--  list in bootstrap  -->                                                      
                        <a href="#" onclick="getPost(0,this)" class="c-link list-group-item list-group-item-action active">All Posts</a>
                        
                        <%
                           PostDao  d = new PostDao(ConnectionProvider.getConnection());
                           ArrayList<Category> list5= d.getAllCategories();
                           for(Category cc1:list5)
                           {
                        %>
                        <a href="#" onclick="getPost(<%= cc1.getCid()%> ,this)" class="c-link list-group-item list-group-item-action"><%= cc1.getName() %></a>
                        <!-- this means hai reference jo apan ne temp ko pass kiya -->
                        <%
                           }
                        %>
  
                    </div>
               </div>      <!--    col-md-4 End    -->
    
    
                    <div class="col-md-8">
                        <div class="container text-center" id="loader-show">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>   
                            <h3> Loading .... </h3>
                         </div>
        
                        <div class="container-fluid" id="posts-container">
                         
                        </div>
                    </div>
    
          </div>   <!--     Row End    -->
    
</div>     <!--    Container End     -->
 
                            
                            
                            
    <!--      End of Main Body of the Page       -->
   
    
    

        
        
                       <!--        javascript-->
        
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<script src="js/myjs.js" type="text/javascript"></script>



<script>
            
        function getPost(catId ,temp) {
            // temp mein uss link ka reference aayega jo humne click kiya hai .
            $(".c-link").removeClass('active')
            
            console.log(temp)
            
            $("#loader-show").show();
            $("#posts-container").hide()
            $.ajax({
                url: "load_posts_index.jsp",
                
                data:{cid:catId},    // yeh catId server par jayegi cid ke thought cid is key and catId is value .
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    $("#loader-show").hide();
                    $("#posts-container").show()
                    $("#posts-container").html(data)
                    
                    $(temp).addClass('active')
                }
            })   
        } 
        
        $(document).ready(function(e){
            // initial  humlog all post ka reference pass karege .
            
            let allPostRef = $('.c-link')[0]
            getPost(0,allPostRef)
        })
    </script>

    
    </body>
</html>
