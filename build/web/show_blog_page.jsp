<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.mysql.jdbc.ConnectionProperties"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if(user==null)
    {
        response.sendRedirect("login_page.jsp");
    }
    
%>

<%
    
    int postId = Integer.parseInt(request.getParameter("post_id"));
    
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    
    Post p = d.getPostByPostId(postId);
    
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle() %></title>
        
          <!--        css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0, 100% 0%, 100% 91%, 63% 100%, 22% 91%, 0% 99%, 0 0);    
            }
            
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            
            body{
                background: url(img/web2.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
            
        </style>
        
        
    </head>
    <body>
     
        <div id="fb-root"></div>
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v12.0" nonce="AtVS36ep"></script>

        
<!--        if(user != null)
           {-->
        
        
        
        <!---    Navbar    -->
        
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">      <!--bg-dark ke jagah primary-background -->
    <a class="navbar-brand" href="index.jsp"> <span class="fa fa-asterisk"></span>    Tech Blog</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
        
      <li class="nav-item active">
        <a class="nav-link" href="profile.jsp"> <span class="fa fa-bell-o"></span>    LearnCode with Ujjwal <span class="sr-only">(current)</span></a>
      </li>
      
<!--      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="fa fa-check-square-o"></span>    Categories
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Programming language</a>
          <a class="dropdown-item" href="#">Project Implementation</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Data Structure</a>
        </div>
      </li>-->

      
      
      <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal" ><span class="fa fa-asterisk"></span>    Do Post</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span>    Contact Us</a>
      </li>
      
      <li class="nav-item">
        <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> About Us</a>
      </li>
        
    </ul>
      
      <ul class="navbar-nav mr-right">
          
            <li class="nav-item">
        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal" ><span class="fa fa-user-circle"></span>     <%=user.getName() %></a>
            </li>
          
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#edit-profile-pic">    Edit Profile Pic</a>
            </li>
            
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet"><span class="fa fa-share-square"></span>     Logout</a>
            </li>
            
          
      </ul>
          
    
  </div>
    
</nav>
        
        <!--    End of NavBar    -->
        
        
        
 <!--    Main Content of Body    -->
        
 <div class="container">
     
     <div class="row my-4">
         
         <div class="col-md-8 offset-md-2">
             
             <div class="card">
                 
                 <div class="card-header primary-background text-white">
                    
                     <h4 class="post-title"> <%= p.getpTitle()%>
                 
                 </div>
                 
                 <div class="card-body">
                     
                     <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic() %>" alt="Card image cap">
                     
                     <div class="row my-3 row-user">
                         
                         <div class="col-md-8">
                             
                             <%
                             UserDao ud = new UserDao(ConnectionProvider.getConnection());
                             
                             %>
                             <p class="post-user-info"><a href=""> <%= ud.getUserByUserId(p.getUserId()).getName() %> </a> has posted : </p>
                         </div>
                         
                         <div class="col-md-4">
                             <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
                         </div>
                         
                     </div>
                     
                     <p class="post-content"><%= p.getpContent() %></p>
                     
                     <br>
                     
                     <div class="post-code">
                     <pre> <%= p.getpCode()%> </pre>
                     </div>
                     
                 </div>
                     
                 <div class="card-footer primary-background">
                         
                     <a href="#!" onclick="doLike(<%=p.getpId()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-md"><i class="fa fa-thumbs-o-up"></i> <span>10</span></a>
                     <a href="#!" class="btn btn-outline-light btn-md"><i class="fa fa-commenting"></i> <span>10</span></a>
                     
                 </div>
                     
                     <div class="card-footer">
                         
                         <div class="fb-comments" data-href="http://localhost:8080/Tech_Blog/show_blog_page.jsp?post_id=<%= p.getpId() %>" data-width="" data-numposts="5"></div>
                             
                     </div>
                     
             
             </div>
             
         </div>
         
     </div>
     
 </div>
        
        
        
        
        <!--    End Main Content of Body    -->
        
        
        
        
        
        <!------     Models     ----->
                            
<!--          Edit Profile Pic -->

<!-- Modal -->

<div class="modal fade" id="edit-profile-pic" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Select New Profile Pic </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          
          <form action="EditProfilePicServlet" method="post" enctype="multipart/form-data">
              <br>
               <table class="table">
              <tr>
                    <td> New Profile: </td>
                    <td> <input type="file" name="image" class="form-control" required> </td>
              </tr>
                                
              </table>
                                        
               
               <div class="container text-center">
                    <button type="submit" class="btn btn-outline-primary">Save</button>
                </div>
              
              <br>
                                       
          </form>
          
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        
      </div>
    </div>
  </div>
</div>
            
    
      <!--End of Edit Profile Pic -->
                            
                            
                            
                            
        
        <!-- Start of Profile Model  -->
        
                 <!-- Button trigger modal -->
          
<!--<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
  Launch demo modal
</button>-->


<!--  Profile Modal -->

<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        
      <div class="modal-header primary-background text-white">
        <h5 class="modal-title" id="exampleModalLabel"> TechBolg </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        
    <div class="modal-body">
        
        <div class="container text-center">
            
            <img src="pics/<%=user.getProfile() %>" class="img-fluid" style="border-radius:50%;width: 140px; height: 130px;" >
            
            <br>
            

             <h5 class="modal-title mt-3" id="exampleModalLabel"> <%=user.getName()%> </h5>
              
    <!--     Details       -->
    
              <br>
            <div id="profile-details">
                  
              <table class="table">
  
                <tbody>
                    <tr>
                        <th scope="row"> ID : </th>
                        <td> <%=user.getId() %> </td>
                    </tr>
                    <tr>
                        <th scope="row"> Email : </th>
                        <td> <%=user.getEmail() %> </td>
                    </tr>
                    <tr>
                        <th scope="row"> Gender : </th>
                        <td> <%=user.getGender()%> </td>
                    </tr>
                    <tr>
                        <th scope="row"> Status : </th>
                        <td> <%=user.getAbout()%> </td>
                    </tr>
                    <tr>
                        <th scope="row"> Registered on : </th>
                        <td> <%=user.getDateTime().toString()%> </td>
                    </tr>
                </tbody>
              </table>
            </div>   
                    
    <!--    End of Details    -->
    
                  
            
    <!-- Profile Edit -->        
                    
                    <div id="profile-edit" style="display:none;">
                        
                        <h4>Please Edit Carefully</h4>
    <!--  Form for Edit  -->             
                        <form action="EditServlet" method="post" > 
                            
                            <table class="table">
                                <tr>
                                    <td> ID : </td>
                                    <td> <%=user.getId() %> </td>
                                </tr>
                                <tr>
                                    <td> Email : </td>
                                    <td> <input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>" ></td>
                                </tr>
                                <tr>
                                    <td> Name : </td>
                                    <td> <input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"> </td>
                                </tr>
                                <tr>
                                    <td> Password : </td>
                                    <td> <input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>" > </td>
                                </tr>
                                <tr>
                                    <td> Gender : </td>
                                    <td> <%=user.getGender().toUpperCase() %> </td>
                                </tr>
                                <tr>
                                    <td> About : </td>
                                    <td> 
                                        <textarea class="form-control" name="user_about" rows="3"><%=user.getAbout()%></textarea>
                                    </td>
                                </tr>
<!--                                <tr>
                                    <td> New Profile: </td>
                                    <td> <input type="file" name="image" class="form-control" required> </td>
                                </tr>-->
                                
                            </table>
                                        
                                <div class="container">
                                   <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                                        
                        </form>
                        
                    </div>
                                    
            <!--    End of Profile Edit    -->
                    
        </div>
    </div>
        
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="edit-profile-button" class="btn btn-primary">EDIT</button>
      </div>
                                    
    </div>
  </div>
</div>
        
        <!-- End of Profile Model  -->
          
          
          
        <!--  Add Post Model -->
        
        
<!-- Modal -->


<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Provide the Post Details..</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        
          <form action="AddPostServlet" id="add-post-form" method="POST">
              
              <div class="form-group">
                  <select class="form-control" name="cid">
                      <option selected disabled>-- Select Category ( required)  --</option>
                      
                      <%
                            PostDao post = new PostDao(ConnectionProvider.getConnection());
                         
                            ArrayList<Category> list = post.getAllCategories();
                            
                            for(Category c:list)    //( type variable : name ) 
                            {
                                
                      %>
                      
                      <option value="<%=c.getCid() %>"><%= c.getName() %></option>
                      
                      <%
                            }
                      %>
                  </select> 
              </div>
              
              
              <div class="form-group">
                  
                  <div class="form-group">
                      <input type="text" name="pTitle" placeholder="Enter Post Title ( required) " class="form-control" required>
                  </div>
                  <div class="form-group">
                      <textarea name="pContent" style="height:200px;" class="form-control" placeholder="Enter your Content"></textarea>
                  </div>
                  <div class="form-group">
                      <textarea name="pCode" style="height:200px;" class="form-control" placeholder="Enter your Program Code (if any)"></textarea>
                  </div>
                  <div class="form-group">
                      <label>Select your pic..</label>
                      <br>
                      
                      <input type="file" name="pic" >   
                  </div>
                  
              </div>
                  
                  <div class="container text-center">
                      <button type="submit" class="btn btn-outline-primary"> Post </button>
                  </div>
    
          </form>
          
      </div>
      
    </div>
  </div>
</div>
            
        <!-- End Add Post Model -->
        
        
<!--           }  -->
        
        
        
       
<!--            if(user==null)
            {-->
                
        
        
<!--        @include file="normal_navbar.jsp" -->
        
        <!--    Main Content of Body    -->
<!--        
 <div class="container">
     
     <div class="row my-4">
         
         <div class="col-md-8 offset-md-2">
             
             <div class="card">
                 
                 <div class="card-header primary-background text-white">
                    
                     <h4 class="post-title">  p.getpTitle()
                 
                 </div>
                 
                 <div class="card-body">
                     
                     <img class="card-img-top my-2" src="blog_pics/ p.getpPic() " alt="Card image cap">
                     
                     <div class="row my-3 row-user">
                         
                         <div class="col-md-8">
                             
                             
                             UserDao ud = new UserDao(ConnectionProvider.getConnection());
                             
                             
                             <p class="post-user-info"><a href="">  ud.getUserByUserId(p.getUserId()).getName()</a> has posted : </p>
                         </div>
                         
                         <div class="col-md-4">
                             <p class="post-date">DateFormat.getDateTimeInstance().format(p.getpDate()) </p>
                         </div>
                         
                     </div>
                     
                     <p class="post-content"> p.getpContent() </p>
                     
                     <br>
                     
                     <div class="post-code">
                     <pre>  p.getpCode() </pre>
                     </div>
                     
                 </div>
                     
                 <div class="card-footer primary-background">
                         
                     <a href="#!" class="btn btn-outline-light btn-md"><i class="fa fa-thumbs-o-up"></i> <span>10</span></a>
                     <a href="#!" class="btn btn-outline-light btn-md"><i class="fa fa-commenting"></i> <span>10</span></a>
                     
                 </div>
                     
                     <div class="card-footer">
                         
                         <div class="fb-comments" data-href="http://localhost:8080/Tech_Blog/show_blog_page.jsp?post_id= p.getpId() " data-width="" data-numposts="5"></div>
                         
                     </div>
                     
             
             </div>
             
         </div>
         
     </div>
     
 </div>-->
        
        
        
        
        <!--    End Main Content of Body    -->
 
        
        
        
<!--            }-->
        
        
        
        <!--        javascript-->
        
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<script src="js/myjs.js" type="text/javascript"></script>



<!-- my script -->

<script>
    
    $(document).ready(function(){
        
        let editStatus=false;
                                                  //toggle logic 
        $('#edit-profile-button').click(function(){
            
            if(editStatus==false)
            {
                $("#profile-details").hide();
            
                $("#profile-edit").show();
            
                editStatus = true;
                $(this).text("Back")   // this apna button hai  means edit button mein edit ke jagah back likh do . 
            }
            else
            {
                $("#profile-details").show();
                
                $("#profile-edit").hide();
                
                editStatus = false;
                $(this).text("Edit")
            }
            
        })
    });
    
</script>

         <!--      For Add Post JS       -->
         
    <script>
        
        $(document).ready(function(){
            //alert("loaded  ..")
            
            $("#add-post-form").on("submit",function(event){
                // this code execute when form is submitted .
                
                event.preventDefault();
                console.log("you have clicked on submit")
                
                let form = new FormData(this); 
                
                // now requesting to server (send data at servlet ) .
                
                $.ajax({
                    url : "AddPostServlet",
                    type : "POST",
                    data : form,
                    
                    success: function (data, textStatus, jqXHR) {
                      //success  
                      console.log(data);
                      
                      if(data.trim()=='done')   //trim white spaces hata deta hai .
                      {
                          swal("Good job!", "Post Saved Successfully", "success");
                      }
                      else{
                          swal("Error!", "Something went wrong ! Try again..", "success");
                      }
                      
                
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        //error
                        swal("Error!", "Something went wrong ! Try again..", "success");
                    },
                    
                    processData: false, 
                    contentType: false    //inn dono ko false karege toh he photo jayegi nahi toh photo servlet pe nahi jayegi .
                    
                    
                })
                
            })
        
        })
        
    </script>
        
        
        
    </body>
</html>
