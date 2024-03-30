<%@page import="entity.course"%>
<%@page import="entity.admin"%>
<%@page import="entity.visitor"%>
<%@page import="entity.collegeadmin"%>
<%@page import="entity.student"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Vector"%>
<%@page import="entity.teacher"%>
<%@page import="dao.teacherdao"%>
<%@page import="helper.RatingCount"%>
<%@page import="entity.college"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.collegedao,java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <%@include  file="./links.html" %>
        <style>
            .comment{
                margin: 5px;
                border: 1px solid rgba(0,0,0,.125);
                box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -webkit-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
                -moz-box-shadow: 0px 0px 13px -9px rgba(0, 0,0,0.75);
            }
            .comment-contain img{
                width: 2rem;
                height:2rem;
                border-right:50% !important;

            }
            .comment-header{
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
                display: flex;
                gap:0.5rem;
                align-items: center;
            }
            .comment-header p{
                position: relative;
                top: 0.3rem;
            }
            .reply-contain{
                display: flex;
                gap:0.5rem;
            }
            .like-dilike-icon-contain{
                background-color:#f3f4fe;
                box-shadow:0px 0px 0px 1px black;
                padding: 0.3rem;
                border-radius:50%;
                color:black;
            }

            .add-comment{
                width:2rem;
                height: 2rem;
                padding:0.8rem;
                border-radius: 50%;
                background-color: blue;
                color:whitesmoke;
                display: flex;
                justify-content: center;
                align-items: center;
            }
            .course-name{
                border-bottom:2px solid #8490ff;

            }
            /*main comment box contain all comment*/
            .our-comments{
                background-color:red !important;

                overflow:scroll;

                position:relative;

            }
            /*//send comment box */
            .comment-box{
                position:sticky;
                background-color:whitesmoke;
                z-index:99;
                color:whitesmoke;
                bottom:0rem;
                border-radius: 0.5rem;


                z-index:9999 !important;

            }
        </style>
    </head>
    <body>
        <%@include file="./navbar.jsp"%>

        <%
            admin ad = (admin) session.getAttribute("adminlogin");

            collegeadmin cd = (collegeadmin) session.getAttribute("collegeadmin");

            vs = (visitor) session.getAttribute("visitorlogin");

            stu = (student) session.getAttribute("loginstudent");

            System.out.println("selectted college = " + request.getParameter("selectedcollege"));
            int cid = Integer.parseInt(request.getParameter("selectedcollege"));
            collegedao cd1 = new collegedao(ConnectionProvider.getConnection());
            college col = cd1.findcollege(cid);
            if (stu != null) {
        %>
        <input type="hidden" class="sid" value="<%=  stu.getSid()%>"/>
        <% }%>
        <%
            if (vs != null) {
        %>
        <input type="hidden" class="vid" value="<%= vs.getVid()%>"/>
        <% }%>
        <input type="hidden" class="cid" value="<%= col.getCid()%>"/>
        <div class="container college-section my-5">
            <div class="row d-flex justify-content-center  pt-2">
                <div class="col-md-4">




                    <img src="./userimg/<%= col.getCimg()%>" alt="" class="img-fluid img-thumbnail" />
                    <h5 class="py-2">
                        <%= col.getCname()%>
                    </h5>
                    <p class="text-start mb-2">
                        <%= col.getCdesc()%>
                    </p>
                    <p class="text-start mb-2"><b>Our Activity</b> :
                        <%= col.getCactivity()%>
                    </p>
                    <p class="text-start mb-2"><b>Course</b> :      <%
                        course cou = col.getCoure();
                        String qtr2 = "select c_name from course where cid=?";
                        Connection con1 = ConnectionProvider.getConnection();
                        PreparedStatement ps1 = con1.prepareStatement(qtr2);
                        ps1.setInt(1, col.getCid());
                        ResultSet rs2 = ps1.executeQuery();
                        while (rs2.next()) {
                            out.println(rs2.getString(1));
                        }
                        %>
                    </p>

                    <p>Email :<spanc style="color:blue;"> <%= col.getEmail()%></span></p>
                    <p>Address : <%= col.getAddress()%></p>
                    <div class="mb-2" id="rat-val">

                        <span class="rat-value text-start mb-3" value="">
                            <%
                                Connection con = ConnectionProvider.getConnection();
                                String qtr = "select sum(c_rval) from coll_rating where cid=" + col.getCid();
                                Statement st = con.createStatement();
                                ResultSet rs = st.executeQuery(qtr);
                                float star = 0;
                                if (rs.next()) {
                                    star = rs.getFloat(1);

                                }

                                String qtr1 = "select count(sid) from coll_rating where cid=?";
                                PreparedStatement ps = con.prepareStatement(qtr1);

                                ps.setInt(1, col.getCid());
                                ResultSet rs1 = ps.executeQuery();
                                float user = 0;
                                if (rs1.next()) {

                                    user = rs1.getInt(1);

                                }
                                out.print(RatingCount.rcount(star, user));

                            %>
                        </span>


                        <span class="college-star"><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i><i class="bi bi-star-fill star-bg"></i></span>
                        <div class="popular-college-detail fs-6 d-flex">
                            <i class="bi bi-person-fill-check"></i>

                            <%= user%>
                            <%
                                if (stu != null) {
                                    if (stu.getCid() == col.getCid()) {
                            %>
                            <span class="bi bi-star rat-star ms-4" data-bs-toggle="modal" data-bs-target="#exampleModalcol">Rate</span>
                            <%}
                                }%>
                            <div class="card-identy" style="display:none" value="college"></div>

                        </div>

                    </div>
                </div>



                <div class="col-md-8 mt-2">
                    <div class="row">
                        <div class="col-10 col-sm-6 col-md-4 mb-4">
                            <h4>Teachers</h4>
                        </div>
                    </div>
                    <div class="row ps-3 mb-2 course-names">
                        <%
                            cou = col.getCoure();
                            qtr2 = "select c_name from course where cid=?";
                            con1 = ConnectionProvider.getConnection();
                            ps1 = con.prepareStatement(qtr2);
                            ps1.setInt(1, col.getCid());
                            rs2 = ps1.executeQuery();
                                    while (rs2.next()) {%>
                        <div class="col-3 m-1 text-center c-name" style="font-size:1.2rem;font-weight:800;cursor:pointer;"> <%= rs2.getString(1)%></div>
                        <% }
                        %>
                    </div>
                    <div class="row teachers">


                    </div>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col-10 col-sm-6 col-md-4 mb-4">
                    <h4>Reviews</h4>
                </div>
            </div>
            <div class="row  out-comments mb-3" >
                <div class="comment-contain row"></div>
                <div class="row comment-box p-2 d-flex justify-content-center align-items-center" style="">
                    <div class="col-8 col-md-5">
                        <textarea class="form-control" id="comment-val" name="comment-val" class="comment-val"  placeholder="your comments..........."></textarea>
                    </div>
                    <div class="col-4 col-md-3 d-flex align-items-center">
                        <div class="add-comment">  <i class="bi bi-send-fill p-1"></i></div>
                    </div>
                </div>
            </div>






        </div>

        <!-- Modal -->
        <div class="modal fade" id="exampleModalcol" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Rating</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <span style="font-size:2rem" class="contain-star">
                            <i class="bi bi-star-fill user-rate" id="pq"></i><i class="bi bi-star-fill user-rate"></i><i
                                class="bi bi-star-fill user-rate"></i><i class="bi bi-star-fill user-rate"></i><i
                                class="bi bi-star-fill user-rate"></i>
                            <div><span class="counting-star">0</span>/5</div>
                        </span>
                        <div class="alert alert-success" role="alert" style="display:none">
                        </div>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-primary college-post">Post</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="exampleModaltech" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Rating</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">

                        <span style="font-size:2rem" class="contain-star1">
                            <i class="bi bi-star-fill user-rate1" id="pq"></i><i class="bi bi-star-fill user-rate1"></i><i
                                class="bi bi-star-fill user-rate1"></i><i class="bi bi-star-fill user-rate1"></i><i
                                class="bi bi-star-fill user-rate1"></i>
                            <div><span class="counting-star1">0</span>/5</div>
                        </span>
                        <div class="alert alert-success" role="alert" style="display:none">
                        </div>
                    </div>
                    <div class="modal-footer">

                        <button type="button" class="btn btn-primary teacher-post">Post</button>
                    </div>
                </div>
            </div>
        </div>


        <script src="./jquery/jquery.js"></script>

        <script>


    let id5, category;

            let cid = $(".cid").attr("value");
            let sid = $(".sid").attr("value");

            let tid;
            let vid = $(".vid").attr("value");
            let id;
            //add comment 
            $(".add-comment").on("click", function ()
            {
                let comment_value = $("#comment-val").val();

                if (sid == undefined && vid == undefined)
                {
                    window.location.href = "visitorlogin.jsp";
                } else if (sid != undefined)
                {
                    console.log("comment_value  = " + comment_value.length);
                    if (comment_value.length > 0)
                    {
                        $.ajax({
                            url: "addcomment",
                            data: {"id": sid, "cid": cid, "data": comment_value, "category": "student"},
                            success: function (data)
                            {
                                $.ajax({
                                    url: "./getcollegecomment.jsp",
                                    data: {"cid": cid},
                                    success: function (data)
                                    {

                                        $(".comment-contain").html(data);
                                        $("#comment-val").val("");
                                 
                                    }
                                });
                            }
                        });
                    }
                } else
                {
                    if (comment_value.length > 0)
                    {
                        $.ajax({
                            url: "addcomment",
                            data: {"id": vid, "cid": cid, "data": comment_value, "category": "visitor"},
                            success: function (data)
                            {
                                $.ajax({
                                    url: "./getcollegecomment.jsp",
                                    data: {"cid": cid},
                                    success: function (data)
                                    {

                                        $(".comment-contain").html(data);
                                        $("#comment-val").val("");
                               
                                    }
                                });
                            }
                        });
                    }
                }
            });

            //get comments
            $(document).ready(function ()
            {
                $.ajax({
                    url: "./getcollegecomment.jsp",
                    data: {"cid": cid},
                    success: function (data)
                    {

                        $(".comment-contain").html(data);
                    }
                });
            });




            $(".btn-close").on("click", function ()
            {
                window.location.href = "./college.jsp?selectedcollege=" + cid + "&loginstudent" + sid;
            });

            //send rating to database
