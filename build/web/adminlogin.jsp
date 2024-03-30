<%@page import="helper.message"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
   
    <title>Document</title>
    <%@include file="./links.html"%>
    <style>
             .referesh
     {
         display: flex;
         gap: 5px;
     }
     .captcha
     {
         text-decoration:line-through;
         background-color:transparent !important;
         font-weight: 200;
         font-style: italic !important ;
         font-family:cursive;
         
     }
     .error-msg
     {
         color: red;
         font-weight: 500;
         display: none;
        
     }
        </style>

</head>
<body>
    <div class="container-fluid px-3 py-5" style="width:100vw;height:100vh;display:flex;justify-content: center;align-items: center;">
        <div class="container my-contain login-form d-flex flex-column">
            <div class="col-12 col-sm-8 col-md-8 col-lg-4  offset-sm-2 offset-md-2 offset-lg-4 p-4" style="background-color: rgb(231, 231, 231);box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -webkit-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);
                 -moz-box-shadow: -2px 5px 11px -4px rgba(0,0,0,0.75);" >
                <div class="row">
                    <div class="h4-title h4-title-login my-3">
                        <h4>Admin Login</h4>
    
                    </div>
                </div>
                <div class="row">
          <% 
              
             message mg=(message)session.getAttribute("adminloginerror");
             if(mg!=null)
             {
          %>
             <div class="alert alert-warning" role="alert">
             <%= mg.getMsg() %>
             </div>
             <% session.setAttribute("adminloginerror",null);} %>
                </div>
                <div class="row">
                    <div class="col-12 col-md-12 ">
                        <form action="adminlogin" method="post" onsubmit="return match()">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email"  name="email" title="enter correct email format"  pattern="[a-z0-9._%+\-]+@[a-z0-9.\-]+\.[a-z]{2,}$"  required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password"  name="password" required>
                            </div>
                                   
                             <div class="mb-3 col-10 referesh captcha">

                                 <input type="text" class="form-control captcha " id="captcha"  name="captcha" oncopy="return false" readonly="readonly" required>
                            <i class="bi bi-arrow-clockwise ml-5 bg-primary text-light border-0 p-2 " style="border-radius:10px" onclick="storecaptcha()"></i>
                              
                            </div>
                                <div class="mb-3">
                                <label for="vcity" class="form-label">Captcha</label>
                                <input type="text" class="form-control captcha-input" id="captcha-input" name="captcha-input" onpaste="return false" required>
                                <p class="error-msg">invalide captcha!Re-Enter Captcha</p>
                            </div>
                            <button type="submit" class="btn btn1">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
                
   <script>
         function generateCaptcha(min, max) {
                               let captchagenerate = Math.floor(Math.random() * (max - min) + min);
                                return captchagenerate;
                            }
                            function storecaptcha() {
                                let value = String.fromCharCode((generateCaptcha(65, 90)));
                                value += String.fromCharCode(generateCaptcha(97, 122));
                                value += generateCaptcha(48, 57);
                                value += generateCaptcha(48, 57);
                                value += String.fromCharCode(generateCaptcha(65, 90));
                               
                                $(".captcha").val(value);
                            }
                            storecaptcha();
                            
                            function match() {
                                
                                let orgcapcha = $(".captcha").val();
                                let inputcaptcha = $(".captcha-input").val();
                                console.log(orgcapcha);
                                console.log(inputcaptcha);
                                if (orgcapcha == inputcaptcha)
                                {
                                    return true;
                                } else
                                {
                                    
                                  
                                  
                                  $(".error-msg").attr("style","display:block");
                                  return false;
                                }
                            }
                            
                                $(".captcha").on("copy",function(){
                             alert("You are not able to copy this Captcha");
                         });
                         
                            $(".captcha-input").on("paste",function(){
                             alert("You are not able to paste value here");
                         });
             </script>
</body>
</html>
