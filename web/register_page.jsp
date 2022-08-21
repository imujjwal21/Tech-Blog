
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up Page</title>
        
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
        
<!--                navbar-->

             <%@include file="normal_navbar.jsp" %>
             
             
        
        
        <main class="primary-background p-5 banner-background" style="height: 150vh">
            <div class="container">
                <div class="col-md-6 offset-md-3">  <!--total 12 grid hai col-md-4 se left se 4 shift ke fir offset-md-4 se right se 4 shift ke-->
                   
                    <div class="card">
                        
                        <div class="card-header text-center primary-background text-white">
                            <span class="fa fa-user-circle fa-3x"></span>
                            <br>
                            <h4>Register Here</h4>    
                        </div>

                        <div class="card-body">
                            
                            <!--    Form    -->
                            
                            <form id="reg-form" action="RegisterServlet" method="POST">
                                
                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input  name="user_name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter User Name">
                                </div>
                             
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                
                                
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>
                                
                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio" id="gender" value="male" name="gender" >Male
                                    <input type="radio" id="gender" value="female" name="gender" >Female
                                </div>
                                
                                <div class="form-group">
                                    <textarea name="about" class="form-control" id="" cols="" rows="5" placeholder="Enter domething about yourself"></textarea>
                                </div>
                                
                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label  class="form-check-label" for="exampleCheck1">agree terms and condition</label>
                                </div>
                               
                                <br>
                                
                                <div class="container text-center" id="loader" style="display:none;">
                                    <span class="fa fa-refresh fa-spin fa-3x"></span>
                                    <h4>Please wait</h4>
                                <br>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-primary">Submit</button>

                            </form>
                        
                        </div>

                        
                    </div>
                         
                    
                </div>  
                
            </div>
            
        </main>
        
        
        
        
                              <!--        javascript-->
        
<script
  src="https://code.jquery.com/jquery-3.6.0.min.js"
  integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
  crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

<script src="js/myjs.js" type="text/javascript"></script>        
        
<!--my script -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>  <!--sweet alert cdn swal ke liye use kiya-->

<script>
    $(document).ready(function(){
        console.log("loaded.......")
        
        $('#reg-form').on('submit',function(event){    //form submit hote he yeh function apne aap chal jayrga .
            event.preventDefault();  // iss se yeh servlet pe nahi jayega  orr apan yahi se pura data submit kar degi servlet pe .
            
            let form=new FormData(this);   // yeh form ka pura data yaha aa jayega iss form mein or iss data ko RegisterServlet pe send karna hai.
            
            $("#submit-btn").hide();
            $("#loader").show();
            
            //send this form to registerServlet
            
            $.ajax({
               url: "RegisterServlet",
               type: 'POST',
               data: form,
               success: function(data,textStatus,jqXHR){
                   console.log(data)
                   
                   $("#submit-btn").show();
                   $("#loader").hide();
                   
                   if(data.trim()=='done')
                   {
                       
                    swal("Successfully Registered .. We are redirect to login page")
                    .then((value) => {
                      window.location="login_page.jsp"
                    });
               }else{
                 swal(data);
             }
             
               
                },
                
               error: function(jqXHR,textStatus,errorThrow){
                    $("#submit-btn").show();
                    $("#loader").hide();
                     swal("Something went wrong .. try again ");          
        
               },
               //imp
               processData: false,
               contentType: false
               
            });
            
        });
        
    });
</script>


        
    </body>
</html>
