<%-- 
    Document   : about
    Created on : 04-Jan-2024, 3:27:47 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <%@include file="links.html" %>
        <style>
            html{
                overflow-x:hidden;
            }
            .footer{
                background:linear-gradient(0deg,rgb(132 144 255) 0%, rgb(98 189 252) 100%);
                color:whitesmoke;
            }
            a{
                color:whitesmoke;
                
            }
                .error-msg
     {
         color: red;
         font-weight: 500;
         opacity: 70%;
         display: none;
        
     }
        </style>

    </head>
    <body>
        <%@include file="navbar.jsp" %>       <!-- hero section or Main section or home main section  -->
        <div class="container-fluid hero-section">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-11 col-md-6 hero-detail">
                        <h1><span style="color:#8490ff"</span>Correct College</h1>
                        <p>We are try to give you best and most ranked college to your bright feature threw this website..if you like us website plz give your feedBack</p>
                    </div>
                    <div class="col-11 col-md-6">
                        <div>
                            <img src="./webimage/college project-pana.png" alt="heroimage" class="img-fluid"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!--                 Second part of about/contact form -->



        <div class="container-fluid hero-section">
            <div class="container">
                <div class="row align-items-center">

                    <div class="col-11 col-md-5 me-5 order-sm-1 order-md-0">
                        <div>
                            <img src="./webimage/contact.png" alt="heroimage" class="img-fluid"/>
                        </div>
                    </div>
                    <div class="col-12 col-md-6 hero-detail">






                        <div class="row mt-2">
                            <div class="h4-title h4-title-login my-2">
                                <h4> Contact Form</h4>

                            </div>
                        </div>

                        <div class="row mb-5">
                            <div class="col-11 col-md-11">
                                <form action="contactdetailadd" method="post" id="myabout">
                                       <div class="mb-1">
                                        <label for="pname" class="form-label">Name</label>
                                        <input type="text" class="form-control" id="pname"   name="pname" required>
                                        <p class="error-msg">Name must be greater than 5 letter</p>
                                    </div>
                                    <div class="mb-1">
                                        <label for="cname" class="form-label">college</label>
                                        <input type="text" class="form-control" id="cname"   name="cname" required>
                                    </div>
                                    <div class="mb-1">
                                        <label for="ccity" class="form-label">city</label>
                                        <input type="text" class="form-control" id="ccity"   name="ccity" required>
                                    </div>
                                    <div class="mb-1">
                                        <label for="mobile" class="form-label">Mobile No</label>
                                        <input type="text" class="form-control" id="mobile"   name="mobile" pattern="[0-9]{10}" required>
                                    </div>
                                    <div class="mb-1">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email"   name="email" required>
                                    </div>


                                    <button type="submit" class="btn btn1">Contact</button>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>



<script>
    $("#pname").on("input",function()
    {
       let len= $(this).val();
        
     console.log(len.length);
     
     if(len.length<5)
     {
         $(this).css("border","1px solid red");
         $(".error-msg").css("display","block");
     }
     else
     {
         $(this).css("border","1px solid green");
         $(".error-msg").css("display","none");
     }
     if($(this).val()=="")
     {
           $(this).css("border","none");
            $(".error-msg").css("display","none");
     }
    });
    </script>
    
        <%@include file="./footer.html" %>
</body>
</html>
