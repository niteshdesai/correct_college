 <%@page import="entity.student"%>
<%@page import="entity.visitor"%>
<style>
    .btn{
        background-color:none !important;
    }
    .mylogo{
       width:5rem;
       height:5rem;
    }
    .navbar{
        height:4.5rem;
        background-color:#f3f4fe !important;
z-index:2000 !important;
    }
    .nav-searchbox{
        position: relative;
        left:3.2rem;
   
    }
    .search-value{
      position: absolute;
      top:100%;
      width:100%;
      background-color:rgb(249,249,255);
      
    }

    .nav-search-btn{
        position: relative;
        right:3.2rem;
        
    }
    .nav-search-btn:hover{
        background-color: rgb(58, 85, 106) !important;
        color:whitesmoke;
    }
    .nav-search-input{
        width:18rem;
        box-shadow: none !important;
   
    }
  
    .navbar a{
      


font-size:1.1rem;
font-weight: 600;
color:rgb(58, 85, 106)!important;
text-decoration:none;
}
.student-container{
    width: 10.0625rem;
height: 3.25rem;
padding:5px 8px;
border-radius: 0.6875rem 0.6875rem 0rem 0.6875rem;
background: #D9D9D9;
/* border:1px solid black; */
}
.active{
    
    margin-right: 2px;
    position: relative;
}
.active::after{
    content: "";
    position: absolute;
    left:1rem;
    top:80%;
    width:60%;
    height:2.6px;
    background-color: rgb(58, 85, 106);
}

    @media (max-width:510px) {
        .nav-search-input {
        width:10rem;
    }
    @media (max-width:388px) {
        .nav-search-input{
            width:100%;
        }
        .nav-searchbox{
        position: relative;
        left:0rem;
    }
    }
    }
    
</style>

<!-- //navbar padding 0 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light p-0 sticky-top" style="background-color:#f3f4fe !important">
    <div class="container-fluid">
        <!-- navbar-brand p-0 -->
      <a class="navbar-brand p-0 logo-container" href="./index.jsp">
        <img src="./webimage/mylogo2.png" alt="mylogo" class="mylogo"/>
      </a>

      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ms-auto mb-0 mb-lg-0 nav-searchbox-container">
        <form class="d-flex nav-searchbox">
             <!-- give class name nav-search-input -->
          <input class="form-control mb-sm-2 nav-search-input " type="search" placeholder="Search" aria-label="Search">
           <!-- give class name nav-search-btn  -->
           <button class="btn btn-outline nav-search-btn" type="submit"><i class="bi bi-search"></i>
           
          </button>
           <div class="search-value" style="display: none">
    
         </div>
        </form> 
        </ul>
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0" style="background-color: #f3f4fe !important;">
          
          <li class="nav-item">
            <a class="nav-link" aria-current="page" href="./index.jsp">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="./index.jsp#colleges">Colleges</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="./about.jsp">About</a>
          </li>
        
          <li class="nav-item">
              <a class="nav-link" href="./about.jsp#myabout">Contact</a>
          </li>

          <li class="nav-item last-nav-item">
            <a class="nav-link" href="./profile.jsp">
                <% 
                  
            visitor vs = (visitor)session.getAttribute("visitorlogin");

            student stu = (student)session.getAttribute("loginstudent");
            
             if(stu!=null || vs!=null)
             {
                %>
                 <span class="student-container">Profile</span>
              <% }
              else
{%>
  <span class="student-container">Student</span>
<% } %>
            </a>
          </li>
    
        </ul>

      </div>
    </div>
  </nav>
<script src="./jquery/jquery.js"></script>
<script>
    
    
    $(".nav-search-input").on("input",function()
{
       console.log($(".nav-search-input").val());
    if(($(".nav-search-input").val())== "")
      {
          $(".search-value").attr("style","display:none");
          $(".search-value").empty();
      }else{
          $(".search-value").attr("style","display:block");
           let name=$(".nav-search-input").val();
           
           console.log("cname :"+name);

           $.ajax({
                url:"findcollegename",
                data:{"search_value":name},
                success:function(data){
                   $(".search-value").empty();
                   let arr=data.split("^");
                   let cid=0;
                   
                   for(let x=0;x<arr.length-1;x++)
                   {
//                       console.log(arr);
                       cid=(arr[x]).substring(0,arr[x].indexOf(" "));
                       console.log("cid");
                       console.log(cid);
                       $(".search-value").append("<li class='list-group-item'><a href='./college.jsp?selectedcollege="+cid+"'>"+(arr[x]).substring((arr[x]).indexOf(" "))+"</a></li>");
                   }
                }
            });
}
});



//set media for nav

let temp=0;
let temp1=0;

function media()
{
    let match=matchMedia("(max-width:990px)");
    
    let mysearch=$(".nav-searchbox");
    
    if(match.matches==true)
    {
        $(".mysearch").insertAfter($(".logo-container"));
    }
    else
    {
        $(".nav-searchbox-container").html(mysearch);
    }
    let match2=matchMedia("(max-width:388px)");
    
    if(match2.matches==true)
    {
        mysearch.insertAfter($(".last-nav-item"));
    }
}
$(window).on("resize",media);
$(document).on("load",media);
</script>