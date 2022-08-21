
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sorry womething went wrong .</title>
        
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
        
        <div class="container text-center">
            <img src="img/computer.png" class="img-fluid">    <!-- image-fluid class se pic responsive ban jayegi -->
            <h3 class="display-3">Sorry ! Something went wrong .</h3>
            <%= exception %>   <!-- yeh page chalega jab koi exception aayege or jo bhi exception aayege wo yaha show ho jayege -->
            <a href="index.jsp" class="btn primary-background btn-lg text-white mt-2">Home</a>  <!-- mt = margin top -->
        </div>
        
    </body>
</html>