//            let tid;
//            $(".rat-star1").on("click", function ()
//            {
//                tid = $(this).attr("value");
//            });
//            $(".teacher-post").on("click", function ()
//            {
//                //console.log("CLICK USERPOST2"); 
//                let stat_fill = $(".counting-star1").text();
//
//                let selected_card = "Teacher";
//                let firstthis = this;
//                let card_id = tid;
//                $.ajax({
//                    url: "addcollegerating",
//                    data: {"star_fill": stat_fill, "select_card": selected_card, "cid": cid, "sid": sid, "id": card_id},
//                    success: function (data)
//                    {
//                        let parent = $(firstthis).parent();
//                        let sib = $(parent).siblings();
//                        console.log(parent);
//                        $(parent).html(" ");
//                        $(sib[1]).html("<div class='alert alert-success mt-1' role='alert'>Your rating seccussfully added </div>");
//                    }
//                });
//            });

            $(".college-post").on("click", function ()
            {
                let star_fill = $(".counting-star").text();
                let cid = $(".cid").attr("value");
                let selected_card = "college";
                let sid = $(".sid").attr("value");
                let card_id = 0;
                let firstthis = this;
                $.ajax({
                    url: "addcollegerating",
                    data: {"star_fill": star_fill, "select_card": selected_card, "cid": cid, "sid": sid, "id": card_id},
                    success: function (data)
                    {


                        let parent = $(firstthis).parent();
                        let sib = $(parent).siblings();
                        console.log(parent);
                        $(parent).html(" ");
                        $(sib[1]).html("<div class='alert alert-success mt-1' role='alert'>Your rating seccussfully added </div>");
                    }
                });
            });

            //user rating
            $(".user-rate1").on("click", function () {

                let co_star = $(".counting-star1").text();

                let v = $(this).attr('style');
                if (v != undefined) {

                    let pre = $($(this).next()).attr("style");

                    if (pre == undefined) {

                        $(this).removeAttr("style");
                        co_star--;
                        console.log("forward " + co_star);
                        $(".counting-star1").text(co_star);

                    }
                } else {

                    let pre = $($(this).prev()).attr("style");
                    console.log("forward style :" + $($(this).prev()).attr("style"));
                    if (pre != undefined || $(this).prev().length == 0) {
                        $(this).css("color", "gold");
                        co_star++;
                        console.log("forward " + co_star);
                        $(".counting-star1").text(co_star);

                    }
                }

            });
            $(".user-rate").on("click", function () {

                let co_star = $(".counting-star").text();

                let v = $(this).attr('style');
                if (v != undefined) {

                    let pre = $($(this).next()).attr("style");

                    if (pre == undefined) {

                        $(this).removeAttr("style");
                        co_star--;
                        $(".counting-star").text(co_star);
                    }
                } else {

                    let pre = $($(this).prev()).attr("style");

                    if (pre != undefined || $(this).prev().length == 0) {
                        $(this).css("color", "gold");
                        co_star++;
                        $(".counting-star").text(co_star);
                    }
                }

            });



            //set star based on database
            let  rat = $(".rat-value").text();
            let nexele = $($(".rat-value").next()).children();
            rat = rat.trim();
            let fill = parseInt(rat);

            let x;

            //   console.log("fill in college page :"+fill);
            for (x = fill; x < 5; x++)
            {

                $(nexele[x]).removeClass("star-bg");
            }

            if (fill < rat)
            {

                $(nexele[fill]).removeClass("bi-star-fill");
                $(nexele[fill]).addClass("bi-star-half");
                $(nexele[fill]).addClass("star-bg");

            }


            let  val = $(".teacher-rv");
            let c1, nextele, nextchild;
            for (c1 = 0; c1 < val.length; c1++)
            {
                let inn1 = parseInt(val[c1].innerText);
                nextele = $(val[c1]).next();
                nextchild = nextele.children();

                for (x = inn1; x < 5; x++)
                {


                    $(nextchild[x]).removeClass("star-bg");
                }

                if (inn1 < val[c1].innerText)
                {


                    $(nextchild[inn1]).removeClass("bi-star-fill");
                    $(nextchild[inn1]).addClass("bi-star-half");
                    $(nextchild[inn1]).addClass("star-bg");
                }
            }
            $(".c-name").on("click", function ()
            {

                let sib = $(this).siblings();
                for (let i = 0; i < sib.length; i++)
                {
                    $(sib[i]).removeClass("course-name");
                }
                $(this).addClass("course-name");
                $.ajax({
                    url: "getcourseteacher.jsp",
                    data: {"cid": cid, "c_name": $(this).text()},
                    success: function (data)
                    {

                        $(".teachers").html(data);
                        let  val = $(".teacher-rv");
                        let c1, nextele, nextchild;
                        for (c1 = 0; c1 < val.length; c1++)
                        {
                            let inn1 = parseInt(val[c1].innerText);
                            nextele = $(val[c1]).next();
                            nextchild = nextele.children();

                            for (x = inn1; x < 5; x++)
                            {


                                $(nextchild[x]).removeClass("star-bg");
                            }

                            if (inn1 < val[c1].innerText)
                            {


                                $(nextchild[inn1]).removeClass("bi-star-fill");
                                $(nextchild[inn1]).addClass("bi-star-half");
                                $(nextchild[inn1]).addClass("star-bg");
                            }
                        }







                        $(".rat-star1").on("click", function ()
                        {
                            tid = $(this).attr("value");
                        });
                        $(".teacher-post").on("click", function ()
                        {
                            //console.log("CLICK USERPOST2"); 
                            let stat_fill = $(".counting-star1").text();

                            let selected_card = "Teacher";
                            let firstthis = this;
                            let card_id = tid;
                            $.ajax({
                                url: "addcollegerating",
                                data: {"star_fill": stat_fill, "select_card": selected_card, "cid": cid, "sid": sid, "id": card_id},
                                success: function (data)
                                {
                                    let parent = $(firstthis).parent();
                                    let sib = $(parent).siblings();
                                    console.log(parent);
                                    $(parent).html(" ");
                                    $(sib[1]).html("<div class='alert alert-success mt-1' role='alert'>Your rating seccussfully added </div>");
                                }
                            });
                        });











                    }

                });

            });
            $(document).ready(function ()
            {
                let child = $(".course-names").children();
                $(child[0]).addClass("course-name");
                $.ajax({
                    url: "getcourseteacher.jsp",
                    data: {"cid": cid, "c_name": $(child[0]).text()},
                    success: function (data)
                    {
                        $(".teachers").html(data);
                    }
                });
            });
        </script>
        <%@include file="./footer.html" %>
    </body>
</html>
